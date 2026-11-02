import {
  BadRequestException,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import { TripMessageService } from './tripMessages.service';

const activeMember = {
  id: 'member-1',
  userId: 'user-1',
  tripId: 'trip-1',
  role: 'MEMBER',
  status: 'ACTIVE',
};

function setup(
  member: Record<string, unknown> | null = activeMember,
  options: {
    tripExists?: boolean;
    image?: Record<string, unknown> | null;
  } = {},
) {
  const prisma = {
    trip: {
      findUnique: jest
        .fn()
        .mockResolvedValue(
          options.tripExists === false ? null : { id: 'trip-1' },
        ),
    },
    tripMember: { findUnique: jest.fn().mockResolvedValue(member) },
    tripMessage: {
      create: jest.fn((args: { data: Record<string, unknown> }) =>
        Promise.resolve({ id: 'message-1', ...args.data }),
      ),
      findFirst: jest.fn().mockResolvedValue({ id: 'cursor-1' }),
      findMany: jest.fn().mockResolvedValue([]),
    },
    uploadedMedia: {
      findFirst: jest
        .fn()
        .mockResolvedValue(
          options.image === undefined
            ? { id: 'media-1', objectKey: 'chat/a.jpg' }
            : options.image,
        ),
      findMany: jest.fn().mockResolvedValue([]),
    },
  };
  const s3 = { getPublicUrl: jest.fn((key: string) => `https://cdn/${key}`) };
  return {
    service: new TripMessageService(prisma as never, s3 as never),
    prisma,
  };
}

describe('TripMessageService.createMessage', () => {
  it('stores the TripMember id as senderId, not the user id', async () => {
    const { service, prisma } = setup();

    const message = await service.createMessage('trip-1', 'user-1', 'Hello');

    expect(prisma.tripMember.findUnique).toHaveBeenCalledWith(
      expect.objectContaining({
        where: { tripId_userId: { tripId: 'trip-1', userId: 'user-1' } },
      }),
    );
    expect(prisma.tripMessage.create).toHaveBeenCalledWith(
      expect.objectContaining({
        data: {
          tripId: 'trip-1',
          senderId: 'member-1',
          content: 'Hello',
          messageType: 'TEXT',
        },
      }),
    );
    expect(message.imageUrl).toBeNull();
    expect(prisma.uploadedMedia.findFirst).not.toHaveBeenCalled();
  });

  it('rejects users who are not active members', async () => {
    const { service, prisma } = setup(null);

    await expect(
      service.createMessage('trip-1', 'user-1', 'Hello'),
    ).rejects.toBeInstanceOf(ForbiddenException);
    expect(prisma.tripMessage.create).not.toHaveBeenCalled();
  });

  it('reports a missing trip as not found', async () => {
    const { service } = setup(null, { tripExists: false });

    await expect(
      service.createMessage('missing', 'user-1', 'Hello'),
    ).rejects.toBeInstanceOf(NotFoundException);
  });

  it('only accepts IMAGE messages that reference an image the sender owns', async () => {
    const { service, prisma } = setup(activeMember, { image: null });

    await expect(
      service.createMessage('trip-1', 'user-1', 'media-of-someone', 'IMAGE'),
    ).rejects.toBeInstanceOf(BadRequestException);
    expect(prisma.uploadedMedia.findFirst).toHaveBeenCalledWith(
      expect.objectContaining({
        where: {
          id: 'media-of-someone',
          userId: 'user-1',
          deletedAt: null,
          mimeType: { startsWith: 'image/' },
        },
      }),
    );
    expect(prisma.tripMessage.create).not.toHaveBeenCalled();
  });

  it('returns the image URL for IMAGE messages', async () => {
    const { service } = setup();

    const message = await service.createMessage(
      'trip-1',
      'user-1',
      'media-1',
      'IMAGE',
    );

    expect(message.imageUrl).toBe('https://cdn/chat/a.jpg');
  });
});

describe('TripMessageService.getMessages', () => {
  it('rejects a cursor from another trip', async () => {
    const { service, prisma } = setup();
    prisma.tripMessage.findFirst.mockResolvedValueOnce(null);

    await expect(
      service.getMessages('trip-1', 'user-1', 20, 'foreign-cursor'),
    ).rejects.toBeInstanceOf(BadRequestException);
    expect(prisma.tripMessage.findMany).not.toHaveBeenCalled();
  });

  it('resolves image URLs and leaves deleted images null', async () => {
    const { service, prisma } = setup();
    prisma.tripMessage.findMany.mockResolvedValueOnce([
      { id: 'm2', content: 'gone', messageType: 'IMAGE' },
      { id: 'm1', content: 'media-1', messageType: 'IMAGE' },
    ]);
    prisma.uploadedMedia.findMany.mockResolvedValueOnce([
      { id: 'media-1', objectKey: 'chat/a.jpg' },
    ]);

    const result = await service.getMessages('trip-1', 'user-1');

    expect(result.data).toEqual([
      expect.objectContaining({ id: 'm1', imageUrl: 'https://cdn/chat/a.jpg' }),
      expect.objectContaining({ id: 'm2', imageUrl: null }),
    ]);
  });
});

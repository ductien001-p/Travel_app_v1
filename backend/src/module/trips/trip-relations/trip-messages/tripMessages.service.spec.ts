import { BadRequestException, NotFoundException } from '@nestjs/common';
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
        Promise.resolve({
          id: 'message-1',
          ...args.data,
          createdAt: new Date('2025-07-19T14:10:00.000Z'),
          sender: {
            id: 'member-1',
            role: 'MEMBER',
            user: {
              id: 'user-1',
              username: 'me',
              displayname: 'Me',
              avatar: null,
            },
          },
          reactions: [],
        }),
      ),
      findFirst: jest.fn().mockResolvedValue({ id: 'cursor-1' }),
      findMany: jest.fn().mockResolvedValue([]),
    },
    tripMessageRead: {
      upsert: jest.fn().mockResolvedValue({
        userId: 'user-1',
        tripId: 'trip-1',
        lastReadAt: new Date(),
      }),
      findMany: jest.fn().mockResolvedValue([]),
    },
    tripMessageReaction: {
      upsert: jest.fn().mockResolvedValue({}),
      deleteMany: jest.fn().mockResolvedValue({ count: 1 }),
      findMany: jest.fn().mockResolvedValue([{ emoji: '❤️' }, { emoji: '❤️' }]),
    },
    itineraryItem: {
      findFirst: jest.fn().mockResolvedValue(null),
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
  const tripGateway = {
    getOnlineUserIds: jest.fn().mockResolvedValue(new Set<string>()),
  };
  return {
    service: new TripMessageService(
      prisma as never,
      s3 as never,
      tripGateway as never,
    ),
    prisma,
    tripGateway,
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
    ).rejects.toBeInstanceOf(NotFoundException);
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
    expect(prisma.tripMessageRead.upsert).toHaveBeenCalledWith(
      expect.objectContaining({
        where: {
          userId_tripId: { userId: 'user-1', tripId: 'trip-1' },
        },
      }),
    );
  });
});

describe('TripMessageService.getChatThread', () => {
  it('returns UI thread chrome and mapped messages', async () => {
    const { service, prisma, tripGateway } = setup();
    prisma.trip = {
      findUnique: jest.fn().mockResolvedValue({
        id: 'trip-1',
        name: 'Mùa hè rực rỡ 2025',
        members: [
          {
            id: 'member-1',
            userId: 'user-1',
            role: 'OWNER',
            user: {
              id: 'user-1',
              displayname: 'Me',
              username: 'me',
              avatar: null,
            },
          },
          {
            id: 'member-2',
            userId: 'user-2',
            role: 'MEMBER',
            user: {
              id: 'user-2',
              displayname: 'Alex',
              username: 'alex',
              avatar: null,
            },
          },
        ],
      }),
    };
    prisma.tripMessage.findMany.mockResolvedValueOnce([
      {
        id: 'm1',
        tripId: 'trip-1',
        senderId: 'member-2',
        content: 'Xin chào',
        messageType: 'TEXT',
        metadata: null,
        createdAt: new Date('2025-07-19T14:10:00.000Z'),
        sender: {
          id: 'member-2',
          role: 'MEMBER',
          user: {
            id: 'user-2',
            username: 'alex',
            displayname: 'Alex',
            avatar: null,
          },
        },
        reactions: [],
      },
    ]);
    tripGateway.getOnlineUserIds.mockResolvedValueOnce(new Set(['user-2']));

    const thread = await service.getChatThread('trip-1', 'user-1');

    expect(thread.tripId).toBe('trip-1');
    expect(thread.title).toBe('Mùa hè rực rỡ 2025');
    expect(thread.memberSummaryLabel).toContain('đang online');
    expect(thread.utilities).toHaveLength(4);
    expect(thread.messages[0]).toEqual(
      expect.objectContaining({
        kind: 'TEXT',
        text: 'Xin chào',
        isMine: false,
      }),
    );
  });
});

describe('TripMessageService.reactions', () => {
  it('adds and aggregates reactions', async () => {
    const { service, prisma } = setup();
    prisma.tripMessage.findFirst.mockResolvedValueOnce({
      id: 'message-1',
      tripId: 'trip-1',
    });

    const result = await service.addReaction(
      'trip-1',
      'message-1',
      'user-1',
      '❤️',
    );

    expect(result.messageId).toBe('message-1');
    expect(result.reactions).toEqual([{ emoji: '❤️', count: 2 }]);
    expect(prisma.tripMessageReaction.upsert).toHaveBeenCalled();
  });
});

describe('TripMessageService.markTripMessagesRead', () => {
  it('upserts TripMessageRead for an active member', async () => {
    const { service, prisma } = setup();

    const result = await service.markTripMessagesRead('trip-1', 'user-1');

    expect(result.tripId).toBe('trip-1');
    expect(result.lastReadAt).toBeInstanceOf(Date);
    expect(prisma.tripMessageRead.upsert).toHaveBeenCalledWith(
      expect.objectContaining({
        where: {
          userId_tripId: { userId: 'user-1', tripId: 'trip-1' },
        },
      }),
    );
  });

  it('rejects users who are not active members', async () => {
    const { service, prisma } = setup(null);

    await expect(
      service.markTripMessagesRead('trip-1', 'user-1'),
    ).rejects.toBeInstanceOf(NotFoundException);
    expect(prisma.tripMessageRead.upsert).not.toHaveBeenCalled();
  });
});

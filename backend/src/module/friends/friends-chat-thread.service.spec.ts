import { BadRequestException, ForbiddenException } from '@nestjs/common';
import { FriendService } from './friends.service';

function createService(overrides?: {
  prisma?: Record<string, unknown>;
  tripGateway?: {
    getConnectedUserIds?: jest.Mock;
  };
}) {
  const conversation = {
    id: 'conv-1',
    user1Id: 'user-1',
    user2Id: 'user-2',
    createdAt: new Date('2026-07-19T08:00:00Z'),
    user1: {
      id: 'user-1',
      displayname: 'Lan Phương',
      avatar: { objectKey: 'avatars/lan.jpg', deletedAt: null },
    },
    user2: {
      id: 'user-2',
      displayname: 'Alex Nguyễn',
      avatar: { objectKey: 'avatars/alex.jpg', deletedAt: null },
    },
  };

  const prisma = {
    friendConversation: {
      findUnique: jest.fn().mockResolvedValue(conversation),
      findUniqueOrThrow: jest.fn().mockResolvedValue({
        user1Id: 'user-1',
        user2Id: 'user-2',
      }),
    },
    friendMessage: {
      findMany: jest.fn().mockResolvedValue([
        {
          id: 'msg-1',
          senderId: 'user-2',
          content: 'Chào Phương!',
          messageType: 'TEXT',
          metadata: null,
          createdAt: new Date('2026-07-19T14:22:00'),
        },
        {
          id: 'msg-2',
          senderId: 'user-2',
          content: '',
          messageType: 'PLACE_CARD',
          metadata: {
            placeId: 'place-faifo',
            name: 'Faifo Coffee Hội An',
            address: '130 Trần Phú',
            imageUrl: 'https://cdn.test/faifo.jpg',
            rating: 4.8,
            reviewCount: 312,
            badgeLabel: 'Điểm ngắm hoàng hôn số 1',
          },
          createdAt: new Date('2026-07-19T14:22:30'),
        },
        {
          id: 'msg-3',
          senderId: 'user-1',
          content: 'Quán đẹp!',
          messageType: 'TEXT',
          metadata: null,
          createdAt: new Date('2026-07-19T14:26:00'),
        },
      ]),
      create: jest.fn().mockImplementation(async ({ data }) => ({
        id: 'msg-new',
        conversationId: data.conversationId,
        senderId: data.senderId,
        content: data.content,
        messageType: data.messageType,
        metadata: data.metadata === null ? null : data.metadata,
        createdAt: new Date('2026-07-19T15:00:00'),
        sender: { id: data.senderId, username: 'lan', avatarId: null },
      })),
      count: jest.fn().mockResolvedValue(0),
    },
    friendConversationRead: {
      findUnique: jest.fn().mockResolvedValue({
        lastReadAt: new Date('2026-07-19T14:30:00'),
      }),
      upsert: jest.fn().mockResolvedValue({}),
      findMany: jest.fn().mockResolvedValue([]),
    },
    tripMember: {
      findMany: jest.fn().mockResolvedValue([
        {
          trip: {
            id: 'trip-1',
            name: 'Mùa Hè Rực Rỡ 2025',
            status: 'ONGOING',
            startDate: new Date('2026-07-01'),
            endDate: new Date('2026-07-05'),
            maxMembers: 6,
            coverMedia: { objectKey: 'covers/a.jpg', deletedAt: null },
            destinations: [{ city: 'Sơn Trà' }],
            _count: { members: 4 },
          },
        },
      ]),
      findFirst: jest.fn().mockResolvedValue({ userId: 'user-2' }),
    },
    user: {
      findUnique: jest.fn(),
    },
    ...(overrides?.prisma ?? {}),
  };

  const s3 = {
    getPublicUrl: jest.fn((key: string) => `https://cdn.test/${key}`),
  };

  const tripGateway = {
    getConnectedUserIds: jest
      .fn()
      .mockResolvedValue(new Set<string>(['user-2'])),
    ...(overrides?.tripGateway ?? {}),
  };

  return {
    service: new FriendService(
      prisma as never,
      s3 as never,
      tripGateway as never,
    ),
    prisma,
    s3,
    tripGateway,
  };
}

describe('FriendService.getThread', () => {
  it('composes UI thread with peer, place card and shortcuts', async () => {
    const { service, prisma } = createService();

    const thread = await service.getThread('conv-1', 'user-1');

    expect(thread.conversationId).toBe('conv-1');
    expect(thread.peer).toMatchObject({
      userId: 'user-2',
      displayName: 'Alex Nguyễn',
      avatarUrl: 'https://cdn.test/avatars/alex.jpg',
      roleBadge: 'Trưởng nhóm',
      isOnline: true,
      presenceLabel: 'Đang hoạt động',
    });
    expect(thread.sharedTrip).toMatchObject({
      tripId: 'trip-1',
      title: 'Mùa Hè Rực Rỡ 2025',
      destinationHint: 'Sơn Trà',
      statusLabel: 'Đang diễn ra',
    });
    expect(thread.messages).toHaveLength(3);
    expect(thread.messages[0]).toMatchObject({
      kind: 'TEXT',
      isMine: false,
      text: 'Chào Phương!',
      showAvatar: true,
    });
    expect(thread.messages[1]).toMatchObject({
      kind: 'PLACE_CARD',
      isMine: false,
      showAvatar: false,
      placeCard: {
        placeId: 'place-faifo',
        name: 'Faifo Coffee Hội An',
      },
    });
    expect(thread.messages[2]).toMatchObject({
      kind: 'TEXT',
      isMine: true,
      readStatus: 'READ',
    });
    expect(thread.isPeerTyping).toBe(false);
    expect(thread.shortcuts[0].kind).toBe('INVITE_TRIP');
    expect(thread.inviteCandidates[0].tripId).toBe('trip-1');
    expect(prisma.friendConversationRead.upsert).toHaveBeenCalled();
  });

  it('rejects non-members', async () => {
    const { service } = createService({
      prisma: {
        friendConversation: {
          findUnique: jest.fn().mockResolvedValue({
            id: 'conv-1',
            user1Id: 'user-1',
            user2Id: 'user-2',
            createdAt: new Date(),
            user1: {
              id: 'user-1',
              displayname: 'A',
              avatar: null,
            },
            user2: {
              id: 'user-2',
              displayname: 'B',
              avatar: null,
            },
          }),
        },
      },
    });

    await expect(service.getThread('conv-1', 'user-3')).rejects.toBeInstanceOf(
      ForbiddenException,
    );
  });
});

describe('FriendService.sendMessageAsUi', () => {
  it('persists TEXT and returns UI-shaped message', async () => {
    const { service, prisma } = createService();

    const message = await service.sendMessageAsUi(
      'conv-1',
      'user-1',
      'Xin chào',
      'TEXT',
    );

    expect(prisma.friendMessage.create).toHaveBeenCalled();
    expect(message).toMatchObject({
      id: 'msg-new',
      kind: 'TEXT',
      isMine: true,
      text: 'Xin chào',
      showAvatar: false,
    });
  });

  it('requires metadata for PLACE_CARD', async () => {
    const { service } = createService();

    await expect(
      service.sendMessageAsUi('conv-1', 'user-1', '', 'PLACE_CARD'),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('accepts TRIP_INVITE with metadata', async () => {
    const { service } = createService();

    const message = await service.sendMessageAsUi(
      'conv-1',
      'user-1',
      '',
      'TRIP_INVITE',
      {
        tripId: 'trip-da-lat',
        title: 'Đà Lạt 3N2Đ',
        imageUrl: 'https://cdn.test/dalat.jpg',
        dateLabel: '25/10 - 27/10',
        priceLabel: '~1.650.000đ/người',
        seatsLabel: '4/6 thành viên',
      },
    );

    expect(message.kind).toBe('TRIP_INVITE');
    expect(message.tripInvite?.tripId).toBe('trip-da-lat');
  });
});

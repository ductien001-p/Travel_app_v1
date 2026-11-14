import { ChatsHubService } from './chats-hub.service';

function createService(overrides?: {
  prisma?: Record<string, unknown>;
  tripGateway?: {
    getOnlineUserIds?: jest.Mock;
    getConnectedUserIds?: jest.Mock;
  };
}) {
  const prisma = {
    user: {
      findUniqueOrThrow: jest.fn().mockResolvedValue({
        displayname: 'Lan Phương',
        avatar: { objectKey: 'avatars/lan.jpg', deletedAt: null },
      }),
    },
    tripMember: {
      findMany: jest.fn().mockResolvedValue([]),
    },
    tripMessage: {
      count: jest.fn().mockResolvedValue(0),
    },
    tripMessageRead: {
      findMany: jest.fn().mockResolvedValue([]),
    },
    friendConversation: {
      findMany: jest.fn().mockResolvedValue([]),
    },
    friendConversationRead: {
      findMany: jest.fn().mockResolvedValue([]),
    },
    friendMessage: {
      count: jest.fn().mockResolvedValue(0),
    },
    ...(overrides?.prisma ?? {}),
  };

  const s3 = {
    getPublicUrl: jest.fn((key: string) => `https://cdn.test/${key}`),
  };

  const tripGateway = {
    getOnlineUserIds: jest.fn().mockResolvedValue(new Set<string>()),
    getConnectedUserIds: jest.fn().mockResolvedValue(new Set<string>()),
    ...(overrides?.tripGateway ?? {}),
  };

  return {
    service: new ChatsHubService(
      prisma as never,
      s3 as never,
      tripGateway as never,
    ),
    prisma,
    s3,
    tripGateway,
  };
}

describe('ChatsHubService.getHub', () => {
  it('returns an empty hub for a user with no threads', async () => {
    const { service } = createService();

    const hub = await service.getHub('user-1');

    expect(hub.viewer).toEqual({
      displayName: 'Lan Phương',
      avatarUrl: 'https://cdn.test/avatars/lan.jpg',
      isOnline: true,
    });
    expect(hub.totalThreadCount).toBe(0);
    expect(hub.hasUnread).toBe(false);
    expect(hub.activeTripPulse).toBeNull();
    expect(hub.tripThreads).toEqual([]);
    expect(hub.friendThreads).toEqual([]);
  });

  it('composes trip threads with unread and emphasize', async () => {
    const tripMembership = {
      id: 'member-me',
      trip: {
        id: 'trip-1',
        name: 'Fansipan',
        status: 'UPCOMING',
        tripType: 'BACKPACKER',
        maxMembers: 6,
        coverMedia: {
          objectKey: 'covers/fan.jpg',
          deletedAt: null,
        },
        _count: { members: 4 },
        tripMessages: [
          {
            id: 'msg-1',
            content: 'Xuất phát 5h',
            messageType: 'TEXT',
            createdAt: new Date('2026-11-08T10:00:00Z'),
            senderId: 'member-peer',
            sender: {
              id: 'member-peer',
              userId: 'user-peer',
              user: { displayname: 'Minh Anh' },
            },
          },
        ],
      },
    };

    const { service, prisma } = createService({
      prisma: {
        tripMember: {
          findMany: jest.fn().mockImplementation((args: {
            where?: { trip?: { status?: unknown } };
            select?: { trip?: unknown };
          }) => {
            // Pulse uses exact ONGOING status; threads use status.in.
            if (args?.where?.trip?.status === 'ONGOING') {
              return Promise.resolve([]);
            }
            if (args?.where?.trip && args.select?.trip) {
              return Promise.resolve([tripMembership]);
            }
            return Promise.resolve([]);
          }),
        },
        tripMessage: {
          count: jest.fn().mockResolvedValue(3),
        },
        tripMessageRead: {
          findMany: jest.fn().mockResolvedValue([]),
        },
        friendConversation: {
          findMany: jest.fn().mockResolvedValue([]),
        },
        friendConversationRead: {
          findMany: jest.fn().mockResolvedValue([]),
        },
        friendMessage: {
          count: jest.fn().mockResolvedValue(0),
        },
        user: {
          findUniqueOrThrow: jest.fn().mockResolvedValue({
            displayname: 'Lan Phương',
            avatar: null,
          }),
        },
      },
    });

    const hub = await service.getHub('user-1');

    expect(hub.tripThreads).toHaveLength(1);
    expect(hub.tripThreads[0]).toMatchObject({
      id: 'trip-1',
      tripId: 'trip-1',
      title: 'Fansipan',
      coverUrl: 'https://cdn.test/covers/fan.jpg',
      badgeIcon: 'hiking',
      status: 'UPCOMING',
      memberCount: 4,
      memberLabel: '4 thành viên',
      lastSenderName: 'Minh Anh',
      lastMessage: 'Xuất phát 5h',
      unreadCount: 3,
      emphasize: true,
      isReadReceipt: false,
    });
    expect(hub.hasUnread).toBe(true);
    expect(hub.totalThreadCount).toBe(1);
    expect(prisma.tripMessage.count).toHaveBeenCalled();
  });

  it('maps OWNER peer on a shared trip to Trưởng nhóm badge', async () => {
    const { service, tripGateway } = createService({
      prisma: {
        user: {
          findUniqueOrThrow: jest.fn().mockResolvedValue({
            displayname: 'Lan',
            avatar: null,
          }),
        },
        tripMember: {
          findMany: jest.fn().mockImplementation((args: {
            where?: {
              trip?: unknown;
              role?: string;
              userId?: string | { in?: string[] };
              tripId?: { in?: string[] };
            };
            select?: Record<string, unknown>;
          }) => {
            // Shared-trip OWNER lookup
            if (args?.where?.role === 'OWNER') {
              return Promise.resolve([{ userId: 'user-alex' }]);
            }
            // My trip ids for role badge (select: { tripId: true })
            if (args?.select && 'tripId' in args.select && !args.where?.trip) {
              return Promise.resolve([{ tripId: 'trip-shared' }]);
            }
            return Promise.resolve([]);
          }),
        },
        tripMessage: { count: jest.fn().mockResolvedValue(0) },
        tripMessageRead: { findMany: jest.fn().mockResolvedValue([]) },
        friendConversation: {
          findMany: jest.fn().mockResolvedValue([
            {
              id: 'conv-1',
              user1Id: 'user-1',
              user2Id: 'user-alex',
              createdAt: new Date('2026-11-01T00:00:00Z'),
              user1: {
                id: 'user-1',
                displayname: 'Lan',
                avatar: null,
              },
              user2: {
                id: 'user-alex',
                displayname: 'Alex Nguyễn',
                avatar: { objectKey: 'a.jpg', deletedAt: null },
              },
              messages: [
                {
                  id: 'fm-1',
                  content: 'Chào buổi sáng',
                  messageType: 'TEXT',
                  senderId: 'user-alex',
                  createdAt: new Date('2026-11-08T08:00:00Z'),
                },
              ],
            },
          ]),
        },
        friendConversationRead: {
          findMany: jest.fn().mockResolvedValue([]),
        },
        friendMessage: {
          count: jest.fn().mockResolvedValue(1),
        },
      },
      tripGateway: {
        getConnectedUserIds: jest
          .fn()
          .mockResolvedValue(new Set(['user-alex'])),
      },
    });

    const hub = await service.getHub('user-1');

    expect(hub.friendThreads).toHaveLength(1);
    expect(hub.friendThreads[0]).toMatchObject({
      conversationId: 'conv-1',
      peerUserId: 'user-alex',
      displayName: 'Alex Nguyễn',
      avatarUrl: 'https://cdn.test/a.jpg',
      roleBadge: 'Trưởng nhóm',
      roleTone: 'PRIMARY',
      isOnline: true,
      lastMessage: 'Chào buổi sáng',
      unreadCount: 1,
    });
    expect(tripGateway.getConnectedUserIds).toHaveBeenCalledWith([
      'user-alex',
    ]);
  });

  it('builds activeTripPulse from an ONGOING trip and last message', async () => {
    const tripMembership = {
      id: 'member-me',
      trip: {
        id: 'trip-ongoing',
        name: 'Miền Trung 2025',
        status: 'ONGOING',
        tripType: 'FRIENDS',
        maxMembers: 6,
        coverMedia: null,
        _count: { members: 4 },
        tripMessages: [
          {
            id: 'msg-1',
            content: 'media-1',
            messageType: 'IMAGE',
            createdAt: new Date('2026-11-08T12:00:00Z'),
            senderId: 'member-alex',
            sender: {
              id: 'member-alex',
              userId: 'user-alex',
              user: { displayname: 'Alex Nguyễn' },
            },
          },
        ],
      },
    };

    const pulseRow = {
      trip: {
        id: 'trip-ongoing',
        name: 'Miền Trung 2025',
        maxMembers: 6,
        destinations: [{ city: 'Hội An' }],
        members: [
          {
            userId: 'user-1',
            user: { avatar: null },
          },
          {
            userId: 'user-alex',
            user: {
              avatar: {
                objectKey: 'avatars/alex.jpg',
                deletedAt: null,
              },
            },
          },
        ],
        tripMessages: [
          {
            content: 'media-1',
            messageType: 'IMAGE',
            createdAt: new Date('2026-11-08T12:00:00Z'),
            sender: {
              user: { displayname: 'Alex Nguyễn' },
            },
          },
        ],
      },
    };

    const { service } = createService({
      prisma: {
        user: {
          findUniqueOrThrow: jest.fn().mockResolvedValue({
            displayname: 'Lan',
            avatar: null,
          }),
        },
        tripMember: {
          findMany: jest.fn().mockImplementation((args: {
            where?: { trip?: { status?: string } };
            select?: { trip?: unknown; tripId?: unknown };
          }) => {
            // Pulse query: trip.status === ONGOING (exact match, not `in`)
            if (args?.where?.trip?.status === 'ONGOING') {
              return Promise.resolve([pulseRow]);
            }
            // Trip threads: status.in
            if (args?.where?.trip && args.select?.trip) {
              return Promise.resolve([tripMembership]);
            }
            return Promise.resolve([]);
          }),
        },
        tripMessage: { count: jest.fn().mockResolvedValue(2) },
        tripMessageRead: { findMany: jest.fn().mockResolvedValue([]) },
        friendConversation: { findMany: jest.fn().mockResolvedValue([]) },
        friendConversationRead: { findMany: jest.fn().mockResolvedValue([]) },
        friendMessage: { count: jest.fn().mockResolvedValue(0) },
      },
      tripGateway: {
        getOnlineUserIds: jest
          .fn()
          .mockResolvedValue(new Set(['user-alex'])),
      },
    });

    const hub = await service.getHub('user-1');

    expect(hub.activeTripPulse).toMatchObject({
      tripId: 'trip-ongoing',
      title: 'Miền Trung 2025',
      statusLabel: 'Đang diễn ra • Chặng Hội An',
      onlineMemberCount: 1,
      memberCapacity: 6,
      memberAvatars: ['https://cdn.test/avatars/alex.jpg'],
      extraMemberCount: 1,
      pinnedSenderName: 'Alex Nguyễn',
      pinnedMessage: '[Ảnh]',
      newExchangeCount: 2,
    });
    expect(hub.tripThreads[0].lastMessage).toBe('[Ảnh]');
    expect(hub.tripThreads[0].coverUrl).toBe('');
  });
});

import { FriendService } from './friends.service';
import { FRIEND_REQUEST_STATUS } from '../../generated/prisma/enums';

describe('FriendService hub enrichment', () => {
  function createService(overrides?: {
    friendships?: Array<{
      id: string;
      userId: string;
      friendId: string;
      createdAt: Date;
      friend: Record<string, unknown>;
    }>;
    received?: Array<{
      id: string;
      fromUserId: string;
      toUserId: string;
      status: string;
      createdAt: Date;
      updatedAt: Date;
      fromUser: Record<string, unknown>;
    }>;
    sent?: Array<{
      id: string;
      fromUserId: string;
      toUserId: string;
      status: string;
      createdAt: Date;
      updatedAt: Date;
      toUser: Record<string, unknown>;
    }>;
    dna?: Array<{ userId: string; type: string; score: number }>;
    tripMembers?: Array<{ userId: string; tripId: string }>;
    conversations?: Array<{
      id: string;
      user1Id: string;
      user2Id: string;
    }>;
    mutualFriendships?: Array<{ userId: string; friendId: string }>;
  }) {
    const prisma = {
      friendship: {
        findMany: jest.fn().mockImplementation(async (args: any) => {
          if (args?.include?.friend) {
            return overrides?.friendships ?? [];
          }
          if (args?.where?.userId && !args?.where?.friendId) {
            return (overrides?.mutualFriendships ?? []).filter(
              (f) => f.userId === args.where.userId,
            );
          }
          if (args?.where?.userId?.in) {
            return (overrides?.mutualFriendships ?? []).filter((f) =>
              args.where.userId.in.includes(f.userId),
            );
          }
          return overrides?.mutualFriendships ?? [];
        }),
      },
      friendRequest: {
        findMany: jest.fn().mockImplementation(async (args: any) => {
          if (args?.where?.toUserId) {
            return overrides?.received ?? [];
          }
          if (args?.where?.fromUserId) {
            return overrides?.sent ?? [];
          }
          return [];
        }),
      },
      userTravelDNA: {
        findMany: jest.fn().mockResolvedValue(overrides?.dna ?? []),
      },
      tripMember: {
        findMany: jest.fn().mockImplementation(async (args: any) => {
          if (args?.select?.tripId) {
            return [{ tripId: 'trip-1' }];
          }
          return overrides?.tripMembers ?? [];
        }),
      },
      friendConversation: {
        findMany: jest.fn().mockResolvedValue(overrides?.conversations ?? []),
      },
    };

    const s3 = {
      getPublicUrl: jest.fn(
        (key: string) => `https://cdn.test/${key}`,
      ),
    };
    const tripGateway = {
      getConnectedUserIds: jest.fn().mockResolvedValue(new Set(['user-alex'])),
    };

    return new FriendService(prisma as any, s3 as any, tripGateway as any);
  }

  const alexFriend = {
    id: 'user-alex',
    username: 'alex_wander',
    displayname: 'Alex Nguyễn',
    isVerified: true,
    avatarId: 'media-alex',
    avatar: { objectKey: 'avatars/alex.jpg', deletedAt: null },
  };

  it('getFriends returns enriched displayName avatarUrl online and conversationId', async () => {
    const service = createService({
      friendships: [
        {
          id: 'fs-1',
          userId: 'viewer',
          friendId: 'user-alex',
          createdAt: new Date('2026-11-01T00:00:00.000Z'),
          friend: alexFriend,
        },
      ],
      conversations: [
        { id: 'conv-alex', user1Id: 'user-alex', user2Id: 'viewer' },
      ],
      tripMembers: [{ userId: 'user-alex', tripId: 'trip-1' }],
      dna: [
        { userId: 'viewer', type: 'FOODIE_TRAVELER', score: 80 },
        { userId: 'user-alex', type: 'FOODIE_TRAVELER', score: 78 },
      ],
    });

    const result = await service.getFriends('viewer');

    expect(result).toHaveLength(1);
    expect(result[0].friend.displayName).toBe('Alex Nguyễn');
    expect(result[0].friend.avatarUrl).toBe('https://cdn.test/avatars/alex.jpg');
    expect(result[0].friend.isOnline).toBe(true);
    expect(result[0].friend.verified).toBe(true);
    expect(result[0].conversationId).toBe('conv-alex');
    expect(result[0].sharedTripsCount).toBe(1);
    expect(result[0].friend.badgeLabel).toContain('Travel Buddy');
  });

  it('getReceivedRequests enriches fromUser', async () => {
    const service = createService({
      received: [
        {
          id: 'req-1',
          fromUserId: 'user-lan',
          toUserId: 'viewer',
          status: FRIEND_REQUEST_STATUS.PENDING,
          createdAt: new Date('2026-11-13T00:00:00.000Z'),
          updatedAt: new Date('2026-11-13T00:00:00.000Z'),
          fromUser: {
            id: 'user-lan',
            username: 'lanphuong.travel',
            displayname: 'Lan Phương',
            isVerified: false,
            avatarId: null,
            avatar: null,
          },
        },
      ],
    });

    const result = await service.getReceivedRequests('viewer');
    expect(result).toHaveLength(1);
    expect(result[0].fromUser.displayName).toBe('Lan Phương');
    expect(result[0].fromUser.username).toBe('lanphuong.travel');
    expect(result[0].fromUser.avatarUrl).toBeNull();
    expect(result[0].createdAt).toBe('2026-11-13T00:00:00.000Z');
  });

  it('getSentRequests enriches toUser', async () => {
    const service = createService({
      sent: [
        {
          id: 'sent-1',
          fromUserId: 'viewer',
          toUserId: 'user-nam',
          status: FRIEND_REQUEST_STATUS.PENDING,
          createdAt: new Date('2026-11-12T00:00:00.000Z'),
          updatedAt: new Date('2026-11-12T00:00:00.000Z'),
          toUser: {
            id: 'user-nam',
            username: 'nam_wanderer',
            displayname: 'Hoàng Nam',
            isVerified: false,
            avatarId: 'media-nam',
            avatar: { objectKey: 'avatars/nam.jpg', deletedAt: null },
          },
        },
      ],
    });

    const result = await service.getSentRequests('viewer');
    expect(result).toHaveLength(1);
    expect(result[0].toUser.displayName).toBe('Hoàng Nam');
    expect(result[0].toUser.avatarUrl).toBe('https://cdn.test/avatars/nam.jpg');
  });
});

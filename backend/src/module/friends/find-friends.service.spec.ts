import { FindFriendsService } from './find-friends.service';
import { FindFriendsActionDto } from './dto/find-friends.dto';

describe('FindFriendsService', () => {
  function createService(overrides?: {
    users?: Array<Record<string, unknown>>;
    friendships?: Array<{ userId: string; friendId: string }>;
    friendRequests?: Array<{
      id?: string;
      fromUserId: string;
      toUserId: string;
      status: string;
    }>;
    dna?: Array<{ userId: string; type: string; score: number }>;
    tripMembers?: Array<{ userId: string; tripId: string }>;
    follows?: Array<{ followerId: string; followingId: string }>;
    conversations?: Array<{
      id: string;
      user1Id: string;
      user2Id: string;
    }>;
    nearbyUsers?: Array<Record<string, unknown>>;
    viewer?: Record<string, unknown>;
  }) {
    const prisma = {
      user: {
        findMany: jest.fn().mockImplementation(async (args: any) => {
          if (args?.where?.shareLocationForDiscovery) {
            return overrides?.nearbyUsers ?? [];
          }
          if (args?.where?.OR) {
            return (overrides?.users ?? []).filter((u) => {
              const q = args.where.OR[0]?.displayname?.startsWith ?? '';
              const name = String(u.displayname ?? '');
              const username = String(u.username ?? '');
              return (
                name.toLowerCase().startsWith(String(q).toLowerCase()) ||
                username.toLowerCase().startsWith(String(q).toLowerCase().replace(/^@/, ''))
              );
            });
          }
          if (args?.where?.id?.in) {
            const ids: string[] = args.where.id.in;
            return (overrides?.users ?? []).filter((u) =>
              ids.includes(String(u.id)),
            );
          }
          return overrides?.users ?? [];
        }),
        findUnique: jest.fn().mockResolvedValue(
          overrides?.viewer ?? {
            discoveryLat: 16.05,
            discoveryLng: 108.2,
            shareLocationForDiscovery: true,
          },
        ),
        update: jest.fn().mockImplementation(async ({ data }: any) => ({
          discoveryLat: data.discoveryLat,
          discoveryLng: data.discoveryLng,
          discoveryLocatedAt: data.discoveryLocatedAt,
          shareLocationForDiscovery: data.shareLocationForDiscovery,
        })),
      },
      friendship: {
        findMany: jest.fn().mockImplementation(async (args: any) => {
          const all = overrides?.friendships ?? [];
          if (args?.where?.userId && !args?.where?.friendId) {
            return all.filter((f) => f.userId === args.where.userId);
          }
          if (args?.where?.userId && args?.where?.friendId?.in) {
            return all.filter(
              (f) =>
                f.userId === args.where.userId &&
                args.where.friendId.in.includes(f.friendId),
            );
          }
          if (args?.where?.userId?.in) {
            return all.filter((f) =>
              args.where.userId.in.includes(f.userId),
            );
          }
          return all;
        }),
      },
      friendRequest: {
        findMany: jest.fn().mockResolvedValue(overrides?.friendRequests ?? []),
      },
      userTravelDNA: {
        findMany: jest.fn().mockResolvedValue(overrides?.dna ?? []),
      },
      tripMember: {
        findMany: jest.fn().mockResolvedValue(overrides?.tripMembers ?? []),
      },
      userFollow: {
        findMany: jest.fn().mockResolvedValue(overrides?.follows ?? []),
      },
      friendConversation: {
        findMany: jest.fn().mockResolvedValue(overrides?.conversations ?? []),
      },
    };

    const s3 = {
      getPublicUrl: jest.fn((key: string) => `https://cdn.test/${key}`),
    };

    const tripGateway = {
      getConnectedUserIds: jest.fn().mockResolvedValue(new Set(['user-online'])),
    };

    const service = new FindFriendsService(
      prisma as any,
      s3 as any,
      tripGateway as any,
    );

    return { service, prisma, s3, tripGateway };
  }

  it('updates discovery location with opt-in', async () => {
    const { service, prisma } = createService();
    const data = await service.updateDiscoveryLocation('viewer', {
      lat: 16.05,
      lng: 108.2,
      shareLocationForDiscovery: true,
    });
    expect(prisma.user.update).toHaveBeenCalled();
    expect(data.shareLocationForDiscovery).toBe(true);
    expect(data.discoveryLat).toBe(16.05);
  });

  it('searches users and maps ADD_FRIEND when DNA overlaps', async () => {
    const { service } = createService({
      users: [
        {
          id: 'user-nam',
          username: 'nam_wanderer',
          displayname: 'Hoàng Nam',
          isVerified: false,
          avatar: { objectKey: 'a.jpg', deletedAt: null },
        },
      ],
      dna: [
        { userId: 'viewer', type: 'BEACH_LOVER', score: 8 },
        { userId: 'user-nam', type: 'BEACH_LOVER', score: 8 },
      ],
    });

    const page = await service.find('viewer', { q: 'Nam' });
    expect(page.results).toHaveLength(1);
    expect(page.results[0].displayName).toBe('Hoàng Nam');
    expect(page.results[0].action).toBe(FindFriendsActionDto.ADD_FRIEND);
    expect(page.recentSearches).toEqual([]);
    expect(page.dnaBanner.ctaLabel).toBe('Quét DNA ngay');
  });

  it('maps FRIENDS to MESSAGE with conversationId', async () => {
    const { service } = createService({
      users: [
        {
          id: 'user-alex',
          username: 'alex_wander',
          displayname: 'Alex Nguyễn',
          isVerified: true,
          avatar: null,
        },
      ],
      friendships: [{ userId: 'viewer', friendId: 'user-alex' }],
      conversations: [
        { id: 'conv-1', user1Id: 'user-alex', user2Id: 'viewer' },
      ],
    });

    const page = await service.find('viewer', { q: 'Alex' });
    expect(page.results[0].action).toBe(FindFriendsActionDto.MESSAGE);
    expect(page.results[0].conversationId).toBe('conv-1');
    expect(page.results[0].verified).toBe(true);
  });

  it('maps REQUEST_SENT', async () => {
    const { service } = createService({
      users: [
        {
          id: 'user-linh',
          username: 'linh_le',
          displayname: 'Lê Thảo Linh',
          isVerified: true,
          avatar: null,
        },
      ],
      friendRequests: [
        {
          id: 'req-linh',
          fromUserId: 'viewer',
          toUserId: 'user-linh',
          status: 'PENDING',
        },
      ],
    });

    const page = await service.find('viewer', { q: 'Linh' });
    expect(page.results[0].action).toBe(FindFriendsActionDto.REQUEST_SENT);
    expect(page.results[0].friendRequestId).toBe('req-linh');
  });

  it('maps FOLLOWING when already following', async () => {
    const { service } = createService({
      users: [
        {
          id: 'user-triet',
          username: 'triet_photographer',
          displayname: 'Minh Triết',
          isVerified: false,
          avatar: null,
        },
      ],
      follows: [{ followerId: 'viewer', followingId: 'user-triet' }],
    });

    const page = await service.find('viewer', { q: 'Minh' });
    expect(page.results[0].action).toBe(FindFriendsActionDto.FOLLOWING);
  });

  it('excludes friends from nearby and requires opt-in radius', async () => {
    const { service } = createService({
      users: [],
      friendships: [{ userId: 'viewer', friendId: 'friend-near' }],
      nearbyUsers: [
        {
          id: 'friend-near',
          displayname: 'Friend Near',
          discoveryLat: 16.05,
          discoveryLng: 108.2,
          avatar: null,
        },
        {
          id: 'stranger-near',
          displayname: 'Stranger Near',
          discoveryLat: 16.051,
          discoveryLng: 108.201,
          avatar: null,
        },
        {
          id: 'too-far',
          displayname: 'Too Far',
          discoveryLat: 17.0,
          discoveryLng: 109.0,
          avatar: null,
        },
      ],
      viewer: {
        discoveryLat: 16.05,
        discoveryLng: 108.2,
        shareLocationForDiscovery: true,
      },
    });

    const page = await service.find('viewer', {});
    expect(page.nearbySuggestions.map((s) => s.id)).toEqual(['stranger-near']);
    expect(page.nearbySuggestions[0].subtitle).toContain('Đang ở gần bạn');
  });

  it('returns empty nearby when viewer has not opted in and no query lat/lng', async () => {
    const { service } = createService({
      nearbyUsers: [
        {
          id: 'stranger-near',
          displayname: 'Stranger Near',
          discoveryLat: 16.05,
          discoveryLng: 108.2,
          avatar: null,
        },
      ],
      viewer: {
        discoveryLat: null,
        discoveryLng: null,
        shareLocationForDiscovery: false,
      },
    });

    const page = await service.find('viewer', {});
    expect(page.nearbySuggestions).toEqual([]);
  });
});

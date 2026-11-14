import { RecommendFriendsToTripService } from './recommend-friends-to-trip.service';

const friendshipAt = new Date('2026-01-01T00:00:00.000Z');
const messageAt = new Date('2026-10-01T00:00:00.000Z');

describe('RecommendFriendsToTripService.getCompanionRecommendations', () => {
  function setup(
    options: {
      dna?: Array<{ userId: string; type: string; score: number }>;
      conversations?: Array<{
        user1Id: string;
        user2Id: string;
        messages: Array<{ createdAt: Date }>;
      }>;
      tripType?: string;
      categories?: string[];
    } = {},
  ) {
    const prisma = {
      trip: {
        findUnique: jest.fn().mockResolvedValue({
          id: 'trip-1',
          tripType: options.tripType ?? 'OTHER',
          itineraryItems: (options.categories ?? ['BEACH']).map((category) => ({
            place: { category },
          })),
        }),
      },
      tripMember: {
        findUnique: jest
          .fn()
          .mockResolvedValue({ role: 'OWNER', status: 'ACTIVE' }),
        findMany: jest
          .fn()
          .mockResolvedValueOnce([
            { userId: 'owner-1' },
            { userId: 'friend-2' },
          ])
          .mockResolvedValueOnce([]),
      },
      tripInvitation: { findMany: jest.fn().mockResolvedValue([]) },
      user: {
        findMany: jest.fn().mockResolvedValue([
          {
            id: 'friend-1',
            displayname: 'Friend One',
            username: 'friend1',
            avatarId: null,
          },
        ]),
      },
      userTravelDNA: {
        findMany: jest.fn().mockResolvedValue(options.dna ?? []),
      },
      friendConversation: {
        findMany: jest.fn().mockResolvedValue(options.conversations ?? []),
      },
    };
    const friendService = {
      getFriends: jest.fn().mockResolvedValue([
        {
          id: 'friendship-1',
          userId: 'owner-1',
          friendId: 'friend-1',
          createdAt: friendshipAt,
        },
        {
          id: 'friendship-2',
          userId: 'owner-1',
          friendId: 'friend-2',
          createdAt: friendshipAt,
        },
      ]),
    };
    return {
      service: new RecommendFriendsToTripService(
        prisma as never,
        friendService as never,
      ),
      prisma,
    };
  }

  it('excludes current members and keeps the friendship date without a message', async () => {
    const { service, prisma } = setup();

    const result = await service.getCompanionRecommendations(
      'trip-1',
      'owner-1',
    );

    expect(prisma.user.findMany).toHaveBeenCalledWith(
      expect.objectContaining({
        where: expect.objectContaining({ id: { in: ['friend-1'] } }),
      }),
    );
    expect(result.tripTravelPersona).toBe('Beach Lover 🏖️');
    expect(result.recommendations).toEqual([
      expect.objectContaining({
        user: expect.objectContaining({ id: 'friend-1' }),
        tripsTogetherCount: 0,
        invitationStatus: null,
        travelPersona: null,
        matchScore: null,
        lastInteractionAt: friendshipAt,
      }),
    ]);
  });

  it('scores a friend whose Travel DNA matches the trip', async () => {
    const { service } = setup({
      dna: [{ userId: 'friend-1', type: 'BEACH_LOVER', score: 8 }],
    });

    const result = await service.getCompanionRecommendations(
      'trip-1',
      'owner-1',
    );

    expect(result.recommendations[0]).toEqual(
      expect.objectContaining({
        travelPersona: 'Beach Lover 🏖️',
        matchScore: 100,
      }),
    );
  });

  it('uses the newer direct message as the last interaction', async () => {
    const { service } = setup({
      conversations: [
        {
          user1Id: 'owner-1',
          user2Id: 'friend-1',
          messages: [{ createdAt: messageAt }],
        },
      ],
    });

    const result = await service.getCompanionRecommendations(
      'trip-1',
      'owner-1',
    );

    expect(result.recommendations[0].lastInteractionAt).toEqual(messageAt);
  });

  it('leaves the trip persona null when the trip has no Travel DNA', async () => {
    const { service } = setup({ tripType: 'OTHER', categories: [] });

    const result = await service.getCompanionRecommendations(
      'trip-1',
      'owner-1',
    );

    expect(result.tripTravelPersona).toBeNull();
    expect(result.recommendations[0].matchScore).toBeNull();
  });
});

import { NotFoundException } from '@nestjs/common';
import {
  BudgetLevel,
  HOST_STATUS,
  RANK,
  TRIP_STATUS,
} from '../../generated/prisma/enums';
import { ProfileShowcaseService } from './profile-showcase.service';

describe('ProfileShowcaseService', () => {
  const start = new Date('2025-07-19T00:00:00.000Z');
  const end = new Date('2025-07-22T00:00:00.000Z');
  const leaderboardDate = new Date('2026-10-26T00:00:00.000Z');

  function tripRow(status: TRIP_STATUS) {
    return {
      id: status === TRIP_STATUS.ONGOING ? 'trip-ongoing' : 'trip-upcoming',
      name: status === TRIP_STATUS.ONGOING ? 'Hội An' : 'Y Tý',
      status,
      startDate: start,
      endDate: end,
      budgetLevel: BudgetLevel.MEDIUM,
      maxMembers: 5,
      coverMedia: { objectKey: `${status}.jpg`, deletedAt: null },
      destinations: [{ highlights: ['Bánh Mì Phượng', 'Trà Mót'] }],
      _count: { members: 4 },
    };
  }

  function setup(user: { id: string; hostStatus: HOST_STATUS } | null) {
    const prisma = {
      user: { findFirst: jest.fn().mockResolvedValue(user) },
      userRanking: {
        findUnique: jest.fn().mockResolvedValue({
          totalPoints: 1450,
          tripsCompleted: 8,
          rank: RANK.ADVENTURER,
        }),
      },
      dailyLeaderboard: {
        findFirst: jest.fn().mockResolvedValue({ date: leaderboardDate }),
        findUnique: jest.fn().mockResolvedValue({ ranking: 50 }),
        count: jest.fn().mockResolvedValue(1000),
      },
      tripMember: { count: jest.fn().mockResolvedValue(12) },
      userFollow: {
        count: jest.fn().mockResolvedValueOnce(1250).mockResolvedValueOnce(340),
      },
      trip: {
        findFirst: jest.fn(({ where }: { where: { status: TRIP_STATUS } }) =>
          tripRow(where.status),
        ),
      },
      itineraryItem: {
        groupBy: jest.fn().mockResolvedValue([
          { tripId: 'trip-ongoing', isCheckin: false, _count: { _all: 3 } },
          { tripId: 'trip-ongoing', isCheckin: true, _count: { _all: 7 } },
        ]),
      },
      tripMedia: {
        count: jest.fn().mockResolvedValue(184),
        findMany: jest.fn().mockResolvedValue([
          {
            id: 'memory-1',
            media: { objectKey: 'memory.jpg', deletedAt: null },
          },
          {
            id: 'memory-deleted',
            media: { objectKey: 'gone.jpg', deletedAt: new Date() },
          },
        ]),
      },
      savedPlace: {
        count: jest.fn().mockResolvedValue(24),
        findMany: jest.fn().mockResolvedValue([
          {
            id: 'saved-1',
            placeId: 'place-1',
            place: {
              name: 'Phố đèn lồng Hội An',
              city: 'Hội An',
              country: 'Việt Nam',
              category: 'OLD_TOWN',
              coverImages: [
                { media: { objectKey: 'place.jpg', deletedAt: null } },
              ],
            },
          },
        ]),
      },
      post: {
        count: jest.fn().mockResolvedValue(15),
        findMany: jest.fn().mockResolvedValue([
          {
            id: 'post-1',
            caption: 'Cao lầu Hội An',
            postMedias: [{ media: { objectKey: 'post.jpg', deletedAt: null } }],
          },
        ]),
      },
    };
    const travelDna = {
      getUserTravelDNA: jest.fn().mockResolvedValue({
        dominant: { type: 'FOODIE_TRAVELER', score: 88 },
        topBadges: [],
        all: [],
      }),
    };
    const s3 = {
      getPublicUrl: jest.fn((key: string) => `https://cdn.test/${key}`),
    };
    const service = new ProfileShowcaseService(
      prisma as never,
      travelDna as never,
      s3 as never,
    );
    return { service, prisma, travelDna };
  }

  it('assembles the signed-in profile from existing records', async () => {
    const { service, prisma, travelDna } = setup({
      id: 'user-1',
      hostStatus: HOST_STATUS.APPROVED,
    });

    const showcase = await service.getShowcase('user-1');

    expect(travelDna.getUserTravelDNA).toHaveBeenCalledWith('user-1');
    expect(prisma.userFollow.count).toHaveBeenNthCalledWith(1, {
      where: { followingId: 'user-1' },
    });
    expect(prisma.userFollow.count).toHaveBeenNthCalledWith(2, {
      where: { followerId: 'user-1' },
    });
    expect(showcase).toMatchObject({
      hostStatus: HOST_STATUS.APPROVED,
      ranking: {
        userId: 'user-1',
        totalPoints: 1450,
        totalTripsCompleted: 8,
        rank: RANK.ADVENTURER,
        ranking: 50,
        percentile: 5,
      },
      social: { tripCount: 12, followerCount: 1250, followingCount: 340 },
      travelDna: { dominant: { type: 'FOODIE_TRAVELER', score: 88 } },
      ongoingTrip: {
        id: 'trip-ongoing',
        name: 'Hội An',
        coverImageUrl: 'https://cdn.test/ONGOING.jpg',
        status: TRIP_STATUS.ONGOING,
        budgetLevel: BudgetLevel.MEDIUM,
        maxMembers: 5,
        memberCount: 4,
        totalActivities: 10,
        completedActivities: 7,
        highlights: ['Bánh Mì Phượng', 'Trà Mót'],
      },
      upcomingTrip: {
        id: 'trip-upcoming',
        status: TRIP_STATUS.UPCOMING,
        totalActivities: 0,
        completedActivities: 0,
      },
      memories: {
        totalCount: 184,
        items: [{ id: 'memory-1', imageUrl: 'https://cdn.test/memory.jpg' }],
      },
      savedPlaces: {
        count: 24,
        items: [
          {
            id: 'saved-1',
            placeId: 'place-1',
            name: 'Phố đèn lồng Hội An',
            coverImageUrl: 'https://cdn.test/place.jpg',
          },
        ],
      },
      posts: {
        count: 15,
        items: [
          {
            id: 'post-1',
            caption: 'Cao lầu Hội An',
            imageUrl: 'https://cdn.test/post.jpg',
          },
        ],
      },
    });
  });

  it('returns an empty showcase when the user has no ranking or trips', async () => {
    const { service, prisma } = setup({
      id: 'user-1',
      hostStatus: HOST_STATUS.NONE,
    });
    prisma.userRanking.findUnique.mockResolvedValue(null);
    prisma.dailyLeaderboard.findFirst.mockResolvedValue(null);
    prisma.trip.findFirst.mockResolvedValue(null);
    prisma.userFollow.count.mockReset();
    prisma.userFollow.count.mockResolvedValue(0);
    prisma.tripMember.count.mockResolvedValue(0);
    prisma.tripMedia.count.mockResolvedValue(0);
    prisma.tripMedia.findMany.mockResolvedValue([]);
    prisma.savedPlace.count.mockResolvedValue(0);
    prisma.savedPlace.findMany.mockResolvedValue([]);
    prisma.post.count.mockResolvedValue(0);
    prisma.post.findMany.mockResolvedValue([]);

    const showcase = await service.getShowcase('user-1');

    expect(showcase.ranking).toEqual({
      userId: 'user-1',
      totalPoints: 0,
      totalTripsCompleted: 0,
      rank: RANK.BEGINNER,
      ranking: null,
      percentile: null,
    });
    expect(showcase.ongoingTrip).toBeNull();
    expect(showcase.upcomingTrip).toBeNull();
    expect(prisma.itineraryItem.groupBy).not.toHaveBeenCalled();
  });

  it('rejects a missing user', async () => {
    const { service } = setup(null);
    await expect(service.getShowcase('missing')).rejects.toBeInstanceOf(
      NotFoundException,
    );
  });
});

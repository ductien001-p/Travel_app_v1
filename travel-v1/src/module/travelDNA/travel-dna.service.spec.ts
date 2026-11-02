import { PlaceStatus, TRAVEL_DNA_TYPE } from '../../generated/prisma/enums';
import { PrismaService } from '../../prisma.service';
import { S3Service } from '../../uploads/s3/s3.service';
import { travelDnaBadgeTitle } from './travel.constant';
import { TravelDnaService } from './travel-dna.service';

describe('travelDnaBadgeTitle', () => {
  it('keeps the type title from 60 and uses the potential label below', () => {
    expect(travelDnaBadgeTitle('FOODIE_TRAVELER', 80)).toBe('Bậc thầy vị giác');
    expect(travelDnaBadgeTitle('FOODIE_TRAVELER', 60)).toBe('Bậc thầy vị giác');
    expect(travelDnaBadgeTitle('FOODIE_TRAVELER', 59)).toBe(
      'Trục tiềm năng mở rộng',
    );
  });
});

describe('TravelDnaService.getRadar', () => {
  const createdAt = new Date('2026-10-01T00:00:00.000Z');
  const updatedAt = new Date('2026-10-25T00:00:00.000Z');

  function badge(
    type: TRAVEL_DNA_TYPE,
    score: number,
    counts: { tripTypeCount?: number; activityCount?: number } = {},
  ) {
    return {
      id: type,
      userId: 'me',
      type,
      score,
      tripTypeCount: counts.tripTypeCount ?? 0,
      activityCount: counts.activityCount ?? 0,
      createdAt,
      updatedAt,
    };
  }

  function setup(options?: {
    community?: Array<{
      type: TRAVEL_DNA_TYPE;
      average: number;
      sampleCount: number;
    }>;
    lowerCount?: number;
    trips?: Array<Record<string, unknown>>;
  }) {
    const viewer = [
      badge('FOODIE_TRAVELER', 88, { activityCount: 16 }),
      badge('PHOTOGRAPHY_LOVER', 72, { activityCount: 1 }),
      badge('ADVENTURE_TRAVELER', 52, { activityCount: 2 }),
    ];
    const friendDna = [
      { userId: 'high', type: 'FOODIE_TRAVELER', score: 88 },
      { userId: 'high', type: 'PHOTOGRAPHY_LOVER', score: 72 },
      { userId: 'high', type: 'ADVENTURE_TRAVELER', score: 52 },
      { userId: 'mid', type: 'FOODIE_TRAVELER', score: 100 },
      { userId: 'low', type: 'MOUNTAIN_LOVER', score: 100 },
      { userId: 'stranger', type: 'FOODIE_TRAVELER', score: 88 },
      { userId: 'stranger', type: 'PHOTOGRAPHY_LOVER', score: 72 },
      { userId: 'stranger', type: 'ADVENTURE_TRAVELER', score: 52 },
    ];
    const places = [
      {
        id: 'food-high',
        name: 'Cao lầu',
        city: 'Hội An',
        category: 'FOOD',
        status: 'APPROVED',
        averageRating: 4.8,
      },
      {
        id: 'food-mid',
        name: 'Bánh mì',
        city: 'Hội An',
        category: 'FOOD',
        status: 'APPROVED',
        averageRating: 4.2,
      },
      {
        id: 'food-hidden',
        name: 'Chưa duyệt',
        city: 'Huế',
        category: 'FOOD',
        status: 'PENDING',
        averageRating: 5,
      },
      {
        id: 'food-low',
        name: 'Phở',
        city: 'Hà Nội',
        category: 'FOOD',
        status: 'APPROVED',
        averageRating: 3,
      },
      {
        id: 'camp-1',
        name: 'Tà Năng',
        city: 'Bình Thuận',
        category: 'CAMPING',
        status: 'APPROVED',
        averageRating: 4.5,
      },
    ];
    const trips = options?.trips ?? [
      {
        id: 'trip-weak',
        name: 'Lên núi',
        tripType: 'OTHER',
        startDate: new Date('2026-11-01T00:00:00.000Z'),
        endDate: new Date('2026-11-03T00:00:00.000Z'),
        coverMedia: { objectKey: 'weak.jpg', deletedAt: null },
        itineraryItems: [{ place: { category: 'MOUNTAIN' } }],
        _count: { itineraryItems: 1 },
      },
      {
        id: 'trip-strong',
        name: 'Ăn Hội An',
        tripType: 'OTHER',
        startDate: new Date('2026-12-01T00:00:00.000Z'),
        endDate: new Date('2026-12-04T00:00:00.000Z'),
        coverMedia: { objectKey: 'strong.jpg', deletedAt: null },
        itineraryItems: [
          { place: { category: 'FOOD' } },
          { place: { category: 'FOOD' } },
        ],
        _count: { itineraryItems: 4 },
      },
      {
        id: 'trip-empty',
        name: 'Trống',
        tripType: 'OTHER',
        startDate: new Date('2026-12-10T00:00:00.000Z'),
        endDate: new Date('2026-12-12T00:00:00.000Z'),
        coverMedia: null,
        itineraryItems: [],
        _count: { itineraryItems: 0 },
      },
    ];

    const prisma = {
      userTravelDNA: {
        findMany: jest.fn(
          async (args: {
            where: {
              userId: string | { in: string[] };
              score?: { gt: number };
            };
          }) => {
            if (typeof args.where.userId === 'string') return viewer;
            const ids = args.where.userId.in;
            return friendDna.filter(
              (row) => ids.includes(row.userId) && row.score > 0,
            );
          },
        ),
        groupBy: jest.fn(async () =>
          (
            options?.community ?? [
              { type: 'FOODIE_TRAVELER', average: 62.4, sampleCount: 40 },
              { type: 'PHOTOGRAPHY_LOVER', average: 10, sampleCount: 5 },
            ]
          ).map((row) => ({
            type: row.type,
            _avg: { score: row.average },
            _count: { _all: row.sampleCount },
          })),
        ),
        count: jest.fn(async () => options?.lowerCount ?? 30),
      },
      place: {
        findMany: jest.fn(
          async (args: {
            where: { status: string; category: { in: string[] } };
            take: number;
          }) => {
            return places
              .filter(
                (place) =>
                  place.status === args.where.status &&
                  args.where.category.in.includes(place.category),
              )
              .sort(
                (left, right) =>
                  right.averageRating - left.averageRating ||
                  left.id.localeCompare(right.id),
              )
              .slice(0, args.take)
              .map(({ id, name, city }) => ({ id, name, city }));
          },
        ),
      },
      trip: {
        findMany: jest.fn(async () => trips),
      },
      friendship: {
        findMany: jest.fn(async () => [
          { friendId: 'high' },
          { friendId: 'mid' },
          { friendId: 'low' },
          { friendId: 'nodna' },
        ]),
      },
      user: {
        findMany: jest.fn(async (args: { where: { id: { in: string[] } } }) => {
          const users = [
            {
              id: 'high',
              displayname: 'Lan Phương',
              username: 'lanphuong',
              avatar: { objectKey: 'lan.jpg', deletedAt: null },
            },
            {
              id: 'mid',
              displayname: 'Quốc Bảo',
              username: 'bao',
              avatar: null,
            },
            {
              id: 'low',
              displayname: 'Hoàng Nam',
              username: 'nam',
              avatar: null,
            },
            {
              id: 'nodna',
              displayname: 'Không DNA',
              username: 'empty',
              avatar: null,
            },
            {
              id: 'stranger',
              displayname: 'Người lạ',
              username: 'stranger',
              avatar: null,
            },
          ];
          return users.filter((user) => args.where.id.in.includes(user.id));
        }),
      },
    };
    const s3 = {
      getPublicUrl: jest.fn((key: string) => `https://cdn.test/${key}`),
    };
    const service = new TravelDnaService(
      prisma as unknown as PrismaService,
      s3 as unknown as S3Service,
    );
    return { service, prisma, s3 };
  }

  it('builds the radar from dna, community, places, the best trip, and friends', async () => {
    const { service, prisma } = setup();

    const radar = await service.getRadar('me');

    expect(radar.dna.dominant).toMatchObject({
      type: 'FOODIE_TRAVELER',
      shortLabel: 'Ẩm Thực',
      badgeTitle: 'Bậc thầy vị giác',
      score: 88,
    });
    expect(
      radar.dna.all.find((badge) => badge.type === 'PHOTOGRAPHY_LOVER')
        ?.badgeTitle,
    ).toBe('Ống kính nghệ thuật');
    expect(
      radar.dna.all.find((badge) => badge.type === 'ADVENTURE_TRAVELER')
        ?.badgeTitle,
    ).toBe('Trục tiềm năng mở rộng');

    const foodie = radar.community.find(
      (row) => row.type === 'FOODIE_TRAVELER',
    );
    expect(foodie).toEqual({
      type: 'FOODIE_TRAVELER',
      averageScore: 62,
      sampleCount: 40,
    });
    expect(JSON.stringify(radar.community)).not.toContain('userId');
    expect(radar.dominantPercentile).toBe(75);
    expect(prisma.userTravelDNA.groupBy).toHaveBeenCalledWith(
      expect.objectContaining({
        by: ['type'],
        where: { score: { gt: 0 } },
      }),
    );

    expect(
      radar.fitPlaces.find((row) => row.type === 'PHOTOGRAPHY_LOVER'),
    ).toEqual({ type: 'PHOTOGRAPHY_LOVER', places: [] });
    expect(
      radar.fitPlaces.find((row) => row.type === 'FOODIE_TRAVELER')?.places,
    ).toEqual([
      { id: 'food-high', name: 'Cao lầu', city: 'Hội An' },
      { id: 'food-mid', name: 'Bánh mì', city: 'Hội An' },
    ]);
    const placeQueries = prisma.place.findMany.mock.calls.map(
      (call) => call[0].where,
    );
    expect(placeQueries).toEqual(
      expect.arrayContaining([
        expect.objectContaining({ status: PlaceStatus.APPROVED }),
      ]),
    );
    expect(
      placeQueries.some(
        (where: { category: { in: string[] } }) =>
          where.category.in.length === 0,
      ),
    ).toBe(false);

    expect(radar.journey).toEqual({
      tripId: 'trip-strong',
      name: 'Ăn Hội An',
      matchPercent: 70,
      startDate: '2026-12-01T00:00:00.000Z',
      endDate: '2026-12-04T00:00:00.000Z',
      coverImageUrl: 'https://cdn.test/strong.jpg',
      activityCount: 4,
    });
    expect(prisma.trip.findMany).toHaveBeenCalledWith(
      expect.objectContaining({
        where: {
          visibility: 'PUBLIC',
          status: { in: ['UPCOMING', 'ONGOING'] },
        },
        orderBy: { updatedAt: 'desc' },
        take: 50,
      }),
    );

    expect(radar.companions.map((person) => person.userId)).toEqual([
      'high',
      'mid',
    ]);
    expect(radar.companions[0]).toEqual({
      userId: 'high',
      displayName: 'Lan Phương',
      username: 'lanphuong',
      avatarUrl: 'https://cdn.test/lan.jpg',
      matchPercent: 100,
      persona: { name: 'Foodie Traveler', icon: '🍜' },
    });
    expect(radar.companions[1].matchPercent).toBe(70);
    expect(JSON.stringify(radar.companions)).not.toContain('"score"');
    const queriedFriendIds = prisma.user.findMany.mock.calls[0][0].where.id
      .in as string[];
    expect(queriedFriendIds).toEqual(['high', 'mid', 'low', 'nodna']);
    expect(queriedFriendIds).not.toContain('stranger');
  });

  it('hides the percentile when the dominant type has fewer than 20 scores', async () => {
    const { service, prisma } = setup({
      community: [{ type: 'FOODIE_TRAVELER', average: 40, sampleCount: 19 }],
    });

    const radar = await service.getRadar('me');

    expect(radar.dominantPercentile).toBeNull();
    expect(prisma.userTravelDNA.count).not.toHaveBeenCalled();
  });

  it('returns no journey when every candidate score is null', async () => {
    const { service } = setup({
      trips: [
        {
          id: 'trip-empty',
          name: 'Trống',
          tripType: 'OTHER',
          startDate: new Date('2026-12-10T00:00:00.000Z'),
          endDate: new Date('2026-12-12T00:00:00.000Z'),
          coverMedia: null,
          itineraryItems: [],
          _count: { itineraryItems: 0 },
        },
      ],
    });

    const radar = await service.getRadar('me');

    expect(radar.journey).toBeNull();
  });
});

import { TripDiscoverService } from './trip-discover.service';
import type { QueryDiscoverTripDto } from '../dto/query-discover-trip.dto';

function row(id: string, createdAt: string) {
  const start = new Date('2026-11-01T00:00:00.000Z');
  return {
    id,
    name: id,
    description: null,
    startDate: start,
    endDate: start,
    budgetLevel: null,
    maxMembers: 4,
    tripType: 'OTHER',
    visibility: 'PUBLIC',
    status: 'UPCOMING',
    createdAt: new Date(createdAt),
    coverMedia: null,
    owner: {
      id: 'owner-1',
      displayname: 'Owner',
      username: 'owner',
      avatar: null,
    },
    _count: { members: 1 },
    members: [],
    destinations: [
      {
        id: `${id}-dest`,
        city: 'Huế',
        country: 'Việt Nam',
        lat: 16,
        lng: 107,
        order: 1,
        startDate: start,
        endDate: start,
        destinationType: null,
      },
    ],
    recruitment: {
      requirements: null,
      estimatedBudgetPerPerson: null,
      expiresAt: new Date('2026-12-01T00:00:00.000Z'),
      urgent: id === 'newest',
    },
    interests: [],
    itineraryItems: [],
  };
}

describe('TripDiscoverService', () => {
  function setup() {
    const prisma = {
      user: {
        findUnique: jest.fn().mockResolvedValue({
          budgetLevel: null,
          interests: [],
          travelStyle: [],
        }),
      },
      trip: {
        findMany: jest.fn().mockImplementation((args: { take?: number }) => {
          if (args.take === 40) return Promise.resolve([]);
          return Promise.resolve([
            row('older', '2026-10-24T01:00:00.000Z'),
            row('newest', '2026-10-24T03:00:00.000Z'),
            row('middle', '2026-10-24T02:00:00.000Z'),
          ]);
        }),
      },
    };
    const s3 = { getPublicUrl: jest.fn() };
    const service = new TripDiscoverService(prisma as never, s3 as never);
    return { service, prisma };
  }

  const query = {
    category: 'beach',
    seed: 'seed-alpha-01',
    timezoneOffsetMinutes: 420,
    page: 1,
    limit: 2,
  } as QueryDiscoverTripDto;

  it('applies the beach category on the candidate query', async () => {
    const { service, prisma } = setup();
    await service.discover(query, 'user-1');
    const candidate = prisma.trip.findMany.mock.calls.find(
      (call) => call[0].take === undefined,
    );
    expect(JSON.stringify(candidate?.[0].where)).toContain('BEACH');
    expect(JSON.stringify(candidate?.[0].where)).toContain('PUBLIC');
  });

  it('returns a cold-start page with null scores and continues on the next page', async () => {
    const { service } = setup();
    const first = await service.discover(query, 'user-1');
    const second = await service.discover({ ...query, page: 2 }, 'user-1');

    const combined = [...first.data, ...second.data];
    expect(first.data.map((item) => item.matchScore)).toEqual([null, null]);
    expect(combined.find((item) => item.id === 'newest')?.urgent).toBe(true);
    expect(combined.find((item) => item.id === 'middle')?.urgent).toBe(false);
    expect(combined.map((item) => item.id)[0]).toBe('newest');
    expect(first.meta).toMatchObject({
      page: 1,
      limit: 2,
      total: 3,
      hasNextPage: true,
    });
    expect(second.data).toHaveLength(1);
    expect(new Set(combined.map((item) => item.id)).size).toBe(3);
  });
});

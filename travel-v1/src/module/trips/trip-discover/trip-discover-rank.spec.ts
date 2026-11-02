import type {
  DiscoverRankTrip,
  DiscoverViewerProfile,
} from './trip-discover-rank';
import { rankDiscoverTrips, seededShuffle } from './trip-discover-rank';

const NOW = new Date('2026-10-24T04:00:00.000Z');

function trip(
  overrides: Partial<DiscoverRankTrip> & Pick<DiscoverRankTrip, 'id'>,
): DiscoverRankTrip {
  return {
    createdAt: NOW,
    tripType: 'OTHER',
    budgetLevel: null,
    interestNames: [],
    cities: [],
    destinationTypes: [],
    placeCategories: [],
    slotsRemaining: 1,
    expiresAt: null,
    ...overrides,
  };
}

function ids<T extends { id: string }>(ranked: Array<{ item: T }>): string[] {
  return ranked.map((entry) => entry.item.id);
}

function orderChanged(
  trips: DiscoverRankTrip[],
  viewer: DiscoverViewerProfile,
): boolean {
  const first = ids(
    rankDiscoverTrips(trips, viewer, 'seed-alpha-01', NOW),
  ).join();
  for (let index = 0; index < 20; index += 1) {
    const next = ids(
      rankDiscoverTrips(trips, viewer, `seed-beta-${index}`, NOW),
    ).join();
    if (next !== first) return true;
  }
  return false;
}

describe('seededShuffle', () => {
  const items = ['a', 'b', 'c', 'd'];

  it('repeats the same order for one seed', () => {
    expect(seededShuffle(items, 'seed-alpha-01')).toEqual(
      seededShuffle(items, 'seed-alpha-01'),
    );
  });

  it('changes order when the seed changes', () => {
    const first = seededShuffle(items, 'seed-alpha-01').join();
    const changed = Array.from({ length: 20 }, (_, index) =>
      seededShuffle(items, `seed-beta-${index}`).join(),
    ).some((order) => order !== first);
    expect(changed).toBe(true);
  });
});

describe('rankDiscoverTrips', () => {
  it('ranks a beach destination above a mountain trip for a beach lover', () => {
    const viewer: DiscoverViewerProfile = {
      dna: [{ type: 'BEACH_LOVER', score: 8 }],
      budgetLevel: 'LOW',
      interests: [],
      pastCities: [],
      pastDestinationTypes: [],
    };
    const trips = [
      trip({
        id: 'mountain',
        destinationTypes: ['MOUNTAIN'],
        budgetLevel: 'LOW',
        slotsRemaining: 9,
      }),
      trip({
        id: 'beach',
        destinationTypes: ['beach'],
        budgetLevel: 'HIGH',
        slotsRemaining: 0,
      }),
    ];

    const ranked = rankDiscoverTrips(trips, viewer, 'seed-alpha-01', NOW);
    expect(ids(ranked)).toEqual(['beach', 'mountain']);
    expect(ranked[0].matchScore).toBeGreaterThan(ranked[1].matchScore ?? 0);
  });

  it('uses itinerary place categories instead of destination type when both exist', () => {
    const beachLover: DiscoverViewerProfile = {
      dna: [{ type: 'BEACH_LOVER', score: 4 }],
      budgetLevel: null,
      interests: [],
      pastCities: [],
      pastDestinationTypes: [],
    };
    const foodie: DiscoverViewerProfile = {
      ...beachLover,
      dna: [{ type: 'FOODIE_TRAVELER', score: 4 }],
    };
    const mixed = trip({
      id: 'mixed',
      destinationTypes: ['BEACH'],
      placeCategories: ['FOOD'],
    });

    expect(
      rankDiscoverTrips([mixed], foodie, 'seed-alpha-01', NOW)[0].matchScore,
    ).toBe(100);
    expect(
      rankDiscoverTrips([mixed], beachLover, 'seed-alpha-01', NOW)[0]
        .matchScore,
    ).toBe(0);
  });

  it('keeps the higher score ahead of a lower score that has more open slots', () => {
    const viewer: DiscoverViewerProfile = {
      dna: [],
      budgetLevel: null,
      interests: ['food'],
      pastCities: [],
      pastDestinationTypes: [],
    };
    const trips = [
      trip({ id: 'weak', interestNames: [], slotsRemaining: 20 }),
      trip({ id: 'strong', interestNames: ['Food'], slotsRemaining: 1 }),
    ];
    const first = ids(rankDiscoverTrips(trips, viewer, 'seed-alpha-01', NOW));
    const second = ids(rankDiscoverTrips(trips, viewer, 'seed-beta-02', NOW));
    expect(first).toEqual(['strong', 'weak']);
    expect(second).toEqual(['strong', 'weak']);
  });

  it('keeps distinct top-band scores in order and rotates a lower band with the seed', () => {
    const viewer: DiscoverViewerProfile = {
      dna: [],
      budgetLevel: null,
      interests: ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'],
      pastCities: [],
      pastDestinationTypes: [],
    };
    const top = [
      trip({
        id: 'best',
        interestNames: ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'],
      }),
      trip({
        id: 'next',
        interestNames: ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i'],
      }),
    ];
    const lower = ['c', 'd', 'e', 'f'].map((id) =>
      trip({ id, interestNames: [] }),
    );
    const trips = [...lower, ...top];

    const alpha = rankDiscoverTrips(trips, viewer, 'seed-alpha-01', NOW);
    const beta = rankDiscoverTrips(trips, viewer, 'seed-beta-02', NOW);
    expect(ids(alpha).slice(0, 2)).toEqual(['best', 'next']);
    expect(ids(beta).slice(0, 2)).toEqual(['best', 'next']);
    expect(orderChanged(trips, viewer)).toBe(true);
    expect(new Set(ids(alpha)).size).toBe(trips.length);
  });

  it('gives a cold start no match score and rotates every trip after the newest', () => {
    const viewer: DiscoverViewerProfile = {
      dna: [],
      budgetLevel: null,
      interests: [],
      pastCities: [],
      pastDestinationTypes: [],
    };
    const trips = [
      trip({ id: 'older-b', createdAt: new Date('2026-10-24T01:00:00.000Z') }),
      trip({ id: 'newest', createdAt: new Date('2026-10-24T03:00:00.000Z') }),
      trip({ id: 'older-a', createdAt: new Date('2026-10-24T02:00:00.000Z') }),
      trip({ id: 'older-c', createdAt: new Date('2026-10-23T20:00:00.000Z') }),
    ];

    const ranked = rankDiscoverTrips(trips, viewer, 'seed-alpha-01', NOW);
    expect(ranked.every((entry) => entry.matchScore === null)).toBe(true);
    expect(ids(ranked)[0]).toBe('newest');
    expect(ids(rankDiscoverTrips(trips, viewer, 'seed-alpha-01', NOW))).toEqual(
      ids(ranked),
    );
    expect(orderChanged(trips, viewer)).toBe(true);
    expect(ids(rankDiscoverTrips(trips, viewer, 'seed-beta-02', NOW))[0]).toBe(
      'newest',
    );
  });

  it('pages as a stable prefix of the same seed', () => {
    const viewer: DiscoverViewerProfile = {
      dna: [{ type: 'BEACH_LOVER', score: 3 }],
      budgetLevel: null,
      interests: [],
      pastCities: ['Đà Nẵng'],
      pastDestinationTypes: [],
    };
    const trips = Array.from({ length: 12 }, (_, index) =>
      trip({
        id: `trip-${index}`,
        destinationTypes: index % 2 === 0 ? ['BEACH'] : ['MOUNTAIN'],
        cities: index % 2 === 0 ? ['Đà Nẵng'] : ['Huế'],
        createdAt: new Date(NOW.getTime() - index * 60_000),
      }),
    );
    const ranked = ids(rankDiscoverTrips(trips, viewer, 'seed-alpha-01', NOW));
    expect(ranked.slice(0, 5).concat(ranked.slice(5))).toEqual(ranked);
    expect(new Set(ranked).size).toBe(trips.length);
  });
});

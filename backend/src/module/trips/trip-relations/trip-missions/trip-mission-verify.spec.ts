import {
  computeMissionProgress,
  resolveCheckinTargetCount,
} from './trip-mission-verify';

describe('trip-mission-verify', () => {
  it('caps checkin target to itinerary size', () => {
    expect(resolveCheckinTargetCount(3, 2)).toBe(2);
    expect(resolveCheckinTargetCount(3, 10)).toBe(3);
  });

  it('counts distinct checkin places once', () => {
    const progress = computeMissionProgress({
      verifyType: 'CHECKIN_COUNT',
      verifyPayload: {},
      targetCount: 3,
      itineraryPlaceCount: 5,
      checkins: [
        { placeId: 'a', city: 'Hue', category: 'MUSEUM' },
        { placeId: 'a', city: 'Hue', category: 'MUSEUM' },
        { placeId: 'b', city: 'Hue', category: 'CAFE' },
      ],
      historicalCities: new Set(),
      memoryCount: 0,
    });
    expect(progress).toBe(2);
  });

  it('counts only new cities', () => {
    const progress = computeMissionProgress({
      verifyType: 'CHECKIN_NEW_CITY',
      verifyPayload: {},
      targetCount: 1,
      itineraryPlaceCount: 2,
      checkins: [
        { placeId: 'a', city: 'Hue', category: 'MUSEUM' },
        { placeId: 'b', city: 'Da Nang', category: 'BEACH' },
      ],
      historicalCities: new Set(['hue']),
      memoryCount: 0,
    });
    expect(progress).toBe(1);
  });

  it('matches place categories', () => {
    const progress = computeMissionProgress({
      verifyType: 'CHECKIN_PLACE_CATEGORY',
      verifyPayload: { categories: ['FOOD', 'CAFE'] },
      targetCount: 1,
      itineraryPlaceCount: 2,
      checkins: [
        { placeId: 'a', city: 'Hue', category: 'MUSEUM' },
        { placeId: 'b', city: 'Hue', category: 'CAFE' },
      ],
      historicalCities: new Set(),
      memoryCount: 0,
    });
    expect(progress).toBe(1);
  });

  it('counts memories', () => {
    expect(
      computeMissionProgress({
        verifyType: 'MEMORY_COUNT',
        verifyPayload: {},
        targetCount: 3,
        itineraryPlaceCount: 1,
        checkins: [],
        historicalCities: new Set(),
        memoryCount: 5,
      }),
    ).toBe(3);
  });
});

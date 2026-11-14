import { planTripMissions, SeedTemplate } from './trip-mission-seed';
import { MAX_MISSIONS_PER_TRIP } from './trip-mission.constants';

function template(
  partial: Partial<SeedTemplate> & Pick<SeedTemplate, 'code' | 'id'>,
): SeedTemplate {
  return {
    group: 'EXPLORATION',
    title: partial.code,
    subtitle: '',
    icon: 'icon',
    verifyType: 'CHECKIN_COUNT',
    verifyPayload: {},
    pointsReward: 30,
    targetCountDefault: 3,
    scope: 'PERSONAL',
    sortOrder: 1,
    seedRules: [{ placeCategories: [], requireNewCity: false, priority: 10 }],
    ...partial,
  };
}

describe('planTripMissions', () => {
  it('always seeds unconditional templates and caps at max', () => {
    const templates = [
      template({ id: '1', code: 'CHECKIN_PLACES', sortOrder: 1, seedRules: [{ placeCategories: [], requireNewCity: false, priority: 10 }] }),
      template({
        id: '2',
        code: 'TRIP_MEMORIES',
        verifyType: 'MEMORY_COUNT',
        sortOrder: 2,
        seedRules: [{ placeCategories: [], requireNewCity: false, priority: 20 }],
      }),
      template({
        id: '3',
        code: 'NEW_CITY',
        verifyType: 'CHECKIN_NEW_CITY',
        sortOrder: 3,
        seedRules: [{ placeCategories: [], requireNewCity: true, priority: 30 }],
      }),
      template({
        id: '4',
        code: 'LOCAL_FOOD',
        verifyType: 'CHECKIN_PLACE_CATEGORY',
        sortOrder: 4,
        seedRules: [{ placeCategories: ['FOOD'], requireNewCity: false, priority: 40 }],
      }),
      template({
        id: '5',
        code: 'CULTURE_SITE',
        verifyType: 'CHECKIN_PLACE_CATEGORY',
        sortOrder: 5,
        seedRules: [{ placeCategories: ['MUSEUM'], requireNewCity: false, priority: 50 }],
      }),
      template({
        id: '6',
        code: 'NATURE_SPOT',
        verifyType: 'CHECKIN_PLACE_CATEGORY',
        sortOrder: 6,
        seedRules: [{ placeCategories: ['BEACH'], requireNewCity: false, priority: 60 }],
      }),
    ];

    const plan = planTripMissions(templates, {
      itineraryPlaceCount: 4,
      itineraryCategories: new Set(['FOOD', 'MUSEUM', 'BEACH']),
      itineraryCities: new Set(['hue']),
      historicalCities: new Set(),
    });

    expect(plan.length).toBe(MAX_MISSIONS_PER_TRIP);
    expect(plan.map((p) => p.code)).toEqual([
      'CHECKIN_PLACES',
      'TRIP_MEMORIES',
      'NEW_CITY',
      'LOCAL_FOOD',
      'CULTURE_SITE',
    ]);
  });

  it('skips category missions when itinerary has no match', () => {
    const templates = [
      template({ id: '1', code: 'CHECKIN_PLACES' }),
      template({
        id: '4',
        code: 'LOCAL_FOOD',
        seedRules: [{ placeCategories: ['FOOD'], requireNewCity: false, priority: 40 }],
      }),
    ];
    const plan = planTripMissions(templates, {
      itineraryPlaceCount: 2,
      itineraryCategories: new Set(['BEACH']),
      itineraryCities: new Set(['nha trang']),
      historicalCities: new Set(['nha trang']),
    });
    expect(plan.map((p) => p.code)).toEqual(['CHECKIN_PLACES']);
  });

  it('skips NEW_CITY when all cities already visited', () => {
    const templates = [
      template({
        id: '3',
        code: 'NEW_CITY',
        verifyType: 'CHECKIN_NEW_CITY',
        seedRules: [{ placeCategories: [], requireNewCity: true, priority: 30 }],
      }),
    ];
    const plan = planTripMissions(templates, {
      itineraryPlaceCount: 1,
      itineraryCategories: new Set(['CAFE']),
      itineraryCities: new Set(['hue']),
      historicalCities: new Set(['hue']),
    });
    expect(plan).toEqual([]);
  });
});

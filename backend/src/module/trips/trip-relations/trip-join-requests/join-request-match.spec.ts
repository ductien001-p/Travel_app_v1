import {
  buildTripDnaProfile,
  dnaSimilarity,
  joinRequestMatchScore,
  topProfilePersona,
  topTravelPersona,
  travelPersonaLabel,
} from './join-request-match';

describe('topTravelPersona', () => {
  it('names the strongest Travel DNA of the user', () => {
    expect(
      topTravelPersona([
        { type: 'BEACH_LOVER', score: 3 },
        { type: 'FOODIE_TRAVELER', score: 8 },
      ]),
    ).toEqual({
      personaType: 'FOODIE_TRAVELER',
      travelPersona: 'Foodie Traveler',
    });
  });

  it('breaks ties by type so the label is stable', () => {
    expect(
      topTravelPersona([
        { type: 'MOUNTAIN_LOVER', score: 5 },
        { type: 'BEACH_LOVER', score: 5 },
      ])?.personaType,
    ).toBe('BEACH_LOVER');
  });

  it('is null without any positive score', () => {
    expect(topTravelPersona([{ type: 'BACKPACKER', score: 0 }])).toBeNull();
    expect(topTravelPersona([])).toBeNull();
  });
});

describe('travelPersonaLabel', () => {
  it('appends the Travel DNA icon', () => {
    expect(travelPersonaLabel([{ type: 'BEACH_LOVER', score: 4 }])).toBe(
      'Beach Lover 🏖️',
    );
  });
});

describe('topProfilePersona', () => {
  it('names the heaviest Travel DNA of the trip', () => {
    const profile = buildTripDnaProfile('OTHER', ['BEACH', 'FOOD', 'FOOD']);

    expect(topProfilePersona(profile)?.personaType).toBe('FOODIE_TRAVELER');
    expect(topProfilePersona(profile)?.travelPersona).toBe(
      'Foodie Traveler 🍜',
    );
  });

  it('is null when the trip has nothing to compare', () => {
    expect(topProfilePersona(buildTripDnaProfile('OTHER', []))).toBeNull();
  });
});

describe('buildTripDnaProfile', () => {
  it('weighs the trip type and the itinerary places half each', () => {
    const profile = buildTripDnaProfile('FRIENDS', [
      'FOOD',
      'FOOD',
      'BEACH',
      'MUSEUM',
    ]);

    expect(profile.get('GROUP_TRAVELER')).toBeCloseTo(0.5);
    expect(profile.get('FOODIE_TRAVELER')).toBeCloseTo(0.25);
    expect(profile.get('BEACH_LOVER')).toBeCloseTo(0.125);
    expect(profile.get('CULTURE_TRAVELER')).toBeCloseTo(0.125);
  });

  it('uses the places alone when the trip type has no Travel DNA', () => {
    const profile = buildTripDnaProfile('OTHER', ['BEACH']);

    expect([...profile]).toEqual([['BEACH_LOVER', 1]]);
  });

  it('is empty for an untyped trip without places', () => {
    expect(buildTripDnaProfile('OTHER', []).size).toBe(0);
  });
});

describe('joinRequestMatchScore', () => {
  const profile = buildTripDnaProfile('OTHER', ['FOOD', 'FOOD', 'BEACH']);

  it('is 100 for a user shaped exactly like the trip', () => {
    expect(
      joinRequestMatchScore(profile, [
        { type: 'FOODIE_TRAVELER', score: 20 },
        { type: 'BEACH_LOVER', score: 10 },
      ]),
    ).toBe(100);
  });

  it('rewards the Travel DNA the trip is about', () => {
    const foodie = joinRequestMatchScore(profile, [
      { type: 'FOODIE_TRAVELER', score: 10 },
    ]);
    const mountain = joinRequestMatchScore(profile, [
      { type: 'MOUNTAIN_LOVER', score: 10 },
    ]);

    expect(foodie).toBe(89);
    expect(mountain).toBe(0);
  });

  it('is null when there is nothing to compare', () => {
    expect(joinRequestMatchScore(profile, [])).toBeNull();
    expect(
      joinRequestMatchScore(new Map(), [{ type: 'BACKPACKER', score: 4 }]),
    ).toBeNull();
  });
});

describe('dnaSimilarity', () => {
  it('is 100 when two friends share the same Travel DNA shape', () => {
    expect(
      dnaSimilarity(
        [{ type: 'FOODIE_TRAVELER', score: 10 }],
        [{ type: 'FOODIE_TRAVELER', score: 80 }],
      ),
    ).toBe(100);
    expect(
      dnaSimilarity(
        [
          { type: 'FOODIE_TRAVELER', score: 80 },
          { type: 'CULTURE_TRAVELER', score: 40 },
        ],
        [
          { type: 'CULTURE_TRAVELER', score: 40 },
          { type: 'FOODIE_TRAVELER', score: 80 },
        ],
      ),
    ).toBe(100);
  });

  it('drops toward zero when the vectors barely overlap', () => {
    expect(
      dnaSimilarity(
        [{ type: 'FOODIE_TRAVELER', score: 100 }],
        [{ type: 'MOUNTAIN_LOVER', score: 100 }],
      ),
    ).toBe(0);
    expect(
      dnaSimilarity(
        [
          { type: 'FOODIE_TRAVELER', score: 3 },
          { type: 'BEACH_LOVER', score: 4 },
        ],
        [{ type: 'FOODIE_TRAVELER', score: 3 }],
      ),
    ).toBe(60);
  });

  it('ignores zero scores and is null when a side has none', () => {
    expect(
      dnaSimilarity(
        [
          { type: 'FOODIE_TRAVELER', score: 8 },
          { type: 'BEACH_LOVER', score: 0 },
        ],
        [{ type: 'FOODIE_TRAVELER', score: 2 }],
      ),
    ).toBe(100);
    expect(
      dnaSimilarity([], [{ type: 'FOODIE_TRAVELER', score: 4 }]),
    ).toBeNull();
    expect(
      dnaSimilarity(
        [{ type: 'FOODIE_TRAVELER', score: 0 }],
        [{ type: 'FOODIE_TRAVELER', score: 4 }],
      ),
    ).toBeNull();
  });
});

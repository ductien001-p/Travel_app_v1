import { resolveTravelTierForTest } from './travel-tier.service';
import { TRAVEL_TIER_CODE } from '../../../../generated/prisma/enums';

describe('resolveTravelTierForTest', () => {
  it('returns ROOKIE at first completed trip', () => {
    expect(resolveTravelTierForTest(1, 0).code).toBe(TRAVEL_TIER_CODE.ROOKIE);
    expect(resolveTravelTierForTest(1, 0).multiplier).toBe(1);
  });

  it('requires cities for TRAVELER and above', () => {
    expect(resolveTravelTierForTest(7, 2).code).toBe(TRAVEL_TIER_CODE.EXPLORER);
    expect(resolveTravelTierForTest(7, 3).code).toBe(TRAVEL_TIER_CODE.TRAVELER);
    expect(resolveTravelTierForTest(7, 3).multiplier).toBe(1.2);
  });

  it('caps at LEGEND x1.5', () => {
    expect(resolveTravelTierForTest(30, 10).code).toBe(TRAVEL_TIER_CODE.LEGEND);
    expect(resolveTravelTierForTest(30, 10).multiplier).toBe(1.5);
  });
});

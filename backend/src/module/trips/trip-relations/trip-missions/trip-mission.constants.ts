export const MISSION_POINTS_CAP = 80;
export const MAX_MISSIONS_PER_TRIP = 5;

export const FOOD_PLACE_CATEGORIES = [
  'FOOD',
  'CAFE',
  'MARKET',
  'NIGHT_MARKET',
] as const;

export const CULTURE_PLACE_CATEGORIES = [
  'MUSEUM',
  'TEMPLES',
  'CHURCH',
  'HISTORICAL_SITE',
  'MONUMENT',
  'PALACE',
  'CASTLE',
  'OLD_TOWN',
] as const;

export const NATURE_PLACE_CATEGORIES = [
  'BEACH',
  'MOUNTAIN',
  'WATERFALL',
  'PARK',
  'LAKE',
  'CAVE',
  'CAMPING',
] as const;

export type MissionCta = 'ITINERARY' | 'MEMORIES';

export function missionCtaForVerify(
  verifyType: string,
): MissionCta {
  return verifyType === 'MEMORY_COUNT' ? 'MEMORIES' : 'ITINERARY';
}

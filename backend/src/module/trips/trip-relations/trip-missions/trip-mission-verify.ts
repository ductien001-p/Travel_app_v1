import { PLACE_CATEGORY } from '../../../../generated/prisma/enums';

export type VerifyPayload = {
  categories?: string[];
};

export type CheckinEvidence = {
  placeId: string;
  city: string;
  category: PLACE_CATEGORY | string;
};

export type MissionVerifyInput = {
  verifyType: string;
  verifyPayload: VerifyPayload | Record<string, unknown> | null;
  targetCount: number;
  itineraryPlaceCount: number;
  checkins: CheckinEvidence[];
  /** Cities the user has checked into on previous trips (before this trip). */
  historicalCities: ReadonlySet<string>;
  memoryCount: number;
};

function asPayload(
  raw: MissionVerifyInput['verifyPayload'],
): VerifyPayload {
  if (!raw || typeof raw !== 'object') {
    return {};
  }
  return raw as VerifyPayload;
}

/** Counts progress for one mission from already-loaded evidence. */
export function computeMissionProgress(
  input: MissionVerifyInput,
): number {
  const payload = asPayload(input.verifyPayload);
  switch (input.verifyType) {
    case 'CHECKIN_COUNT': {
      const distinct = new Set(input.checkins.map((c) => c.placeId));
      return Math.min(distinct.size, input.targetCount);
    }
    case 'CHECKIN_NEW_CITY': {
      const newCities = new Set(
        input.checkins
          .map((c) => c.city.trim().toLowerCase())
          .filter((city) => city.length > 0 && !input.historicalCities.has(city)),
      );
      return Math.min(newCities.size, input.targetCount);
    }
    case 'CHECKIN_PLACE_CATEGORY': {
      const allowed = new Set(
        (payload.categories ?? []).map((c) => String(c).toUpperCase()),
      );
      const matched = new Set(
        input.checkins
          .filter((c) => allowed.has(String(c.category).toUpperCase()))
          .map((c) => c.placeId),
      );
      return Math.min(matched.size, input.targetCount);
    }
    case 'MEMORY_COUNT':
      return Math.min(input.memoryCount, input.targetCount);
    default:
      return 0;
  }
}

export function resolveCheckinTargetCount(
  defaultTarget: number,
  itineraryPlaceCount: number,
): number {
  if (itineraryPlaceCount <= 0) {
    return Math.max(1, defaultTarget);
  }
  return Math.max(1, Math.min(defaultTarget, itineraryPlaceCount));
}

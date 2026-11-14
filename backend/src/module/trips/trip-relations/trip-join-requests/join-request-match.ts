import {
  PLACE_CATEGORY,
  TRAVEL_DNA_TYPE,
  TRIP_TYPE,
} from '../../../../generated/prisma/enums';
import { TRAVEL_DNA_CONFIG } from '../../../travelDNA/travel.constant';

export type TravelDnaScore = { type: TRAVEL_DNA_TYPE; score: number };

export type TravelPersona = {
  personaType: TRAVEL_DNA_TYPE;
  travelPersona: string;
};

/** How much each Travel DNA type fits a trip, summing to 1. */
export type TripDnaProfile = ReadonlyMap<TRAVEL_DNA_TYPE, number>;

const DNA_TYPES = Object.keys(TRAVEL_DNA_CONFIG) as TRAVEL_DNA_TYPE[];

/** The strongest Travel DNA of a user; ties go to the first type by name. */
export function topTravelPersona(
  scores: readonly TravelDnaScore[],
): TravelPersona | null {
  let top: TravelDnaScore | null = null;
  for (const entry of scores) {
    if (entry.score <= 0) continue;
    if (
      !top ||
      entry.score > top.score ||
      (entry.score === top.score && entry.type < top.type)
    ) {
      top = entry;
    }
  }
  if (!top) return null;
  return {
    personaType: top.type,
    travelPersona: TRAVEL_DNA_CONFIG[top.type].name,
  };
}

/**
 * The trip type and the places of the itinerary weigh half each; a trip with
 * only one of them is described by that one alone.
 */
export function buildTripDnaProfile(
  tripType: TRIP_TYPE,
  placeCategories: readonly PLACE_CATEGORY[],
): TripDnaProfile {
  const typeWeights = normalize(
    DNA_TYPES.filter((type) =>
      TRAVEL_DNA_CONFIG[type].tripTypes.includes(tripType),
    ).map((type) => [type, 1]),
  );

  const placeCounts = new Map<TRAVEL_DNA_TYPE, number>();
  for (const category of placeCategories) {
    for (const type of DNA_TYPES) {
      if (TRAVEL_DNA_CONFIG[type].activities.includes(category)) {
        placeCounts.set(type, (placeCounts.get(type) ?? 0) + 1);
      }
    }
  }
  const placeWeights = normalize([...placeCounts]);

  const parts = [typeWeights, placeWeights].filter((part) => part.size > 0);
  const profile = new Map<TRAVEL_DNA_TYPE, number>();
  for (const part of parts) {
    for (const [type, weight] of part) {
      profile.set(type, (profile.get(type) ?? 0) + weight / parts.length);
    }
  }
  return profile;
}

/** The Travel DNA the trip leans toward most. Ties use the first type by name. */
export function topProfilePersona(
  profile: TripDnaProfile,
): TravelPersona | null {
  let top: { type: TRAVEL_DNA_TYPE; weight: number } | null = null;
  for (const [type, weight] of profile) {
    if (weight <= 0) continue;
    if (
      !top ||
      weight > top.weight ||
      (weight === top.weight && type < top.type)
    ) {
      top = { type, weight };
    }
  }
  if (!top) return null;
  const badge = TRAVEL_DNA_CONFIG[top.type];
  return {
    personaType: top.type,
    travelPersona: `${badge.name} ${badge.icon}`,
  };
}

/** Badge label of a user's strongest Travel DNA, including the icon. */
export function travelPersonaLabel(
  scores: readonly TravelDnaScore[],
): string | null {
  const persona = topTravelPersona(scores);
  if (!persona) return null;
  const badge = TRAVEL_DNA_CONFIG[persona.personaType];
  return `${badge.name} ${badge.icon}`;
}

/**
 * Cosine similarity of two Travel DNA score vectors, as a 0..100 percentage.
 * Missing types count as zero. Null when either side has no positive score.
 */
export function dnaSimilarity(
  left: readonly TravelDnaScore[],
  right: readonly TravelDnaScore[],
): number | null {
  const leftPositive = left.filter((entry) => entry.score > 0);
  const rightPositive = right.filter((entry) => entry.score > 0);
  if (leftPositive.length === 0 || rightPositive.length === 0) return null;

  const rightByType = new Map(
    rightPositive.map((entry) => [entry.type, entry.score]),
  );
  let dot = 0;
  let leftNorm = 0;
  for (const { type, score } of leftPositive) {
    dot += (rightByType.get(type) ?? 0) * score;
    leftNorm += score * score;
  }
  let rightNorm = 0;
  for (const { score } of rightPositive) rightNorm += score * score;

  const similarity = dot / Math.sqrt(leftNorm * rightNorm);
  return Math.round(Math.min(Math.max(similarity, 0), 1) * 100);
}

/**
 * Cosine similarity between the trip profile and the user's Travel DNA, as a
 * 0..100 percentage. Null when either side has nothing to compare.
 */
export function joinRequestMatchScore(
  profile: TripDnaProfile,
  scores: readonly TravelDnaScore[],
): number | null {
  if (profile.size === 0) return null;
  return dnaSimilarity(
    [...profile].map(([type, score]) => ({ type, score })),
    scores,
  );
}

function normalize(
  entries: Array<[TRAVEL_DNA_TYPE, number]>,
): Map<TRAVEL_DNA_TYPE, number> {
  const total = entries.reduce((sum, [, weight]) => sum + weight, 0);
  return new Map(
    total > 0 ? entries.map(([type, weight]) => [type, weight / total]) : [],
  );
}

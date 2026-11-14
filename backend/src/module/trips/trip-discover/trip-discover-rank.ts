import {
  BudgetLevel,
  PLACE_CATEGORY,
  TRIP_TYPE,
} from '../../../generated/prisma/enums';
import {
  buildTripDnaProfile,
  joinRequestMatchScore,
  type TravelDnaScore,
} from '../trip-relations/trip-join-requests/join-request-match';

const SCORE_BAND = 10;
const DAY_MS = 24 * 60 * 60 * 1000;
const DNA_WEIGHT = 60;
const BUDGET_WEIGHT = 15;
const INTEREST_WEIGHT = 15;
const HISTORY_WEIGHT = 10;
const EXPLORE_PAGE = 10;
const EXPLORE_SLOTS = 2;

const PLACE_CATEGORY_VALUES = new Set<string>(Object.values(PLACE_CATEGORY));

export type DiscoverRankTrip = {
  id: string;
  createdAt: Date;
  tripType: TRIP_TYPE;
  budgetLevel: BudgetLevel | null;
  interestNames: readonly string[];
  cities: readonly string[];
  destinationTypes: readonly string[];
  placeCategories: readonly PLACE_CATEGORY[];
  slotsRemaining: number;
  expiresAt: Date | null;
};

export type DiscoverViewerProfile = {
  dna: readonly TravelDnaScore[];
  budgetLevel: BudgetLevel | null;
  interests: readonly string[];
  pastCities: readonly string[];
  pastDestinationTypes: readonly string[];
};

export type RankedDiscoverTrip<T> = {
  item: T;
  matchScore: number | null;
};

type Scored<T> = RankedDiscoverTrip<T> & { band: number };

/**
 * Ranks open trips for one Home visit.
 * The highest score band stays in score order. Lower bands and exact ties
 * rotate with `seed`. About 2 of every 10 slots after that band are drawn
 * from the tail. A viewer with no DNA, budget, interests, or past trips is
 * ordered by recency, then the tail rotates so the next seed is not a copy.
 */
export function rankDiscoverTrips<T extends DiscoverRankTrip>(
  trips: readonly T[],
  viewer: DiscoverViewerProfile,
  seed: string,
  now: Date,
): RankedDiscoverTrip<T>[] {
  if (trips.length === 0) return [];

  const personalized = viewerHasSignals(viewer);
  const scored: Scored<T>[] = trips.map((trip) => {
    const matchScore = personalized ? scoreTrip(trip, viewer) : null;
    return {
      item: trip,
      matchScore,
      band: personalized
        ? Math.floor((matchScore ?? 0) / SCORE_BAND)
        : recencyBand(trip.createdAt, now),
    };
  });

  const bands = new Map<number, Scored<T>[]>();
  for (const entry of scored) {
    const group = bands.get(entry.band);
    if (group) group.push(entry);
    else bands.set(entry.band, [entry]);
  }

  const bandKeys = [...bands.keys()].sort((a, b) =>
    personalized ? b - a : a - b,
  );
  const topKey = bandKeys[0];
  const ordered: Scored<T>[] = [];

  for (const key of bandKeys) {
    const group = bands.get(key) ?? [];
    if (key === topKey) {
      ordered.push(...orderTopBand(group, seed, personalized));
      continue;
    }
    const stable = [...group].sort((a, b) => compareRanked(a, b, personalized));
    ordered.push(...seededShuffle(stable, `${seed}:band:${key}`));
  }

  if (!personalized && bandKeys.length === 1 && ordered.length > 1) {
    const [newest, ...tail] = ordered;
    return [newest, ...seededShuffle(tail, `${seed}:cold`)];
  }

  const topCount = bands.get(topKey)?.length ?? 0;
  const head = ordered.slice(0, topCount);
  const rest = mixExploration(ordered.slice(topCount), seed);
  return [...head, ...rest];
}

export function seededShuffle<T>(items: readonly T[], seed: string): T[] {
  const copy = [...items];
  const random = mulberry32(hashSeed(seed));
  for (let index = copy.length - 1; index > 0; index -= 1) {
    const swap = Math.floor(random() * (index + 1));
    const current = copy[index];
    copy[index] = copy[swap];
    copy[swap] = current;
  }
  return copy;
}

function viewerHasSignals(viewer: DiscoverViewerProfile): boolean {
  return (
    viewer.dna.some((entry) => entry.score > 0) ||
    viewer.budgetLevel != null ||
    viewer.interests.some((interest) => interest.trim().length > 0) ||
    viewer.pastCities.some((city) => city.trim().length > 0) ||
    viewer.pastDestinationTypes.some((type) => type.trim().length > 0)
  );
}

function scoreTrip(
  trip: DiscoverRankTrip,
  viewer: DiscoverViewerProfile,
): number {
  const parts: Array<{ weight: number; value: number }> = [];

  if (viewer.dna.some((entry) => entry.score > 0)) {
    const categories =
      trip.placeCategories.length > 0
        ? trip.placeCategories
        : asPlaceCategories(trip.destinationTypes);
    const profile = buildTripDnaProfile(trip.tripType, categories);
    const dna = joinRequestMatchScore(profile, viewer.dna);
    if (dna != null) parts.push({ weight: DNA_WEIGHT, value: dna });
  }

  if (viewer.budgetLevel) {
    const value =
      trip.budgetLevel != null && trip.budgetLevel === viewer.budgetLevel
        ? 100
        : 0;
    parts.push({ weight: BUDGET_WEIGHT, value });
  }

  const interests = unique(viewer.interests, normText);
  if (interests.length > 0) {
    const names = new Set(trip.interestNames.map(normText));
    const hits = interests.filter((interest) => names.has(interest)).length;
    parts.push({
      weight: INTEREST_WEIGHT,
      value: Math.round((hits / interests.length) * 100),
    });
  }

  const pastCities = unique(viewer.pastCities, normText);
  const pastTypes = unique(viewer.pastDestinationTypes, normType);
  if (pastCities.length > 0 || pastTypes.length > 0) {
    const cityHit = trip.cities.some((city) =>
      pastCities.includes(normText(city)),
    );
    const typeHit = trip.destinationTypes.some((type) =>
      pastTypes.includes(normType(type)),
    );
    parts.push({ weight: HISTORY_WEIGHT, value: cityHit || typeHit ? 100 : 0 });
  }

  if (parts.length === 0) return 0;
  const weight = parts.reduce((sum, part) => sum + part.weight, 0);
  const raw = parts.reduce((sum, part) => sum + part.weight * part.value, 0);
  return Math.round(raw / weight);
}

function orderTopBand<T extends DiscoverRankTrip>(
  group: readonly Scored<T>[],
  seed: string,
  personalized: boolean,
): Scored<T>[] {
  const sorted = [...group].sort((a, b) => compareRanked(a, b, personalized));
  const chunks: Scored<T>[][] = [];
  for (const entry of sorted) {
    const last = chunks[chunks.length - 1];
    if (last && sameTie(last[0], entry, personalized)) last.push(entry);
    else chunks.push([entry]);
  }
  return chunks.flatMap((chunk, index) =>
    chunk.length < 2
      ? chunk
      : seededShuffle(
          chunk,
          `${seed}:tie:${index}:${chunk[0].matchScore ?? 'new'}`,
        ),
  );
}

function sameTie<T extends DiscoverRankTrip>(
  left: Scored<T>,
  right: Scored<T>,
  personalized: boolean,
): boolean {
  if (personalized) return left.matchScore === right.matchScore;
  return left.item.createdAt.getTime() === right.item.createdAt.getTime();
}

function compareRanked<T extends DiscoverRankTrip>(
  left: Scored<T>,
  right: Scored<T>,
  personalized: boolean,
): number {
  if (personalized) {
    const score = (right.matchScore ?? 0) - (left.matchScore ?? 0);
    if (score !== 0) return score;
    const slots = right.item.slotsRemaining - left.item.slotsRemaining;
    if (slots !== 0) return slots;
    const expiry =
      (left.item.expiresAt?.getTime() ?? Number.MAX_SAFE_INTEGER) -
      (right.item.expiresAt?.getTime() ?? Number.MAX_SAFE_INTEGER);
    if (expiry !== 0) return expiry;
  }
  const created =
    right.item.createdAt.getTime() - left.item.createdAt.getTime();
  if (created !== 0) return created;
  return left.item.id < right.item.id
    ? -1
    : left.item.id > right.item.id
      ? 1
      : 0;
}

function mixExploration<T>(rest: readonly T[], seed: string): T[] {
  if (rest.length < EXPLORE_PAGE) return [...rest];
  const exploreCount = Math.max(EXPLORE_SLOTS, Math.floor(rest.length * 0.2));
  const primary = rest.slice(0, rest.length - exploreCount);
  const explore = seededShuffle(
    rest.slice(rest.length - exploreCount),
    `${seed}:explore`,
  );
  const mixed: T[] = [];
  let primaryIndex = 0;
  let exploreIndex = 0;
  while (primaryIndex < primary.length || exploreIndex < explore.length) {
    const primaryTake = Math.min(
      EXPLORE_PAGE - EXPLORE_SLOTS,
      primary.length - primaryIndex,
    );
    for (let index = 0; index < primaryTake; index += 1) {
      mixed.push(primary[primaryIndex]);
      primaryIndex += 1;
    }
    const exploreTake = Math.min(EXPLORE_SLOTS, explore.length - exploreIndex);
    for (let index = 0; index < exploreTake; index += 1) {
      mixed.push(explore[exploreIndex]);
      exploreIndex += 1;
    }
    if (primaryTake === 0 && exploreTake === 0) break;
  }
  return mixed;
}

function recencyBand(createdAt: Date, now: Date): number {
  const age = Math.max(0, now.getTime() - createdAt.getTime());
  return Math.floor(age / DAY_MS);
}

function asPlaceCategories(types: readonly string[]): PLACE_CATEGORY[] {
  const categories: PLACE_CATEGORY[] = [];
  for (const type of types) {
    const normalized = normType(type);
    if (!PLACE_CATEGORY_VALUES.has(normalized)) continue;
    categories.push(normalized as PLACE_CATEGORY);
  }
  return categories;
}

function unique(
  values: readonly string[],
  normalize: (value: string) => string,
): string[] {
  return [
    ...new Set(values.map(normalize).filter((value) => value.length > 0)),
  ];
}

function normText(value: string): string {
  return value.trim().toLocaleLowerCase();
}

function normType(value: string): string {
  return value.trim().toUpperCase();
}

function hashSeed(input: string): number {
  let hash = 2166136261;
  for (let index = 0; index < input.length; index += 1) {
    hash ^= input.charCodeAt(index);
    hash = Math.imul(hash, 16777619);
  }
  return hash >>> 0;
}

function mulberry32(seed: number): () => number {
  let state = seed;
  return () => {
    state = (state + 0x6d2b79f5) >>> 0;
    let next = state;
    next = Math.imul(next ^ (next >>> 15), next | 1);
    next ^= next + Math.imul(next ^ (next >>> 7), next | 61);
    return ((next ^ (next >>> 14)) >>> 0) / 4294967296;
  };
}

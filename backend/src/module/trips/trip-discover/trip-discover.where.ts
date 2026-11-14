import { Prisma } from '../../../generated/prisma/client';
import {
  BudgetLevel,
  MEMBER_STATUS,
  PLACE_CATEGORY,
  TRIP_STATUS,
  TRIP_TYPE,
  TRIP_VISIBILITY,
} from '../../../generated/prisma/enums';
import { buildTripReadAccessWhere } from '../policies';
import { effectiveOpenWhere } from '../trip-relations/trip-recruitment/recruitment.policy';

export const DISCOVER_CATEGORIES = [
  'all',
  'backpacker',
  'camping',
  'beach',
  'budget',
  'weekend',
] as const;

export type DiscoverCategory = (typeof DISCOVER_CATEGORIES)[number];

const DAY_MS = 24 * 60 * 60 * 1000;

/** Public upcoming posts an outsider can still request to join. */
export function buildCommunityDiscoverWhere(
  userId: string,
  now: Date,
): Prisma.TripWhereInput {
  return {
    visibility: TRIP_VISIBILITY.PUBLIC,
    status: TRIP_STATUS.UPCOMING,
    recruitment: { is: effectiveOpenWhere(now) },
    NOT: {
      OR: [
        { ownerId: userId },
        {
          members: {
            some: { userId, status: MEMBER_STATUS.ACTIVE },
          },
        },
      ],
    },
  };
}

/**
 * Saturday 00:00 through Sunday 23:59:59.999 in the viewer's fixed offset.
 * Monday–Friday uses the coming weekend. Saturday and Sunday use the weekend
 * already in progress.
 */
export function weekendWindow(
  now: Date,
  timezoneOffsetMinutes: number,
): { start: Date; end: Date } {
  const local = new Date(now.getTime() + timezoneOffsetMinutes * 60_000);
  const weekday = local.getUTCDay();
  const daysFromSaturday = weekday === 6 ? 0 : weekday === 0 ? -1 : 6 - weekday;
  const saturdayUtc = Date.UTC(
    local.getUTCFullYear(),
    local.getUTCMonth(),
    local.getUTCDate() + daysFromSaturday,
  );
  const start = new Date(saturdayUtc - timezoneOffsetMinutes * 60_000);
  const end = new Date(start.getTime() + 2 * DAY_MS - 1);
  return { start, end };
}

export function buildDiscoverCategoryWhere(
  category: DiscoverCategory,
  now: Date,
  timezoneOffsetMinutes: number,
): Prisma.TripWhereInput {
  switch (category) {
    case 'all':
      return {};
    case 'backpacker':
      return { tripType: TRIP_TYPE.BACKPACKER };
    case 'beach':
      return placeOrDestinationWhere(PLACE_CATEGORY.BEACH);
    case 'camping':
      return placeOrDestinationWhere(PLACE_CATEGORY.CAMPING);
    case 'budget':
      return { budgetLevel: BudgetLevel.LOW };
    case 'weekend': {
      const window = weekendWindow(now, timezoneOffsetMinutes);
      return { startDate: { gte: window.start, lte: window.end } };
    }
  }
}

export function buildDiscoverListWhere(input: {
  userId: string;
  now: Date;
  category: DiscoverCategory;
  timezoneOffsetMinutes: number;
  search?: string;
  destinationCatalogId?: string;
}): Prisma.TripWhereInput {
  const search = input.search?.trim();
  const catalogId = input.destinationCatalogId?.trim();
  return {
    AND: [
      buildTripReadAccessWhere(input.userId),
      buildCommunityDiscoverWhere(input.userId, input.now),
      buildDiscoverCategoryWhere(
        input.category,
        input.now,
        input.timezoneOffsetMinutes,
      ),
      ...(search
        ? [{ name: { contains: search, mode: 'insensitive' as const } }]
        : []),
      ...(catalogId
        ? [{ destinations: { some: { destinationId: catalogId } } }]
        : []),
    ],
  };
}

function placeOrDestinationWhere(
  category: PLACE_CATEGORY,
): Prisma.TripWhereInput {
  return {
    OR: [
      {
        destinations: {
          some: {
            destinationType: { equals: category, mode: 'insensitive' },
          },
        },
      },
      {
        itineraryItems: {
          some: { place: { category } },
        },
      },
    ],
  };
}

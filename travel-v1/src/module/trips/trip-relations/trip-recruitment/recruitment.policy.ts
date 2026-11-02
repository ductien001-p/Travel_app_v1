import { DateTime } from 'luxon';
import { Prisma } from '../../../../generated/prisma/client';
import {
  RECRUITMENT_STATE,
  TRIP_STATUS,
  TRIP_VISIBILITY,
} from '../../../../generated/prisma/enums';
import {
  ACTIVE_RECRUITMENT_CAP,
  MIN_RECRUITMENT_DESCRIPTION_LENGTH,
  PUBLISH_IDEMPOTENCY_TTL_HOURS,
  PUBLISH_MIN_LEAD_HOURS,
  RECRUITMENT_EXPIRES_HOURS_BEFORE_START,
  type RecruitmentBlocker,
} from './recruitment.constants';

export type RecruitmentSnapshot = {
  state: RECRUITMENT_STATE;
  expiresAt: Date | null;
};

export type RecruitmentTripClock = {
  status: TRIP_STATUS;
  now?: Date;
};

/**
 * Client-facing state. Reading never writes. A missing row stays unpublished.
 * OPEN/FULL past expiresAt are reported as CLOSED until the cron persists it.
 */
export function effectiveRecruitmentState(
  row: RecruitmentSnapshot | null,
  now: Date = new Date(),
): RECRUITMENT_STATE {
  if (!row || row.state === RECRUITMENT_STATE.NOT_PUBLISHED) {
    return RECRUITMENT_STATE.NOT_PUBLISHED;
  }
  if (row.state === RECRUITMENT_STATE.CLOSED) {
    return RECRUITMENT_STATE.CLOSED;
  }
  if (
    (row.state === RECRUITMENT_STATE.OPEN ||
      row.state === RECRUITMENT_STATE.FULL) &&
    row.expiresAt !== null &&
    row.expiresAt.getTime() > now.getTime()
  ) {
    return row.state;
  }
  return RECRUITMENT_STATE.CLOSED;
}

export function isEffectiveOpen(
  row: RecruitmentSnapshot | null,
  tripStatus: TRIP_STATUS,
  now: Date = new Date(),
): boolean {
  return (
    tripStatus === TRIP_STATUS.UPCOMING &&
    row?.state === RECRUITMENT_STATE.OPEN &&
    row.expiresAt !== null &&
    row.expiresAt.getTime() > now.getTime()
  );
}

export function isActiveRecruitment(
  row: RecruitmentSnapshot | null,
  tripStatus: TRIP_STATUS,
  now: Date = new Date(),
): boolean {
  return (
    tripStatus === TRIP_STATUS.UPCOMING &&
    (row?.state === RECRUITMENT_STATE.OPEN ||
      row?.state === RECRUITMENT_STATE.FULL) &&
    row.expiresAt !== null &&
    row.expiresAt.getTime() > now.getTime()
  );
}

/** expiresAt = startDate - 24 hours, evaluated in UTC. */
export function recruitmentExpiresAt(startDate: Date): Date {
  return DateTime.fromJSDate(startDate, { zone: 'utc' })
    .toUTC()
    .minus({ hours: RECRUITMENT_EXPIRES_HOURS_BEFORE_START })
    .toJSDate();
}

export function hasPublishLeadTime(startDate: Date, now: Date = new Date()): boolean {
  const earliest = DateTime.fromJSDate(now, { zone: 'utc' })
    .toUTC()
    .plus({ hours: PUBLISH_MIN_LEAD_HOURS });
  return (
    DateTime.fromJSDate(startDate, { zone: 'utc' }).toUTC().toMillis() >=
    earliest.toMillis()
  );
}

export function idempotencyFreshAfter(now: Date = new Date()): Date {
  return DateTime.fromJSDate(now, { zone: 'utc' })
    .toUTC()
    .minus({ hours: PUBLISH_IDEMPOTENCY_TTL_HOURS })
    .toJSDate();
}

export function isFreshIdempotencyKey(createdAt: Date, now: Date = new Date()): boolean {
  return createdAt.getTime() > idempotencyFreshAfter(now).getTime();
}

/**
 * Active posts for one owner. CANCELLED and deleted trips are excluded:
 * deleted rows cascade away, and the status filter drops everything else.
 */
export function activeRecruitmentWhere(
  ownerId: string,
  now: Date,
  excludeTripId?: string,
): Prisma.TripRecruitmentWhereInput {
  return {
    state: { in: [RECRUITMENT_STATE.OPEN, RECRUITMENT_STATE.FULL] },
    expiresAt: { gt: now },
    trip: { ownerId, status: TRIP_STATUS.UPCOMING },
    ...(excludeTripId ? { tripId: { not: excludeTripId } } : {}),
  };
}

export function recruitmentBlockers(input: {
  startDate: Date;
  activeRecruitmentCount: number;
  activeMemberCount: number;
  maxMembers: number;
  description: string | null;
  hasCover: boolean;
  now?: Date;
}): RecruitmentBlocker[] {
  const blockers: RecruitmentBlocker[] = [];
  if (!hasPublishLeadTime(input.startDate, input.now)) {
    blockers.push('START_TOO_SOON');
  }
  if (input.activeRecruitmentCount >= ACTIVE_RECRUITMENT_CAP) {
    blockers.push('ACTIVE_LIMIT_REACHED');
  }
  if (input.activeMemberCount >= input.maxMembers) {
    blockers.push('NO_OPEN_SLOT');
  }
  if (
    (input.description?.trim().length ?? 0) < MIN_RECRUITMENT_DESCRIPTION_LENGTH
  ) {
    blockers.push('DESCRIPTION_TOO_SHORT');
  }
  if (!input.hasCover) {
    blockers.push('COVER_REQUIRED');
  }
  return blockers;
}

/** Discover only lists posts outsiders can still request to join. */
export function effectiveOpenWhere(now: Date): Prisma.TripRecruitmentWhereInput {
  return {
    state: RECRUITMENT_STATE.OPEN,
    expiresAt: { gt: now },
  };
}

/**
 * Snapshot visibility only when a post becomes active and the column is empty.
 * An existing value is left for close/expiry to restore.
 */
export function snapshotPreviousVisibility(
  current: TRIP_VISIBILITY | null | undefined,
  visibility: TRIP_VISIBILITY,
): { previousVisibility: TRIP_VISIBILITY } | Record<string, never> {
  if (current != null) return {};
  return { previousVisibility: visibility };
}

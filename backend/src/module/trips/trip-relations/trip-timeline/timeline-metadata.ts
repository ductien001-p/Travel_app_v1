import {
  CURRENCY,
  EXPENSE_CATEGORY,
  EXPENSE_SPLIT_TYPE,
  TIMELINE_EVENT_TYPE,
  TIMELINE_TARGET_TYPE,
} from '../../../../generated/prisma/enums';

/**
 * Snapshot stored with each event, shaped per event type. Values are captured
 * when the event happens so the feed stays correct after the resource changes
 * or is deleted. Dates are ISO-8601 strings; money is a base-10 string.
 */
export type TimelineMetadataByType = {
  TRIP_CREATED: {
    tripName: string;
    startDate: string | null;
    endDate: string | null;
    destinationCount: number;
  };
  TRIP_PUBLISHED: {
    tripName: string;
    expiresAt: string;
  };
  /** The invite code itself is owner-only and is never stored here. */
  MEMBER_JOINED: {
    via: 'INVITE_CODE' | 'INVITATION' | 'JOIN_REQUEST';
  };
  MEMBER_LEFT: null;
  MEMBER_KICKED: {
    targetMemberId: string;
    targetName: string;
  };
  ACTIVITY_ADDED: {
    activityTitle: string;
    placeName: string | null;
    dayNumber: number | null;
    startTime: string | null;
  };
  ACTIVITY_UPDATED: {
    activityTitle: string;
    placeName: string | null;
    dayNumber: number | null;
    previousStartTime: string | null;
    startTime: string | null;
  };
  ACTIVITY_DELETED: {
    activityTitle: string;
    dayNumber: number | null;
  };
  ACTIVITY_CHECKIN: {
    activityTitle: string;
    placeName: string;
    placeArea: string | null;
    /** Coordinates of the place, never the member's own GPS position. */
    latitude: number;
    longitude: number;
    /** Storage key of the place cover; resolved to `imageUrl` on read. */
    placeMediaKey: string | null;
    verified: boolean;
    pointsEarned: number;
  };
  EXPENSE_CREATED: {
    amount: string;
    currency: CURRENCY;
    category: EXPENSE_CATEGORY;
    description: string | null;
    splitType: EXPENSE_SPLIT_TYPE;
    splitCount: number;
    payerMemberId: string;
    spentAt: string;
    receiptCount: number;
  };
  EXPENSE_SETTLED: {
    amount: string;
    currency: CURRENCY;
    description: string | null;
    payerMemberId: string;
    payerName: string;
    debtorMemberId: string;
    debtorName: string;
  };
  PHOTO_ADDED: null;
  MEMORY_ADDED: {
    /** Resolved on read so photos of deleted memories are never exposed. */
    memoryIds: string[];
    caption: string | null;
  };
  MEMORY_DELETED: null;
  SYSTEM: null;
};

/** Fails to compile when a TIMELINE_EVENT_TYPE has no metadata shape. */
type AssertCoversAllTypes<T extends Record<TIMELINE_EVENT_TYPE, unknown>> = T;
export type TimelineMetadataMap = AssertCoversAllTypes<TimelineMetadataByType>;

export type TimelineEventInput<T extends TIMELINE_EVENT_TYPE> = {
  type: T;
  /** Human-readable fallback for clients that do not render metadata. */
  content: string;
  metadata: TimelineMetadataMap[T];
  target?: { type: TIMELINE_TARGET_TYPE; id: string } | null;
};

/** Metadata as returned to clients: one flat object, fields depend on `type`. */
export type TimelineEventMetadataResponse = {
  tripName?: string;
  startDate?: string | null;
  endDate?: string | null;
  expiresAt?: string;
  destinationCount?: number;
  via?: string;
  targetMemberId?: string;
  targetName?: string;
  activityTitle?: string;
  placeName?: string | null;
  placeArea?: string | null;
  dayNumber?: number | null;
  startTime?: string | null;
  previousStartTime?: string | null;
  latitude?: number;
  longitude?: number;
  imageUrl?: string | null;
  verified?: boolean;
  pointsEarned?: number;
  amount?: string;
  currency?: string;
  category?: string;
  description?: string | null;
  splitType?: string;
  splitCount?: number;
  payerMemberId?: string;
  spentAt?: string;
  receiptCount?: number;
  payerName?: string;
  debtorMemberId?: string;
  debtorName?: string;
  memoryIds?: string[];
  photoUrls?: string[];
  photoCount?: number;
  caption?: string | null;
};

const STRING_FIELDS = [
  'tripName',
  'startDate',
  'endDate',
  'expiresAt',
  'via',
  'targetMemberId',
  'targetName',
  'activityTitle',
  'placeName',
  'placeArea',
  'startTime',
  'previousStartTime',
  'amount',
  'currency',
  'category',
  'description',
  'splitType',
  'payerMemberId',
  'spentAt',
  'payerName',
  'debtorMemberId',
  'debtorName',
  'caption',
] as const;

const NUMBER_FIELDS = [
  'destinationCount',
  'dayNumber',
  'latitude',
  'longitude',
  'pointsEarned',
  'splitCount',
  'receiptCount',
] as const;

/**
 * Copies only known fields with the expected primitive type, so a malformed or
 * legacy JSON value can never leak arbitrary data to clients. Storage-only
 * fields (`placeMediaKey`, `memoryIds`) are returned separately for resolution.
 */
export function readStoredMetadata(raw: unknown): {
  metadata: TimelineEventMetadataResponse;
  placeMediaKey: string | null;
  memoryIds: string[];
} | null {
  if (!raw || typeof raw !== 'object' || Array.isArray(raw)) return null;
  const source = raw as Record<string, unknown>;
  const metadata: Record<string, unknown> = {};

  for (const key of STRING_FIELDS) {
    const value = source[key];
    if (typeof value === 'string' || value === null) metadata[key] = value;
  }
  for (const key of NUMBER_FIELDS) {
    const value = source[key];
    if (typeof value === 'number' && Number.isFinite(value)) {
      metadata[key] = value;
    } else if (value === null) {
      metadata[key] = null;
    }
  }
  if (typeof source.verified === 'boolean') metadata.verified = source.verified;

  const memoryIds = Array.isArray(source.memoryIds)
    ? source.memoryIds.filter((id): id is string => typeof id === 'string')
    : [];
  const placeMediaKey =
    typeof source.placeMediaKey === 'string' ? source.placeMediaKey : null;

  return {
    metadata,
    placeMediaKey,
    memoryIds,
  };
}

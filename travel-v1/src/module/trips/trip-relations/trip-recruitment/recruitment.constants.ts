/** Posts that still accept or display members (OPEN or FULL, unexpired, UPCOMING). */
export const ACTIVE_RECRUITMENT_CAP = 3;

/** Publish and reopen require the trip to start at least this far ahead. */
export const PUBLISH_MIN_LEAD_HOURS = 48;

/** A live post leaves the feed 24 hours before startDate. */
export const RECRUITMENT_EXPIRES_HOURS_BEFORE_START = 24;

export const PUBLISH_IDEMPOTENCY_TTL_HOURS = 48;

/** Wizard drafts with no itinerary are hard-deleted after this many days. */
export const PUBLISH_WIZARD_DRAFT_TTL_DAYS = 30;

/** Trimmed description shorter than this cannot be published. */
export const MIN_RECRUITMENT_DESCRIPTION_LENGTH = 20;

export const RECRUITMENT_CRON_LOCK_KEY = 'trip-recruitment-maintenance';

export const RECRUITMENT_BLOCKERS = [
  'START_TOO_SOON',
  'ACTIVE_LIMIT_REACHED',
  'NO_OPEN_SLOT',
  'DESCRIPTION_TOO_SHORT',
  'COVER_REQUIRED',
] as const;

export type RecruitmentBlocker = (typeof RECRUITMENT_BLOCKERS)[number];

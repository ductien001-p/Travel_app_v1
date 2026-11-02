import { TIMELINE_EVENT_TYPE } from '../../../../generated/prisma/enums';

/** Filter groups shown as chips on the trip timeline screen. */
export const TIMELINE_CATEGORIES = [
  'checkin',
  'expense',
  'memory',
  'member',
] as const;

export type TimelineCategory = (typeof TIMELINE_CATEGORIES)[number];

export const TIMELINE_CATEGORY_TYPES: Record<
  TimelineCategory,
  readonly TIMELINE_EVENT_TYPE[]
> = {
  checkin: [TIMELINE_EVENT_TYPE.ACTIVITY_CHECKIN],
  expense: [
    TIMELINE_EVENT_TYPE.EXPENSE_CREATED,
    TIMELINE_EVENT_TYPE.EXPENSE_SETTLED,
  ],
  memory: [
    TIMELINE_EVENT_TYPE.MEMORY_ADDED,
    TIMELINE_EVENT_TYPE.PHOTO_ADDED,
    TIMELINE_EVENT_TYPE.MEMORY_DELETED,
  ],
  member: [
    TIMELINE_EVENT_TYPE.MEMBER_JOINED,
    TIMELINE_EVENT_TYPE.MEMBER_LEFT,
    TIMELINE_EVENT_TYPE.MEMBER_KICKED,
  ],
};

export type TimelineCounts = Record<'all' | TimelineCategory, number>;

/** Folds per-type counts into the totals of every filter chip. */
export function toTimelineCounts(
  countsByType: ReadonlyArray<{ type: TIMELINE_EVENT_TYPE; count: number }>,
): TimelineCounts {
  const counts: TimelineCounts = {
    all: 0,
    checkin: 0,
    expense: 0,
    memory: 0,
    member: 0,
  };
  for (const { type, count } of countsByType) {
    counts.all += count;
    for (const category of TIMELINE_CATEGORIES) {
      if (TIMELINE_CATEGORY_TYPES[category].includes(type)) {
        counts[category] += count;
      }
    }
  }
  return counts;
}

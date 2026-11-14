import type { TransformFnParams } from 'class-transformer';

const CALENDAR_DATE_PREFIX = /^(\d{4})-(\d{2})-(\d{2})(T.*)?$/;

/**
 * Accepts `yyyy-MM-dd` or a full ISO datetime and keeps the calendar day the
 * client wrote, ignoring any offset: `2026-10-10T00:00:00+07:00` becomes
 * 2026-10-10T00:00:00Z instead of shifting to the 9th.
 * Invalid input is returned unchanged so `@IsDate()` rejects it.
 */
export function toCalendarDate({ value }: TransformFnParams): unknown {
  if (typeof value !== 'string') return value;

  const trimmed = value.trim();
  const match = CALENDAR_DATE_PREFIX.exec(trimmed);
  if (!match) return value;

  const [, year, month, day, timePart] = match;
  if (timePart && Number.isNaN(Date.parse(trimmed))) return value;

  const date = new Date(Date.UTC(Number(year), Number(month) - 1, Number(day)));
  const isSameCalendarDay = date
    .toISOString()
    .startsWith(`${year}-${month}-${day}`);

  return isSameCalendarDay ? date : value;
}

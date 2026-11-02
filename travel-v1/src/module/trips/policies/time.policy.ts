import { DateTime } from 'luxon';
import { ensure } from './policy.error';
import type { ISODate, ISODateTime, TripRange } from './policy.types';

/** Every calendar day and instant in the trip domain is evaluated in UTC. */
export class TimePolicy {
  static day(value: ISODate): DateTime {
    ensure(
      /^\d{4}-\d{2}-\d{2}$/.test(value),
      'INVALID_DATE',
      'Use yyyy-MM-dd',
      { value },
    );
    const day = DateTime.fromISO(value, { zone: 'UTC' });
    ensure(
      day.isValid && day.toISODate() === value,
      'INVALID_DATE',
      'Invalid calendar date',
      { value },
    );
    return day;
  }

  static instant(value: ISODateTime): DateTime {
    // Never silently interpret offset-free values in server local timezone.
    ensure(
      /(?:Z|[+-]\d{2}:?\d{2})$/i.test(value),
      'INVALID_DATETIME',
      'startTime must include timezone offset or Z',
      { value },
    );
    const dt = DateTime.fromISO(value, { setZone: true });
    ensure(dt.isValid, 'INVALID_DATETIME', 'Invalid ISO datetime', { value });
    return dt.toUTC();
  }

  static validateRange(range: TripRange): void {
    const start = this.day(range.startDate);
    const end = this.day(range.endDate);
    ensure(
      start.toMillis() <= end.toMillis(),
      'INVALID_RANGE',
      'startDate must be <= endDate',
    );
  }

  /** Number of calendar days in the range, both ends included. */
  static dayCount(range: TripRange): number {
    this.validateRange(range);
    return (
      this.day(range.endDate).diff(this.day(range.startDate), 'days').days + 1
    );
  }

  static containsDay(range: TripRange, value: ISODate): boolean {
    this.validateRange(range);
    const day = this.day(value).toMillis();
    return (
      day >= this.day(range.startDate).toMillis() &&
      day <= this.day(range.endDate).toMillis()
    );
  }

  static containsRange(parent: TripRange, child: TripRange): boolean {
    this.validateRange(parent);
    this.validateRange(child);
    return (
      this.containsDay(parent, child.startDate) &&
      this.containsDay(parent, child.endDate)
    );
  }

  static overlapsDays(a: TripRange, b: TripRange): boolean {
    this.validateRange(a);
    this.validateRange(b);
    return a.startDate <= b.endDate && b.startDate <= a.endDate;
  }

  static today(now: DateTime = DateTime.utc()): ISODate {
    return now.toUTC().toISODate()!;
  }

  static utcDate(instant: DateTime): ISODate {
    return instant.toUTC().toISODate()!;
  }

  static rangeBoundsUtc(range: TripRange): {
    start: DateTime;
    endExclusive: DateTime;
  } {
    this.validateRange(range);
    return {
      start: this.day(range.startDate),
      endExclusive: this.day(range.endDate).plus({ days: 1 }),
    };
  }
}

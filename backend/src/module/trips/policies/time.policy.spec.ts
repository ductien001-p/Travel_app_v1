import { DateTime } from 'luxon';
import { ActivityPolicy } from './activity.policy';
import { TimePolicy } from './time.policy';

describe('TimePolicy (UTC)', () => {
  it('reports today as the UTC calendar date', () => {
    const lateEveningUtc = DateTime.fromISO('2026-10-12T23:30:00Z');

    expect(TimePolicy.today(lateEveningUtc)).toBe('2026-10-12');
  });

  it('normalises any offset to the UTC calendar date', () => {
    const instant = TimePolicy.instant('2026-10-13T05:00:00+07:00');

    expect(TimePolicy.utcDate(instant)).toBe('2026-10-12');
  });

  it('bounds a range from UTC midnight to the next UTC midnight', () => {
    const { start, endExclusive } = TimePolicy.rangeBoundsUtc({
      startDate: '2026-10-12',
      endDate: '2026-10-13',
    });

    expect(start.toISO()).toBe('2026-10-12T00:00:00.000Z');
    expect(endExclusive.toISO()).toBe('2026-10-14T00:00:00.000Z');
  });
});

describe('ActivityPolicy.validateSchedule (UTC)', () => {
  const destination = {
    id: 'destination-1',
    order: 1,
    startDate: '2026-10-12',
    endDate: '2026-10-13',
  };
  const day = {
    id: 'day-1',
    tripId: 'trip-1',
    destinationId: 'destination-1',
    date: '2026-10-12',
  };

  function validate(startTime: string, estimatedDuration = 60) {
    ActivityPolicy.validateSchedule(
      { tripId: 'trip-1', dayId: 'day-1', startTime, estimatedDuration },
      'trip-1',
      day,
      destination,
    );
  }

  it('accepts an activity that starts and ends on the UTC day', () => {
    expect(() => validate('2026-10-12T09:00:00Z')).not.toThrow();
  });

  it('rejects an activity whose UTC start falls on the previous day', () => {
    expect(() => validate('2026-10-12T05:00:00+07:00')).toThrow(
      expect.objectContaining({
        response: expect.objectContaining({ code: 'ACTIVITY_DAY_MISMATCH' }),
      }),
    );
  });

  it('rejects an activity that crosses UTC midnight', () => {
    expect(() => validate('2026-10-12T23:30:00Z', 60)).toThrow(
      expect.objectContaining({
        response: expect.objectContaining({
          code: 'ACTIVITY_OVERNIGHT_NOT_ALLOWED',
        }),
      }),
    );
  });
});

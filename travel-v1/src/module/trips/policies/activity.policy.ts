import { DateTime } from 'luxon';
import { ensure } from './policy.error';
import { TimePolicy } from './time.policy';
import type {
  ActivityInput,
  DestinationRange,
  ItineraryDayInput,
} from './policy.types';
import { ItineraryPolicy } from './itinerary.policy';

export interface ActivityScheduleOptions {
  allowOvernightActivity?: boolean;
  allowOverlappingActivities?: boolean;
  requireStartTimeAndDurationTogether?: boolean;
}

type Window = { start: DateTime; end: DateTime };

export class ActivityPolicy {
  static validatePersistedSchedule(
    activity: ActivityInput,
    day: {
      id: string;
      tripId: string;
      destinationId: string;
      date: Date;
      destination: {
        id: string;
        startDate: Date;
        endDate: Date;
        order: number;
      };
    },
    siblings: Array<{
      id: string;
      tripId: string;
      dayId: string;
      placeId: string;
      startTime: Date | null;
      estimatedDuration: number | null;
    }>,
  ): void {
    this.validateSchedule(
      activity,
      activity.tripId,
      {
        id: day.id,
        tripId: day.tripId,
        destinationId: day.destinationId,
        date: day.date.toISOString().slice(0, 10),
      },
      {
        id: day.destination.id,
        startDate: day.destination.startDate.toISOString().slice(0, 10),
        endDate: day.destination.endDate.toISOString().slice(0, 10),
        order: day.destination.order,
      },
      siblings.map((sibling) => ({
        id: sibling.id,
        tripId: sibling.tripId,
        dayId: sibling.dayId,
        placeId: sibling.placeId,
        startTime: sibling.startTime?.toISOString(),
        estimatedDuration: sibling.estimatedDuration,
      })),
    );
  }

  static window(
    activity: ActivityInput,
    options: ActivityScheduleOptions = {},
  ): Window | null {
    const hasStart = activity.startTime != null;
    const hasDuration = activity.estimatedDuration != null;
    const requirePair = options.requireStartTimeAndDurationTogether ?? true;
    if (requirePair) {
      ensure(
        hasStart === hasDuration,
        'ACTIVITY_TIME_INCOMPLETE',
        'startTime and estimatedDuration must both be supplied, or neither',
      );
    }
    if (hasDuration) {
      ensure(
        Number.isInteger(activity.estimatedDuration) &&
          activity.estimatedDuration! >= 0,
        'INVALID_DURATION',
        'Duration must be nonnegative integer minutes',
      );
    }
    if (!hasStart) return null;
    const start = TimePolicy.instant(activity.startTime!);
    // Missing duration is allowed only if requirePair=false; no known end in that case.
    if (!hasDuration) return { start, end: start };
    return { start, end: start.plus({ minutes: activity.estimatedDuration! }) };
  }

  static validateSchedule(
    activity: ActivityInput,
    tripId: string,
    day: ItineraryDayInput,
    destination: DestinationRange,
    siblings: ActivityInput[] = [],
    options: ActivityScheduleOptions = {},
  ): void {
    ItineraryPolicy.validateDay(day, tripId, destination);
    ensure(
      activity.tripId === tripId && activity.dayId === day.id,
      'ACTIVITY_DAY_MISMATCH',
      'Activity belongs to another trip or day',
    );
    const w = this.window(activity, options);
    if (!w) return; // unscheduled activity allowed
    const startDay = TimePolicy.utcDate(w.start);
    ensure(
      startDay === day.date,
      'ACTIVITY_DAY_MISMATCH',
      'Activity must start on its itinerary day (UTC)',
      { startDay, day: day.date },
    );
    const { start: earliest, endExclusive: latest } =
      TimePolicy.rangeBoundsUtc(destination);
    ensure(
      w.start.toMillis() >= earliest.toMillis() &&
        w.end.toMillis() <= latest.toMillis(),
      'OUTSIDE_DESTINATION',
      'Activity outside destination date range',
    );
    const lastMoment = w.end.minus({ millisecond: 1 });
    // A zero-minute event has no occupied interval; it cannot cross midnight.
    const endsSameDay =
      w.start.toMillis() === w.end.toMillis() ||
      TimePolicy.utcDate(lastMoment) === day.date;
    ensure(
      options.allowOvernightActivity || endsSameDay,
      'ACTIVITY_OVERNIGHT_NOT_ALLOWED',
      'Activity crosses itinerary day boundary',
    );

    if (!(options.allowOverlappingActivities ?? false)) {
      for (const other of siblings) {
        if (other.id && other.id === activity.id) continue;
        if (other.dayId !== day.id || other.tripId !== tripId) continue;
        const otherWindow = this.window(other, options);
        if (!otherWindow) continue;
        const overlaps = w.start < otherWindow.end && otherWindow.start < w.end;
        ensure(
          !overlaps,
          'ACTIVITY_OVERLAP',
          'Activity overlaps another activity',
          { otherActivityId: other.id },
        );
      }
    }
  }

  static assertPlaceMutable(
    before: ActivityInput,
    nextPlaceId: string | null | undefined,
  ): void {
    if (
      before.isCheckin &&
      nextPlaceId !== undefined &&
      nextPlaceId !== before.placeId
    ) {
      ensure(
        false,
        'CHECKED_IN_PLACE_LOCKED',
        'Cannot change place after check-in',
      );
    }
  }
}

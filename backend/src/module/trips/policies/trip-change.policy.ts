import { ensure } from './policy.error';
import { TimePolicy } from './time.policy';
import {
  ActivityPolicy,
  type ActivityScheduleOptions,
} from './activity.policy';
import type {
  ActivityInput,
  DestinationRange,
  ItineraryDayInput,
  TripRange,
} from './policy.types';

export class TripChangePolicy {
  /** Preview invalidated destination IDs before reducing a trip range. */
  static assertTripDateChange(
    newTrip: TripRange,
    destinations: DestinationRange[],
  ): void {
    TimePolicy.validateRange(newTrip);
    const affected = destinations
      .filter((d) => !TimePolicy.containsRange(newTrip, d))
      .map((d) => d.id);
    ensure(
      affected.length === 0,
      'CHANGE_INVALIDATES_CHILDREN',
      'Trip date change invalidates destinations',
      { destinationIds: affected },
    );
  }

  /** Requires authoritative loaded days + activities. Do not pass paginated subsets. */
  static assertDestinationDateChange(
    tripId: string,
    updated: DestinationRange,
    days: ItineraryDayInput[],
    activities: ActivityInput[],
    options: ActivityScheduleOptions = {},
  ): void {
    const affectedDays = days
      .filter(
        (day) =>
          day.destinationId === updated.id &&
          !TimePolicy.containsDay(updated, day.date),
      )
      .map((d) => d.id);
    const invalidActivities: string[] = [];
    for (const day of days.filter(
      (d) => d.destinationId === updated.id && !affectedDays.includes(d.id),
    )) {
      for (const activity of activities.filter((a) => a.dayId === day.id)) {
        try {
          ActivityPolicy.validateSchedule(
            activity,
            tripId,
            day,
            updated,
            [],
            options,
          );
        } catch {
          invalidActivities.push(activity.id ?? '<unsaved>');
        }
      }
    }
    ensure(
      affectedDays.length === 0 && invalidActivities.length === 0,
      'CHANGE_INVALIDATES_CHILDREN',
      'Destination date change invalidates itinerary',
      { dayIds: affectedDays, activityIds: invalidActivities },
    );
  }
}

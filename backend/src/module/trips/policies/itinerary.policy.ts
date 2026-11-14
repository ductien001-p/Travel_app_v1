import { ensure } from './policy.error';
import { TimePolicy } from './time.policy';
import type { DestinationRange, ItineraryDayInput } from './policy.types';

export class ItineraryPolicy {
  static validateDay(
    day: ItineraryDayInput,
    tripId: string,
    destination: DestinationRange,
  ): void {
    ensure(
      day.tripId === tripId,
      'DAY_TRIP_MISMATCH',
      'Itinerary day belongs to another trip',
    );
    ensure(
      day.destinationId === destination.id,
      'DAY_DESTINATION_MISMATCH',
      'Day belongs to another destination',
    );
    ensure(
      TimePolicy.containsDay(destination, day.date),
      'OUTSIDE_DESTINATION',
      'Itinerary day outside destination dates',
      { dayId: day.id },
    );
  }
}

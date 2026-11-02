import { ensure } from './policy.error';
import { TimePolicy } from './time.policy';
import type { DestinationRange, TripRange } from './policy.types';

export const MAX_DESTINATION_DAYS = 30;
export const MAX_TRIP_DAYS = 90;

export class DestinationPolicy {
  static validatePersistedDateRange(startDate: Date, endDate: Date): void {
    this.validateDestinationRange({
      startDate: startDate.toISOString().slice(0, 10),
      endDate: endDate.toISOString().slice(0, 10),
    });
  }

  static validateDestinationRange(range: TripRange): void {
    ensure(
      TimePolicy.dayCount(range) <= MAX_DESTINATION_DAYS,
      'RANGE_TOO_LONG',
      `A destination cannot last more than ${MAX_DESTINATION_DAYS} days`,
      { maxDays: MAX_DESTINATION_DAYS },
    );
  }

  static validatePersistedTimeline(
    destinations: Array<{
      id?: string;
      startDate: Date;
      endDate: Date;
      order: number;
    }>,
  ): void {
    this.validateTimeline(
      destinations.map((destination) => ({
        id: destination.id,
        order: destination.order,
        startDate: destination.startDate.toISOString().slice(0, 10),
        endDate: destination.endDate.toISOString().slice(0, 10),
      })),
    );
  }

  static validateTimeline(
    destinations: Array<TripRange & { id?: string; order: number }>,
  ): void {
    ensure(
      destinations.length > 0,
      'INVALID_RANGE',
      'Trip must have at least one destination',
    );
    const sorted = [...destinations].sort((a, b) => a.order - b.order);
    const orders = new Set<number>();
    for (const destination of sorted) {
      this.validateDestinationRange(destination);
      ensure(
        Number.isInteger(destination.order) && destination.order >= 0,
        'INVALID_RANGE',
        'Destination order must be a nonnegative integer',
      );
      ensure(
        !orders.has(destination.order),
        'DUPLICATE_DESTINATION_ORDER',
        'Destination order must be unique',
        { order: destination.order },
      );
      orders.add(destination.order);
    }
    for (let index = 1; index < sorted.length; index++) {
      const previous = sorted[index - 1];
      const current = sorted[index];
      ensure(
        !TimePolicy.overlapsDays(previous, current),
        'DESTINATION_OVERLAP',
        'Destinations must not overlap',
        { ids: [previous.id, current.id] },
      );
      ensure(
        previous.endDate < current.startDate,
        'DESTINATION_ORDER_INVALID',
        'Destination order must follow the travel dates',
        { ids: [previous.id, current.id] },
      );
    }
    ensure(
      TimePolicy.dayCount({
        startDate: sorted[0].startDate,
        endDate: sorted[sorted.length - 1].endDate,
      }) <= MAX_TRIP_DAYS,
      'RANGE_TOO_LONG',
      `A trip cannot last more than ${MAX_TRIP_DAYS} days`,
      { maxDays: MAX_TRIP_DAYS },
    );
  }

  static validate(destination: DestinationRange, trip: TripRange): void {
    ensure(
      Number.isInteger(destination.order) && destination.order >= 0,
      'INVALID_RANGE',
      'Destination order must be nonnegative integer',
    );
    ensure(
      TimePolicy.containsRange(trip, destination),
      'OUTSIDE_TRIP',
      'Destination outside trip',
      { destinationId: destination.id },
    );
  }

  static validateCollection(
    destinations: DestinationRange[],
    trip: TripRange,
    options: { forbidSharedDays?: boolean } = {},
  ): void {
    const orders = new Set<number>();
    for (const d of destinations) {
      this.validate(d, trip);
      ensure(
        !orders.has(d.order),
        'DUPLICATE_DESTINATION_ORDER',
        'Duplicate destination order',
        { order: d.order },
      );
      orders.add(d.order);
    }
    if (options.forbidSharedDays) {
      for (let i = 0; i < destinations.length; i++) {
        for (let j = i + 1; j < destinations.length; j++) {
          ensure(
            !TimePolicy.overlapsDays(destinations[i], destinations[j]),
            'DESTINATION_OVERLAP',
            'Destinations overlap',
            { ids: [destinations[i].id, destinations[j].id] },
          );
        }
      }
    }
  }
}

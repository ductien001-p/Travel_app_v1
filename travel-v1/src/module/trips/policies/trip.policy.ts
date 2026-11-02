import { ensure } from './policy.error';
import { TimePolicy } from './time.policy';
import type {
  DestinationRange,
  ISODate,
  TripRange,
  TripStatus,
} from './policy.types';

export class TripPolicy {
  static validateBudgetFields(
    estimatedBudgetPerPerson?: string,
    budgetCurrency?: string,
  ): void {
    const hasBudget = estimatedBudgetPerPerson !== undefined;
    const hasCurrency = budgetCurrency !== undefined;
    ensure(
      hasBudget === hasCurrency,
      'BUDGET_INCOMPLETE',
      'estimatedBudgetPerPerson and budgetCurrency must be provided together',
    );
    if (estimatedBudgetPerPerson !== undefined) {
      const value = Number(estimatedBudgetPerPerson);
      ensure(
        Number.isFinite(value) && value >= 0,
        'INVALID_RANGE',
        'estimatedBudgetPerPerson must be greater than or equal to 0',
      );
    }
  }

  static validateDates(trip: TripRange): void {
    TimePolicy.validateRange(trip);
  }
  static validateDestinationsWithinTrip(
    trip: TripRange,
    destinations: DestinationRange[],
  ): void {
    this.validateDates(trip);
    for (const d of destinations) {
      ensure(
        TimePolicy.containsRange(trip, d),
        'OUTSIDE_TRIP',
        'Destination dates outside trip',
        { destinationId: d.id },
      );
    }
  }
  static assertCapacity(maxMembers: number, activeMembers: number): void {
    ensure(
      Number.isInteger(maxMembers) && maxMembers > 0,
      'INVALID_RANGE',
      'maxMembers must be positive integer',
    );
    ensure(activeMembers < maxMembers, 'TRIP_CAPACITY_REACHED', 'Trip is full');
  }
  static assertStatusTransition(from: TripStatus, to: TripStatus): void {
    const allowed: Record<TripStatus, readonly TripStatus[]> = {
      DRAFT: ['UPCOMING', 'CANCELLED'],
      UPCOMING: ['ONGOING', 'CANCELLED'],
      ONGOING: ['COMPLETED', 'NOTCOMPLETED', 'CANCELLED'],
      COMPLETED: [],
      CANCELLED: [],
      NOTCOMPLETED: [],
    };
    ensure(
      from === to || allowed[from]?.includes(to),
      'TRIP_STATUS_INVALID',
      `Cannot transition ${from} -> ${to}`,
    );
  }
  /** A trip can be completed once it has started and was not closed. */
  static assertStarted(
    trip: { status: TripStatus; startDate: ISODate },
    today: ISODate,
  ): void {
    ensure(
      trip.status === 'UPCOMING' || trip.status === 'ONGOING',
      'TRIP_STATUS_INVALID',
      `Trip in status ${trip.status} cannot be completed`,
    );
    ensure(
      today >= trip.startDate,
      'TRIP_STATUS_INVALID',
      'Trip has not started yet',
      { startDate: trip.startDate, today },
    );
  }
  /** A trip leaving DRAFT must not have started already. */
  static assertNotStartedYet(startDate: ISODate, today: ISODate): void {
    ensure(
      startDate >= today,
      'TRIP_START_IN_PAST',
      'Trip start date cannot be in the past',
      { startDate, today },
    );
  }
  // NOTE: completion >=50% check-ins is a separate product-specific service rule.
  static assertCompletionThreshold(
    checkedIn: number,
    total: number,
    requiredRatio = 0.5,
  ): void {
    ensure(
      Number.isInteger(checkedIn) &&
        Number.isInteger(total) &&
        total > 0 &&
        checkedIn >= 0 &&
        checkedIn <= total,
      'INVALID_RANGE',
      'Invalid activity counts',
    );
    ensure(
      checkedIn / total >= requiredRatio,
      'TRIP_STATUS_INVALID',
      'Not enough checked-in activities to complete trip',
    );
  }
}

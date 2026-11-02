import { BadRequestException } from '@nestjs/common';

export type PolicyErrorCode =
  | 'INVALID_DATE'
  | 'INVALID_DATETIME'
  | 'INVALID_DURATION'
  | 'BUDGET_INCOMPLETE'
  | 'INVALID_RANGE'
  | 'RANGE_TOO_LONG'
  | 'OUTSIDE_TRIP'
  | 'OUTSIDE_DESTINATION'
  | 'DAY_DESTINATION_MISMATCH'
  | 'DAY_TRIP_MISMATCH'
  | 'ACTIVITY_DAY_MISMATCH'
  | 'ACTIVITY_OVERLAP'
  | 'DESTINATION_OVERLAP'
  | 'DESTINATION_ORDER_INVALID'
  | 'DUPLICATE_DESTINATION_ORDER'
  | 'ACTIVITY_TIME_INCOMPLETE'
  | 'ACTIVITY_OVERNIGHT_NOT_ALLOWED'
  | 'TRIP_CAPACITY_REACHED'
  | 'TRIP_STATUS_INVALID'
  | 'TRIP_START_IN_PAST'
  | 'INACTIVE_MEMBER'
  | 'FORBIDDEN'
  | 'CHECKED_IN_PLACE_LOCKED'
  | 'CHANGE_INVALIDATES_CHILDREN';

export class TripPolicyError extends BadRequestException {
  constructor(
    public readonly code: PolicyErrorCode,
    message: string,
    public readonly details?: Record<string, unknown>,
  ) {
    super({ code, message, details });
    this.name = 'TripPolicyError';
  }
}
export function ensure(
  condition: unknown,
  code: PolicyErrorCode,
  message: string,
  details?: Record<string, unknown>,
): asserts condition {
  if (!condition) throw new TripPolicyError(code, message, details);
}

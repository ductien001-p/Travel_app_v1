import { MAX_TRIP_DAYS } from '../policies/destination.policy';

/** Destinations never share a day, so a trip cannot hold more than one per day. */
export const MAX_DESTINATIONS_PER_TRIP = MAX_TRIP_DAYS;
export const MAX_INTERESTS_PER_TRIP = 20;
export const MAX_PENDING_PLACES_PER_DESTINATION = 50;

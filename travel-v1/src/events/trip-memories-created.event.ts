export const TRIP_MEMORIES_CREATED = 'trip.memories.created';

/** Emitted after the memories are committed. */
export class TripMemoriesCreatedEvent {
  constructor(
    public readonly tripId: string,
    public readonly memoryIds: string[],
  ) {}
}

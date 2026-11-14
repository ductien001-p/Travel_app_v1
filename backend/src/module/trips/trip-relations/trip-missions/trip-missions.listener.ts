import { Injectable, Logger } from '@nestjs/common';
import { OnEvent } from '@nestjs/event-emitter';
import { TripCheckinedEvent } from '../../../../events/trip-checkined.event';
import {
  TRIP_MEMORIES_CREATED,
  TripMemoriesCreatedEvent,
} from '../../../../events/trip-memories-created.event';
import { TripMissionProgressService } from './trip-mission-progress.service';

@Injectable()
export class TripMissionsListener {
  private readonly logger = new Logger(TripMissionsListener.name);

  constructor(
    private readonly progressService: TripMissionProgressService,
  ) {}

  @OnEvent('trip.checkin', { async: true })
  async onCheckin(event: TripCheckinedEvent): Promise<void> {
    try {
      await this.progressService.recomputeFromCheckin(event.checkinId);
    } catch (error) {
      this.logger.warn(
        `Failed to update missions after checkin ${event.checkinId}`,
        error instanceof Error ? error.stack : undefined,
      );
    }
  }

  @OnEvent(TRIP_MEMORIES_CREATED, { async: true })
  async onMemories(event: TripMemoriesCreatedEvent): Promise<void> {
    try {
      await this.progressService.recomputeFromMemories(
        event.tripId,
        event.memoryIds,
      );
    } catch (error) {
      this.logger.warn(
        `Failed to update missions after memories on trip ${event.tripId}`,
        error instanceof Error ? error.stack : undefined,
      );
    }
  }
}

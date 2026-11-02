import { Injectable, Logger } from '@nestjs/common';
import { OnEvent } from '@nestjs/event-emitter';
import { Cron, CronExpression } from '@nestjs/schedule';
import {
  TRIP_MEMORIES_CREATED,
  TripMemoriesCreatedEvent,
} from '../../../../../events/trip-memories-created.event';
import { MemoryBadgeService } from './memory-badge.service';

@Injectable()
export class MemoryBadgeListener {
  private readonly logger = new Logger(MemoryBadgeListener.name);

  constructor(private readonly badges: MemoryBadgeService) {}

  @OnEvent(TRIP_MEMORIES_CREATED, { async: true })
  async handleMemoriesCreated(event: TripMemoriesCreatedEvent) {
    await this.badges
      .enqueue(event.memoryIds)
      .catch((error: unknown) => this.logFailure(error));
  }

  /** Catches photos missed by the event: restarts, outages, older photos. */
  @Cron(CronExpression.EVERY_10_MINUTES)
  async classifyPending() {
    await this.badges
      .classifyPending()
      .catch((error: unknown) => this.logFailure(error));
  }

  private logFailure(error: unknown) {
    this.logger.error(
      `Memory badge job failed: ${error instanceof Error ? error.message : 'unknown'}`,
    );
  }
}

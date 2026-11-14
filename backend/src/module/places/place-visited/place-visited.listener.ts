import { Injectable } from '@nestjs/common';
import { OnEvent } from '@nestjs/event-emitter';
import { TripCheckinedEvent } from '../../../events/trip-checkined.event';
import { PlaceVisitedService } from './place-visited.service';

@Injectable()
export class PlaceVisitedListener {
  constructor(private readonly placeVisitedService: PlaceVisitedService) {}

  @OnEvent('trip.checkin')
  async handleTripCompleted(event: TripCheckinedEvent) {
    await this.placeVisitedService.visitPlace(event.checkinId);
  }
}

import { Injectable } from '@nestjs/common';
import { OnEvent } from '@nestjs/event-emitter';
import { TripCheckinedEvent } from '../../events/trip-checkined.event';
import { TravelDnaService } from './travel-dna.service';

@Injectable()
export class TravelDNAListener {
  constructor(private readonly travelDnaService: TravelDnaService) {}

  @OnEvent('trip.checkin')
  async handleTripCheckin(event: TripCheckinedEvent) {
    await this.travelDnaService.processCheckin(event.checkinId);
  }
}

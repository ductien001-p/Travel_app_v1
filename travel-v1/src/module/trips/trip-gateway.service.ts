import { Injectable } from '@nestjs/common';
import { TripGateway } from '../../websocket/gateway';

@Injectable()
export class TripRoomWS {
  constructor(private readonly tripGateway: TripGateway) {}

  removeTripRoom(tripId: string) {
    this.tripGateway.closeTripRoom(tripId);
  }

  removeUserFromTripRoom(tripId: string, userId: string) {
    return this.tripGateway.removeUserFromTripRoom(tripId, userId);
  }

  getOnlineUserIds(tripId: string) {
    return this.tripGateway.getOnlineUserIds(tripId);
  }
}

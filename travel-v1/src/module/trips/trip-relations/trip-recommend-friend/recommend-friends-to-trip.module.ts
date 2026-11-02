import { Module } from '@nestjs/common';
import { FriendModule } from '../../../friends/friends.module';
import { TripItinerariesModule } from '../trip-itineraries/trip-itineraries.module';
import { RecommendFriendsToTripService } from './recommend-friends-to-trip.service';
import { PrismaModule } from '../../../../prisma.module';

@Module({
  imports: [FriendModule, PrismaModule, TripItinerariesModule],
  providers: [RecommendFriendsToTripService],
  exports: [RecommendFriendsToTripService],
})
export class RecommendFriendsToTripModule {}

import { Module, forwardRef } from '@nestjs/common';
import { TripsService } from './trips.service';
import { TripsController } from './trips.controller';
import { TripMemoriesService } from './trip-relations/trip-memories/trip-memories.service';
import { MemoryBadgeClassifier } from './trip-relations/trip-memories/memory-badge/memory-badge.classifier';
import { MemoryBadgeService } from './trip-relations/trip-memories/memory-badge/memory-badge.service';
import { MemoryBadgeListener } from './trip-relations/trip-memories/memory-badge/memory-badge.listener';
import { S3Module } from '../../uploads/s3/s3.module';
import { MediaModule } from '../media/media.module';
import { TripItinerariesModule } from './trip-relations/trip-itineraries/trip-itineraries.module';
import { TripTimelineModule } from './trip-relations/trip-timeline/tripTimeline.module';
import { TripRoomWS } from './trip-gateway.service';
import { RecommendFriendsToTripModule } from './trip-relations/trip-recommend-friend/recommend-friends-to-trip.module';
import { TripInterestModule } from './trip-relations/trip-interests/trip-interest.module';
import { RouteModule } from './route/route.module';
import { PrismaModule } from '../../prisma.module';
import { TripMembersService } from './trip-relations/trip-members/trip-member.service';
import { TripExploreModule } from './trip-relations/trip-explore/trip-explore.module';
import { TripDetailService } from './trip-detail/trip-detail.service';
import { TripSharesModule } from './trip-relations/trip-shares/trip-shares.module';
import { TripJoinRequestsModule } from './trip-relations/trip-join-requests/trip-join-requests.module';
import { TripRecruitmentModule } from './trip-relations/trip-recruitment/trip-recruitment.module';
import { TripDiscoverService } from './trip-discover/trip-discover.service';

@Module({
  imports: [
    PrismaModule,
    S3Module,
    MediaModule,
    TripItinerariesModule,
    TripTimelineModule,
    S3Module,
    RecommendFriendsToTripModule,
    TripInterestModule,
    RouteModule,
    TripExploreModule,
    TripSharesModule,
    TripJoinRequestsModule,
    forwardRef(() => TripRecruitmentModule),
  ],
  controllers: [TripsController],
  providers: [
    TripsService,
    TripDetailService,
    TripMemoriesService,
    MemoryBadgeClassifier,
    MemoryBadgeService,
    MemoryBadgeListener,
    TripRoomWS,
    TripMembersService,
    TripDiscoverService,
  ],
  exports: [TripsService],
})
export class TripsModule {}

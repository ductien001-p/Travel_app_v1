import { Module } from '@nestjs/common';
import { TripItinerariesService } from './trip-destination.service';
import { TripItinerariesActivitiesService } from './trip-itineraries-activities.service';
import { TripItineraryViewerService } from './trip-itinerary-viewer.service';
import {
  ItineraryDayItemsController,
  TripItinerariesController,
} from './trip-itianeraries.controller';
import { TripTimelineModule } from '../trip-timeline/tripTimeline.module';
import { TripMessageModule } from '../trip-messages/tripMessage.module';
import { S3Module } from '../../../../uploads/s3/s3.module';
import { PrismaModule } from '../../../../prisma.module';
import { RouteModule } from '../../route/route.module';

@Module({
  imports: [
    PrismaModule,
    TripTimelineModule,
    TripMessageModule,
    S3Module,
    RouteModule,
  ],
  controllers: [TripItinerariesController, ItineraryDayItemsController],
  providers: [
    TripItinerariesService,
    TripItinerariesActivitiesService,
    TripItineraryViewerService,
  ],
  exports: [TripItinerariesService, TripItinerariesActivitiesService],
})
export class TripItinerariesModule {}

import { Module } from '@nestjs/common';

import { NotificationModule } from '../../../../notification/notification.module';
import { PrismaModule } from '../../../../prisma.module';
import { S3Module } from '../../../../uploads/s3/s3.module';
import { TripTimelineModule } from '../trip-timeline/tripTimeline.module';
import { TripJoinRequestsController } from './trip-join-requests.controller';
import { TripJoinRequestsService } from './trip-join-requests.service';

@Module({
  imports: [PrismaModule, S3Module, NotificationModule, TripTimelineModule],
  controllers: [TripJoinRequestsController],
  providers: [TripJoinRequestsService],
  exports: [TripJoinRequestsService],
})
export class TripJoinRequestsModule {}

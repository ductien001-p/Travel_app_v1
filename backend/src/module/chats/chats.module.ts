import { Module } from '@nestjs/common';

import { PrismaModule } from '../../prisma.module';
import { S3Module } from '../../uploads/s3/s3.module';
import { TripTimelineModule } from '../trips/trip-relations/trip-timeline/tripTimeline.module';
import { ChatsController } from './chats.controller';
import { ChatsHubService } from './chats-hub.service';

@Module({
  imports: [PrismaModule, S3Module, TripTimelineModule],
  controllers: [ChatsController],
  providers: [ChatsHubService],
  exports: [ChatsHubService],
})
export class ChatsModule {}

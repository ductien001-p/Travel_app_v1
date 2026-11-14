import { Module, forwardRef } from '@nestjs/common';
import { TripMessageController } from './tripMessages.controller';
import { TripMessageService } from './tripMessages.service';
import { PrismaModule } from '../../../../prisma.module';
import { S3Module } from '../../../../uploads/s3/s3.module';
import { TripTimelineModule } from '../trip-timeline/tripTimeline.module';

@Module({
  imports: [
    PrismaModule,
    S3Module,
    forwardRef(() => TripTimelineModule),
  ],
  controllers: [TripMessageController],
  providers: [TripMessageService],
  exports: [TripMessageService],
})
export class TripMessageModule {}

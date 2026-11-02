import { Module, forwardRef } from '@nestjs/common';
import { PrismaModule } from '../../../../prisma.module';
import { S3Module } from '../../../../uploads/s3/s3.module';
import { TripsModule } from '../../trips.module';
import { TripTimelineModule } from '../trip-timeline/tripTimeline.module';
import { TripRecruitmentController } from './trip-recruitment.controller';
import { TripRecruitmentCron } from './trip-recruitment.cron';
import { TripRecruitmentService } from './trip-recruitment.service';

@Module({
  imports: [
    PrismaModule,
    S3Module,
    TripTimelineModule,
    forwardRef(() => TripsModule),
  ],
  controllers: [TripRecruitmentController],
  providers: [TripRecruitmentService, TripRecruitmentCron],
  exports: [TripRecruitmentService],
})
export class TripRecruitmentModule {}

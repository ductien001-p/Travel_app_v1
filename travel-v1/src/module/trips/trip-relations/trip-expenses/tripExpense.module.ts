import { Module } from '@nestjs/common';
import { TripExpenseController } from './tripExpense.controller';
import { TripExpenseService } from './tripExpense.service';
import { TripTimelineModule } from '../trip-timeline/tripTimeline.module';
import { PrismaModule } from '../../../../prisma.module';
import { MediaModule } from '../../../media/media.module';
import { S3Module } from '../../../../uploads/s3/s3.module';

@Module({
  imports: [PrismaModule, TripTimelineModule, MediaModule, S3Module],
  controllers: [TripExpenseController],
  providers: [TripExpenseService],
  exports: [TripExpenseService],
})
export class TripExpenseModule {}

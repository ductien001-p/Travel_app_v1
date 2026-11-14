import { Module, forwardRef } from '@nestjs/common';
import { TripTimelineService } from './tripTimeline.service';
import { TripGateway } from '../../../../websocket/gateway';
import { TripTimelineController } from './tripTimeline.controller';
import { TripMessageModule } from '../trip-messages/tripMessage.module';
import { AuthModule } from '../../../auth/auth.module';
import { PrismaModule } from '../../../../prisma.module';
import { S3Module } from '../../../../uploads/s3/s3.module';

@Module({
  imports: [
    PrismaModule,
    forwardRef(() => TripMessageModule),
    AuthModule,
    S3Module,
  ],
  providers: [TripTimelineService, TripGateway],
  controllers: [TripTimelineController],
  exports: [TripTimelineService, TripGateway],
})
export class TripTimelineModule {}

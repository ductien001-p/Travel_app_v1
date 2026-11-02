import { Module } from '@nestjs/common';
import { NotificationModule } from '../../../../notification/notification.module';
import { TripInvitationsService } from './tripInvitations.service';
import { TripInvitationsController } from './tripInvitations.controller';
import { PrismaModule } from '../../../../prisma.module';
import { TripTimelineModule } from '../trip-timeline/tripTimeline.module';

@Module({
  imports: [NotificationModule, PrismaModule, TripTimelineModule],
  controllers: [TripInvitationsController],
  providers: [TripInvitationsService],
  exports: [TripInvitationsService],
})
export class TripInvitationsModule {}

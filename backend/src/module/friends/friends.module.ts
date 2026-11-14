import { Module } from '@nestjs/common';
import { FriendController } from './friends.controller';
import { PrismaModule } from '../../prisma.module';
import { AuthModule } from '../auth/auth.module';
import { S3Module } from '../../uploads/s3/s3.module';
import { TripTimelineModule } from '../trips/trip-relations/trip-timeline/tripTimeline.module';
import { FriendService } from './friends.service';
import { FindFriendsService } from './find-friends.service';
import { FriendGateway } from './friend-gateway';

@Module({
  imports: [PrismaModule, AuthModule, S3Module, TripTimelineModule],
  controllers: [FriendController],

  providers: [FriendService, FindFriendsService, FriendGateway],

  exports: [FriendService, FindFriendsService],
})
export class FriendModule {}

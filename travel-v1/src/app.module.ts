import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config/dist/config.module';
import { PrismaService } from './prisma.service';
import { UsersModule } from './module/users/users.module';
import { AuthModule } from './module/auth/auth.module';
import { JwtAuthGuard } from './module/auth/strategies/jwt-auth.guard';
import { APP_FILTER, APP_GUARD } from '@nestjs/core';
import { RedisModule } from './redis/redis.module';
import { MailModule } from './mail/mail.module';
import { PresignUploadModule } from './uploads/presign-upload/presign-upload.module';
import { TripsModule } from './module/trips/trips.module';
import { NotificationModule } from './notification/notification.module';
import { DeviceTokensModule } from './module/auth/device-token/device-token.module';
import { TripInvitationsModule } from './module/trips/trip-relations/trip-invitations/tripInvitations.module';
import { TripItinerariesModule } from './module/trips/trip-relations/trip-itineraries/trip-itineraries.module';
import { TripInterestModule } from './module/trips/trip-relations/trip-interests/trip-interest.module';
import { ScheduleModule } from '@nestjs/schedule';
import { TripCompletetionModule } from './module/trips/trip-relations/trip-completetion/tripCompletetion.module';
import { TripExpenseModule } from './module/trips/trip-relations/trip-expenses/tripExpense.module';
import { TripTimelineModule } from './module/trips/trip-relations/trip-timeline/tripTimeline.module';
import { FriendModule } from './module/friends/friends.module';
import { EventEmitterModule } from '@nestjs/event-emitter';
import { TravelDnaModule } from './module/travelDNA/travel-dna.module';
import { FollowModule } from './module/follow/follow.module';
import { RankingModule } from './module/ranking/ranking.module';
import { RolesGuard } from './module/authorization/guard/roles.guard';
import { PlacesModule } from './module/places/places.module';
import { PostsModule } from './module/social/post.module';
import { ApiExceptionFilter } from './common/filters/api-exception.filter';

@Module({
  imports: [
    MailModule,
    RedisModule,
    PresignUploadModule,
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    EventEmitterModule.forRoot(),
    UsersModule,
    AuthModule,
    DeviceTokensModule,
    TripsModule,
    NotificationModule,
    TripInvitationsModule,
    TripItinerariesModule,
    TripInterestModule,
    ScheduleModule.forRoot(),
    TripCompletetionModule,
    TripExpenseModule,
    TripTimelineModule,
    FriendModule,
    TravelDnaModule,
    FollowModule,
    RankingModule,
    PlacesModule,
    PostsModule,
  ],
  controllers: [],
  providers: [
    PrismaService,
    {
      provide: APP_GUARD,
      useClass: JwtAuthGuard,
    },
    {
      provide: APP_GUARD,
      useClass: RolesGuard,
    },
    {
      provide: APP_FILTER,
      useClass: ApiExceptionFilter,
    },
  ],
})
export class AppModule {}

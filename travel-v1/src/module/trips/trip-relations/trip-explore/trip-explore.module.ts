import { Module } from '@nestjs/common';
import { PrismaModule } from '../../../../prisma.module';
import { S3Module } from '../../../../uploads/s3/s3.module';
import { RouteModule } from '../../route/route.module';
import { TripExploreService } from './trip-explore.service';
import { PlacePopularityRankingService } from '../../../places/place-popularity/place-popularity-ranking.service';
@Module({
  imports: [PrismaModule, RouteModule, S3Module],
  providers: [TripExploreService, PlacePopularityRankingService],
  exports: [TripExploreService],
})
export class TripExploreModule {}

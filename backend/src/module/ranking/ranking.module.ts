import { Module } from '@nestjs/common';
import { RankingController } from './ranking.controller';
import { RankingService } from './ranking.service';
import { PrismaModule } from '../../prisma.module';
import { S3Module } from '../../uploads/s3/s3.module';
import { TripMissionsModule } from '../trips/trip-relations/trip-missions/trip-missions.module';

@Module({
  imports: [PrismaModule, S3Module, TripMissionsModule],
  controllers: [RankingController],
  providers: [RankingService],
  exports: [RankingService],
})
export class RankingModule {}

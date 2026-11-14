import { Module } from '@nestjs/common';
import { TripCompletionService } from './tripCompletetion.service';
import { TripCompletionController } from './tripCompletetion.controller';
import { PrismaModule } from '../../../../prisma.module';
import { RankingModule } from '../../../ranking/ranking.module';
import { TripMissionsModule } from '../trip-missions/trip-missions.module';

@Module({
  imports: [PrismaModule, RankingModule, TripMissionsModule],
  controllers: [TripCompletionController],
  providers: [TripCompletionService],
  exports: [TripCompletionService],
})
export class TripCompletetionModule {}

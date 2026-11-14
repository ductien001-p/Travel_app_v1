import { Module } from '@nestjs/common';
import { PrismaModule } from '../../../../prisma.module';
import { TripMissionsController } from './trip-missions.controller';
import { TripMissionsService } from './trip-missions.service';
import { TripMissionProgressService } from './trip-mission-progress.service';
import { TripMissionsListener } from './trip-missions.listener';
import { TravelTierService } from './travel-tier.service';

@Module({
  imports: [PrismaModule],
  controllers: [TripMissionsController],
  providers: [
    TripMissionsService,
    TripMissionProgressService,
    TripMissionsListener,
    TravelTierService,
  ],
  exports: [TripMissionsService, TripMissionProgressService, TravelTierService],
})
export class TripMissionsModule {}

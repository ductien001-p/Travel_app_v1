import { Module } from '@nestjs/common';
import { TripInterestsController } from './trip-interest.controller';
import { TripInterestService } from './trip-interest.service';
import { TripItinerariesModule } from '../trip-itineraries/trip-itineraries.module';
import { PrismaModule } from '../../../../prisma.module';

@Module({
  imports: [PrismaModule, TripItinerariesModule],
  controllers: [TripInterestsController],
  providers: [TripInterestService],
  exports: [TripInterestService],
})
export class TripInterestModule {}

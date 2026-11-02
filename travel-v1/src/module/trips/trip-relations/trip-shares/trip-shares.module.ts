import { Module } from '@nestjs/common';

import { PrismaModule } from '../../../../prisma.module';
import { S3Module } from '../../../../uploads/s3/s3.module';
import { TripItinerariesModule } from '../trip-itineraries/trip-itineraries.module';
import { TripSharePublicController } from './trip-share-public.controller';
import { TripShareService } from './trip-share.service';
import { TripSharesController } from './trip-shares.controller';

@Module({
  imports: [PrismaModule, S3Module, TripItinerariesModule],
  controllers: [TripSharesController, TripSharePublicController],
  providers: [TripShareService],
})
export class TripSharesModule {}

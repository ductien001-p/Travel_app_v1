import { Module } from '@nestjs/common';
import { PlaceReviewsController } from './review-places.controller';
import { PlaceReviewsService } from './review-places.service';
import { PrismaModule } from '../../../prisma.module';

@Module({
  imports: [PrismaModule],
  controllers: [PlaceReviewsController],

  providers: [PlaceReviewsService],

  exports: [PlaceReviewsService],
})
export class PlaceReviewsModule {}

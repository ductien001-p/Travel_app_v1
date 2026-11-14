import { Module } from '@nestjs/common';

import { PlacesController } from './places.controller';
import { PlacesService } from './places.service';
import { PlaceEmbeddingService } from './place-embedding.service';
import { PrismaModule } from '../../prisma.module';
import { SearchPlaceService } from './search-place.service';
import { S3Module } from '../../uploads/s3/s3.module';
import { PlaceGalaryService } from './place-gallary/place-galary.service';
import { SavedPlacesModule } from './saved-places/saved-places.module';
import { PlaceReviewsModule } from './reviews-places/review-places.module';
import { PlaceCollectionsModule } from './place-collections/place-collections.module';
import { FeaturedPlacesService } from './featured-places.service';
import { NearbyPlacesService } from './nearby-places.service';
import { PlaceVisitedService } from './place-visited/place-visited.service';
import { PlaceVisitedListener } from './place-visited/place-visited.listener';
import { PlacePopularityRankingService } from './place-popularity/place-popularity-ranking.service';

@Module({
  imports: [
    PrismaModule,
    S3Module,
    SavedPlacesModule,
    PlaceReviewsModule,
    PlaceCollectionsModule,
  ],
  controllers: [PlacesController],

  providers: [
    PlacesService,
    PlaceEmbeddingService,
    SearchPlaceService,
    PlaceGalaryService,
    PlaceVisitedService,
    PlaceVisitedListener,
    PlacePopularityRankingService,
    FeaturedPlacesService,
    NearbyPlacesService,
  ],

  exports: [
    PlacesService,
    PlaceEmbeddingService,
    SearchPlaceService,
    PlaceGalaryService,
    PlacePopularityRankingService,
  ],
})
export class PlacesModule {}

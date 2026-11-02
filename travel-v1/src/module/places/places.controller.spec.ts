import { Test, TestingModule } from '@nestjs/testing';
import { PlacesController } from './places.controller';
import { PlacesService } from './places.service';
import { SearchPlaceService } from './search-place.service';
import { PlaceGalaryService } from './place-gallary/place-galary.service';
import { FeaturedPlacesService } from './featured-places.service';
import { NearbyPlacesService } from './nearby-places.service';

describe('PlacesController', () => {
  let controller: PlacesController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [PlacesController],
      providers: [
        { provide: PlacesService, useValue: {} },
        { provide: SearchPlaceService, useValue: {} },
        { provide: PlaceGalaryService, useValue: {} },
        { provide: FeaturedPlacesService, useValue: {} },
        { provide: NearbyPlacesService, useValue: {} },
      ],
    }).compile();

    controller = module.get<PlacesController>(PlacesController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});

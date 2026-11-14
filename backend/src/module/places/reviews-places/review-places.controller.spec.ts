import { Test, TestingModule } from '@nestjs/testing';
import { ReviewPlacesController } from './review-places.controller';
import { ReviewPlacesService } from './review-places.service';

describe('ReviewPlacesController', () => {
  let controller: ReviewPlacesController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [ReviewPlacesController],
      providers: [ReviewPlacesService],
    }).compile();

    controller = module.get<ReviewPlacesController>(ReviewPlacesController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});

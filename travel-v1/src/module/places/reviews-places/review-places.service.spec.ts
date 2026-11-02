import { Test, TestingModule } from '@nestjs/testing';

describe('ReviewPlacesService', () => {
  let service: ReviewPlacesService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [ReviewPlacesService],
    }).compile();

    service = module.get<ReviewPlacesService>(ReviewPlacesService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});

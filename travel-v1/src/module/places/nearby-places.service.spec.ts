import { PlacePolicyError } from './policies';
import { NearbyPlacesService } from './nearby-places.service';
import { travelEstimate } from './nearby-places.travel';

describe('nearby travel estimate', () => {
  it('walks short distances and drives the rest', () => {
    expect(travelEstimate(1.1).travelMode).toBe('walk');
    expect(travelEstimate(2).travelMode).toBe('drive');
    expect(travelEstimate(0.1).travelMinutes).toBeGreaterThanOrEqual(1);
  });
});

describe('NearbyPlacesService', () => {
  it('rejects a radius outside 1, 5 and 10 before querying', async () => {
    const prisma = { $queryRaw: jest.fn(), place: { findMany: jest.fn() } };
    const service = new NearbyPlacesService(
      prisma as never,
      {
        getPublicUrl: (key: string) => key,
      } as never,
    );
    await expect(service.findNearby(16, 108, 20)).rejects.toBeInstanceOf(
      PlacePolicyError,
    );
    expect(prisma.$queryRaw).not.toHaveBeenCalled();
  });

  it('returns approved places inside the radius without a like flag', async () => {
    const prisma = {
      $queryRaw: jest.fn().mockResolvedValue([
        {
          id: 'near',
          name: 'Linh Ung',
          category: 'TEMPLES',
          address: 'Son Tra',
          average_rating: 4.9,
          distance_km: 1.1,
        },
      ]),
      place: {
        findMany: jest.fn().mockResolvedValue([
          {
            id: 'near',
            _count: { reviews: 12 },
            coverImages: [{ media: { objectKey: 'covers/a.jpg' } }],
          },
        ]),
      },
    };
    const service = new NearbyPlacesService(
      prisma as never,
      {
        getPublicUrl: (key: string) => `https://cdn.test/${key}`,
      } as never,
    );

    const places = await service.findNearby(16.07, 108.22, 5);
    expect(places).toEqual([
      expect.objectContaining({
        id: 'near',
        distanceMeters: 1100,
        travelMode: 'walk',
        reviewCount: 12,
        coverImageUrl: 'https://cdn.test/covers/a.jpg',
      }),
    ]);
    expect(places[0]).not.toHaveProperty('liked');
  });
});

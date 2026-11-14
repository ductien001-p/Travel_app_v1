import { PlacePopularityRankingService } from '../places/place-popularity/place-popularity-ranking.service';
import { CatalogPlaceSort } from './dto/destination-planning.dto';
import { DestinationCatalogPlacesService } from './destination-catalog-places.service';

describe('DestinationCatalogPlacesService', () => {
  const ratedPlace = {
    id: 'place-1',
    name: 'Marble Mountains',
    category: 'ATTRACTION',
    description: null,
    address: 'Da Nang',
    latitude: 16.0036,
    longitude: 108.263,
    averageRating: 4.7,
    _count: { reviews: 12, visitCount: 10, savedPlaces: 5, posts: 2 },
    coverImages: [{ media: { objectKey: 'places/marble.jpg' } }],
  };

  type NearbyRow = {
    key: string;
    id: string;
    distance_km: number;
    total: number;
  };

  function setup(
    places = [ratedPlace],
    nearbyRows: NearbyRow[] = places.map((place) => ({
      key: 'catalog-1',
      id: place.id,
      distance_km: 7.9,
      total: places.length,
    })),
  ) {
    const prisma = {
      destinationCatalog: {
        findFirst: jest.fn().mockResolvedValue({
          id: 'catalog-1',
          lat: 16.0544,
          lng: 108.2022,
        }),
      },
      place: { findMany: jest.fn().mockResolvedValue(places) },
      $queryRaw: jest.fn().mockResolvedValue(nearbyRows),
    };
    const s3 = { getPublicUrl: jest.fn((key: string) => `https://cdn/${key}`) };
    const config = {
      get: jest.fn((key: string) =>
        key === 'DESTINATION_PLACE_RADIUS_KM' ? 20 : 20,
      ),
    };
    return {
      service: new DestinationCatalogPlacesService(
        prisma as never,
        s3 as never,
        new PlacePopularityRankingService(),
        config as never,
      ),
      prisma,
    };
  }

  it('ranks popular catalog places before closer ones when sort is POPULAR', async () => {
    const popular = {
      ...ratedPlace,
      id: 'popular',
      _count: {
        reviews: 100,
        visitCount: 1000,
        savedPlaces: 500,
        posts: 50,
      },
    };
    const { service, prisma } = setup(
      [{ ...ratedPlace, id: 'nearby' }, popular],
      [
        { key: 'catalog-1', id: 'nearby', distance_km: 1, total: 2 },
        { key: 'catalog-1', id: 'popular', distance_km: 5, total: 2 },
      ],
    );
    const result = await service.getCatalogPlaces(
      'catalog-1',
      undefined,
      1,
      CatalogPlaceSort.POPULAR,
    );
    expect(result.total).toBe(2);
    expect(result.data.map((place) => place.id)).toEqual(['popular']);
    expect(prisma.$queryRaw.mock.calls[0]).toContain(500);
  });

  it('reports the full in-radius total while returning only the limit', async () => {
    const { service } = setup(
      [ratedPlace],
      [{ key: 'catalog-1', id: 'place-1', distance_km: 1, total: 42 }],
    );
    const result = await service.getCatalogPlaces('catalog-1', undefined, 1);
    expect(result.total).toBe(42);
    expect(result.data).toHaveLength(1);
  });
});

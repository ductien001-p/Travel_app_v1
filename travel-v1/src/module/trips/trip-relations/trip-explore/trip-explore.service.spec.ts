import { Prisma } from '../../../../generated/prisma/client';
import { GalleryStatus, PlaceStatus } from '../../../../generated/prisma/enums';
import { TripExploreService } from './trip-explore.service';
import { PlacePopularityRankingService } from '../../../places/place-popularity/place-popularity-ranking.service';
import { CatalogPlaceSort } from '../../dto/destination-planning.dto';

describe('TripExploreService', () => {
  const destinations = [
    {
      id: 'destination-a',
      city: 'Da Nang',
      country: 'Vietnam',
      lat: 16.0544,
      lng: 108.2022,
      order: 1,
      destinationType: 'BEACH',
      highlights: ['Beach'],
      coverMedia: {
        id: 'media-1',
        objectKey: 'destinations/a.jpg',
        deletedAt: null,
      },
    },
    {
      id: 'destination-b',
      city: 'Hoi An',
      country: 'Vietnam',
      lat: 15.8801,
      lng: 108.338,
      order: 2,
      destinationType: 'CULTURAL',
      highlights: [],
      coverMedia: null,
    },
    {
      id: 'destination-c',
      city: 'Hue',
      country: 'Vietnam',
      lat: 16.4637,
      lng: 107.5909,
      order: 3,
      destinationType: null,
      highlights: [],
      coverMedia: null,
    },
  ];

  const ratedPlace = {
    id: 'place-1',
    name: 'Marble Mountains',
    category: 'ATTRACTION',
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

  const route = {
    available: true,
    distanceMeters: 1000,
    durationSeconds: 120,
    polyline: 'encoded',
  };

  function setup(
    places = [ratedPlace],
    nearbyRows: NearbyRow[] = places.map((place) => ({
      key: 'destination-a',
      id: place.id,
      distance_km: 7.9,
      total: places.length,
    })),
  ) {
    const prisma = {
      trip: {
        findFirst: jest.fn().mockResolvedValue({ id: 'trip-1', destinations }),
      },
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
    const routes = {
      getRoutes: jest.fn((segments: unknown[]) =>
        Promise.resolve(segments.map(() => route)),
      ),
    };
    const s3 = { getPublicUrl: jest.fn((key: string) => `https://cdn/${key}`) };
    const config = {
      get: jest.fn((key: string) =>
        key === 'DESTINATION_PLACE_RADIUS_KM' ? 20 : 20,
      ),
    };
    return {
      service: new TripExploreService(
        prisma as never,
        routes as never,
        s3 as never,
        new PlacePopularityRankingService(),
        config as never,
      ),
      prisma,
      routes,
    };
  }

  it('returns ordered destinations, places, and one route per consecutive pair', async () => {
    const { service, prisma, routes } = setup();
    const result = await service.getExplore('trip-1', 'user-1');

    expect(result.destinations.map((item) => item.id)).toEqual([
      'destination-a',
      'destination-b',
      'destination-c',
    ]);
    expect(result.routes).toHaveLength(2);
    expect(result.routes[0]).toMatchObject({
      fromDestinationId: 'destination-a',
      toDestinationId: 'destination-b',
      distanceMeters: 1000,
      durationSeconds: 120,
      polyline: 'encoded',
    });
    expect(routes.getRoutes).toHaveBeenCalledTimes(1);
    expect(routes.getRoutes.mock.calls[0][0]).toHaveLength(2);
    expect(prisma.trip.findFirst.mock.calls[0][0].where.OR).toBeDefined();
  });

  it('queries only approved places and active gallery media', async () => {
    const { service, prisma } = setup();
    await service.getExplore('trip-1', 'user-1');
    expect(prisma.$queryRaw.mock.calls[0]).toContain(PlaceStatus.APPROVED);
    const query = prisma.place.findMany.mock.calls[0][0];
    expect(query.where.status).toBe(PlaceStatus.APPROVED);
    expect(query.select.coverImages.where.status).toBe(GalleryStatus.ACTIVE);
  });

  it('finds nearby places for every destination in a single bounded query', async () => {
    const { service, prisma } = setup();
    await service.getExplore('trip-1', 'user-1');
    expect(prisma.$queryRaw).toHaveBeenCalledTimes(1);
    const centers = centerValues(prisma.$queryRaw.mock.calls[0]);
    expect(centers.map((center) => center[0])).toEqual([
      'destination-a',
      'destination-b',
      'destination-c',
    ]);
    expect(prisma.$queryRaw.mock.calls[0]).toContain(20);
  });

  it('wraps the search box across the antimeridian', async () => {
    const { service, prisma } = setup([]);
    prisma.trip.findFirst.mockResolvedValueOnce({
      id: 'trip-1',
      destinations: [
        { ...destinations[0], id: 'fiji', lat: -17.7, lng: 179.95 },
      ],
    });
    await service.getExplore('trip-1', 'user-1');
    const [, , , , , minLng, maxLng] = centerValues(
      prisma.$queryRaw.mock.calls[0],
    )[0] as number[];
    expect(minLng).toBeGreaterThan(179);
    expect(maxLng).toBeLessThan(-179);
  });

  it('maps real rating, review count, image, and coordinates', async () => {
    const { service } = setup();
    const result = await service.getExplore('trip-1', 'user-1');
    expect(result.destinations[0].places[0]).toMatchObject({
      id: 'place-1',
      name: 'Marble Mountains',
      category: 'ATTRACTION',
      address: 'Da Nang',
      latitude: 16.0036,
      longitude: 108.263,
      averageRating: 4.7,
      reviewCount: 12,
      thumbnailUrl: 'https://cdn/places/marble.jpg',
      description: null,
    });
    expect(result.destinations[0].places[0].distanceKm).toBeGreaterThan(0);
  });

  it('returns null rating and image when a place has no reviews or gallery', async () => {
    const { service } = setup([
      {
        ...ratedPlace,
        averageRating: 0,
        _count: {
          reviews: 0,
          visitCount: 0,
          savedPlaces: 0,
          posts: 0,
        },
        coverImages: [],
      },
    ]);
    const result = await service.getExplore('trip-1', 'user-1');
    expect(result.destinations[0].places[0]).toMatchObject({
      averageRating: null,
      reviewCount: 0,
      thumbnailUrl: null,
    });
  });

  it('returns empty places for destinations with no nearby approved place', async () => {
    const { service } = setup();
    const result = await service.getExplore('trip-1', 'user-1');
    expect(result.destinations[2].places).toEqual([]);
  });

  it('ranks the full filtered candidate set before applying limit', async () => {
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

  it('returns empty arrays for a trip without destinations', async () => {
    const { service, prisma, routes } = setup([]);
    prisma.trip.findFirst.mockResolvedValueOnce({
      id: 'trip-1',
      destinations: [],
    });
    const result = await service.getExplore('trip-1', 'user-1');
    expect(result.destinations).toEqual([]);
    expect(result.routes).toEqual([]);
    expect(prisma.$queryRaw).not.toHaveBeenCalled();
    expect(routes.getRoutes).toHaveBeenCalledWith([]);
  });
});

/** Per-center VALUES rows passed to the nearby-places raw query. */
function centerValues(call: unknown[]): unknown[][] {
  const joined = call.find(
    (value): value is Prisma.Sql =>
      value instanceof Prisma.Sql && value.values.length % 7 === 0,
  );
  if (!joined) throw new Error('center rows not found');
  const rows: unknown[][] = [];
  for (let index = 0; index < joined.values.length; index += 7) {
    rows.push(joined.values.slice(index, index + 7));
  }
  return rows;
}

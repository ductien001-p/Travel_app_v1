import { ForbiddenException, NotFoundException } from '@nestjs/common';
import { PlaceStatus, TRIP_VISIBILITY } from '../../generated/prisma/enums';
import { SearchPlaceService } from './search-place.service';

describe('SearchPlaceService.semanticSearch', () => {
  function setup(destination: unknown) {
    const prisma = {
      tripDestination: { findUnique: jest.fn().mockResolvedValue(destination) },
      place: { findMany: jest.fn().mockResolvedValue([]) },
      placeCollectionItem: { findMany: jest.fn().mockResolvedValue([]) },
      $queryRaw: jest.fn().mockResolvedValue([]),
    };
    const embeddings = {
      createEmbedding: jest.fn().mockResolvedValue([0.1, 0.2]),
    };
    return {
      service: new SearchPlaceService(
        prisma as never,
        embeddings as never,
        {
          getPublicUrl: jest.fn((key: string) => `https://media/${key}`),
        } as never,
      ),
      prisma,
    };
  }

  it('requires the destination to exist', async () => {
    await expect(
      setup(null).service.semanticSearch('beach', 'missing', 20, 'user-1'),
    ).rejects.toBeInstanceOf(NotFoundException);
  });

  it('blocks outsiders from a private trip', async () => {
    const destination = {
      lat: 10,
      lng: 106,
      trip: {
        visibility: TRIP_VISIBILITY.PRIVATE,
        ownerId: 'owner-1',
        members: [],
      },
    };
    await expect(
      setup(destination).service.semanticSearch(
        'beach',
        'destination-1',
        20,
        'outsider',
      ),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });

  it('binds the APPROVED filter for an authorized search', async () => {
    const destination = {
      lat: 10,
      lng: 106,
      trip: {
        visibility: TRIP_VISIBILITY.PUBLIC,
        ownerId: 'owner-1',
        members: [],
      },
    };
    const { service, prisma } = setup(destination);
    await service.semanticSearch('beach', 'destination-1', 20, 'user-1');
    expect(prisma.$queryRaw).toHaveBeenCalled();
    const queryParts = prisma.$queryRaw.mock
      .calls[0][0] as TemplateStringsArray;
    expect(queryParts.join('?')).toContain('p.status = ?::"PlaceStatus"');
    expect(queryParts.join('?')).toContain('distance.distance_km <=');
    expect(prisma.$queryRaw.mock.calls[0]).toContain(PlaceStatus.APPROVED);
    expect(prisma.tripDestination.findUnique).toHaveBeenCalled();
  });

  it('enriches semantic results without changing their ranked order', async () => {
    const destination = {
      lat: 10,
      lng: 106,
      trip: {
        visibility: TRIP_VISIBILITY.PUBLIC,
        ownerId: 'owner-1',
        members: [],
      },
    };
    const { service, prisma } = setup(destination);
    prisma.$queryRaw.mockResolvedValue([
      {
        id: 'place-2',
        name: 'Beach',
        description: null,
        latitude: 10,
        longitude: 106,
        similarity: 0.9,
        distance_km: 1.2,
      },
      {
        id: 'place-1',
        name: 'Cafe',
        description: null,
        latitude: 10.01,
        longitude: 106.01,
        similarity: 0.8,
        distance_km: 2.1,
      },
    ]);
    prisma.place.findMany.mockResolvedValue([
      {
        id: 'place-1',
        category: 'CAFE',
        address: '1 Cafe Street',
        averageRating: 4.5,
        _count: { reviews: 2 },
        coverImages: [],
      },
      {
        id: 'place-2',
        category: 'BEACH',
        address: '2 Beach Road',
        averageRating: 0,
        _count: { reviews: 0 },
        coverImages: [{ media: { objectKey: 'places/beach.webp' } }],
      },
    ]);

    const result = await service.semanticSearch(
      'beach',
      'destination-1',
      20,
      'user-1',
    );

    expect(result.map((place) => place.id)).toEqual(['place-2', 'place-1']);
    expect(result[0]).toMatchObject({
      category: 'BEACH',
      address: '2 Beach Road',
      averageRating: null,
      reviewCount: 0,
      saveCount: 0,
      bookmarked: false,
      thumbnailUrl: 'https://media/places/beach.webp',
    });
    expect(result[1]).toMatchObject({
      averageRating: 4.5,
      reviewCount: 2,
      saveCount: 0,
      bookmarked: false,
      thumbnailUrl: null,
    });
  });

  it('binds an optional category group without changing the enum codes', async () => {
    const destination = {
      lat: 10,
      lng: 106,
      trip: {
        visibility: TRIP_VISIBILITY.PUBLIC,
        ownerId: 'owner-1',
        members: [],
      },
    };
    const { service, prisma } = setup(destination);

    await service.semanticSearch('food', 'destination-1', 20, 'user-1', [
      'FOOD',
      'CAFE',
    ] as never);

    const categoryFilter = prisma.$queryRaw.mock.calls[0].find(
      (value: unknown) =>
        typeof value === 'object' &&
        value !== null &&
        'strings' in value &&
        'values' in value,
    ) as { strings: string[]; values: unknown[] };
    expect(categoryFilter.strings.join('?')).toContain('p.category IN');
    expect(categoryFilter.values).toEqual(['FOOD', 'CAFE']);
  });

  it('searches the approved catalog without a destination', async () => {
    const { service, prisma } = setup(null);

    await service.semanticSearch('beach', undefined, 20, 'user-1');

    expect(prisma.tripDestination.findUnique).not.toHaveBeenCalled();
    const queryParts = prisma.$queryRaw.mock
      .calls[0][0] as TemplateStringsArray;
    const sql = queryParts.join('?');
    expect(sql).toContain('p.embedding IS NOT NULL');
    expect(sql).toContain('p.status = ?::"PlaceStatus"');
    expect(sql).not.toContain('BETWEEN');
    expect(prisma.$queryRaw.mock.calls[0]).toContain(PlaceStatus.APPROVED);
  });

  it('keeps catalog rank order and reports save counts', async () => {
    const { service, prisma } = setup(null);
    prisma.$queryRaw.mockResolvedValue([
      {
        id: 'place-2',
        name: 'Beach',
        description: null,
        latitude: 10,
        longitude: 106,
        similarity: 0.9,
        distance_km: null,
      },
      {
        id: 'place-1',
        name: 'Cafe',
        description: null,
        latitude: 10.01,
        longitude: 106.01,
        similarity: 0.4,
        distance_km: null,
      },
    ]);
    prisma.place.findMany.mockResolvedValue([
      {
        id: 'place-1',
        category: 'CAFE',
        address: '1 Cafe Street',
        averageRating: 4.9,
        _count: { reviews: 3, savedPlaces: 12 },
        coverImages: [],
      },
      {
        id: 'place-2',
        category: 'BEACH',
        address: '2 Beach Road',
        averageRating: 4.2,
        _count: { reviews: 1, savedPlaces: 80 },
        coverImages: [],
      },
    ]);
    prisma.placeCollectionItem.findMany.mockResolvedValue([
      { placeId: 'place-2' },
    ]);

    const result = await service.semanticSearch(
      'beach',
      undefined,
      20,
      'user-1',
    );

    expect(result.map((place) => place.id)).toEqual(['place-2', 'place-1']);
    expect(result[0]).toMatchObject({
      saveCount: 80,
      bookmarked: true,
      distance_km: null,
    });
    expect(result[1]).toMatchObject({ saveCount: 12, bookmarked: false });
  });
});

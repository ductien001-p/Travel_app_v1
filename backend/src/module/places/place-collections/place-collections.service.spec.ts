import {
  PlaceCollectionVisibility,
  PlaceStatus,
} from '../../../generated/prisma/enums';
import { PlaceCollectionsService } from './place-collections.service';
import { PlacePolicyError } from '../policies';

describe('PlaceCollectionsService', () => {
  const s3 = { getPublicUrl: (key: string) => `https://cdn.test/${key}` };

  it('rejects an empty membership before writing', async () => {
    const prisma = {
      place: {
        findUnique: jest.fn().mockResolvedValue({
          id: 'place-1',
          status: PlaceStatus.APPROVED,
        }),
      },
      placeCollection: { findMany: jest.fn().mockResolvedValue([]) },
      $transaction: jest.fn(),
    };
    const service = new PlaceCollectionsService(prisma as never, s3 as never);
    await expect(
      service.setMembership('user-1', 'place-1', []),
    ).rejects.toBeInstanceOf(PlacePolicyError);
    expect(prisma.$transaction).not.toHaveBeenCalled();
  });

  it('saves the place when it is added to at least one owned collection', async () => {
    const upsert = jest.fn();
    const prisma = {
      place: {
        findUnique: jest.fn().mockResolvedValue({
          id: 'place-1',
          status: PlaceStatus.APPROVED,
        }),
      },
      placeCollection: {
        findMany: jest.fn().mockResolvedValue([{ id: 'col-1' }]),
      },
      $transaction: jest.fn(async (run: (tx: unknown) => Promise<void>) =>
        run({
          placeCollectionItem: {
            findMany: jest.fn().mockResolvedValue([]),
            deleteMany: jest.fn(),
            createMany: jest.fn(),
          },
          savedPlace: { upsert },
        }),
      ),
    };
    const service = new PlaceCollectionsService(prisma as never, s3 as never);
    const result = await service.setMembership('user-1', 'place-1', ['col-1']);
    expect(result).toEqual({
      placeId: 'place-1',
      collectionIds: ['col-1'],
      saved: true,
    });
    expect(upsert).toHaveBeenCalledWith(
      expect.objectContaining({
        where: { userId_placeId: { userId: 'user-1', placeId: 'place-1' } },
      }),
    );
  });

  it('returns the existing snapshot and does not copy later changes', async () => {
    const create = jest.fn();
    const prisma = {
      placeCollection: {
        findUnique: jest.fn().mockResolvedValue({
          id: 'public-1',
          ownerId: 'owner',
          title: 'Beaches',
          visibility: PlaceCollectionVisibility.PUBLIC,
          items: [{ placeId: 'place-1' }, { placeId: 'place-2' }],
        }),
        findFirst: jest.fn().mockResolvedValue({
          id: 'copy-1',
          title: 'Beaches',
          visibility: PlaceCollectionVisibility.PRIVATE,
          items: [{ placeId: 'place-1' }],
        }),
        create,
      },
    };
    const service = new PlaceCollectionsService(prisma as never, s3 as never);
    const copy = await service.copy('user-1', 'public-1');
    expect(copy.id).toBe('copy-1');
    expect(copy.placeIds).toEqual(['place-1']);
    expect(create).not.toHaveBeenCalled();
  });

  it('ranks rated public originals ahead of unrated ones', async () => {
    const prisma = {
      placeCollection: {
        findMany: jest
          .fn()
          .mockResolvedValue([
            featuredRow('new', [], new Date('2026-10-31T00:00:00.000Z')),
            featuredRow('loved', [5, 5], new Date('2026-10-01T00:00:00.000Z')),
            featuredRow('ok', [4], new Date('2026-10-20T00:00:00.000Z')),
          ]),
      },
    };
    const service = new PlaceCollectionsService(prisma as never, s3 as never);
    const ranked = await service.findFeatured();
    expect(ranked.map((item) => item.id)).toEqual(['loved', 'ok', 'new']);
    expect(prisma.placeCollection.findMany.mock.calls[0][0].where).toEqual({
      visibility: PlaceCollectionVisibility.PUBLIC,
      sourceCollectionId: null,
    });
  });
});

function featuredRow(id: string, ratings: number[], createdAt: Date) {
  return {
    id,
    title: id,
    createdAt,
    owner: { displayname: 'Mai' },
    ratings: ratings.map((rating) => ({ rating })),
    items: [{ place: { coverImages: [] } }],
    _count: { items: 2 },
  };
}

import { PlaceStatus } from '../../generated/prisma/enums';
import { FeaturedPlacesService } from './featured-places.service';
import { PlacePopularityRankingService } from './place-popularity/place-popularity-ranking.service';

describe('FeaturedPlacesService', () => {
  it('marks a place bookmarked only when it is in one of the user collections', async () => {
    const place = candidate('place-1');
    const prisma = {
      place: { findMany: jest.fn().mockResolvedValue([place]) },
      placeCollectionItem: {
        findMany: jest.fn().mockResolvedValue([{ placeId: 'place-1' }]),
      },
    };
    const service = new FeaturedPlacesService(
      prisma as never,
      new PlacePopularityRankingService(),
      { getPublicUrl: (key: string) => `https://cdn.test/${key}` } as never,
    );

    const first = await service.findForUser(
      'user-1',
      420,
      new Date('2026-10-31T02:00:00.000Z'),
    );
    const second = await service.findForUser(
      'user-1',
      420,
      new Date('2026-10-31T10:00:00.000Z'),
    );

    expect(first.date).toBe('2026-10-31');
    expect(first.subtitle).toBe('Nổi bật hôm nay');
    expect(first.places.map((item) => item.id)).toEqual(
      second.places.map((item) => item.id),
    );
    expect(first.places[0].bookmarked).toBe(true);
    expect(prisma.place.findMany.mock.calls[0][0].where).toEqual({
      status: PlaceStatus.APPROVED,
    });
  });
});

function candidate(id: string) {
  return {
    id,
    name: id,
    description: 'A short note',
    category: 'BEACH',
    city: 'Da Nang',
    address: 'Son Tra',
    averageRating: 4.5,
    _count: { savedPlaces: 2, reviews: 1, visitCount: 3, posts: 0 },
    coverImages: [{ media: { objectKey: 'covers/a.jpg' } }],
  };
}

import { PlaceStatus } from '../../generated/prisma/enums';
import { PlacesService } from './places.service';

describe('PlacesService public responses', () => {
  it('keeps list/detail approved-only and supplies image URLs in both', async () => {
    const place = {
      id: 'place-1',
      name: 'Hoi An',
      status: PlaceStatus.APPROVED,
      coverImages: [{ media: { id: 'media-1', objectKey: 'places/u/a.jpg' } }],
    };
    const prisma = {
      place: {
        findFirst: jest.fn().mockResolvedValue(place),
        findMany: jest.fn().mockResolvedValue([place]),
        count: jest.fn().mockResolvedValue(1),
      },
      $transaction: jest.fn(async (operations: Promise<unknown>[]) =>
        Promise.all(operations),
      ),
    };
    const s3 = {
      getPublicUrl: jest.fn((key: string) => `https://cdn.test/${key}`),
    };
    const service = new PlacesService(
      prisma as never,
      {} as never,
      s3 as never,
      {} as never,
    );

    const [list, detail] = await Promise.all([
      service.findPublicMany({ page: 1, limit: 20 }),
      service.findPublicById('place-1'),
    ]);
    expect(prisma.place.findMany.mock.calls[0][0].where).toEqual({
      status: PlaceStatus.APPROVED,
    });
    expect(prisma.place.findFirst.mock.calls[0][0].where).toEqual({
      id: 'place-1',
      status: PlaceStatus.APPROVED,
    });
    expect(list.data[0].coverImageUrls).toEqual([
      'https://cdn.test/places/u/a.jpg',
    ]);
    expect(detail.coverImageUrls).toEqual(['https://cdn.test/places/u/a.jpg']);
  });
});

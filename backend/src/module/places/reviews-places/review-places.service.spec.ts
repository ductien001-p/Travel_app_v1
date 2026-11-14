import { PlaceReviewsService } from './review-places.service';

describe('PlaceReviewsService', () => {
  it('returns the created review without an extra envelope', async () => {
    const review = {
      id: 'review-1',
      userId: 'user-1',
      placeId: 'place-1',
      rating: 5,
      comment: 'Great',
      createdAt: new Date('2026-11-02T00:00:00.000Z'),
      user: { id: 'user-1', username: 'traveler', avatarId: null },
      place: { id: 'place-1', name: 'Hoi An' },
    };
    const tx = {
      placeReview: {
        create: jest.fn().mockResolvedValue(review),
        aggregate: jest.fn().mockResolvedValue({ _avg: { rating: 5 } }),
      },
      place: {
        update: jest.fn().mockResolvedValue({}),
      },
    };
    const prisma = {
      place: {
        findUnique: jest.fn().mockResolvedValue({ id: 'place-1' }),
      },
      tripCheckin: {
        findFirst: jest.fn().mockResolvedValue({ id: 'checkin-1' }),
      },
      placeReview: {
        findUnique: jest.fn().mockResolvedValue(null),
      },
      $transaction: jest.fn(async (callback: (client: typeof tx) => unknown) =>
        callback(tx),
      ),
    };
    const service = new PlaceReviewsService(prisma as never);

    const created = await service.create('user-1', 'place-1', {
      rating: 5,
      comment: 'Great',
    });

    expect(created).toEqual(review);
    expect(created).not.toHaveProperty('message');
  });
});

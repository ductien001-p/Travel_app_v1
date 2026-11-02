import { PlacePopularityRankingService } from './place-popularity-ranking.service';

const candidate = (
  id: string,
  values: Partial<{
    visitCount: number;
    saveCount: number;
    reviewCount: number;
    averageRating: number;
    postCount: number;
  }> = {},
) => ({
  id,
  visitCount: 0,
  saveCount: 0,
  reviewCount: 0,
  averageRating: 0,
  postCount: 0,
  ...values,
});

describe('PlacePopularityRankingService', () => {
  const service = new PlacePopularityRankingService();

  it('log-normalizes count metrics with different scales', () => {
    const ranked = service.rank([
      candidate('A', { visitCount: 10000, saveCount: 10 }),
      candidate('B', { visitCount: 100, saveCount: 1000 }),
    ]);
    expect(ranked.map((place) => place.id)).toEqual(['A', 'B']);
  });

  it('does not produce unstable ordering when every value is identical', () => {
    const ranked = service.rank([candidate('B'), candidate('A')]);
    expect(ranked.map((place) => place.id)).toEqual(['A', 'B']);
  });

  it('ranks zero-metric candidates without NaN or Infinity', () => {
    const ranked = service.rank([candidate('zero')]);
    expect(ranked).toEqual([candidate('zero')]);
  });

  it('uses rating, review count, then id as stable tie-breaks', () => {
    expect(
      service
        .rank([
          candidate('low-rating', { averageRating: 2.5, postCount: 1 }),
          candidate('high-rating', { averageRating: 5 }),
        ])
        .map((place) => place.id),
    ).toEqual(['high-rating', 'low-rating']);

    const reviewTie = service.rank([
      candidate('few-reviews', { saveCount: 2 }),
      candidate('many-reviews', { reviewCount: 1 }),
      candidate('save-range-anchor', { saveCount: 8, reviewCount: 1 }),
    ]);
    expect(
      reviewTie.findIndex((place) => place.id === 'many-reviews'),
    ).toBeLessThan(reviewTie.findIndex((place) => place.id === 'few-reviews'));
  });
});

import { Injectable } from '@nestjs/common';

export type PopularityCandidate<T> = T & {
  id: string;
  visitCount: number;
  saveCount: number;
  reviewCount: number;
  averageRating: number;
  postCount: number;
};

@Injectable()
export class PlacePopularityRankingService {
  private static readonly weights = {
    visitCount: 0.4,
    saveCount: 0.3,
    reviewCount: 0.15,
    averageRating: 0.1,
    postCount: 0.05,
  } as const;

  rank<T>(places: PopularityCandidate<T>[]): PopularityCandidate<T>[] {
    const ranges = {
      visitCount: this.logRange(places.map((place) => place.visitCount)),
      saveCount: this.logRange(places.map((place) => place.saveCount)),
      reviewCount: this.logRange(places.map((place) => place.reviewCount)),
      postCount: this.logRange(places.map((place) => place.postCount)),
    };

    return places
      .map((place) => ({
        place,
        score:
          this.normalizeCount(place.visitCount, ranges.visitCount) *
            PlacePopularityRankingService.weights.visitCount +
          this.normalizeCount(place.saveCount, ranges.saveCount) *
            PlacePopularityRankingService.weights.saveCount +
          this.normalizeCount(place.reviewCount, ranges.reviewCount) *
            PlacePopularityRankingService.weights.reviewCount +
          this.normalizeRating(place.averageRating) *
            PlacePopularityRankingService.weights.averageRating +
          this.normalizeCount(place.postCount, ranges.postCount) *
            PlacePopularityRankingService.weights.postCount,
      }))
      .sort(
        (a, b) =>
          b.score - a.score ||
          b.place.averageRating - a.place.averageRating ||
          b.place.reviewCount - a.place.reviewCount ||
          a.place.id.localeCompare(b.place.id),
      )
      .map(({ place }) => place);
  }

  private logRange(values: number[]) {
    const logs = values.map((value) => Math.log1p(value));
    return {
      min: logs.length === 0 ? 0 : Math.min(...logs),
      max: logs.length === 0 ? 0 : Math.max(...logs),
    };
  }

  private normalizeCount(value: number, range: { min: number; max: number }) {
    if (range.max === range.min) return 0;
    return (Math.log1p(value) - range.min) / (range.max - range.min);
  }

  private normalizeRating(value: number) {
    return value / 5;
  }
}

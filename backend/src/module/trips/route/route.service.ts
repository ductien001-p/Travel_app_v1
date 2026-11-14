import { HttpException, HttpStatus, Inject, Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { RedisService } from '../../../redis/redis.service';
import { ROUTE_PROVIDER } from './route.types';
import type { Coordinate, RouteProvider, RouteResult } from './route.types';

export type RouteSegmentResult =
  | ({ available: true } & RouteResult)
  | {
      available: false;
      distanceMeters: null;
      durationSeconds: null;
      polyline: null;
      unavailableReason: 'MISSING_COORDINATES' | 'PROVIDER_UNAVAILABLE';
    };

const COORDINATE_DECIMALS = 5;
const PREVIEW_QUOTA_WINDOW_SECONDS = 60;
const DEFAULT_PREVIEW_QUOTA_PER_WINDOW = 30;
/** Upper bound on simultaneous provider calls for one multi-segment request. */
const MAX_CONCURRENT_SEGMENTS = 4;

export type RouteSegmentRequest = {
  origin: Coordinate;
  destination: Coordinate;
};

@Injectable()
export class RouteService {
  private readonly ttlSeconds: number;
  private readonly previewQuota: number;

  constructor(
    @Inject(ROUTE_PROVIDER) private readonly provider: RouteProvider,
    private readonly redis: RedisService,
    config: ConfigService,
  ) {
    this.ttlSeconds = this.positiveInteger(
      config.get('GOOGLE_ROUTES_CACHE_TTL_SECONDS'),
      86400,
    );
    this.previewQuota = this.positiveInteger(
      config.get('ROUTE_PREVIEW_QUOTA_PER_MINUTE'),
      DEFAULT_PREVIEW_QUOTA_PER_WINDOW,
    );
  }

  /** User-triggered preview; each call may cost a paid provider request. */
  async previewRoute(
    userId: string,
    origin: Coordinate,
    destination: Coordinate,
  ): Promise<RouteSegmentResult> {
    await this.assertPreviewQuota(userId);
    return this.getRoute(origin, destination);
  }

  /** Resolves segments in order without flooding the provider. */
  async getRoutes(
    segments: RouteSegmentRequest[],
  ): Promise<RouteSegmentResult[]> {
    const results: RouteSegmentResult[] = [];
    for (
      let start = 0;
      start < segments.length;
      start += MAX_CONCURRENT_SEGMENTS
    ) {
      const batch = segments.slice(start, start + MAX_CONCURRENT_SEGMENTS);
      results.push(
        ...(await Promise.all(
          batch.map(({ origin, destination }) =>
            this.getRoute(origin, destination),
          ),
        )),
      );
    }
    return results;
  }

  async getRoute(
    rawOrigin: Coordinate,
    rawDestination: Coordinate,
  ): Promise<RouteSegmentResult> {
    if (!this.isCoordinate(rawOrigin) || !this.isCoordinate(rawDestination)) {
      return this.unavailable('MISSING_COORDINATES');
    }

    // Near-identical points share one cache entry (and one paid Google call).
    const origin = this.roundCoordinate(rawOrigin);
    const destination = this.roundCoordinate(rawDestination);

    const key = this.cacheKey(origin, destination);
    try {
      const cached = await this.redis.get(key);
      if (cached)
        return { available: true, ...(JSON.parse(cached) as RouteResult) };
    } catch {
      // A cache outage must not prevent the route provider from serving data.
    }

    try {
      const route = await this.provider.getRoute(origin, destination);
      try {
        await this.redis.set(key, JSON.stringify(route), this.ttlSeconds);
      } catch {
        // Returning the provider result is preferable to failing on cache writes.
      }
      return { available: true, ...route };
    } catch {
      return this.unavailable('PROVIDER_UNAVAILABLE');
    }
  }

  private async assertPreviewQuota(userId: string): Promise<void> {
    let used: number;
    try {
      used = await this.redis.incrementWithTtl(
        `route:preview-quota:${userId}`,
        PREVIEW_QUOTA_WINDOW_SECONDS,
      );
    } catch {
      // A cache outage must not block route previews.
      return;
    }
    if (used > this.previewQuota) {
      throw new HttpException(
        {
          code: 'RATE_LIMITED',
          message: 'Too many route previews, please try again later',
        },
        HttpStatus.TOO_MANY_REQUESTS,
      );
    }
  }

  private positiveInteger(value: unknown, fallback: number): number {
    const parsed = Number(value);
    return Number.isInteger(parsed) && parsed > 0 ? parsed : fallback;
  }

  private unavailable(
    reason: 'MISSING_COORDINATES' | 'PROVIDER_UNAVAILABLE',
  ): RouteSegmentResult {
    return {
      available: false,
      distanceMeters: null,
      durationSeconds: null,
      polyline: null,
      unavailableReason: reason,
    };
  }

  private isCoordinate(value: Coordinate): boolean {
    return (
      Number.isFinite(value.latitude) &&
      Number.isFinite(value.longitude) &&
      value.latitude >= -90 &&
      value.latitude <= 90 &&
      value.longitude >= -180 &&
      value.longitude <= 180
    );
  }

  /** 5 decimal places is about 1.1 m, finer than a routable difference. */
  private roundCoordinate(value: Coordinate): Coordinate {
    return {
      latitude: Number(value.latitude.toFixed(COORDINATE_DECIMALS)),
      longitude: Number(value.longitude.toFixed(COORDINATE_DECIMALS)),
    };
  }

  private cacheKey(origin: Coordinate, destination: Coordinate): string {
    return `route:google:${origin.latitude}:${origin.longitude}:${destination.latitude}:${destination.longitude}`;
  }
}

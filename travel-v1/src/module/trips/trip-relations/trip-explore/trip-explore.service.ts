import { Injectable, NotFoundException } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Prisma } from '../../../../generated/prisma/client';
import {
  GalleryStatus,
  PLACE_CATEGORY,
  PlaceStatus,
} from '../../../../generated/prisma/enums';
import { PrismaService } from '../../../../prisma.service';
import { S3Service } from '../../../../uploads/s3/s3.service';
import { RouteService } from '../../route/route.service';
import { buildTripReadAccessWhere } from '../../policies';
import { PlacePopularityRankingService } from '../../../places/place-popularity/place-popularity-ranking.service';
import { CatalogPlaceSort } from '../../dto/destination-planning.dto';

type ExploreDestination = {
  id: string;
  city: string;
  country: string;
  lat: number;
  lng: number;
  order: number;
  destinationType: string | null;
  highlights: string[];
  coverMedia: { id: string; objectKey: string; deletedAt: Date | null } | null;
};

type NearbyCenter = { key: string; lat: number; lng: number };

type NearbyPlaces = {
  places: Array<{ id: string; distanceKm: number }>;
  /** Every approved place within the radius, not only the returned ones. */
  total: number;
};

type NearbyRow = {
  key: string;
  id: string;
  distance_km: number;
  total: bigint | number;
};

/**
 * Popularity is ranked among this many nearest candidates; ranking every
 * place in a dense city would load an unbounded number of rows.
 */
const MAX_RANKED_CANDIDATES = 500;
const MAX_CATALOG_PLACE_LIMIT = 100;
const EARTH_RADIUS_KM = 6371;
const KM_PER_LATITUDE_DEGREE = 111;

const PLACE_DETAIL_SELECT = {
  id: true,
  name: true,
  category: true,
  description: true,
  address: true,
  latitude: true,
  longitude: true,
  averageRating: true,
  _count: {
    select: {
      reviews: true,
      visitCount: true,
      savedPlaces: true,
      posts: true,
    },
  },
  coverImages: {
    where: { status: GalleryStatus.ACTIVE, media: { deletedAt: null } },
    orderBy: [{ isCover: 'desc' }, { score: 'desc' }, { createdAt: 'asc' }],
    take: 1,
    select: { media: { select: { objectKey: true } } },
  },
} satisfies Prisma.PlaceSelect;

type PlaceDetail = Prisma.PlaceGetPayload<{
  select: typeof PLACE_DETAIL_SELECT;
}>;

@Injectable()
export class TripExploreService {
  private readonly radiusKm: number;
  private readonly placeLimit: number;

  constructor(
    private readonly prisma: PrismaService,
    private readonly routes: RouteService,
    private readonly s3: S3Service,
    private readonly popularityRanking: PlacePopularityRankingService,
    config: ConfigService,
  ) {
    this.radiusKm = this.positiveNumber(
      config.get('DESTINATION_PLACE_RADIUS_KM'),
      20,
    );
    this.placeLimit = Math.floor(
      this.positiveNumber(config.get('DESTINATION_PLACE_LIMIT'), 20),
    );
  }

  async getExplore(tripId: string, userId: string) {
    const trip = await this.prisma.trip.findFirst({
      where: { id: tripId, ...buildTripReadAccessWhere(userId) },
      select: {
        id: true,
        destinations: {
          orderBy: { order: 'asc' },
          select: {
            id: true,
            city: true,
            country: true,
            lat: true,
            lng: true,
            order: true,
            destinationType: true,
            highlights: true,
            coverMedia: {
              select: { id: true, objectKey: true, deletedAt: true },
            },
          },
        },
      },
    });

    if (!trip) throw new NotFoundException('Trip not found');

    const placesByDestination = await this.findPlaces(trip.destinations);
    const legs = trip.destinations.slice(0, -1).map((origin, index) => ({
      origin,
      destination: trip.destinations[index + 1],
    }));
    const legRoutes = await this.routes.getRoutes(
      legs.map(({ origin, destination }) => ({
        origin: { latitude: origin.lat, longitude: origin.lng },
        destination: { latitude: destination.lat, longitude: destination.lng },
      })),
    );
    const routes = legs.map(({ origin, destination }, index) => ({
      fromDestinationId: origin.id,
      toDestinationId: destination.id,
      ...legRoutes[index],
    }));

    return {
      tripId: trip.id,
      destinations: trip.destinations.map((destination) => ({
        id: destination.id,
        city: destination.city,
        country: destination.country,
        latitude: destination.lat,
        longitude: destination.lng,
        order: destination.order,
        type: destination.destinationType,
        image:
          destination.coverMedia && destination.coverMedia.deletedAt === null
            ? {
                id: destination.coverMedia.id,
                url: this.s3.getPublicUrl(destination.coverMedia.objectKey),
              }
            : null,
        highlights: destination.highlights,
        places: placesByDestination.get(destination.id) ?? [],
      })),
      routes,
    };
  }

  async getDestinationPlaces(
    tripId: string,
    destinationId: string,
    userId: string,
  ) {
    const trip = await this.prisma.trip.findFirst({
      where: { id: tripId, ...buildTripReadAccessWhere(userId) },
      select: {
        destinations: {
          where: { id: destinationId },
          select: {
            id: true,
            city: true,
            country: true,
            lat: true,
            lng: true,
            order: true,
            destinationType: true,
            highlights: true,
            coverMedia: {
              select: { id: true, objectKey: true, deletedAt: true },
            },
          },
        },
      },
    });
    const destination = trip?.destinations[0];
    if (!destination) throw new NotFoundException('Destination not found');
    return (await this.findPlaces([destination])).get(destination.id) ?? [];
  }

  async getCatalogPlaces(
    catalogId: string,
    category?: PLACE_CATEGORY,
    requestedLimit?: number,
    sort?: CatalogPlaceSort,
  ) {
    const destination = await this.prisma.destinationCatalog.findFirst({
      where: { id: catalogId, isActive: true },
      select: { id: true, lat: true, lng: true },
    });
    if (!destination) throw new NotFoundException('Destination not found');

    const limit = Math.min(
      Math.max(requestedLimit ?? this.placeLimit, 1),
      MAX_CATALOG_PLACE_LIMIT,
    );
    const isPopular = sort === CatalogPlaceSort.POPULAR;
    const nearby = (
      await this.findNearbyPlaceIds(
        [{ key: destination.id, lat: destination.lat, lng: destination.lng }],
        isPopular ? MAX_RANKED_CANDIDATES : limit,
        category,
      )
    ).get(destination.id) ?? { places: [], total: 0 };

    const candidates = await this.loadPlaceDetails(nearby.places);
    const ordered = isPopular
      ? this.popularityRanking.rank(
          candidates.map((entry) => ({
            ...entry,
            id: entry.place.id,
            visitCount: entry.place._count.visitCount,
            saveCount: entry.place._count.savedPlaces,
            reviewCount: entry.place._count.reviews,
            averageRating: entry.place.averageRating,
            postCount: entry.place._count.posts,
          })),
        )
      : candidates;

    return {
      data: ordered
        .slice(0, limit)
        .map(({ place, distanceKm }) => this.mapPlace(place, distanceKm)),
      total: nearby.total,
      categories: Object.values(PLACE_CATEGORY),
    };
  }

  private async findPlaces(destinations: ExploreDestination[]) {
    const result = new Map<
      string,
      ReturnType<TripExploreService['mapPlace']>[]
    >();
    if (destinations.length === 0) return result;

    const nearbyByDestination = await this.findNearbyPlaceIds(
      destinations.map((destination) => ({
        key: destination.id,
        lat: destination.lat,
        lng: destination.lng,
      })),
      this.placeLimit,
    );
    const details = new Map(
      (
        await this.loadPlaceDetails(
          [...nearbyByDestination.values()].flatMap((entry) => entry.places),
        )
      ).map(({ place }) => [place.id, place]),
    );

    for (const destination of destinations) {
      const nearby = nearbyByDestination.get(destination.id)?.places ?? [];
      result.set(
        destination.id,
        nearby.flatMap(({ id, distanceKm }) => {
          const place = details.get(id);
          return place ? [this.mapPlace(place, distanceKm)] : [];
        }),
      );
    }
    return result;
  }

  /**
   * Nearest approved places per center, closest first, using one query.
   * Distances are great-circle, so centers near the antimeridian also match
   * places on the other side of it.
   */
  private async findNearbyPlaceIds(
    centers: NearbyCenter[],
    limitPerCenter: number,
    category?: PLACE_CATEGORY,
  ): Promise<Map<string, NearbyPlaces>> {
    const result = new Map<string, NearbyPlaces>();
    if (centers.length === 0) return result;

    const centerRows = centers.map((center) => {
      const box = this.boundingBox(center.lat, center.lng);
      return Prisma.sql`(${center.key}::text, ${center.lat}::float8, ${center.lng}::float8, ${box.minLat}::float8, ${box.maxLat}::float8, ${box.minLng}::float8, ${box.maxLng}::float8)`;
    });
    const categoryFilter = category
      ? Prisma.sql`AND pl."category"::text = ${category}`
      : Prisma.empty;

    const rows = await this.prisma.$queryRaw<NearbyRow[]>`
      SELECT c.key, nearest.id, nearest.distance_km, nearest.total
      FROM (VALUES ${Prisma.join(centerRows)})
        AS c(key, lat, lng, min_lat, max_lat, min_lng, max_lng)
      CROSS JOIN LATERAL (
        SELECT candidate.id, candidate.distance_km, COUNT(*) OVER () AS total
        FROM (
          SELECT pl.id,
            ${EARTH_RADIUS_KM}::float8 * 2 * asin(least(1, sqrt(
              power(sin(radians(pl.latitude - c.lat) / 2), 2) +
              cos(radians(c.lat)) * cos(radians(pl.latitude)) *
              power(sin(radians(pl.longitude - c.lng) / 2), 2)
            ))) AS distance_km
          FROM "Place" pl
          WHERE pl."status"::text = ${PlaceStatus.APPROVED}
            ${categoryFilter}
            AND pl.latitude BETWEEN c.min_lat AND c.max_lat
            AND CASE
              WHEN c.min_lng <= c.max_lng
                THEN pl.longitude BETWEEN c.min_lng AND c.max_lng
              ELSE pl.longitude >= c.min_lng OR pl.longitude <= c.max_lng
            END
        ) candidate
        WHERE candidate.distance_km <= ${this.radiusKm}::float8
        ORDER BY candidate.distance_km ASC, candidate.id ASC
        LIMIT ${limitPerCenter}::int
      ) nearest
    `;

    for (const center of centers) {
      result.set(center.key, { places: [], total: 0 });
    }
    for (const row of rows) {
      const entry = result.get(row.key);
      if (!entry) continue;
      entry.places.push({ id: row.id, distanceKm: Number(row.distance_km) });
      entry.total = Number(row.total);
    }
    return result;
  }

  /** Loads display data and keeps the nearest-first order of `nearby`. */
  private async loadPlaceDetails(
    nearby: Array<{ id: string; distanceKm: number }>,
  ): Promise<Array<{ place: PlaceDetail; distanceKm: number }>> {
    if (nearby.length === 0) return [];
    const places = await this.prisma.place.findMany({
      where: {
        id: { in: [...new Set(nearby.map((entry) => entry.id))] },
        status: PlaceStatus.APPROVED,
      },
      select: PLACE_DETAIL_SELECT,
    });
    const byId = new Map(places.map((place) => [place.id, place]));
    return nearby.flatMap(({ id, distanceKm }) => {
      const place = byId.get(id);
      return place ? [{ place, distanceKm }] : [];
    });
  }

  private mapPlace(place: PlaceDetail, distanceKm: number) {
    return {
      id: place.id,
      name: place.name,
      category: place.category,
      description: place.description ?? null,
      address: place.address,
      latitude: place.latitude,
      longitude: place.longitude,
      averageRating: place._count.reviews > 0 ? place.averageRating : null,
      reviewCount: place._count.reviews,
      thumbnailUrl: place.coverImages[0]
        ? this.s3.getPublicUrl(place.coverImages[0].media.objectKey)
        : null,
      distanceKm,
    };
  }

  /**
   * Coarse index filter around a center. Longitudes are normalized to
   * [-180, 180]; `minLng > maxLng` means the box wraps the antimeridian.
   */
  private boundingBox(latitude: number, longitude: number) {
    const latDelta = this.radiusKm / KM_PER_LATITUDE_DEGREE;
    const minLat = Math.max(latitude - latDelta, -90);
    const maxLat = Math.min(latitude + latDelta, 90);
    const cosine = Math.cos((latitude * Math.PI) / 180);
    const lngDelta =
      this.radiusKm /
      (KM_PER_LATITUDE_DEGREE * Math.max(Math.abs(cosine), 0.01));

    if (lngDelta >= 180 || minLat === -90 || maxLat === 90) {
      return { minLat, maxLat, minLng: -180, maxLng: 180 };
    }
    return {
      minLat,
      maxLat,
      minLng: this.normalizeLongitude(longitude - lngDelta),
      maxLng: this.normalizeLongitude(longitude + lngDelta),
    };
  }

  private normalizeLongitude(value: number): number {
    if (value < -180) return value + 360;
    if (value > 180) return value - 360;
    return value;
  }

  private positiveNumber(value: unknown, fallback: number) {
    const parsed = Number(value);
    return Number.isFinite(parsed) && parsed > 0 ? parsed : fallback;
  }
}

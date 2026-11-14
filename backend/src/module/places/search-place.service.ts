import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { PrismaService } from '../../prisma.service';
import { PlaceEmbeddingService } from './place-embedding.service';
import { Prisma } from '../../generated/prisma/client';
import {
  GalleryStatus,
  MEMBER_STATUS,
  PLACE_CATEGORY,
  PlaceStatus,
  TRIP_VISIBILITY,
} from '../../generated/prisma/enums';
import { S3Service } from '../../uploads/s3/s3.service';

@Injectable()
export class SearchPlaceService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly placeEmbeddingService: PlaceEmbeddingService,
    private readonly s3: S3Service,
  ) {}
  // Có destinationId: lọc quanh điểm đến của chuyến. Không có: tìm mọi place đã duyệt.
  async semanticSearch(
    query: string,
    destinationId: string | undefined,
    radiusKm = 20,
    userId: string,
    categories?: PLACE_CATEGORY[],
  ) {
    if (!query?.trim()) {
      return [];
    }

    const trimmed = query.trim();
    if (!destinationId) {
      const vector = await this.vectorFor(trimmed);
      const places = await this.searchApprovedCatalog(vector, categories);
      return this.enrich(places, userId);
    }

    const vector = await this.vectorFor(trimmed);
    const places = await this.searchAroundDestination(
      destinationId,
      radiusKm,
      userId,
      vector,
      categories,
    );
    return this.enrich(places, userId);
  }

  private async vectorFor(query: string) {
    const embedding = await this.placeEmbeddingService.createEmbedding(query);
    return `[${embedding.join(',')}]`;
  }

  private searchApprovedCatalog(vector: string, categories?: PLACE_CATEGORY[]) {
    return this.prisma.$queryRaw<SemanticPlaceRow[]>`
      SELECT
        p.id,
        p.name,
        p.description,
        p.latitude,
        p.longitude,
        1 - (p.embedding <=> ${vector}::vector) AS similarity,
        NULL::double precision AS distance_km
      FROM "Place" p
      WHERE p.embedding IS NOT NULL
        AND p.status = ${PlaceStatus.APPROVED}::"PlaceStatus"
        ${categorySql(categories)}
      ORDER BY p.embedding <=> ${vector}::vector
      LIMIT 30
    `;
  }

  private async searchAroundDestination(
    destinationId: string,
    radiusKm: number,
    userId: string,
    vector: string,
    categories?: PLACE_CATEGORY[],
  ) {
    const destination = await this.prisma.tripDestination.findUnique({
      where: {
        id: destinationId,
      },
      select: {
        lat: true,
        lng: true,
        trip: {
          select: {
            ownerId: true,
            visibility: true,
            members: {
              where: { userId, status: MEMBER_STATUS.ACTIVE },
              select: { id: true },
            },
          },
        },
      },
    });

    if (!destination) {
      throw new NotFoundException('Destination not found');
    }

    if (destination.lat == null || destination.lng == null) {
      throw new BadRequestException('Destination does not have coordinates');
    }

    if (
      destination.trip.visibility !== TRIP_VISIBILITY.PUBLIC &&
      destination.trip.ownerId !== userId &&
      destination.trip.members.length === 0
    ) {
      throw new ForbiddenException('You cannot search this destination');
    }

    const { lat, lng } = destination;
    const latDelta = radiusKm / 111;

    const lngDelta = radiusKm / (111 * Math.cos((lat * Math.PI) / 180));

    const minLat = lat - latDelta;
    const maxLat = lat + latDelta;

    const minLng = lng - lngDelta;
    const maxLng = lng + lngDelta;

    // ==========================================
    // 4. Search
    // ==========================================

    const places = await this.prisma.$queryRaw<
      {
        id: string;
        name: string;
        description: string | null;
        latitude: number;
        longitude: number;
        similarity: number;
        distance_km: number;
      }[]
    >`
    SELECT
      p.id,
      p.name,
      p.description,
      p.latitude,
      p.longitude,

      -- =====================================
      -- Semantic similarity
      -- =====================================

      1 - (
        p.embedding <=> ${vector}::vector
      ) AS similarity,

      -- =====================================
      -- Khoảng cách chính xác
      -- =====================================

      distance.distance_km

    FROM "Place" p

    -- Tính distance
    CROSS JOIN LATERAL (
      SELECT
        6371 * acos(
          LEAST(
            1,
            GREATEST(
              -1,

              cos(radians(${lat}))
              *
              cos(radians(p.latitude))
              *
              cos(
                radians(p.longitude)
                -
                radians(${lng})
              )
              +

              sin(radians(${lat}))
              *
              sin(radians(p.latitude))
            )
          )
        ) AS distance_km
    ) AS distance

    WHERE

      -- =====================================
      -- Place phải có embedding
      -- =====================================

      p.embedding IS NOT NULL

      AND p.status = ${PlaceStatus.APPROVED}::"PlaceStatus"

      ${categorySql(categories)}

      -- =====================================
      -- Place phải có GPS
      -- =====================================

      AND p.latitude IS NOT NULL
      AND p.longitude IS NOT NULL

      -- =====================================
      -- BƯỚC 1: Bounding Box
      -- =====================================

      AND p.latitude BETWEEN
        ${minLat} AND ${maxLat}

      AND p.longitude BETWEEN
        ${minLng} AND ${maxLng}

      -- =====================================
      -- BƯỚC 2: Exact Radius
      -- =====================================

      AND distance.distance_km <= ${radiusKm}

    -- =======================================
    -- BƯỚC 3: Semantic Search
    -- =======================================

    ORDER BY
      p.embedding <=> ${vector}::vector

    LIMIT 30
  `;

    return places;
  }

  private async enrich(places: SemanticPlaceRow[], userId: string) {
    if (places.length === 0) return [];

    const ids = places.map((place) => place.id);
    const [details, saved] = await Promise.all([
      this.prisma.place.findMany({
        where: { id: { in: ids } },
        select: {
          id: true,
          category: true,
          address: true,
          averageRating: true,
          _count: { select: { reviews: true, savedPlaces: true } },
          coverImages: {
            where: { status: GalleryStatus.ACTIVE, media: { deletedAt: null } },
            orderBy: [
              { isCover: 'desc' },
              { score: 'desc' },
              { createdAt: 'asc' },
            ],
            take: 1,
            select: { media: { select: { objectKey: true } } },
          },
        },
      }),
      this.prisma.placeCollectionItem.findMany({
        where: {
          placeId: { in: ids },
          collection: { ownerId: userId },
        },
        select: { placeId: true },
      }),
    ]);
    const detailsById = new Map(details.map((place) => [place.id, place]));
    const bookmarked = new Set(saved.map((item) => item.placeId));

    return places.map((place) => {
      const detail = detailsById.get(place.id);
      return {
        ...place,
        category: detail?.category ?? null,
        address: detail?.address ?? null,
        averageRating:
          detail && detail._count.reviews > 0 ? detail.averageRating : null,
        reviewCount: detail?._count.reviews ?? 0,
        saveCount: detail?._count.savedPlaces ?? 0,
        bookmarked: bookmarked.has(place.id),
        thumbnailUrl: detail?.coverImages[0]
          ? this.s3.getPublicUrl(detail.coverImages[0].media.objectKey)
          : null,
      };
    });
  }
}

type SemanticPlaceRow = {
  id: string;
  name: string;
  description: string | null;
  latitude: number;
  longitude: number;
  similarity: number;
  distance_km: number | null;
};

function categorySql(categories?: PLACE_CATEGORY[]) {
  if (!categories?.length) return Prisma.empty;
  return Prisma.sql`AND p.category IN (${Prisma.join(
    categories.map((category) => Prisma.sql`${category}::"PLACE_CATEGORY"`),
  )})`;
}

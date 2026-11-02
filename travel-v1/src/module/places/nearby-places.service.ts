import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../prisma.service';
import { S3Service } from '../../uploads/s3/s3.service';
import { GalleryStatus, PlaceStatus } from '../../generated/prisma/enums';
import { PlaceAccessPolicy } from './policies';
import { boundingBox, travelEstimate } from './nearby-places.travel';

const NEARBY_LIMIT = 20;

type NearbyRow = {
  id: string;
  name: string;
  category: string;
  address: string;
  average_rating: number;
  distance_km: number;
};

@Injectable()
export class NearbyPlacesService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
  ) {}

  async findNearby(latitude: number, longitude: number, radiusKm: number) {
    PlaceAccessPolicy.assertCoordinates(latitude, longitude);
    PlaceAccessPolicy.assertRadiusKm(radiusKm);
    const box = boundingBox(latitude, longitude, radiusKm);
    const rows = await this.prisma.$queryRaw<NearbyRow[]>`
      SELECT
        p.id,
        p.name,
        p.category::text AS category,
        p.address,
        p."averageRating" AS average_rating,
        distance.distance_km
      FROM "Place" p
      CROSS JOIN LATERAL (
        SELECT
          6371 * acos(
            LEAST(
              1,
              GREATEST(
                -1,
                cos(radians(${latitude}))
                * cos(radians(p.latitude))
                * cos(radians(p.longitude) - radians(${longitude}))
                + sin(radians(${latitude}))
                * sin(radians(p.latitude))
              )
            )
          ) AS distance_km
      ) AS distance
      WHERE p.status = ${PlaceStatus.APPROVED}::"PlaceStatus"
        AND p.latitude IS NOT NULL
        AND p.longitude IS NOT NULL
        AND p.latitude BETWEEN ${box.minLat} AND ${box.maxLat}
        AND p.longitude BETWEEN ${box.minLng} AND ${box.maxLng}
        AND distance.distance_km <= ${radiusKm}
      ORDER BY distance.distance_km ASC
      LIMIT ${NEARBY_LIMIT}
    `;

    if (rows.length === 0) return [];

    const details = await this.prisma.place.findMany({
      where: { id: { in: rows.map((row) => row.id) } },
      select: {
        id: true,
        _count: { select: { reviews: true } },
        coverImages: {
          where: { status: GalleryStatus.ACTIVE },
          orderBy: [{ isCover: 'desc' }, { score: 'desc' }],
          take: 1,
          select: { media: { select: { objectKey: true } } },
        },
      },
    });
    const byId = new Map(details.map((place) => [place.id, place]));

    return rows.map((row) => {
      const distanceKm = Number(row.distance_km);
      const travel = travelEstimate(distanceKm);
      const detail = byId.get(row.id);
      const cover = detail?.coverImages[0]?.media.objectKey;
      return {
        id: row.id,
        name: row.name,
        coverImageUrl: cover ? this.s3.getPublicUrl(cover) : null,
        category: row.category,
        averageRating: Number(row.average_rating),
        reviewCount: detail?._count.reviews ?? 0,
        address: row.address,
        distanceMeters: Math.round(distanceKm * 1000),
        travelMode: travel.travelMode,
        travelMinutes: travel.travelMinutes,
      };
    });
  }
}

import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../prisma.service';
import { S3Service } from '../../uploads/s3/s3.service';
import { GalleryStatus, PlaceStatus } from '../../generated/prisma/enums';
import { PlacePopularityRankingService } from './place-popularity/place-popularity-ranking.service';
import { PlaceAccessPolicy } from './policies';
import {
  FEATURED_SUBTITLE,
  pickFeaturedIds,
  viewerDateKey,
} from './featured-places.rotation';

const DESCRIPTION_LIMIT = 160;

@Injectable()
export class FeaturedPlacesService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly ranking: PlacePopularityRankingService,
    private readonly s3: S3Service,
  ) {}

  async findForUser(
    userId: string,
    utcOffsetMinutes: number,
    now = new Date(),
  ) {
    PlaceAccessPolicy.assertUtcOffsetMinutes(utcOffsetMinutes);
    const date = viewerDateKey(now, utcOffsetMinutes);
    const places = await this.prisma.place.findMany({
      where: { status: PlaceStatus.APPROVED },
      select: {
        id: true,
        name: true,
        description: true,
        category: true,
        city: true,
        address: true,
        averageRating: true,
        _count: {
          select: {
            savedPlaces: true,
            reviews: true,
            visitCount: true,
            posts: true,
          },
        },
        coverImages: {
          where: { status: GalleryStatus.ACTIVE },
          orderBy: [{ isCover: 'desc' }, { score: 'desc' }],
          take: 1,
          select: { media: { select: { objectKey: true } } },
        },
      },
    });

    const ranked = this.ranking.rank(
      places.map((place) => ({
        ...place,
        visitCount: place._count.visitCount,
        saveCount: place._count.savedPlaces,
        reviewCount: place._count.reviews,
        postCount: place._count.posts,
      })),
    );
    const pickedIds = pickFeaturedIds(
      ranked.map((place) => place.id),
      userId,
      date,
    );
    const byId = new Map(ranked.map((place) => [place.id, place]));
    const saved = await this.prisma.placeCollectionItem.findMany({
      where: {
        placeId: { in: pickedIds },
        collection: { ownerId: userId },
      },
      select: { placeId: true },
    });
    const bookmarked = new Set(saved.map((item) => item.placeId));

    return {
      subtitle: FEATURED_SUBTITLE,
      date,
      places: pickedIds.flatMap((id) => {
        const place = byId.get(id);
        if (!place) return [];
        const cover = place.coverImages[0]?.media.objectKey;
        return [
          {
            id: place.id,
            name: place.name,
            coverImageUrl: cover ? this.s3.getPublicUrl(cover) : null,
            category: place.category,
            averageRating: place.averageRating,
            saveCount: place.saveCount,
            city: place.city,
            address: place.address,
            description: clipDescription(place.description),
            bookmarked: bookmarked.has(place.id),
          },
        ];
      }),
    };
  }
}

function clipDescription(value: string | null): string | null {
  if (!value) return null;
  const trimmed = value.trim();
  if (trimmed.length <= DESCRIPTION_LIMIT) return trimmed;
  return `${trimmed.slice(0, DESCRIPTION_LIMIT - 3)}...`;
}

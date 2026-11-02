import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../../../prisma.service';
import { S3Service } from '../../../uploads/s3/s3.service';
import { Prisma } from '../../../generated/prisma/client';
import {
  GalleryStatus,
  PlaceCollectionVisibility,
} from '../../../generated/prisma/enums';
import { PlaceAccessPolicy, PlaceCollectionPolicy } from '../policies';

const FEATURED_LIMIT = 10;
const DETAIL_PLACE_LIMIT = 100;

const coverSelect = {
  where: { status: GalleryStatus.ACTIVE },
  orderBy: [{ isCover: 'desc' as const }, { score: 'desc' as const }],
  take: 1,
  select: { media: { select: { objectKey: true } } },
};

@Injectable()
export class PlaceCollectionsService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
  ) {}

  async create(userId: string, title: string) {
    const name = PlaceCollectionPolicy.assertTitle(title);
    const created = await this.prisma.placeCollection.create({
      data: {
        ownerId: userId,
        title: name,
        visibility: PlaceCollectionVisibility.PRIVATE,
      },
    });
    return this.toOwned(created, [], 0);
  }

  async findMine(userId: string) {
    const collections = await this.prisma.placeCollection.findMany({
      where: { ownerId: userId },
      orderBy: { createdAt: 'desc' },
      include: {
        items: { select: { placeId: true }, orderBy: { createdAt: 'asc' } },
      },
    });
    return collections.map((collection) =>
      this.toOwned(
        collection,
        collection.items.map((item) => item.placeId),
        collection.items.length,
      ),
    );
  }

  async findOne(userId: string, collectionId: string) {
    const collection = await this.loadCollection(collectionId);
    PlaceCollectionPolicy.assertCanRead(
      collection.ownerId,
      userId,
      collection.visibility,
    );
    const [viewerRating, copy] = await Promise.all([
      this.prisma.placeCollectionRating.findUnique({
        where: {
          collectionId_userId: { collectionId, userId },
        },
        select: { rating: true },
      }),
      this.prisma.placeCollection.findFirst({
        where: { ownerId: userId, sourceCollectionId: collectionId },
        select: { id: true },
      }),
    ]);
    const ratings = collection.ratings.map((item) => item.rating);
    return {
      id: collection.id,
      title: collection.title,
      visibility: collection.visibility,
      ownerDisplayName: collection.owner.displayname,
      coverImageUrl: this.coverUrl(collection.items[0]?.place.coverImages),
      placeCount: collection._count.items,
      averageRating: average(ratings),
      ratingCount: ratings.length,
      viewerRating: viewerRating?.rating ?? null,
      copiedByViewer: copy !== null,
      places: collection.items.map((item) => ({
        id: item.place.id,
        name: item.place.name,
        coverImageUrl: this.coverUrl(item.place.coverImages),
        category: item.place.category,
        city: item.place.city,
        averageRating: item.place.averageRating,
      })),
    };
  }

  async update(
    userId: string,
    collectionId: string,
    input: { title?: string; visibility?: PlaceCollectionVisibility },
  ) {
    const collection = await this.requireOwned(userId, collectionId);
    const title =
      input.title === undefined
        ? collection.title
        : PlaceCollectionPolicy.assertTitle(input.title);
    const updated = await this.prisma.placeCollection.update({
      where: { id: collectionId },
      data: {
        title,
        visibility: input.visibility ?? collection.visibility,
      },
      include: { items: { select: { placeId: true } } },
    });
    return this.toOwned(
      updated,
      updated.items.map((item) => item.placeId),
      updated.items.length,
    );
  }

  async remove(userId: string, collectionId: string) {
    const collection = await this.requireOwned(userId, collectionId);
    const placeIds = collection.items.map((item) => item.placeId);
    await this.prisma.$transaction(async (tx) => {
      await tx.placeCollection.delete({ where: { id: collectionId } });
      await this.dropOrphanSaves(tx, userId, placeIds);
    });
  }

  async setMembership(
    userId: string,
    placeId: string,
    collectionIds: string[],
  ) {
    const place = await this.prisma.place.findUnique({
      where: { id: placeId },
      select: { id: true, status: true },
    });
    PlaceAccessPolicy.assertApproved(place);
    const owned = await this.prisma.placeCollection.findMany({
      where: { ownerId: userId, id: { in: collectionIds } },
      select: { id: true },
    });
    PlaceCollectionPolicy.assertMembership(
      collectionIds,
      new Set(owned.map((item) => item.id)),
    );

    await this.prisma.$transaction(async (tx) => {
      const existing = await tx.placeCollectionItem.findMany({
        where: { placeId, collection: { ownerId: userId } },
        select: { collectionId: true },
      });
      const current = new Set(existing.map((item) => item.collectionId));
      const next = new Set(collectionIds);
      const toRemove = [...current].filter((id) => !next.has(id));
      const toAdd = [...next].filter((id) => !current.has(id));
      if (toRemove.length > 0) {
        await tx.placeCollectionItem.deleteMany({
          where: { placeId, collectionId: { in: toRemove } },
        });
      }
      if (toAdd.length > 0) {
        await tx.placeCollectionItem.createMany({
          data: toAdd.map((collectionId) => ({ collectionId, placeId })),
        });
      }
      await tx.savedPlace.upsert({
        where: { userId_placeId: { userId, placeId } },
        create: { userId, placeId },
        update: {},
      });
    });

    return { placeId, collectionIds, saved: true };
  }

  async copy(userId: string, collectionId: string) {
    const source = await this.prisma.placeCollection.findUnique({
      where: { id: collectionId },
      select: {
        id: true,
        ownerId: true,
        title: true,
        visibility: true,
        items: { select: { placeId: true }, orderBy: { createdAt: 'asc' } },
      },
    });
    if (!source) throw new NotFoundException('Collection not found');
    PlaceCollectionPolicy.assertCanCopy(
      source.ownerId,
      userId,
      source.visibility,
    );
    const existing = await this.prisma.placeCollection.findFirst({
      where: { ownerId: userId, sourceCollectionId: source.id },
      include: { items: { select: { placeId: true } } },
    });
    if (existing) {
      return this.toOwned(
        existing,
        existing.items.map((item) => item.placeId),
        existing.items.length,
      );
    }

    const created = await this.prisma.$transaction(async (tx) => {
      const copy = await tx.placeCollection.create({
        data: {
          ownerId: userId,
          title: source.title,
          visibility: PlaceCollectionVisibility.PRIVATE,
          sourceCollectionId: source.id,
          items: {
            create: source.items.map((item) => ({ placeId: item.placeId })),
          },
        },
        include: { items: { select: { placeId: true } } },
      });
      for (const item of source.items) {
        await tx.savedPlace.upsert({
          where: { userId_placeId: { userId, placeId: item.placeId } },
          create: { userId, placeId: item.placeId },
          update: {},
        });
      }
      return copy;
    });
    return this.toOwned(
      created,
      created.items.map((item) => item.placeId),
      created.items.length,
    );
  }

  async rate(userId: string, collectionId: string, rating: number) {
    PlaceCollectionPolicy.assertRatingValue(rating);
    const collection = await this.prisma.placeCollection.findUnique({
      where: { id: collectionId },
      select: { id: true, ownerId: true, visibility: true },
    });
    if (!collection) throw new NotFoundException('Collection not found');
    PlaceCollectionPolicy.assertCanRate(
      collection.ownerId,
      userId,
      collection.visibility,
    );
    await this.prisma.placeCollectionRating.upsert({
      where: { collectionId_userId: { collectionId, userId } },
      create: { collectionId, userId, rating },
      update: { rating },
    });
    const ratings = await this.prisma.placeCollectionRating.findMany({
      where: { collectionId },
      select: { rating: true },
    });
    const values = ratings.map((item) => item.rating);
    return {
      rating,
      averageRating: average(values),
      ratingCount: values.length,
    };
  }

  async findFeatured() {
    const collections = await this.prisma.placeCollection.findMany({
      where: {
        visibility: PlaceCollectionVisibility.PUBLIC,
        sourceCollectionId: null,
      },
      include: {
        owner: { select: { displayname: true } },
        ratings: { select: { rating: true } },
        items: {
          orderBy: { createdAt: 'asc' },
          take: 1,
          select: {
            place: { select: { coverImages: coverSelect } },
          },
        },
        _count: { select: { items: true } },
      },
    });
    return collections
      .map((collection) => {
        const values = collection.ratings.map((item) => item.rating);
        return {
          id: collection.id,
          title: collection.title,
          ownerDisplayName: collection.owner.displayname,
          coverImageUrl: this.coverUrl(collection.items[0]?.place.coverImages),
          placeCount: collection._count.items,
          averageRating: average(values),
          ratingCount: values.length,
          createdAt: collection.createdAt,
        };
      })
      .sort((left, right) => {
        const leftRated = left.ratingCount > 0;
        const rightRated = right.ratingCount > 0;
        if (leftRated !== rightRated) return leftRated ? -1 : 1;
        const byAverage =
          (right.averageRating ?? 0) - (left.averageRating ?? 0);
        if (byAverage !== 0) return byAverage;
        if (left.ratingCount !== right.ratingCount) {
          return right.ratingCount - left.ratingCount;
        }
        return right.createdAt.getTime() - left.createdAt.getTime();
      })
      .slice(0, FEATURED_LIMIT)
      .map(({ createdAt: _createdAt, ...collection }) => collection);
  }

  private async requireOwned(userId: string, collectionId: string) {
    const collection = await this.prisma.placeCollection.findUnique({
      where: { id: collectionId },
      include: { items: { select: { placeId: true } } },
    });
    if (!collection) throw new NotFoundException('Collection not found');
    PlaceCollectionPolicy.assertOwner(collection.ownerId, userId);
    return collection;
  }

  private async loadCollection(collectionId: string) {
    const collection = await this.prisma.placeCollection.findUnique({
      where: { id: collectionId },
      include: {
        owner: { select: { displayname: true } },
        ratings: { select: { rating: true } },
        items: {
          orderBy: { createdAt: 'asc' },
          take: DETAIL_PLACE_LIMIT,
          select: {
            place: {
              select: {
                id: true,
                name: true,
                category: true,
                city: true,
                averageRating: true,
                coverImages: coverSelect,
              },
            },
          },
        },
        _count: { select: { items: true } },
      },
    });
    if (!collection) throw new NotFoundException('Collection not found');
    return collection;
  }

  private coverUrl(
    images: { media: { objectKey: string } }[] | undefined,
  ): string | null {
    const key = images?.[0]?.media.objectKey;
    return key ? this.s3.getPublicUrl(key) : null;
  }

  private toOwned(
    collection: {
      id: string;
      title: string;
      visibility: PlaceCollectionVisibility;
    },
    placeIds: string[],
    placeCount: number,
  ) {
    return {
      id: collection.id,
      title: collection.title,
      visibility: collection.visibility,
      placeCount,
      placeIds,
    };
  }

  private async dropOrphanSaves(
    tx: Prisma.TransactionClient,
    userId: string,
    placeIds: string[],
  ) {
    for (const placeId of placeIds) {
      const remaining = await tx.placeCollectionItem.count({
        where: { placeId, collection: { ownerId: userId } },
      });
      if (remaining > 0) continue;
      await tx.savedPlace.deleteMany({
        where: { userId, placeId },
      });
    }
  }
}

function average(values: number[]): number | null {
  if (values.length === 0) return null;
  const total = values.reduce((sum, value) => sum + value, 0);
  return Math.round((total / values.length) * 10) / 10;
}

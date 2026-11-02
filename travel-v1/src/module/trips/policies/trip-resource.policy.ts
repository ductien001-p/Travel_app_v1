import { BadRequestException, ForbiddenException } from '@nestjs/common';
import { Prisma } from '../../../generated/prisma/client';

export class TripResourcePolicy {
  static async assertMediaOwned(
    reader: Pick<Prisma.TransactionClient, 'uploadedMedia'>,
    userId: string,
    mediaId: string,
  ): Promise<void> {
    const media = await reader.uploadedMedia.findFirst({
      where: { id: mediaId, userId, deletedAt: null },
      select: { id: true },
    });
    if (!media) {
      throw new BadRequestException(
        'Cover media is invalid or does not belong to you',
      );
    }
  }

  /** An image uploaded by `userId` and not deleted; returns its storage key. */
  static async assertOwnedImage(
    reader: Pick<Prisma.TransactionClient, 'uploadedMedia'>,
    userId: string,
    mediaId: string,
  ): Promise<{ id: string; objectKey: string }> {
    const media = await reader.uploadedMedia.findFirst({
      where: {
        id: mediaId,
        userId,
        deletedAt: null,
        mimeType: { startsWith: 'image/' },
      },
      select: { id: true, objectKey: true },
    });
    if (!media) {
      throw new BadRequestException(
        'Image is invalid or does not belong to you',
      );
    }
    return media;
  }

  /** Like `assertOwnedImage` for several ids at once; fails if any is not valid. */
  static async assertOwnedImages(
    reader: Pick<Prisma.TransactionClient, 'uploadedMedia'>,
    userId: string,
    mediaIds: string[],
  ): Promise<Map<string, { id: string; objectKey: string }>> {
    const uniqueIds = [...new Set(mediaIds)];
    const media = await reader.uploadedMedia.findMany({
      where: {
        id: { in: uniqueIds },
        userId,
        deletedAt: null,
        mimeType: { startsWith: 'image/' },
      },
      select: { id: true, objectKey: true },
    });
    if (media.length !== uniqueIds.length) {
      throw new BadRequestException(
        'Image is invalid or does not belong to you',
      );
    }
    return new Map(media.map((item) => [item.id, item]));
  }

  static assertOwnedBy(
    ownerId: string | null | undefined,
    actorId: string,
    message = 'You do not own this resource',
  ): void {
    if (!ownerId || ownerId !== actorId) {
      throw new ForbiddenException(message);
    }
  }

  static assertDifferentUsers(
    actorId: string,
    targetUserId: string,
    message = 'You cannot perform this action on yourself',
  ): void {
    if (actorId === targetUserId) {
      throw new BadRequestException(message);
    }
  }
}

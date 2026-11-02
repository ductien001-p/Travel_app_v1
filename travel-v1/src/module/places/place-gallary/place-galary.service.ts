import {
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { PrismaService } from '../../../prisma.service';
import { Prisma } from '../../../generated/prisma/browser';

@Injectable()
export class PlaceGalaryService {
  constructor(private readonly prisma: PrismaService) {}
  async addGalleryMedia(
    userId: string,
    placeId: string,
    mediaIds: string[],
    tx: Prisma.TransactionClient,
  ) {
    // 1. Kiểm tra Place
    const place = await tx.place.findUnique({
      where: {
        id: placeId,
      },
    });

    if (!place) {
      throw new NotFoundException('Place not found');
    }

    // 2. Lấy toàn bộ media
    const medias = await tx.uploadedMedia.findMany({
      where: {
        deletedAt: null,
        id: {
          in: mediaIds,
        },
      },
    });

    // 3. Kiểm tra media nào không tồn tại
    if (medias.length !== mediaIds.length) {
      throw new NotFoundException('Some media not found');
    }

    // 4. Kiểm tra toàn bộ media đều thuộc user
    const unauthorizedMedia = medias.find((media) => media.userId !== userId);

    if (unauthorizedMedia) {
      throw new ForbiddenException('You cannot use one or more media');
    }

    // 5. Tạo gallery records
    return tx.placeGallery.createMany({
      data: mediaIds.map((mediaId) => ({
        placeId,
        mediaId,
        uploadedById: userId,
      })),
      skipDuplicates: true,
    });
  }

  //Sau nay tao them ham cleanUp de xoa nhung media khong con trong gallery nua
  async deleteGalleryMedia(
    userId: string,
    placeId: string,
    mediaIds: string[],
  ) {
    const uniqueMediaIds = [...new Set(mediaIds)];

    const galleries = await this.prisma.placeGallery.findMany({
      where: {
        placeId,
        mediaId: {
          in: uniqueMediaIds,
        },
        media: {
          userId,
        },
      },
      select: {
        id: true,
        mediaId: true,
      },
    });

    if (galleries.length !== uniqueMediaIds.length) {
      throw new NotFoundException(
        'One or more gallery media were not found or do not belong to this user',
      );
    }

    await this.prisma.placeGallery.deleteMany({
      where: {
        id: {
          in: galleries.map((gallery) => gallery.id),
        },
      },
    });

    return {
      message: 'Gallery media deleted successfully',
      deletedCount: galleries.length,
    };
  }
}

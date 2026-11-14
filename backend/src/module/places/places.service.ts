import {
  ConflictException,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';

import { PrismaService } from '../../prisma.service';
import { CreatePlaceDto } from './dto/create-place.dto';
import { UpdatePlaceDto } from './dto/update-place.dto';
import { PaginationDto } from '../users/dto/pagination.dto';
import { PlaceEmbeddingService } from './place-embedding.service';

import { PlaceStatus, USER_ROLE } from '../../generated/prisma/browser';
import { GalleryStatus } from '../../generated/prisma/enums';
import { S3Service } from '../../uploads/s3/s3.service';
import { PlaceGalaryService } from './place-gallary/place-galary.service';
import { createPaginationMeta } from '../../common/contracts/pagination-meta.dto';

function coverImageInclude(take: number) {
  return {
    where: {
      status: GalleryStatus.ACTIVE,
      media: { deletedAt: null },
    },
    orderBy: [{ isCover: 'desc' as const }, { score: 'desc' as const }],
    take,
    select: {
      media: {
        select: {
          objectKey: true,
        },
      },
    },
  };
}

@Injectable()
export class PlacesService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly embeddingService: PlaceEmbeddingService,
    private readonly s3: S3Service,
    private readonly placeGalaryService: PlaceGalaryService,
  ) {}

  /**
   * =========================================================
   * PUBLIC PLACE
   * =========================================================
   */

  async findPublicById(id: string) {
    const place = await this.prisma.place.findFirst({
      where: {
        id,
        status: PlaceStatus.APPROVED,
      },
      include: {
        coverImages: coverImageInclude(12),
      },
    });

    if (!place) {
      throw new NotFoundException('Place not found');
    }
    const vistedCount = await this.prisma.placeVisit.count({
      where: {
        placeId: id,
      },
    });

    const { coverImages, ...placeData } = place;

    return {
      ...placeData,
      vistedCount,
      coverImageUrls: coverImages.map((cover) =>
        this.s3.getPublicUrl(cover.media.objectKey),
      ),
    };
  }

  async findPublicMany(paginationDto: PaginationDto) {
    const page = Math.max(paginationDto.page, 1);
    const limit = Math.min(Math.max(paginationDto.limit, 1), 100);

    const skip = (page - 1) * limit;

    const [places, total] = await this.prisma.$transaction([
      this.prisma.place.findMany({
        where: {
          status: PlaceStatus.APPROVED,
        },

        skip,
        take: limit,

        orderBy: {
          createdAt: 'desc',
        },

        include: {
          coverImages: coverImageInclude(1),
        },
      }),

      this.prisma.place.count({
        where: {
          status: PlaceStatus.APPROVED,
        },
      }),
    ]);

    const placeIds = places.map((place) => place.id);
    const visitCounts =
      placeIds.length === 0
        ? []
        : await this.prisma.placeVisit.groupBy({
            by: ['placeId'],
            where: { placeId: { in: placeIds } },
            _count: { _all: true },
          });
    const visitsByPlace = new Map(
      visitCounts.map((row) => [row.placeId, row._count._all]),
    );

    const data = places.map((place) => {
      const { coverImages, ...placeData } = place;
      return {
        ...placeData,
        vistedCount: visitsByPlace.get(place.id) ?? 0,
        coverImageUrls: coverImages.map((cover) =>
          this.s3.getPublicUrl(cover.media.objectKey),
        ),
      };
    });

    return {
      data,
      meta: createPaginationMeta(page, limit, total),
    };
  }

  /**
   * =========================================================
   * CREATE
   * =========================================================
   */

  async createByUser(dto: CreatePlaceDto, userId: string) {
    const mediaIds = [...new Set(dto.mediaIds ?? [])];
    const existingPlace = await this.findExistingPlace(dto);

    if (existingPlace) {
      throw new ConflictException('Place already exists');
    }
    const result = await this.prisma.$transaction(async (tx) => {
      const place = await tx.place.create({
        data: {
          name: dto.name,
          description: dto.description,
          category: dto.category,

          city: dto.city,
          country: dto.country,
          address: dto.address,

          latitude: dto.latitude,
          longitude: dto.longitude,

          createdByUserId: userId ?? null,
        },
      });
      if (mediaIds.length > 0) {
        await this.placeGalaryService.addGalleryMedia(
          userId,
          place.id,
          mediaIds,
          tx,
        );
      }
      return { place };
    });
    await this.generateEmbeddingSafely(result.place.id);

    return result.place;
  }

  async createByAdmin(dto: CreatePlaceDto, adminId: string) {
    const existingPlace = await this.findExistingPlace(dto);

    if (existingPlace) {
      throw new ConflictException('Place already exists');
    }

    const { mediaIds, ...placeData } = dto;
    const mediaIdsSet = [...new Set(mediaIds ?? [])];

    const place = await this.prisma.$transaction(async (tx) => {
      const createdPlace = await tx.place.create({
        data: {
          ...placeData,
          createdByUserId: adminId,
          status: PlaceStatus.APPROVED,
        },
      });

      if (mediaIdsSet?.length) {
        await this.placeGalaryService.addGalleryMedia(
          adminId,
          createdPlace.id,
          mediaIdsSet,
          tx,
        );
      }

      return createdPlace;
    });

    await this.generateEmbeddingSafely(place.id);

    return place;
  }
  /**
   * =========================================================
   * FIND EXISTING PLACE
   * =========================================================
   */

  private async findExistingPlace(dto: CreatePlaceDto) {
    return this.prisma.place.findFirst({
      where: {
        name: dto.name,
        city: dto.city,
        country: dto.country,
        latitude: dto.latitude,
        longitude: dto.longitude,

        status: {
          not: PlaceStatus.DELETED,
        },
      },
    });
  }

  /**
   * =========================================================
   * UPDATE
   * =========================================================
   */

  async update(id: string, dto: UpdatePlaceDto, userId: string) {
    const place = await this.prisma.place.findUnique({
      where: {
        id,
      },
    });

    if (!place) {
      throw new NotFoundException('Place not found');
    }

    if (place.createdByUserId !== userId) {
      throw new ForbiddenException('You are not allowed to update this place');
    }

    const updatedPlace = await this.prisma.place.update({
      where: {
        id,
      },
      data: {
        ...dto,

        /**
         * Editing an approved place may require
         * moderation again depending on your policy.
         */
        status:
          place.status === PlaceStatus.APPROVED
            ? PlaceStatus.PENDING
            : place.status,
      },
    });

    /**
     * Only regenerate embedding when semantic fields change.
     */
    const embeddingFieldsChanged =
      dto.name !== undefined ||
      dto.description !== undefined ||
      dto.category !== undefined ||
      dto.address !== undefined ||
      dto.city !== undefined ||
      dto.country !== undefined;

    if (embeddingFieldsChanged) {
      await this.generateEmbeddingSafely(updatedPlace.id);
    }

    return updatedPlace;
  }

  /**
   * =========================================================
   * ADMIN MODERATION
   * =========================================================
   */

  async approve(id: string, adminId: string) {
    await this.ensureAdmin(adminId);

    const place = await this.prisma.place.findFirst({
      where: {
        id,
        status: PlaceStatus.PENDING,
      },
    });

    if (!place) {
      throw new NotFoundException('Pending place not found');
    }

    return this.prisma.place.update({
      where: {
        id,
      },
      data: {
        status: PlaceStatus.APPROVED,
      },
    });
  }

  async reject(id: string, adminId: string) {
    await this.ensureAdmin(adminId);

    const place = await this.prisma.place.findFirst({
      where: {
        id,
        status: PlaceStatus.PENDING,
      },
    });

    if (!place) {
      throw new NotFoundException('Pending place not found');
    }

    return this.prisma.place.update({
      where: {
        id,
      },
      data: {
        status: PlaceStatus.REJECTED,
      },
    });
  }

  async softDelete(id: string, adminId: string) {
    await this.ensureAdmin(adminId);

    const place = await this.prisma.place.findUnique({
      where: {
        id,
        status: PlaceStatus.APPROVED,
      },
    });

    if (!place) {
      throw new NotFoundException('Place not found');
    }

    return this.prisma.place.update({
      where: {
        id,
      },
      data: {
        status: PlaceStatus.DELETED,
      },
    });
  }

  /**
   * =========================================================
   * ADMIN QUERY
   * =========================================================
   */

  async findPending(paginationDto: PaginationDto) {
    const page = Math.max(paginationDto.page, 1);

    const limit = Math.min(Math.max(paginationDto.limit, 1), 100);

    const skip = (page - 1) * limit;

    const [data, total] = await this.prisma.$transaction([
      this.prisma.place.findMany({
        where: {
          status: PlaceStatus.PENDING,
        },

        skip,
        take: limit,

        orderBy: {
          createdAt: 'asc',
        },
      }),

      this.prisma.place.count({
        where: {
          status: PlaceStatus.PENDING,
        },
      }),
    ]);

    return {
      data,
      meta: createPaginationMeta(page, limit, total),
    };
  }
  /**
   * =========================================================
   * HELPERS
   * =========================================================
   */

  private async ensureAdmin(userId: string) {
    const user = await this.prisma.user.findUnique({
      where: {
        id: userId,
      },
      select: {
        id: true,
        role: true,
      },
    });

    if (!user || user.role !== USER_ROLE.ADMIN) {
      throw new ForbiddenException('Admin access required');
    }
  }

  /**
   * Embedding should not break Place creation.
   */
  private async generateEmbeddingSafely(placeId: string) {
    try {
      await this.embeddingService.generateForPlace(placeId);
    } catch (error) {
      console.error(`Failed to generate embedding for place ${placeId}`, error);
    }
  }
}

import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';

import { PrismaService } from '../../../prisma.service';
import { PaginationDto } from '../../users/dto/pagination.dto';
import { PlaceStatus } from '../../../generated/prisma/enums';
import { PlaceAccessPolicy } from '../policies';

import { createPaginationMeta } from '../../../common/contracts/pagination-meta.dto';

@Injectable()
export class SavedPlacesService {
  constructor(private readonly prisma: PrismaService) {}

  // =========================================================
  // SAVE PLACE
  // =========================================================

  async save(userId: string, placeId: string) {
    const place = await this.prisma.place.findUnique({
      where: {
        id: placeId,
        status: PlaceStatus.APPROVED,
      },
      select: {
        id: true,
      },
    });

    if (!place) {
      throw new NotFoundException('Place not found');
    }

    const existing = await this.prisma.savedPlace.findUnique({
      where: {
        userId_placeId: {
          userId,
          placeId,
        },
      },
    });

    if (existing) {
      throw new BadRequestException('Place is already saved');
    }

    return this.prisma.savedPlace.create({
      data: {
        userId,
        placeId,
      },

      include: {
        place: {
          select: {
            id: true,
            name: true,
            description: true,
            category: true,
            city: true,
            country: true,
            address: true,
            latitude: true,
            longitude: true,
            averageRating: true,
          },
        },
      },
    });
  }

  // =========================================================
  // UNSAVE PLACE
  // =========================================================

  async remove(userId: string, placeId: string): Promise<void> {
    const savedPlace = await this.prisma.savedPlace.findUnique({
      where: {
        userId_placeId: {
          userId,
          placeId,
        },
      },
    });

    PlaceAccessPolicy.assertSavedRecord(savedPlace);

    await this.prisma.$transaction(async (tx) => {
      await tx.placeCollectionItem.deleteMany({
        where: {
          placeId,
          collection: { ownerId: userId },
        },
      });
      await tx.savedPlace.delete({
        where: {
          userId_placeId: {
            userId,
            placeId,
          },
        },
      });
    });
  }

  // =========================================================
  // SAVE STATUS
  // =========================================================

  async getStatus(userId: string, placeId: string) {
    const savedPlace = await this.prisma.savedPlace.findUnique({
      where: {
        userId_placeId: {
          userId,
          placeId,
        },
      },
      select: {
        id: true,
        createdAt: true,
      },
    });

    return {
      saved: !!savedPlace,
      savedAt: savedPlace?.createdAt ?? null,
    };
  }

  // =========================================================
  // MY SAVED PLACES
  // =========================================================

  async findMySavedPlaces(userId: string, pageDto: PaginationDto) {
    const page = Math.max(pageDto.page, 1);

    const limit = Math.min(Math.max(pageDto.limit, 1), 100);

    const skip = (page - 1) * limit;

    const [data, total] = await this.prisma.$transaction([
      this.prisma.savedPlace.findMany({
        where: {
          userId,
        },

        skip,
        take: limit,

        orderBy: {
          createdAt: 'desc',
        },

        include: {
          place: {
            select: {
              id: true,
              name: true,
              description: true,
              category: true,
              city: true,
              country: true,
              address: true,
              latitude: true,
              longitude: true,
              averageRating: true,
            },
          },
        },
      }),

      this.prisma.savedPlace.count({
        where: {
          userId,
        },
      }),
    ]);

    return {
      data,
      meta: createPaginationMeta(page, limit, total),
    };
  }

  // =========================================================
  // COUNT
  // =========================================================

  async countMySavedPlaces(userId: string) {
    const count = await this.prisma.savedPlace.count({
      where: {
        userId,
      },
    });

    return {
      count,
    };
  }
}

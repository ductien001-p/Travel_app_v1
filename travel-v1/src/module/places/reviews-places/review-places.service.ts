import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';

import { createPaginationMeta } from '../../../common/contracts/pagination-meta.dto';
import { PrismaService } from '../../../prisma.service';
import { CreatePlaceReviewDto } from './dto/create-review-place.dto';
import { PaginationDto } from '../../users/dto/pagination.dto';
import { PlaceStatus } from '../../../generated/prisma/browser';

@Injectable()
export class PlaceReviewsService {
  constructor(private readonly prisma: PrismaService) {}

  // =========================================================
  // CREATE REVIEW
  // POST /places/:placeId/reviews
  // =========================================================

  async create(userId: string, placeId: string, dto: CreatePlaceReviewDto) {
    // =======================================================
    // 1. CHECK PLACE
    // =======================================================

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

    // =======================================================
    // 2. CHECK USER HAS CHECKED IN
    // =======================================================
    const checkin = await this.prisma.tripCheckin.findFirst({
      where: {
        userId,
        placeId,
      },

      select: {
        id: true,
      },
    });

    if (!checkin) {
      throw new BadRequestException(
        'You can only review a place after checking in',
      );
    }

    // =======================================================
    // 3. CHECK EXISTING REVIEW
    // =======================================================

    const existingReview = await this.prisma.placeReview.findUnique({
      where: {
        userId_placeId: {
          userId,
          placeId,
        },
      },
    });

    if (existingReview) {
      throw new BadRequestException('You have already reviewed this place');
    }

    // =======================================================
    // 4. CREATE REVIEW
    // =======================================================

    const result = await this.prisma.$transaction(async (tx) => {
      const review = await tx.placeReview.create({
        data: {
          userId,
          placeId,
          rating: dto.rating,
          comment: dto.comment,
        },

        include: {
          user: {
            select: {
              id: true,
              username: true,
              avatarId: true,
            },
          },

          place: {
            select: {
              id: true,
              name: true,
            },
          },
        },
      });
      const averageRating = await tx.placeReview.aggregate({
        where: {
          placeId,
        },
        _avg: {
          rating: true,
        },
      });
      await tx.place.update({
        where: {
          id: placeId,
        },
        data: {
          averageRating: averageRating._avg.rating ?? 0,
        },
      });
      return review;
    });

    return {
      message: 'Review created successfully',
      data: result,
    };
  }

  // =========================================================
  // GET ONE REVIEW
  // GET /places/reviews/:reviewId
  // =========================================================

  async findById(reviewId: string) {
    const review = await this.prisma.placeReview.findUnique({
      where: {
        id: reviewId,
      },

      include: {
        user: {
          select: {
            id: true,
            username: true,
            avatarId: true,
          },
        },

        place: {
          select: {
            id: true,
            name: true,
          },
        },
      },
    });

    if (!review) {
      throw new NotFoundException('Review not found');
    }

    return review;
  }

  // =========================================================
  // GET REVIEWS OF PLACE
  // GET /places/:placeId/reviews
  // =========================================================

  async findByPlace(placeId: string, pageDto: PaginationDto) {
    // Check place
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

    const { page, limit } = pageDto;
    const skip = (page - 1) * limit;

    const [reviews, total] = await Promise.all([
      this.prisma.placeReview.findMany({
        where: {
          placeId,
        },

        skip,
        take: limit,

        orderBy: {
          createdAt: 'desc',
        },

        include: {
          user: {
            select: {
              id: true,
              username: true,
              avatarId: true,
            },
          },
        },
      }),

      this.prisma.placeReview.count({
        where: {
          placeId,
        },
      }),
    ]);

    return {
      data: reviews,
      meta: createPaginationMeta(page, limit, total),
    };
  }

  // =========================================================
  // GET MY REVIEW
  // GET /places/:placeId/reviews/me
  // =========================================================

  async findMyReview(userId: string, placeId: string) {
    return this.prisma.placeReview.findUnique({
      where: {
        userId_placeId: {
          userId,
          placeId,
        },
      },

      include: {
        user: {
          select: {
            id: true,
            username: true,
            avatarId: true,
          },
        },

        place: {
          select: {
            id: true,
            name: true,
          },
        },
      },
    });
  }

  // =========================================================
  // DELETE REVIEW
  // DELETE /places/reviews/:reviewId
  // =========================================================

  async remove(userId: string, reviewId: string) {
    // 1. Find
    const review = await this.prisma.placeReview.findUnique({
      where: {
        id: reviewId,
      },
    });

    if (!review) {
      throw new NotFoundException('Review not found');
    }

    // 2. Ownership
    if (review.userId !== userId) {
      throw new ForbiddenException('You cannot delete this review');
    }

    // 3. Delete
    await this.prisma.$transaction(async (tx) => {
      await tx.placeReview.delete({
        where: {
          id: reviewId,
        },
      });
      const averageRating = await tx.placeReview.aggregate({
        where: {
          placeId: review.placeId,
        },
        _avg: {
          rating: true,
        },
      });
      await tx.place.update({
        where: {
          id: review.placeId,
        },
        data: {
          averageRating: averageRating._avg.rating ?? 0,
        },
      });
    });
    return {
      message: 'Review deleted successfully',
    };
  }
  // =========================================================
  // GET RATING SUMMARY
  // =========================================================

  async getRatingSummary(placeId: string) {
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

    const [aggregate, distribution] = await Promise.all([
      this.prisma.placeReview.aggregate({
        where: {
          placeId,
        },

        _avg: {
          rating: true,
        },

        _count: {
          rating: true,
        },
      }),

      this.prisma.placeReview.groupBy({
        by: ['rating'],

        where: {
          placeId,
        },

        _count: {
          rating: true,
        },

        orderBy: {
          rating: 'asc',
        },
      }),
    ]);

    const ratings: Record<number, number> = {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
    };

    for (const item of distribution) {
      ratings[item.rating] = item._count.rating;
    }

    return {
      averageRating: aggregate._avg.rating ?? 0,

      totalReviews: aggregate._count.rating,

      distribution: ratings,
    };
  }
}

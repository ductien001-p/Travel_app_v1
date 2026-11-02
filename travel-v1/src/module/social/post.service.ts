import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';

import { CreatePostDto } from './dto/create-post.dto';
import { UpdatePostDto } from './dto/update-post.dto';
import {
  PlaceStatus,
  SocialPostVisibility,
} from '../../generated/prisma/enums';
import { PrismaService } from '../../prisma.service';
import { createPaginationMeta } from '../../common/contracts/pagination-meta.dto';
import { PaginationDto } from '../users/dto/pagination.dto';

@Injectable()
export class PostsService {
  constructor(private readonly prisma: PrismaService) {}

  // =========================================================
  // CREATE POST
  // =========================================================

  async create(userId: string, dto: CreatePostDto) {
    // 1. Validate place
    if (dto.placeId) {
      const place = await this.prisma.place.findUnique({
        where: {
          id: dto.placeId,
          status: PlaceStatus.APPROVED,
        },
        select: {
          id: true,
        },
      });

      if (!place) {
        throw new NotFoundException('Place not found');
      }
    }

    // 2. Remove duplicate media IDs
    const mediaIds = [...new Set(dto.mediaIds)];

    // 3. Check media ownership
    const medias = await this.prisma.uploadedMedia.findMany({
      where: {
        deletedAt: null,
        id: {
          in: mediaIds,
        },
        userId,
      },
      select: {
        id: true,
      },
    });

    if (medias.length !== mediaIds.length) {
      throw new BadRequestException(
        'One or more media are invalid or do not belong to you',
      );
    }

    // 4. Check duplicate post
    const candidates = await this.prisma.post.findMany({
      where: {
        authorId: userId,
        caption: dto.caption,
        placeId: dto.placeId ?? null,
        visibility: dto.visibility ?? SocialPostVisibility.PUBLIC,
        deletedAt: null,
      },
      select: {
        id: true,
        postMedias: {
          select: {
            mediaId: true,
          },
        },
      },
    });

    const sortedMediaIds = [...mediaIds].sort();

    const existingPost = candidates.find((post) => {
      const existingMediaIds = post.postMedias
        .map((item) => item.mediaId)
        .sort();

      return (
        existingMediaIds.length === sortedMediaIds.length &&
        existingMediaIds.every(
          (mediaId, index) => mediaId === sortedMediaIds[index],
        )
      );
    });

    if (existingPost) {
      throw new BadRequestException('Duplicate post detected');
    }

    // 5. Create Post + PostMedia
    const post = await this.prisma.post.create({
      data: {
        authorId: userId,
        placeId: dto.placeId ?? null,
        caption: dto.caption,
        visibility: dto.visibility ?? SocialPostVisibility.PUBLIC,

        postMedias: {
          create: mediaIds.map((mediaId, index) => ({
            mediaId,
            orderIndex: index,
          })),
        },
      },

      include: {
        author: {
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

        postMedias: {
          orderBy: {
            orderIndex: 'asc',
          },

          select: {
            mediaId: true,
            orderIndex: true,
          },
        },
      },
    });

    return {
      ...post,
      liked: false,
      shared: false,
    };
  }

  // =========================================================
  // GET POST BY ID
  // =========================================================

  //Lay bai cu the va kiem tra quyen truy cap bai viet
  async findById(postId: string, currentUserId: string) {
    await this.ensureCanAccessPost(postId, currentUserId);

    const post = await this.prisma.post.findUnique({
      where: {
        id: postId,
      },

      include: {
        author: {
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
            address: true,
            latitude: true,
            longitude: true,
          },
        },

        postMedias: {
          orderBy: {
            orderIndex: 'asc',
          },

          select: {
            mediaId: true,
            orderIndex: true,
          },
        },

        _count: {
          select: {
            likes: true,
            comments: true,
            shares: true,
          },
        },
      },
    });

    if (!post) {
      throw new NotFoundException('Post not found');
    }

    const [like, share] = await Promise.all([
      this.prisma.socialPostLike.findUnique({
        where: {
          postId_userId: {
            postId,
            userId: currentUserId,
          },
        },

        select: {
          id: true,
        },
      }),

      this.prisma.socialPostShare.findUnique({
        where: {
          postId_userId: {
            postId,
            userId: currentUserId,
          },
        },

        select: {
          id: true,
        },
      }),
    ]);

    return {
      ...post,
      liked: !!like,
      shared: !!share,
    };
  }

  // =========================================================
  // FEED
  // =========================================================
  //Lay danh sach tren bang tin gom co cua following va cua chinh minh, phan trang
  async findFeed(userId: string, dto: PaginationDto) {
    const page = Math.max(dto.page, 1);

    const limit = Math.min(Math.max(dto.limit, 1), 100);

    const skip = (page - 1) * limit;

    const following = await this.prisma.userFollow.findMany({
      where: {
        followerId: userId,
      },

      select: {
        followingId: true,
      },
    });

    const followingIds = following.map((follow) => follow.followingId);

    const feedWhere = {
      deletedAt: null,

      OR: [
        {
          visibility: SocialPostVisibility.PUBLIC,
        },

        {
          visibility: SocialPostVisibility.FOLLOWERS,

          authorId: {
            in: followingIds,
          },
        },

        {
          visibility: SocialPostVisibility.FOLLOWERS,

          authorId: userId,
        },
      ],
    };

    const [posts, total] = await this.prisma.$transaction([
      this.prisma.post.findMany({
        where: feedWhere,

        skip,
        take: limit,

        orderBy: {
          createdAt: 'desc',
        },

        include: {
          author: {
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

          postMedias: {
            orderBy: {
              orderIndex: 'asc',
            },

            select: {
              mediaId: true,
              orderIndex: true,
            },
          },

          _count: {
            select: {
              likes: true,
              comments: true,
              shares: true,
            },
          },

          likes: {
            where: {
              userId,
            },

            select: {
              id: true,
            },
          },

          shares: {
            where: {
              userId,
            },

            select: {
              id: true,
            },
          },
        },
      }),

      this.prisma.post.count({
        where: feedWhere,
      }),
    ]);

    const data = posts.map((post) => {
      const { likes, shares, ...rest } = post;

      return {
        ...rest,
        liked: likes.length > 0,
        shared: shares.length > 0,
      };
    });

    return {
      data,

      meta: createPaginationMeta(page, limit, total),
    };
  }

  // =========================================================
  // MY POSTS
  // =========================================================

  async findMyPosts(userId: string, dto: PaginationDto) {
    const page = Math.max(dto.page, 1);

    const limit = Math.min(Math.max(dto.limit, 1), 100);

    const skip = (page - 1) * limit;

    const [posts, total] = await this.prisma.$transaction([
      this.prisma.post.findMany({
        where: {
          authorId: userId,
          deletedAt: null,
        },

        skip,
        take: limit,

        orderBy: {
          createdAt: 'desc',
        },

        include: {
          author: {
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

          postMedias: {
            orderBy: {
              orderIndex: 'asc',
            },

            select: {
              mediaId: true,
              orderIndex: true,
            },
          },

          _count: {
            select: {
              likes: true,
              comments: true,
              shares: true,
            },
          },

          likes: {
            where: {
              userId,
            },

            select: {
              id: true,
            },
          },

          shares: {
            where: {
              userId,
            },

            select: {
              id: true,
            },
          },
        },
      }),

      this.prisma.post.count({
        where: {
          authorId: userId,
          deletedAt: null,
        },
      }),
    ]);

    const data = posts.map((post) => {
      const { likes, shares, ...rest } = post;

      return {
        ...rest,
        liked: likes.length > 0,
        shared: shares.length > 0,
      };
    });

    return {
      data,
      meta: createPaginationMeta(page, limit, total),
    };
  }
  // =========================================================
  // POSTS BY PLACE
  // =========================================================

  async findByPlace(placeId: string, userId: string, dto: PaginationDto) {
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

    const page = Math.max(dto.page, 1);

    const limit = Math.min(Math.max(dto.limit, 1), 100);

    const skip = (page - 1) * limit;

    const where = {
      placeId,
      visibility: SocialPostVisibility.PUBLIC,
      deletedAt: null,
    };

    const [posts, total] = await this.prisma.$transaction([
      this.prisma.post.findMany({
        where,

        skip,
        take: limit,

        orderBy: {
          createdAt: 'desc',
        },

        include: {
          author: {
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

          postMedias: {
            orderBy: {
              orderIndex: 'asc',
            },

            select: {
              mediaId: true,
              orderIndex: true,
            },
          },

          _count: {
            select: {
              likes: true,
              comments: true,
              shares: true,
            },
          },

          likes: {
            where: {
              userId,
            },

            select: {
              id: true,
            },
          },

          shares: {
            where: {
              userId,
            },

            select: {
              id: true,
            },
          },
        },
      }),

      this.prisma.post.count({
        where,
      }),
    ]);

    const data = posts.map((post) => {
      const { likes, shares, ...rest } = post;

      return {
        ...rest,
        liked: likes.length > 0,
        shared: shares.length > 0,
      };
    });

    return {
      data,
      meta: createPaginationMeta(page, limit, total),
    };
  }

  // =========================================================
  // UPDATE POST
  // =========================================================

  async update(userId: string, postId: string, dto: UpdatePostDto) {
    const post = await this.prisma.post.findUnique({
      where: {
        id: postId,
      },
    });

    if (!post || post.deletedAt) {
      throw new NotFoundException('Post not found');
    }

    if (post.authorId !== userId) {
      throw new ForbiddenException('You cannot update this post');
    }

    // -------------------------------------------------------
    // Validate place
    // -------------------------------------------------------

    if (dto.placeId) {
      const place = await this.prisma.place.findUnique({
        where: {
          id: dto.placeId,
          status: PlaceStatus.APPROVED,
        },

        select: {
          id: true,
        },
      });

      if (!place) {
        throw new NotFoundException('Place not found');
      }
    }

    // -------------------------------------------------------
    // Validate media
    // -------------------------------------------------------

    let mediaIds: string[] | undefined;

    if (dto.mediaIds) {
      mediaIds = [...new Set(dto.mediaIds)];

      const medias = await this.prisma.uploadedMedia.findMany({
        where: {
          id: {
            in: mediaIds,
          },
          deletedAt: null,
          userId,
        },

        select: {
          id: true,
        },
      });

      if (medias.length !== mediaIds.length) {
        throw new BadRequestException(
          'One or more media are invalid or do not belong to you',
        );
      }
    }

    // -------------------------------------------------------
    // Transaction
    // -------------------------------------------------------

    const updated = await this.prisma.$transaction(async (tx) => {
      if (mediaIds) {
        await tx.postMedia.deleteMany({
          where: {
            postId,
          },
        });
      }

      return tx.post.update({
        where: {
          id: postId,
        },

        data: {
          ...(dto.caption !== undefined && {
            caption: dto.caption,
          }),

          ...(dto.placeId !== undefined && {
            placeId: dto.placeId,
          }),

          ...(dto.visibility !== undefined && {
            visibility: dto.visibility,
          }),

          ...(mediaIds && {
            postMedias: {
              create: mediaIds.map((mediaId, index) => ({
                mediaId,
                orderIndex: index,
              })),
            },
          }),
        },

        include: {
          author: {
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

          postMedias: {
            orderBy: {
              orderIndex: 'asc',
            },

            select: {
              mediaId: true,
              orderIndex: true,
            },
          },

          _count: {
            select: {
              likes: true,
              comments: true,
              shares: true,
            },
          },
        },
      });
    });
    return {
      ...updated,
      liked: false,
      shared: false,
    };
  }

  // =========================================================
  // DELETE POST
  // =========================================================

  async remove(userId: string, postId: string): Promise<void> {
    const post = await this.prisma.post.findUnique({
      where: {
        id: postId,
      },
    });

    if (!post || post.deletedAt) {
      throw new NotFoundException('Post not found');
    }

    if (post.authorId !== userId) {
      throw new ForbiddenException('You cannot delete this post');
    }

    await this.prisma.post.update({
      where: {
        id: postId,
      },

      data: {
        deletedAt: new Date(),
      },
    });
  }

  async ensureCanAccessPost(postId: string, userId?: string) {
    const post = await this.prisma.post.findFirst({
      where: {
        id: postId,
        deletedAt: null,
      },
      select: {
        id: true,
        authorId: true,
        visibility: true,
      },
    });

    if (!post) {
      throw new NotFoundException('Post not found');
    }

    // PUBLIC → ai cũng truy cập được
    if (post.visibility === SocialPostVisibility.PUBLIC) {
      return post;
    }

    // Owner luôn được xem post của mình
    if (userId && post.authorId === userId) {
      return post;
    }

    // PRIVATE → chỉ owner
    if (post.visibility === SocialPostVisibility.PRIVATE) {
      throw new ForbiddenException(
        'You do not have permission to access this post',
      );
    }

    // FOLLOWERS → phải login
    if (post.visibility === SocialPostVisibility.FOLLOWERS) {
      if (!userId) {
        throw new ForbiddenException(
          'You do not have permission to access this post',
        );
      }

      const follow = await this.prisma.userFollow.findFirst({
        where: {
          followerId: userId,
          followingId: post.authorId,
        },
        select: {
          id: true,
        },
      });

      if (!follow) {
        throw new ForbiddenException(
          'You do not have permission to access this post',
        );
      }
    }

    return post;
  }
}

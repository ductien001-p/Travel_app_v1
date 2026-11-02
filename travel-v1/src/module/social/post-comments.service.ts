import {
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';

import { PrismaService } from '../../prisma.service';
import { CreatePostCommentDto } from './dto/create-post-comment.dto';
import { PostsService } from './post.service';
import { PaginationDto } from '../users/dto/pagination.dto';

import { createPaginationMeta } from '../../common/contracts/pagination-meta.dto';

@Injectable()
export class PostCommentsService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly postService: PostsService,
  ) {}

  // =========================================================
  // CREATE COMMENT
  // =========================================================

  async create(userId: string, postId: string, dto: CreatePostCommentDto) {
    await this.postService.ensureCanAccessPost(postId, userId);

    return this.prisma.$transaction(async (tx) => {
      const comment = await tx.socialPostComment.create({
        data: {
          postId,
          userId,
          content: dto.content,
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
      });

      await tx.post.update({
        where: {
          id: postId,
        },

        data: {
          commentsCount: {
            increment: 1,
          },
        },
      });

      return comment;
    });
  }

  // =========================================================
  // GET COMMENTS
  // =========================================================

  async findByPost(postId: string, userId: string, pageDto: PaginationDto) {
    await this.postService.ensureCanAccessPost(postId, userId);

    const page = Math.max(pageDto.page, 1);

    const limit = Math.min(Math.max(pageDto.limit, 1), 100);

    const skip = (page - 1) * limit;

    const [data, total] = await this.prisma.$transaction([
      this.prisma.socialPostComment.findMany({
        where: {
          postId,
          deletedAt: null,
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

      this.prisma.socialPostComment.count({
        where: {
          postId,
          deletedAt: null,
        },
      }),
    ]);

    return {
      data,

      meta: createPaginationMeta(page, limit, total),
    };
  }

  // =========================================================
  // DELETE COMMENT
  // =========================================================

  async remove(userId: string, commentId: string): Promise<void> {
    const comment = await this.prisma.socialPostComment.findUnique({
      where: {
        id: commentId,
      },
    });

    if (!comment || comment.deletedAt) {
      throw new NotFoundException('Comment not found');
    }

    if (comment.userId !== userId) {
      throw new ForbiddenException('You cannot delete this comment');
    }

    await this.prisma.$transaction(async (tx) => {
      await tx.socialPostComment.update({
        where: {
          id: commentId,
        },

        data: {
          deletedAt: new Date(),
        },
      });

      await tx.post.update({
        where: {
          id: comment.postId,
        },

        data: {
          commentsCount: {
            decrement: 1,
          },
        },
      });
    });
  }
}

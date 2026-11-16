import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';

import { PrismaService } from '../../prisma.service';
import { PostsService } from './post.service';

@Injectable()
export class PostLikesService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly postService: PostsService,
  ) {}

  // =========================================================
  // LIKE
  // =========================================================

  async like(userId: string, postId: string): Promise<void> {
    await this.postService.ensureCanAccessPost(postId, userId);

    const existing = await this.prisma.socialPostLike.findUnique({
      where: {
        postId_userId: {
          postId,
          userId,
        },
      },
    });

    if (existing) {
      throw new BadRequestException('Post already liked');
    }

    await this.prisma.$transaction(async (tx) => {
      await tx.socialPostLike.create({
        data: {
          postId,
          userId,
        },
      });

      await tx.post.update({
        where: {
          id: postId,
        },

        data: {
          likesCount: {
            increment: 1,
          },
        },
      });
    });
  }

  // =========================================================
  // UNLIKE
  // =========================================================

  async unlike(userId: string, postId: string): Promise<void> {
    const like = await this.prisma.socialPostLike.findUnique({
      where: {
        postId_userId: {
          postId,
          userId,
        },
      },
    });

    if (!like) {
      throw new NotFoundException('Like not found');
    }

    await this.prisma.$transaction(async (tx) => {
      await tx.socialPostLike.delete({
        where: {
          postId_userId: {
            postId,
            userId,
          },
        },
      });

      await tx.post.update({
        where: {
          id: postId,
        },

        data: {
          likesCount: {
            decrement: 1,
          },
        },
      });
    });
  }

}

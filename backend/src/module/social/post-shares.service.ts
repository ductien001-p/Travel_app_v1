import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';

import { PrismaService } from '../../prisma.service';
import { PostsService } from './post.service';

@Injectable()
export class PostSharesService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly postService: PostsService,
  ) {}

  // =========================================================
  // SHARE
  // =========================================================

  async share(userId: string, postId: string): Promise<void> {
    await this.postService.ensureCanAccessPost(postId, userId);

    const existing = await this.prisma.socialPostShare.findUnique({
      where: {
        postId_userId: {
          postId,
          userId,
        },
      },
    });

    if (existing) {
      throw new BadRequestException('Post already shared');
    }

    await this.prisma.$transaction(async (tx) => {
      await tx.socialPostShare.create({
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
          sharesCount: {
            increment: 1,
          },
        },
      });
    });
  }

  // =========================================================
  // UNSHARE
  // =========================================================

  async unshare(userId: string, postId: string): Promise<void> {
    await this.postService.ensureCanAccessPost(postId, userId);

    const share = await this.prisma.socialPostShare.findUnique({
      where: {
        postId_userId: {
          postId,
          userId,
        },
      },
    });

    if (!share) {
      throw new NotFoundException('Share not found');
    }

    await this.prisma.$transaction(async (tx) => {
      await tx.socialPostShare.delete({
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
          sharesCount: {
            decrement: 1,
          },
        },
      });
    });
  }

}

import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';

import { PrismaService } from '../../prisma.service';
import { PostsService } from './post.service';

@Injectable()
export class PostSavesService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly postService: PostsService,
  ) {}

  async save(userId: string, postId: string): Promise<void> {
    await this.postService.ensureCanAccessPost(postId, userId);

    const existing = await this.prisma.socialPostSave.findUnique({
      where: {
        postId_userId: { postId, userId },
      },
    });

    if (existing) {
      throw new BadRequestException('Post already saved');
    }

    await this.prisma.$transaction(async (tx) => {
      await tx.socialPostSave.create({
        data: { postId, userId },
      });
      await tx.post.update({
        where: { id: postId },
        data: { savesCount: { increment: 1 } },
      });
    });
  }

  async unsave(userId: string, postId: string): Promise<void> {
    const save = await this.prisma.socialPostSave.findUnique({
      where: {
        postId_userId: { postId, userId },
      },
    });

    if (!save) {
      throw new NotFoundException('Save not found');
    }

    await this.prisma.$transaction(async (tx) => {
      await tx.socialPostSave.delete({
        where: {
          postId_userId: { postId, userId },
        },
      });
      await tx.post.update({
        where: { id: postId },
        data: { savesCount: { decrement: 1 } },
      });
    });
  }

  async getStatus(userId: string, postId: string) {
    await this.postService.ensureCanAccessPost(postId, userId);

    const save = await this.prisma.socialPostSave.findUnique({
      where: {
        postId_userId: { postId, userId },
      },
      select: { createdAt: true },
    });

    return {
      saved: !!save,
      savedAt: save?.createdAt ?? null,
    };
  }
}

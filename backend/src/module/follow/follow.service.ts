import {
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { PrismaService } from '../../prisma.service';
import { PaginationDto } from '../users/dto/pagination.dto';
import { USER_STATUS } from '../../generated/prisma/browser';
import { createPaginationMeta } from '../../common/contracts/pagination-meta.dto';

@Injectable()
export class FollowService {
  constructor(private readonly prisma: PrismaService) {}
  async createFollow(followerId: string, followingId: string) {
    if (followerId == followingId) {
      throw new ConflictException('User cannot follow themselves');
    }
    const followingUser = await this.prisma.user.findUnique({
      where: {
        id: followingId,
        status: USER_STATUS.ACTIVE,
        deletedAt: null,
      },
    });
    if (!followingUser) {
      throw new NotFoundException('User to follow not found');
    }
    const existingFollow = await this.prisma.userFollow.findFirst({
      where: {
        followerId,
        followingId,
      },
    });
    if (existingFollow) {
      throw new ConflictException('User is already following this user');
    }
    return this.prisma.userFollow.create({
      data: {
        followerId,
        followingId,
      },
    });
  }

  async removeFollow(followerId: string, followingId: string) {
    const existingFollow = await this.prisma.userFollow.findFirst({
      where: {
        followerId,
        followingId,
      },
    });
    if (!existingFollow) {
      throw new NotFoundException('User is not following this user');
    }
    return this.prisma.userFollow.delete({
      where: {
        id: existingFollow.id,
      },
    });
  }

  async getFollowers(userId: string, page: PaginationDto) {
    const skip = (page.page - 1) * page.limit;

    const activeFollower = {
      followingId: userId,
      follower: {
        deletedAt: null,
        status: USER_STATUS.ACTIVE,
      },
    };
    const [data, total] = await this.prisma.$transaction([
      this.prisma.userFollow.findMany({
        where: activeFollower,
        take: page.limit,
        skip,
        include: {
          follower: {
            select: {
              username: true,
              avatarId: true,
            },
          },
        },
      }),

      this.prisma.userFollow.count({
        where: activeFollower,
      }),
    ]);

    return {
      data,
      meta: createPaginationMeta(page.page, page.limit, total),
    };
  }
}

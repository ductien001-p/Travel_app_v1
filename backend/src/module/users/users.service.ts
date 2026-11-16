import {
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { UpdateUserDto } from './dto/update-user.dto';
import { PrismaService } from '../../prisma.service';
import { USER_STATUS } from '../../../src/generated/prisma/enums';
import { createPaginationMeta } from '../../common/contracts/pagination-meta.dto';
import { SearchUsersDto } from './dto/search-user.dto';

const VISIT_COUNT_SELECT = {
  _count: {
    select: {
      placeVisits: true,
    },
  },
} as const;

/** Fields another signed-in user may see on GET /users/:id. */
const PUBLIC_USER_SELECT = {
  id: true,
  displayname: true,
  username: true,
  avatarId: true,
  bio: true,
  gender: true,
  location: true,
  budgetLevel: true,
  languages: true,
  interests: true,
} as const;

/** Fields returned for the authenticated user on GET /users/me and PATCH /users/update. */
const PRIVATE_USER_SELECT = {
  ...PUBLIC_USER_SELECT,
  email: true,
  phone: true,
  address: true,
  dateofBirth: true,
  travelStyle: true,
  notificationEnabled: true,
} as const;

const UPDATABLE_USER_FIELDS = [
  'displayname',
  'username',
  'phone',
  'avatarId',
  'gender',
  'dateofBirth',
  'address',
  'bio',
  'location',
  'notificationEnabled',
  'shareLocationForDiscovery',
  'budgetLevel',
  'languages',
  'interests',
] as const;

@Injectable()
export class UsersService {
  constructor(private readonly prismaService: PrismaService) {}

  async findOne(id: string) {
    const user = await this.prismaService.user.findFirst({
      where: {
        id,
        deletedAt: null,
        status: USER_STATUS.ACTIVE,
      },

      select: {
        ...PRIVATE_USER_SELECT,
        ...VISIT_COUNT_SELECT,
      },
    });

    if (!user) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }

    const { _count, ...userData } = user;

    return {
      ...userData,
      visitedCount: _count.placeVisits,
    };
  }

  async findOneById(id: string) {
    const user = await this.prismaService.user.findFirst({
      where: {
        id,
        deletedAt: null,
        status: USER_STATUS.ACTIVE,
      },

      select: {
        ...PUBLIC_USER_SELECT,
        ...VISIT_COUNT_SELECT,
      },
    });

    if (!user) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }

    const { _count, ...userData } = user;

    return {
      ...userData,
      visitedCount: _count.placeVisits,
    };
  }
  async searchUsers(dto: SearchUsersDto, currentUserId: string) {
    const q = dto.q.trim();

    if (!q) {
      return {
        data: [],
        meta: createPaginationMeta(dto.page, dto.limit, 0),
      };
    }

    const normalizedUsername = q.replace(/^@/, '');

    const where = {
      status: USER_STATUS.ACTIVE,
      deletedAt: null,

      // Không trả chính user đang search
      id: {
        not: currentUserId,
      },

      OR: [
        {
          displayname: {
            startsWith: q,
            mode: 'insensitive' as const,
          },
        },

        {
          username: {
            startsWith: normalizedUsername,
            mode: 'insensitive' as const,
          },
        },
      ],
    };

    const skip = (dto.page - 1) * dto.limit;

    const [users, total] = await Promise.all([
      this.prismaService.user.findMany({
        where,

        skip,

        take: dto.limit,

        orderBy: [
          {
            displayname: 'asc',
          },
        ],

        select: {
          id: true,
          username: true,
          displayname: true,
          avatarId: true,
        },
      }),

      this.prismaService.user.count({
        where,
      }),
    ]);

    return {
      data: users,

      meta: createPaginationMeta(dto.page, dto.limit, total),
    };
  }

  async update(id: string, updateUserDto: UpdateUserDto) {
    await this.findOne(id);
    if (updateUserDto.avatarId !== undefined) {
      await this.assertOwnedActiveImage(id, updateUserDto.avatarId);
    }
    await this.prismaService.user.update({
      where: { id, deletedAt: null, status: USER_STATUS.ACTIVE },
      data: this.toUpdateData(updateUserDto),
    });
    return this.findOne(id);
  }

  async remove(id: string) {
    await this.findOne(id);
    await this.prismaService.$transaction([
      this.prismaService.user.update({
        where: { id, deletedAt: null, status: USER_STATUS.ACTIVE },
        data: { deletedAt: new Date() },
      }),
      this.prismaService.refreshToken.updateMany({
        where: { userId: id, revoked: false },
        data: { revoked: true },
      }),
      this.prismaService.deviceToken.deleteMany({
        where: { userId: id },
      }),
    ]);
  }

  private toUpdateData(dto: UpdateUserDto): Record<string, unknown> {
    const data: Record<string, unknown> = {};
    for (const key of UPDATABLE_USER_FIELDS) {
      if (dto[key] !== undefined) {
        data[key] = dto[key];
      }
    }
    return data;
  }

  async setAvatar(userId: string, mediaId: string) {
    await this.findOne(userId);
    await this.assertOwnedActiveImage(userId, mediaId);

    const user = await this.prismaService.user.update({
      where: {
        id: userId,
      },
      data: {
        avatarId: mediaId,
      },
    });

    return this.findOne(user.id);
  }

  private async assertOwnedActiveImage(
    userId: string,
    mediaId: string,
  ): Promise<void> {
    const media = await this.prismaService.uploadedMedia.findUnique({
      where: { id: mediaId },
      select: { userId: true, deletedAt: true, mimeType: true },
    });

    if (!media || media.deletedAt !== null) {
      throw new NotFoundException('Media not found');
    }
    if (media.userId !== userId) {
      throw new ForbiddenException('You cannot use this media');
    }
    const allowedAvatarMimeTypes = new Set([
      'image/jpeg',
      'image/jpg',
      'image/png',
      'image/gif',
      'image/webp',
    ]);
    if (!media.mimeType || !allowedAvatarMimeTypes.has(media.mimeType)) {
      throw new ForbiddenException('Avatar media must be an image');
    }
  }
}

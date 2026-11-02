import {
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { PrismaService } from '../../prisma.service';
import * as bcrypt from 'bcrypt';
import { USER_STATUS } from '../../../src/generated/prisma/enums';
import { createPaginationMeta } from '../../common/contracts/pagination-meta.dto';
import { SearchUsersDto } from './dto/search-user.dto';

const PUBLIC_USER_SELECT = {
  id: true,
  displayname: true,
  username: true,
  email: true,
  avatarId: true,
  bio: true,
  address: true,
  phone: true,
  gender: true,
  dateofBirth: true,
  location: true,
  travelStyle: true,
  budgetLevel: true,
  languages: true,
  interests: true,
  notificationEnabled: true,
} as const;

@Injectable()
export class UsersService {
  constructor(private readonly prismaService: PrismaService) {}

  async hashPassword(plain: string): Promise<string> {
    return await bcrypt.hash(plain, 10);
  }

  async create(createUserDto: CreateUserDto) {
    const {
      email,
      password,
      displayname,
      username,
      phone,
      avatarId,
      gender,
      dateofBirth,
      address,
      bio,
      location,
    } = createUserDto;

    const hashedPassword = await this.hashPassword(password);

    const user = await this.prismaService.user.create({
      data: {
        email,
        password: hashedPassword,
        displayname,
        username,
        phone,
        avatarId,
        gender,
        dateofBirth,
        address,
        bio,
        location,
      },

      select: {
        id: true,
      },
    });

    return user;
  }

  async findAll(page: number, limit: number) {
    const safePage = Math.max(page, 1);

    const safeLimit = Math.min(Math.max(limit, 1), 100);

    const skip = (safePage - 1) * safeLimit;

    const where = {
      deletedAt: null,
      status: USER_STATUS.ACTIVE,
    };

    const [users, total] = await Promise.all([
      this.prismaService.user.findMany({
        skip,
        take: safeLimit,
        where,

        orderBy: {
          createdAt: 'desc',
        },

        select: {
          ...PUBLIC_USER_SELECT,

          _count: {
            select: {
              placeVisits: true,
            },
          },
        },
      }),

      this.prismaService.user.count({
        where,
      }),
    ]);

    const data = users.map(({ _count, ...user }) => ({
      ...user,
      visitedCount: _count.placeVisits,
    }));

    return {
      data,

      meta: createPaginationMeta(safePage, safeLimit, total),
    };
  }

  async findOne(id: string) {
    const user = await this.prismaService.user.findFirst({
      where: {
        id,
        deletedAt: null,
        status: USER_STATUS.ACTIVE,
      },

      select: {
        ...PUBLIC_USER_SELECT,

        _count: {
          select: {
            placeVisits: true,
          },
        },
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

        _count: {
          select: {
            placeVisits: true,
          },
        },
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
      data: updateUserDto,
    });
    return this.findOne(id);
  }

  async remove(id: string) {
    await this.findOne(id);
    await this.prismaService.user.update({
      where: { id, deletedAt: null, status: USER_STATUS.ACTIVE },
      data: { deletedAt: new Date() },
    });
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

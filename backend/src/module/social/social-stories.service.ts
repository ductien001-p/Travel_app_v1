import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { PrismaService } from '../../prisma.service';
import { S3Service } from '../../uploads/s3/s3.service';
import { CreateSocialStoryDto } from './dto/create-social-story.dto';
import { toPublicMediaUrl } from './social-url.helper';

@Injectable()
export class SocialStoriesService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
  ) {}

  async create(userId: string, dto: CreateSocialStoryDto) {
    const media = await this.prisma.uploadedMedia.findFirst({
      where: { id: dto.mediaId, userId, deletedAt: null },
      select: { id: true, objectKey: true, deletedAt: true },
    });
    if (!media) {
      throw new BadRequestException('Media is invalid or does not belong to you');
    }

    const expiresAt = new Date();
    expiresAt.setHours(expiresAt.getHours() + 24);

    const story = await this.prisma.socialStory.create({
      data: {
        authorId: userId,
        mediaId: dto.mediaId,
        label: dto.label.trim(),
        isLive: dto.isLive ?? false,
        expiresAt,
      },
      include: {
        media: { select: { objectKey: true, deletedAt: true } },
      },
    });

    return this.mapStory(story, true);
  }

  async listForFeed(userId: string) {
    const following = await this.prisma.userFollow.findMany({
      where: { followerId: userId },
      select: { followingId: true },
    });
    const authorIds = [userId, ...following.map((f) => f.followingId)];

    const stories = await this.prisma.socialStory.findMany({
      where: {
        authorId: { in: authorIds },
        OR: [{ expiresAt: null }, { expiresAt: { gt: new Date() } }],
      },
      orderBy: { createdAt: 'desc' },
      take: 20,
      include: {
        media: { select: { objectKey: true, deletedAt: true } },
      },
    });

    const self = stories.find((s) => s.authorId === userId);
    const others = stories.filter((s) => s.authorId !== userId);

    const mapped = [
      ...(self
        ? [this.mapStory(self, true)]
        : [
            {
              id: `story-self-${userId}`,
              label: 'Bạn',
              imageUrl: null as string | null,
              isSelf: true,
              isActive: false,
              badge: 'NONE' as const,
            },
          ]),
      ...others.map((s) => this.mapStory(s, false)),
    ];

    return mapped;
  }

  private mapStory(
    story: {
      id: string;
      authorId: string;
      label: string;
      isLive: boolean;
      createdAt: Date;
      media: { objectKey: string; deletedAt: Date | null } | null;
    },
    isSelf: boolean,
  ) {
    const ageHours =
      (Date.now() - story.createdAt.getTime()) / 3_600_000;
    const badge = story.isLive
      ? 'LIVE'
      : ageHours <= 24
        ? 'NEW'
        : 'NONE';

    return {
      id: story.id,
      label: story.label,
      imageUrl: toPublicMediaUrl((k) => this.s3.getPublicUrl(k), story.media),
      isSelf,
      isActive: story.isLive || ageHours <= 24,
      badge,
    };
  }

  async ensureOwned(storyId: string, userId: string) {
    const story = await this.prisma.socialStory.findUnique({
      where: { id: storyId },
    });
    if (!story) throw new NotFoundException('Story not found');
    if (story.authorId !== userId) {
      throw new BadRequestException('You cannot modify this story');
    }
    return story;
  }
}

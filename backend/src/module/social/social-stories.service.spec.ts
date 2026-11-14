import { BadRequestException } from '@nestjs/common';
import { SocialStoriesService } from './social-stories.service';

describe('SocialStoriesService', () => {
  const prisma = {
    uploadedMedia: {
      findFirst: jest.fn(),
    },
    socialStory: {
      create: jest.fn(),
      findMany: jest.fn(),
    },
    userFollow: {
      findMany: jest.fn(),
    },
  };

  const s3 = {
    getPublicUrl: jest.fn((key: string) => `https://cdn/${key}`),
  };

  const service = new SocialStoriesService(prisma as never, s3 as never);

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('creates a story for owned media', async () => {
    prisma.uploadedMedia.findFirst.mockResolvedValue({
      id: 'media-1',
      objectKey: 'stories/a.jpg',
      deletedAt: null,
    });
    prisma.socialStory.create.mockResolvedValue({
      id: 'story-1',
      authorId: 'user-1',
      label: 'Đà Nẵng',
      isLive: false,
      createdAt: new Date(),
      media: { objectKey: 'stories/a.jpg', deletedAt: null },
    });

    const result = await service.create('user-1', {
      mediaId: 'media-1',
      label: 'Đà Nẵng',
    });

    expect(result.id).toBe('story-1');
    expect(result.isSelf).toBe(true);
    expect(result.imageUrl).toBe('https://cdn/stories/a.jpg');
    expect(prisma.socialStory.create).toHaveBeenCalled();
  });

  it('rejects create when media is invalid', async () => {
    prisma.uploadedMedia.findFirst.mockResolvedValue(null);
    await expect(
      service.create('user-1', { mediaId: 'bad', label: 'X' }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('lists self placeholder when user has no story', async () => {
    prisma.userFollow.findMany.mockResolvedValue([]);
    prisma.socialStory.findMany.mockResolvedValue([]);

    const result = await service.listForFeed('user-1');
    expect(result[0]).toMatchObject({
      id: 'story-self-user-1',
      isSelf: true,
      imageUrl: null,
    });
  });
});

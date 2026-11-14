import { BadRequestException } from '@nestjs/common';
import { SocialFeedService } from './social-feed.service';

describe('SocialFeedService', () => {
  const prisma = {
    user: { findUnique: jest.fn() },
    notification: { count: jest.fn() },
    userFollow: { findMany: jest.fn(), count: jest.fn() },
    post: { findMany: jest.fn(), count: jest.fn() },
    trip: { findFirst: jest.fn() },
    $transaction: jest.fn(),
  };

  const s3 = {
    getPublicUrl: jest.fn((key: string) => `https://cdn/${key}`),
  };

  const storiesService = {
    listForFeed: jest.fn(),
  };

  const challengesService = {
    getActive: jest.fn(),
  };

  const streakService = {
    getCurrentDays: jest.fn(),
  };

  const service = new SocialFeedService(
    prisma as never,
    s3 as never,
    storiesService as never,
    challengesService as never,
    streakService as never,
  );

  beforeEach(() => {
    jest.clearAllMocks();
    prisma.user.findUnique.mockResolvedValue({
      displayname: 'Alex',
      avatar: { objectKey: 'avatars/a.jpg', deletedAt: null },
    });
    streakService.getCurrentDays.mockResolvedValue(7);
    prisma.notification.count.mockResolvedValue(2);
    prisma.userFollow.count.mockResolvedValue(3);
    prisma.userFollow.findMany.mockResolvedValue([{ followingId: 'u2' }]);
    storiesService.listForFeed.mockResolvedValue([
      {
        id: 'story-self-user-1',
        label: 'Bạn',
        imageUrl: null,
        isSelf: true,
        isActive: false,
        badge: 'NONE',
      },
    ]);
    challengesService.getActive.mockResolvedValue({
      id: 'ch1',
      eyebrow: 'THỬ THÁCH',
      title: 'Cafe Sơn Trà',
      rewardLabel: '+150 Xu',
      progressLabel: '0/3 quán đã check-in',
      progressRatio: 0,
      daysLeftLabel: 'Còn 3 ngày',
      badgeLabel: 'Biển Xanh',
      ctaLabel: 'Tham gia ngay',
    });
    prisma.trip.findFirst.mockResolvedValue(null);
    prisma.$transaction.mockImplementation(async (ops: Promise<unknown>[]) =>
      Promise.all(ops),
    );
  });

  it('requires lat/lng for nearby tab', async () => {
    await expect(
      service.getFeed('user-1', { tab: 'nearby', page: 1, limit: 10 }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('builds explore chrome and inserts challenge after first review', async () => {
    const post = {
      id: 'post-1',
      authorId: 'u2',
      placeId: null,
      caption: 'Hello',
      visibility: 'PUBLIC',
      tipTitle: null,
      tipBody: null,
      topic: null,
      placeDetail: null,
      likesCount: 1,
      commentsCount: 0,
      sharesCount: 0,
      savesCount: 0,
      createdAt: new Date(),
      updatedAt: new Date(),
      deletedAt: null,
      author: {
        id: 'u2',
        displayname: 'Lan',
        isVerified: false,
        profileBadge: null,
        avatar: null,
      },
      place: null,
      postMedias: [],
      _count: { likes: 1, comments: 0, shares: 0, saves: 0 },
      likes: [],
      saves: [],
      comments: [],
    };
    prisma.post.findMany.mockResolvedValue([post]);
    prisma.post.count.mockResolvedValue(1);

    const feed = await service.getFeed('user-1', {
      tab: 'explore',
      page: 1,
      limit: 10,
    });

    expect(feed.header.title).toBe('Bảng Tin');
    expect(feed.header.streakLabel).toContain('7 ngày');
    expect(feed.header.hasUnreadNotifications).toBe(true);
    expect(feed.composer.displayName).toBe('Alex');
    expect(feed.tabs.find((t) => t.id === 'explore')?.selected).toBe(true);
    expect(feed.tabs.find((t) => t.id === 'following')?.badgeLabel).toBe('3');
    expect(feed.items[0].type).toBe('REVIEW');
    expect(feed.items[1].type).toBe('CHALLENGE');
    expect(feed.meta.total).toBe(1);
  });

  it('filters posts by topic chip', async () => {
    prisma.post.findMany.mockResolvedValue([]);
    prisma.post.count.mockResolvedValue(0);

    await service.getFeed('user-1', {
      tab: 'explore',
      topic: 'PHOTO_SPOTS',
      page: 1,
      limit: 10,
    });

    const findArgs = prisma.post.findMany.mock.calls[0][0];
    expect(findArgs.where.topic).toBe('PHOTO_SPOTS');
    expect(
      (
        await service.getFeed('user-1', {
          tab: 'explore',
          topic: 'PHOTO_SPOTS',
          page: 1,
          limit: 10,
        })
      ).topicChips.find((c) => c.id === 'PHOTO_SPOTS')?.selected,
    ).toBe(true);
  });

  it('scopes following tab to following authors', async () => {
    prisma.post.findMany.mockResolvedValue([]);
    prisma.post.count.mockResolvedValue(0);

    await service.getFeed('user-1', {
      tab: 'following',
      page: 1,
      limit: 10,
    });

    const findArgs = prisma.post.findMany.mock.calls[0][0];
    expect(findArgs.where.authorId).toEqual({ in: ['u2', 'user-1'] });
  });

  it('applies nearby place bounds when lat/lng provided', async () => {
    prisma.post.findMany.mockResolvedValue([]);
    prisma.post.count.mockResolvedValue(0);

    await service.getFeed('user-1', {
      tab: 'nearby',
      page: 1,
      limit: 10,
      lat: 16.05,
      lng: 108.2,
    });

    const findArgs = prisma.post.findMany.mock.calls[0][0];
    expect(findArgs.where.place.latitude.gte).toBeCloseTo(15.6, 1);
    expect(findArgs.where.place.longitude.lte).toBeCloseTo(108.65, 1);
  });
});

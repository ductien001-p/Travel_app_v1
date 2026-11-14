import { BadRequestException, Injectable } from '@nestjs/common';
import { createPaginationMeta } from '../../common/contracts/pagination-meta.dto';
import {
  MEMBER_STATUS,
  SocialPostVisibility,
  TRIP_STATUS,
  TRIP_VISIBILITY,
} from '../../generated/prisma/enums';
import { Prisma } from '../../generated/prisma/client';
import { PrismaService } from '../../prisma.service';
import { S3Service } from '../../uploads/s3/s3.service';
import { effectiveOpenWhere } from '../trips/trip-relations/trip-recruitment/recruitment.policy';
import {
  QuerySocialFeedDto,
  SocialFeedTab,
} from './dto/query-social-feed.dto';
import {
  mapEnrichedPost,
  postAuthorSelect,
  postMediaSelect,
  postPlaceSelect,
  viewerInteractionInclude,
} from './post-response.mapper';
import { SocialChallengesService } from './social-challenges.service';
import { SocialStoriesService } from './social-stories.service';
import { toPublicMediaUrl } from './social-url.helper';
import { UserTravelStreakService } from './user-travel-streak.service';

const TOPIC_CHIPS = [
  { id: 'HIDDEN_EATS', label: '🍜 Quán ngon giấu kín' },
  { id: 'PHOTO_SPOTS', label: '📸 Góc sống ảo' },
  { id: 'ITINERARY_2N1D', label: '🗺️ Lộ trình 2N1Đ' },
  { id: 'FIND_BUDDY', label: '🎒 Tìm bạn đồng hành' },
] as const;

@Injectable()
export class SocialFeedService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
    private readonly storiesService: SocialStoriesService,
    private readonly challengesService: SocialChallengesService,
    private readonly streakService: UserTravelStreakService,
  ) {}

  async getFeed(userId: string, query: QuerySocialFeedDto) {
    const tab = query.tab ?? 'explore';
    const page = Math.max(query.page ?? 1, 1);
    const limit = Math.min(Math.max(query.limit ?? 10, 1), 50);

    if (tab === 'nearby' && (query.lat == null || query.lng == null)) {
      throw new BadRequestException('lat and lng are required when tab=nearby');
    }

    const [
      me,
      streakDays,
      unreadCount,
      followingCount,
      stories,
      challenge,
      postsPage,
      tripRecruit,
    ] = await Promise.all([
      this.prisma.user.findUnique({
        where: { id: userId },
        select: {
          displayname: true,
          avatar: { select: { objectKey: true, deletedAt: true } },
        },
      }),
      this.streakService.getCurrentDays(userId),
      this.prisma.notification.count({
        where: { userId, isRead: false },
      }),
      this.prisma.userFollow.count({ where: { followerId: userId } }),
      this.storiesService.listForFeed(userId),
      this.challengesService.getActive(userId),
      this.loadPosts(userId, tab, query, page, limit),
      page === 1 ? this.loadTripRecruit(userId) : Promise.resolve(null),
    ]);

    const displayName = me?.displayname?.trim() || 'Bạn';
    const avatarUrl = toPublicMediaUrl(
      (k) => this.s3.getPublicUrl(k),
      me?.avatar ?? null,
    );

    const reviewItems = postsPage.data.map((post) => {
      const enriched = mapEnrichedPost(post, (k) => this.s3.getPublicUrl(k));
      const medias = enriched.postMedias.map((m, index) => ({
        id: m.mediaId,
        imageUrl: m.url ?? '',
        caption: null as string | null,
        isHero: index === 0,
        overlayLabel: index === 0 ? enriched.place?.name ?? null : null,
      }));
      const visible = medias.slice(0, 2);
      const extraMediaCount = Math.max(0, medias.length - visible.length);

      return {
        id: `item-review-${enriched.id}`,
        type: 'REVIEW' as const,
        review: {
          postId: enriched.id,
          author: {
            id: enriched.author.id,
            displayName: enriched.author.displayName,
            avatarUrl: enriched.author.avatarUrl,
            badgeLabel: enriched.author.badgeLabel,
            verified: enriched.author.verified,
          },
          timeLabel: enriched.timeLabel,
          trendLabel: enriched.trendLabel,
          placeLabel: enriched.place?.name ?? null,
          placeDetail: enriched.placeDetail,
          placeId: enriched.placeId,
          savedByLabel:
            enriched.savesCount > 0
              ? `+${enriched.savesCount} người đã lưu`
              : null,
          caption: enriched.caption ?? '',
          tipTitle: enriched.tipTitle,
          tipBody: enriched.tipBody,
          medias: visible,
          extraMediaCount,
          primaryCtaLabel: 'Gợi ý lịch trình 1 ngày',
          secondaryCtaLabel: 'Lưu vào lịch trình',
          likesCount: enriched.likesCount,
          commentsCount: enriched.commentsCount,
          savesCount: enriched.savesCount,
          liked: enriched.liked,
          bookmarked: enriched.bookmarked,
          previewComment: enriched.previewComment,
        },
        challenge: null,
        tripRecruit: null,
      };
    });

    const items: Array<Record<string, unknown>> = [...reviewItems];

    if (page === 1 && challenge && reviewItems.length > 0) {
      items.splice(1, 0, {
        id: `item-challenge-${challenge.id}`,
        type: 'CHALLENGE',
        review: null,
        challenge,
        tripRecruit: null,
      });
    } else if (page === 1 && challenge && reviewItems.length === 0) {
      items.push({
        id: `item-challenge-${challenge.id}`,
        type: 'CHALLENGE',
        review: null,
        challenge,
        tripRecruit: null,
      });
    }

    if (page === 1 && tripRecruit) {
      const insertAt = Math.min(items.length, reviewItems.length > 0 ? 2 : 1);
      items.splice(insertAt, 0, {
        id: `item-trip-${tripRecruit.tripId}`,
        type: 'TRIP_RECRUIT',
        review: null,
        challenge: null,
        tripRecruit,
      });
    }

    return {
      header: {
        title: 'Bảng Tin',
        streakLabel:
          streakDays > 0
            ? `${streakDays} ngày xê dịch`
            : 'Bắt đầu chuỗi xê dịch',
        hasUnreadNotifications: unreadCount > 0,
        showFriendsCta: true,
      },
      composer: {
        displayName,
        avatarUrl,
        prompt: `${displayName} ơi, chia sẻ khoảnh khắc tuyệt vời hôm nay nào! ✨`,
      },
      stories,
      tabs: [
        {
          id: 'explore',
          label: 'Khám phá',
          badgeLabel: null,
          emoji: null,
          selected: tab === 'explore',
        },
        {
          id: 'following',
          label: 'Đang theo dõi',
          badgeLabel: followingCount > 0 ? String(followingCount) : null,
          emoji: null,
          selected: tab === 'following',
        },
        {
          id: 'nearby',
          label: 'Gần bạn',
          badgeLabel: null,
          emoji: '🔥',
          selected: tab === 'nearby',
        },
      ],
      topicChips: TOPIC_CHIPS.map((chip) => ({
        id: chip.id,
        label: chip.label,
        selected: query.topic === chip.id,
      })),
      items,
      meta: postsPage.meta,
    };
  }

  private async loadPosts(
    userId: string,
    tab: SocialFeedTab,
    query: QuerySocialFeedDto,
    page: number,
    limit: number,
  ) {
    const following = await this.prisma.userFollow.findMany({
      where: { followerId: userId },
      select: { followingId: true },
    });
    const followingIds = following.map((f) => f.followingId);

    const where: Prisma.PostWhereInput = {
      deletedAt: null,
      ...(query.topic ? { topic: query.topic } : {}),
    };

    if (tab === 'explore') {
      where.OR = [
        { visibility: SocialPostVisibility.PUBLIC },
        {
          visibility: SocialPostVisibility.FOLLOWERS,
          authorId: { in: followingIds },
        },
        {
          visibility: SocialPostVisibility.FOLLOWERS,
          authorId: userId,
        },
      ];
    } else if (tab === 'following') {
      where.authorId = { in: [...followingIds, userId] };
      where.visibility = {
        in: [SocialPostVisibility.PUBLIC, SocialPostVisibility.FOLLOWERS],
      };
    } else {
      const lat = query.lat!;
      const lng = query.lng!;
      const delta = 0.45; // ~50km
      where.visibility = SocialPostVisibility.PUBLIC;
      where.place = {
        latitude: { gte: lat - delta, lte: lat + delta },
        longitude: { gte: lng - delta, lte: lng + delta },
      };
    }

    const skip = (page - 1) * limit;
    const [posts, total] = await this.prisma.$transaction([
      this.prisma.post.findMany({
        where,
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
        include: {
          author: { select: postAuthorSelect },
          place: { select: postPlaceSelect },
          postMedias: {
            orderBy: { orderIndex: 'asc' },
            select: postMediaSelect,
          },
          _count: {
            select: { likes: true, comments: true, shares: true, saves: true },
          },
          ...viewerInteractionInclude(userId),
        },
      }),
      this.prisma.post.count({ where }),
    ]);

    return {
      data: posts,
      meta: createPaginationMeta(page, limit, total),
    };
  }

  private async loadTripRecruit(userId: string) {
    const now = new Date();
    const trip = await this.prisma.trip.findFirst({
      where: {
        visibility: TRIP_VISIBILITY.PUBLIC,
        status: TRIP_STATUS.UPCOMING,
        recruitment: { is: effectiveOpenWhere(now) },
        NOT: {
          OR: [
            { ownerId: userId },
            {
              members: {
                some: { userId, status: MEMBER_STATUS.ACTIVE },
              },
            },
          ],
        },
      },
      orderBy: { startDate: 'asc' },
      select: {
        id: true,
        name: true,
        startDate: true,
        maxMembers: true,
        owner: {
          select: {
            id: true,
            displayname: true,
            username: true,
            isVerified: true,
            profileBadge: true,
            avatar: { select: { objectKey: true, deletedAt: true } },
          },
        },
        destinations: {
          orderBy: { order: 'asc' },
          take: 2,
          select: { city: true, country: true },
        },
        recruitment: {
          select: {
            estimatedBudgetPerPerson: true,
            urgent: true,
            expiresAt: true,
            requirements: true,
          },
        },
        _count: {
          select: { members: { where: { status: MEMBER_STATUS.ACTIVE } } },
        },
        members: {
          where: { status: MEMBER_STATUS.ACTIVE },
          take: 3,
          orderBy: { joinedAt: 'asc' },
          select: {
            user: {
              select: {
                avatar: { select: { objectKey: true, deletedAt: true } },
              },
            },
          },
        },
      },
    });

    if (!trip || !trip.owner) return null;

    const memberCount = trip._count.members;
    const spotsLeft = Math.max(0, trip.maxMembers - memberCount);
    if (spotsLeft <= 0) return null;

    const fillRatio =
      trip.maxMembers > 0
        ? Number((memberCount / trip.maxMembers).toFixed(2))
        : 0;
    const placeLabel = trip.destinations
      .map((d) => `${d.city}, ${d.country}`)
      .join(' & ');
    const daysLeft = trip.recruitment?.expiresAt
      ? Math.max(
          0,
          Math.ceil(
            (trip.recruitment.expiresAt.getTime() - Date.now()) / 86_400_000,
          ),
        )
      : null;
    const budget = trip.recruitment?.estimatedBudgetPerPerson;
    const memberAvatars = trip.members
      .map((m) =>
        toPublicMediaUrl((k) => this.s3.getPublicUrl(k), m.user.avatar),
      )
      .filter((url): url is string => !!url);

    return {
      postId: `trip-recruit-${trip.id}`,
      author: {
        id: trip.owner.id,
        displayName: trip.owner.displayname,
        avatarUrl: toPublicMediaUrl(
          (k) => this.s3.getPublicUrl(k),
          trip.owner.avatar,
        ),
        badgeLabel: trip.owner.profileBadge,
        verified: trip.owner.isVerified,
      },
      timeLabel: 'Đang tuyển',
      recruitBadge: 'Tuyển thành viên',
      placeLabel: placeLabel || 'Chuyến đi cộng đồng',
      caption:
        trip.recruitment?.requirements?.trim() ||
        `Nhóm đang cần thêm ${spotsLeft} bạn đồng hành cho chuyến đi sắp tới.`,
      tripId: trip.id,
      tripTitle: trip.name,
      spotsLeftLabel: `Còn ${spotsLeft} chỗ`,
      urgencyLabel:
        trip.recruitment?.urgent || (daysLeft != null && daysLeft <= 2)
          ? `⚡ Chỉ còn ${daysLeft ?? 2} ngày`
          : 'CHUYẾN ĐI MỞ',
      scheduleLabel: `${trip.startDate.toLocaleDateString('vi-VN')} • 05:00 Sáng`,
      priceLabel: budget
        ? `~${Number(budget).toLocaleString('vi-VN')}đ / người`
        : 'Liên hệ nhóm',
      membersLabel: `${memberCount}/${trip.maxMembers}`,
      fillRatio,
      fillPercentLabel: `Đã đủ ${Math.round(fillRatio * 100)}%`,
      memberAvatars,
      extraMemberCount: Math.max(0, memberCount - memberAvatars.length),
      highlightLabel: null,
      highlightDetail: null,
      likesCount: 0,
      commentsCount: 0,
      sharesCount: 0,
      liked: false,
      bookmarked: false,
      itineraryCtaLabel: 'Lịch trình',
      joinCtaLabel: '🚀 Tham gia ngay',
    };
  }
}

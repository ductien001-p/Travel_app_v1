import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { Cron } from '@nestjs/schedule';

import { PrismaService } from '../../prisma.service';
import { Prisma } from '../../generated/prisma/client';
import {
  PLACE_CATEGORY,
  RANK,
  RANKING_POINT_REASON,
  TRAVEL_DNA_TYPE,
} from '../../generated/prisma/enums';
import { S3Service } from '../../uploads/s3/s3.service';
import { createPaginationMeta } from '../../common/contracts/pagination-meta.dto';
import {
  RankingLeaderboardQueryDto,
  RankingMeQueryDto,
  RankingPeriodQuery,
} from './dto/ranking-period.dto';
import { resolveTravelStyleBadge } from './ranking-badge';
import { TravelTierService } from '../trips/trip-relations/trip-missions/travel-tier.service';

type MediaUrlSource = {
  objectKey: string;
  deletedAt: Date | null;
} | null;

type RankingUserSource = {
  username: string;
  displayname: string | null;
  isVerified: boolean | null;
  profileBadge: string | null;
  interests?: string[];
  travelStyle?: Array<{ type: TRAVEL_DNA_TYPE; score: number }>;
  avatar: MediaUrlSource;
  ranking?: { tripsCompleted: number; rank: RANK } | null;
};

type PeriodWindow = {
  period: RankingPeriodQuery;
  start: Date | null;
  end: Date | null;
  seasonLabel: string | null;
};

const TOP_N = 10;

const HERITAGE_CATEGORIES: PLACE_CATEGORY[] = [
  PLACE_CATEGORY.MUSEUM,
  PLACE_CATEGORY.TEMPLES,
  PLACE_CATEGORY.CHURCH,
  PLACE_CATEGORY.HISTORICAL_SITE,
  PLACE_CATEGORY.MONUMENT,
  PLACE_CATEGORY.PALACE,
  PLACE_CATEGORY.CASTLE,
  PLACE_CATEGORY.OLD_TOWN,
];

const USER_SELECT = {
  id: true,
  username: true,
  displayname: true,
  isVerified: true,
  profileBadge: true,
  interests: true,
  travelStyle: {
    select: { type: true, score: true },
    orderBy: { score: 'desc' as const },
    take: 1,
  },
  avatar: {
    select: { objectKey: true, deletedAt: true },
  },
  ranking: {
    select: { tripsCompleted: true, rank: true },
  },
} satisfies Prisma.UserSelect;

@Injectable()
export class RankingService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
    private readonly travelTierService: TravelTierService,
  ) {}

  @Cron('0 0 * * *')
  async handleDailyLeaderboard() {
    const topUsers = await this.prisma.userRanking.findMany({
      orderBy: [{ totalPoints: 'desc' }, { userId: 'asc' }],
      take: 1000,
      select: { userId: true, totalPoints: true },
    });

    const date = new Date();
    await this.prisma.$transaction(async (tx) => {
      await tx.dailyLeaderboard.createMany({
        data: topUsers.map((user, index) => ({
          userId: user.userId,
          points: user.totalPoints,
          ranking: index + 1,
          date,
        })),
      });
    });
  }

  /**
   * Awards points inside the caller's transaction and writes a ledger row.
   */
  async awardPoints(
    tx: Prisma.TransactionClient,
    input: {
      userId: string;
      points: number;
      reason: RANKING_POINT_REASON;
      sourceType?: string | null;
      sourceId?: string | null;
      incrementTripsCompleted?: boolean;
    },
  ): Promise<{ ledgerId: string; totalPoints: number; rank: RANK }> {
    if (input.points <= 0) {
      throw new BadRequestException('points must be positive');
    }

    const ranking = await tx.userRanking.upsert({
      where: { userId: input.userId },
      create: {
        userId: input.userId,
        totalPoints: input.points,
        tripsCompleted: input.incrementTripsCompleted ? 1 : 0,
        rank: this.getLevel(input.points),
      },
      update: {
        totalPoints: { increment: input.points },
        ...(input.incrementTripsCompleted
          ? { tripsCompleted: { increment: 1 } }
          : {}),
      },
      select: { totalPoints: true, rank: true },
    });

    const rank = this.getLevel(ranking.totalPoints);
    if (rank !== ranking.rank) {
      await tx.userRanking.update({
        where: { userId: input.userId },
        data: { rank },
      });
    }

    const ledger = await tx.rankingPointLedger.create({
      data: {
        userId: input.userId,
        points: input.points,
        reason: input.reason,
        sourceType: input.sourceType ?? null,
        sourceId: input.sourceId ?? null,
      },
      select: { id: true },
    });

    return {
      ledgerId: ledger.id,
      totalPoints: ranking.totalPoints,
      rank,
    };
  }

  /** Backward-compatible wrapper used by trip completion. */
  async awardTripCompletion(
    tx: Prisma.TransactionClient,
    userId: string,
    pointsAwarded: number,
    tripId?: string,
  ): Promise<void> {
    await this.awardPoints(tx, {
      userId,
      points: pointsAwarded,
      reason: RANKING_POINT_REASON.TRIP_COMPLETION,
      sourceType: tripId ? 'trip' : null,
      sourceId: tripId ?? null,
      incrementTripsCompleted: true,
    });
  }

  async leaderboard(dto: RankingLeaderboardQueryDto) {
    const page = Math.max(dto.page, 1);
    const limit = Math.min(Math.max(dto.limit, 1), 100);
    const skip = (page - 1) * limit;
    const window = await this.resolvePeriodWindow(dto.period);

    const aggregates = await this.aggregateLeaderboard(window);
    const total = aggregates.length;
    const pageRows = aggregates.slice(skip, skip + limit);

    const users = await this.prisma.user.findMany({
      where: { id: { in: pageRows.map((row) => row.userId) } },
      select: USER_SELECT,
    });
    const userMap = new Map(users.map((user) => [user.id, user]));

    const data = pageRows.map((row, index) => {
      const user = userMap.get(row.userId);
      return this.mapEntry({
        userId: row.userId,
        totalPoints: row.points,
        ranking: skip + index + 1,
        user: user ?? {
          username: 'unknown',
          displayname: null,
          isVerified: false,
          profileBadge: null,
          interests: [],
          travelStyle: [],
          avatar: null,
          ranking: null,
        },
      });
    });

    return {
      data,
      meta: createPaginationMeta(page, limit, total),
      period: window.period,
      seasonLabel: window.seasonLabel,
      windowStart: window.start?.toISOString() ?? null,
      windowEnd: window.end?.toISOString() ?? null,
      snapshotAt: new Date().toISOString(),
    };
  }

  async getUserRanking(userId: string, dto: RankingMeQueryDto = { period: RankingPeriodQuery.ALL_TIME }) {
    const ranking = await this.prisma.userRanking.findUnique({
      where: { userId },
    });
    if (!ranking) {
      throw new NotFoundException('User ranking not found');
    }

    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: USER_SELECT,
    });
    if (!user) {
      throw new NotFoundException('User not found');
    }

    const window = await this.resolvePeriodWindow(dto.period);
    const aggregates = await this.aggregateLeaderboard(window);
    const myIndex = aggregates.findIndex((row) => row.userId === userId);
    const myPoints =
      myIndex >= 0
        ? aggregates[myIndex].points
        : await this.sumLedgerPoints(userId, window);
    const leaderboardRanking = myIndex >= 0 ? myIndex + 1 : null;

    const previousWindow = await this.resolvePreviousWindow(window);
    let previousRanking: number | null = null;
    if (previousWindow) {
      const previous = await this.aggregateLeaderboard(previousWindow);
      const prevIndex = previous.findIndex((row) => row.userId === userId);
      previousRanking = prevIndex >= 0 ? prevIndex + 1 : null;
    }

    const rankDelta =
      previousRanking != null && leaderboardRanking != null
        ? previousRanking - leaderboardRanking
        : 0;

    const topN = this.computeTopNProgress(aggregates, myPoints, leaderboardRanking);
    const [travelTier, achievements] = await Promise.all([
      this.travelTierService.getTravelTierDto(userId),
      this.travelTierService.listAchievements(userId),
    ]);

    return {
      ...this.mapEntry({
        userId,
        totalPoints: myPoints,
        ranking: leaderboardRanking,
        user: {
          ...user,
          ranking: {
            tripsCompleted: ranking.tripsCompleted,
            rank: ranking.rank,
          },
        },
      }),
      rankDelta,
      previousRanking,
      nextRank: null,
      nextTierLabel: topN.nextTierLabel,
      nextRankPoints: topN.nextRankPoints,
      progressHint: topN.progressHint,
      snapshotAt: new Date().toISOString(),
      period: window.period,
      seasonLabel: window.seasonLabel,
      windowStart: window.start?.toISOString() ?? null,
      windowEnd: window.end?.toISOString() ?? null,
      travelTier,
      achievements,
    };
  }

  async listQuests(userId: string) {
    const definitions = await this.prisma.rankingQuestDefinition.findMany({
      where: { isActive: true },
      orderBy: { sortOrder: 'asc' },
    });
    const claims = await this.prisma.rankingQuestClaim.findMany({
      where: { userId },
      select: { questId: true },
    });
    const claimedIds = new Set(claims.map((c) => c.questId));

    const progressMap = await this.computeQuestProgress(userId, definitions.map((d) => d.code));

    const data = definitions.map((quest) => {
      const progressCurrent = progressMap.get(quest.code) ?? 0;
      const claimed = claimedIds.has(quest.id);
      return {
        id: quest.id,
        code: quest.code,
        title: quest.title,
        subtitle:
          quest.code === 'HERITAGE_CHECKIN'
            ? `Tiến độ hiện tại: ${progressCurrent}/${quest.targetCount} địa danh`
            : quest.subtitle,
        icon: quest.icon,
        pointsReward: quest.pointsReward,
        action: quest.action,
        tone: quest.tone,
        targetCount: quest.targetCount,
        progressCurrent,
        claimed,
        claimable: !claimed && progressCurrent >= quest.targetCount,
      };
    });

    return { data, questsTotal: data.length };
  }

  async claimQuest(userId: string, questId: string) {
    const quest = await this.prisma.rankingQuestDefinition.findFirst({
      where: { id: questId, isActive: true },
    });
    if (!quest) {
      throw new NotFoundException('Quest not found');
    }

    const existing = await this.prisma.rankingQuestClaim.findUnique({
      where: { userId_questId: { userId, questId } },
    });
    if (existing) {
      throw new BadRequestException('Quest already claimed');
    }

    const progressMap = await this.computeQuestProgress(userId, [quest.code]);
    const progressCurrent = progressMap.get(quest.code) ?? 0;
    if (progressCurrent < quest.targetCount) {
      throw new BadRequestException('Quest progress is incomplete');
    }

    await this.prisma.$transaction(async (tx) => {
      const awarded = await this.awardPoints(tx, {
        userId,
        points: quest.pointsReward,
        reason: RANKING_POINT_REASON.QUEST_CLAIM,
        sourceType: 'quest',
        sourceId: quest.id,
      });

      await tx.rankingQuestClaim.create({
        data: {
          userId,
          questId: quest.id,
          pointsAwarded: quest.pointsReward,
          ledgerId: awarded.ledgerId,
        },
      });
    });

    const listed = await this.listQuests(userId);
    const updated = listed.data.find((item) => item.id === quest.id);
    if (!updated) {
      throw new NotFoundException('Quest not found after claim');
    }
    return updated;
  }

  getLevel(totalPoints: number): RANK {
    if (totalPoints < 100) return RANK.BEGINNER;
    if (totalPoints < 500) return RANK.EXPLORER;
    if (totalPoints < 2500) return RANK.ADVENTURER;
    if (totalPoints < 5000) return RANK.TRAVELER;
    return RANK.LEGEND;
  }

  computeTopNProgress(
    aggregates: Array<{ userId: string; points: number }>,
    myPoints: number,
    myRanking: number | null,
  ) {
    const threshold =
      aggregates.length >= TOP_N
        ? aggregates[TOP_N - 1].points
        : aggregates.length > 0
          ? aggregates[aggregates.length - 1].points
          : 0;

    if (myRanking != null && myRanking <= TOP_N) {
      return {
        nextTierLabel: `Top ${TOP_N}`,
        nextRankPoints: Math.max(threshold, myPoints),
        progressHint: `Bạn đang ở hạng #${myRanking} — giữ vững Top ${TOP_N}`,
      };
    }

    const remaining = Math.max(0, threshold + 1 - myPoints);
    return {
      nextTierLabel: `Top ${TOP_N}`,
      nextRankPoints: threshold + 1,
      progressHint:
        remaining === 0
          ? `Sẵn sàng lọt Top ${TOP_N}`
          : `Chỉ còn ${remaining} pts để lọt Top ${TOP_N}`,
    };
  }

  private async resolvePeriodWindow(
    period: RankingPeriodQuery = RankingPeriodQuery.ALL_TIME,
  ): Promise<PeriodWindow> {
    const now = new Date();
    if (period === RankingPeriodQuery.ALL_TIME) {
      return { period, start: null, end: null, seasonLabel: null };
    }
    if (period === RankingPeriodQuery.WEEK) {
      const start = new Date(now);
      start.setUTCDate(start.getUTCDate() - 7);
      return {
        period,
        start,
        end: now,
        seasonLabel: null,
      };
    }
    if (period === RankingPeriodQuery.MONTH) {
      const start = new Date(
        Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), 1),
      );
      return {
        period,
        start,
        end: now,
        seasonLabel: null,
      };
    }

    const season = await this.prisma.rankingSeason.findFirst({
      where: { isActive: true },
      orderBy: { startsAt: 'desc' },
    });
    if (!season) {
      const start = new Date(Date.UTC(now.getUTCFullYear(), 5, 1));
      const end = new Date(Date.UTC(now.getUTCFullYear(), 7, 31, 23, 59, 59, 999));
      return {
        period,
        start,
        end,
        seasonLabel: `Mùa Hè ${now.getUTCFullYear()}`,
      };
    }
    return {
      period,
      start: season.startsAt,
      end: season.endsAt,
      seasonLabel: season.label,
    };
  }

  private async resolvePreviousWindow(
    current: PeriodWindow,
  ): Promise<PeriodWindow | null> {
    if (current.period === RankingPeriodQuery.ALL_TIME) {
      return null;
    }
    if (current.period === RankingPeriodQuery.WEEK && current.start && current.end) {
      const duration = current.end.getTime() - current.start.getTime();
      return {
        period: current.period,
        start: new Date(current.start.getTime() - duration),
        end: current.start,
        seasonLabel: null,
      };
    }
    if (current.period === RankingPeriodQuery.MONTH && current.start) {
      const start = new Date(current.start);
      start.setUTCMonth(start.getUTCMonth() - 1);
      const end = new Date(current.start);
      return {
        period: current.period,
        start,
        end,
        seasonLabel: null,
      };
    }
    if (current.period === RankingPeriodQuery.SEASON && current.start) {
      const previous = await this.prisma.rankingSeason.findFirst({
        where: { endsAt: { lt: current.start } },
        orderBy: { endsAt: 'desc' },
      });
      if (!previous) return null;
      return {
        period: current.period,
        start: previous.startsAt,
        end: previous.endsAt,
        seasonLabel: previous.label,
      };
    }
    return null;
  }

  private async aggregateLeaderboard(window: PeriodWindow) {
    const where: Prisma.RankingPointLedgerWhereInput = {};
    if (window.start || window.end) {
      where.createdAt = {
        ...(window.start ? { gte: window.start } : {}),
        ...(window.end ? { lte: window.end } : {}),
      };
    }

    const grouped = await this.prisma.rankingPointLedger.groupBy({
      by: ['userId'],
      where,
      _sum: { points: true },
      orderBy: [{ _sum: { points: 'desc' } }, { userId: 'asc' }],
    });

    return grouped
      .map((row) => ({
        userId: row.userId,
        points: row._sum.points ?? 0,
      }))
      .filter((row) => row.points > 0);
  }

  private async sumLedgerPoints(userId: string, window: PeriodWindow) {
    const where: Prisma.RankingPointLedgerWhereInput = { userId };
    if (window.start || window.end) {
      where.createdAt = {
        ...(window.start ? { gte: window.start } : {}),
        ...(window.end ? { lte: window.end } : {}),
      };
    }
    const result = await this.prisma.rankingPointLedger.aggregate({
      where,
      _sum: { points: true },
    });
    return result._sum.points ?? 0;
  }

  private async computeQuestProgress(userId: string, codes: string[]) {
    const map = new Map<string, number>();
    await Promise.all(
      codes.map(async (code) => {
        if (code === 'COMPLETE_TRIP') {
          const count = await this.prisma.tripCompletion.count({
            where: { member: { userId } },
          });
          map.set(code, count);
          return;
        }
        if (code === 'HERITAGE_CHECKIN') {
          const rows = await this.prisma.tripCheckin.findMany({
            where: {
              userId,
              place: { category: { in: HERITAGE_CATEGORIES } },
            },
            distinct: ['placeId'],
            select: { placeId: true },
          });
          map.set(code, rows.length);
          return;
        }
        if (code === 'PHOTO_REVIEW') {
          const count = await this.prisma.post.count({
            where: {
              authorId: userId,
              postMedias: { some: {} },
            },
          });
          map.set(code, count);
        }
      }),
    );
    return map;
  }

  private mapEntry(input: {
    userId: string;
    totalPoints: number;
    ranking: number | null;
    user: RankingUserSource;
  }) {
    const dominantDna = input.user.travelStyle?.[0]?.type ?? null;
    const badge = resolveTravelStyleBadge({
      profileBadge: input.user.profileBadge,
      interests: input.user.interests ?? [],
      dominantDna,
    });

    return {
      userId: input.userId,
      totalPoints: input.totalPoints,
      totalTripsCompleted: input.user.ranking?.tripsCompleted ?? 0,
      rank: input.user.ranking?.rank ?? this.getLevel(input.totalPoints),
      ranking: input.ranking,
      displayName:
        input.user.displayname?.trim() ||
        input.user.username ||
        'Người dùng',
      username: input.user.username,
      avatarUrl: this.toPublicUrl(input.user.avatar),
      isVerified: input.user.isVerified === true,
      badgeLabel: badge.badgeLabel,
      badgeIcon: badge.badgeIcon,
    };
  }

  private toPublicUrl(media: MediaUrlSource): string | null {
    if (!media || media.deletedAt) return null;
    return this.s3.getPublicUrl(media.objectKey);
  }
}

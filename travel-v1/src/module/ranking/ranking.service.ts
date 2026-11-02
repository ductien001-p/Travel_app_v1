import { Injectable, NotFoundException } from '@nestjs/common';
import { Cron } from '@nestjs/schedule';

import { PrismaService } from '../../prisma.service';
import { Prisma } from '../../generated/prisma/client';
import { RANK } from '../../generated/prisma/enums';
import { PaginationDto } from '../users/dto/pagination.dto';

import { createPaginationMeta } from '../../common/contracts/pagination-meta.dto';

@Injectable()
export class RankingService {
  constructor(private readonly prisma: PrismaService) {}

  // =========================================================
  // DAILY LEADERBOARD SNAPSHOT
  // =========================================================

  @Cron('0 0 * * *')
  async handleDailyLeaderboard() {
    const topUsers = await this.prisma.userRanking.findMany({
      orderBy: [
        {
          totalPoints: 'desc',
        },
        {
          userId: 'asc',
        },
      ],

      take: 1000,

      select: {
        userId: true,
        totalPoints: true,
      },
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

  // =========================================================
  // LEADERBOARD
  // =========================================================

  async leaderboard(dto: PaginationDto) {
    const page = Math.max(dto.page, 1);

    const limit = Math.min(Math.max(dto.limit, 1), 100);

    const skip = (page - 1) * limit;

    const latest = await this.getLatestLeaderboardDate();

    if (!latest) {
      return {
        data: [],
        meta: createPaginationMeta(page, limit, 0),
      };
    }

    const [items, total] = await this.prisma.$transaction([
      this.prisma.dailyLeaderboard.findMany({
        where: {
          date: latest,
        },

        orderBy: {
          ranking: 'asc',
        },

        skip,
        take: limit,

        include: {
          user: {
            include: {
              ranking: true,
            },
          },
        },
      }),

      this.prisma.dailyLeaderboard.count({
        where: {
          date: latest,
        },
      }),
    ]);

    const data = items.map((item) => ({
      userId: item.userId,

      totalPoints: item.points,

      totalTripsCompleted: item.user.ranking?.tripsCompleted ?? 0,

      rank: item.user.ranking?.rank ?? RANK.BEGINNER,

      ranking: item.ranking,
    }));

    return {
      data,

      meta: createPaginationMeta(page, limit, total),
    };
  }

  // =========================================================
  // CALCULATE POINTS
  // =========================================================

  /**
   * Runs inside the caller's transaction (trip completion). The increment is
   * atomic and the upserted row stays locked until commit, so concurrent
   * completions by the same user cannot lose points or misjudge the rank.
   */
  async awardTripCompletion(
    tx: Prisma.TransactionClient,
    userId: string,
    pointsAwarded: number,
  ): Promise<void> {
    const ranking = await tx.userRanking.upsert({
      where: { userId },
      create: {
        userId,
        totalPoints: pointsAwarded,
        tripsCompleted: 1,
        rank: this.getLevel(pointsAwarded),
      },
      update: {
        totalPoints: { increment: pointsAwarded },
        tripsCompleted: { increment: 1 },
      },
      select: { totalPoints: true, rank: true },
    });

    const rank = this.getLevel(ranking.totalPoints);
    if (rank !== ranking.rank) {
      await tx.userRanking.update({ where: { userId }, data: { rank } });
    }
  }

  // =========================================================
  // MY RANKING
  // =========================================================

  async getUserRanking(userId: string) {
    const ranking = await this.prisma.userRanking.findUnique({
      where: {
        userId,
      },
    });

    if (!ranking) {
      throw new NotFoundException('User ranking not found');
    }

    const latest = await this.getLatestLeaderboardDate();

    let leaderboardRanking: number | null = null;

    if (latest) {
      const entry = await this.prisma.dailyLeaderboard.findUnique({
        where: {
          userId_date: {
            userId,
            date: latest,
          },
        },

        select: {
          ranking: true,
        },
      });

      leaderboardRanking = entry?.ranking ?? null;
    }

    return {
      userId,

      totalPoints: ranking.totalPoints,

      totalTripsCompleted: ranking.tripsCompleted,

      rank: ranking.rank,

      // null = không nằm trong leaderboard hiện tại
      ranking: leaderboardRanking,
    };
  }

  // =========================================================
  // LEVEL
  // =========================================================

  private getLevel(totalPoints: number): RANK {
    if (totalPoints < 100) {
      return RANK.BEGINNER;
    }

    if (totalPoints < 500) {
      return RANK.EXPLORER;
    }

    if (totalPoints < 2500) {
      return RANK.ADVENTURER;
    }

    if (totalPoints < 5000) {
      return RANK.TRAVELER;
    }

    return RANK.LEGEND;
  }

  // =========================================================
  // LATEST SNAPSHOT
  // =========================================================

  private async getLatestLeaderboardDate(): Promise<Date | null> {
    const latest = await this.prisma.dailyLeaderboard.findFirst({
      orderBy: {
        date: 'desc',
      },

      select: {
        date: true,
      },
    });

    return latest?.date ?? null;
  }
}

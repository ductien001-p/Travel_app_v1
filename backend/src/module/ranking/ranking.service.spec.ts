import { BadRequestException, NotFoundException } from '@nestjs/common';
import { RANK, RANKING_POINT_REASON } from '../../generated/prisma/enums';
import { RankingPeriodQuery } from './dto/ranking-period.dto';
import { RankingService } from './ranking.service';

function buildService(prisma: Record<string, unknown> = {}) {
  return new RankingService(
    prisma as never,
    {
      getPublicUrl: (key: string) => `https://cdn.test/${key}`,
    } as never,
    {
      getTravelTierDto: jest.fn().mockResolvedValue({
        code: 'ROOKIE',
        label: 'Tân binh',
        multiplier: 1,
        tripsCompleted: 0,
        distinctCities: 0,
        next: null,
      }),
      listAchievements: jest.fn().mockResolvedValue([]),
    } as never,
  );
}

describe('RankingService.awardPoints', () => {
  it('increments ranking and writes ledger in the same transaction', async () => {
    const tx = {
      userRanking: {
        upsert: jest.fn().mockResolvedValue({
          totalPoints: 150,
          rank: RANK.EXPLORER,
        }),
        update: jest.fn(),
      },
      rankingPointLedger: {
        create: jest.fn().mockResolvedValue({ id: 'ledger-1' }),
      },
    };
    const service = buildService();

    const result = await service.awardPoints(tx as never, {
      userId: 'user-1',
      points: 50,
      reason: RANKING_POINT_REASON.TRIP_COMPLETION,
      sourceType: 'trip',
      sourceId: 'trip-1',
      incrementTripsCompleted: true,
    });

    expect(result.ledgerId).toBe('ledger-1');
    expect(tx.rankingPointLedger.create).toHaveBeenCalled();
    expect(tx.userRanking.upsert).toHaveBeenCalled();
  });

  it('promotes RANK when crossing threshold', async () => {
    const tx = {
      userRanking: {
        upsert: jest.fn().mockResolvedValue({
          totalPoints: 520,
          rank: RANK.EXPLORER,
        }),
        update: jest.fn().mockResolvedValue({}),
      },
      rankingPointLedger: {
        create: jest.fn().mockResolvedValue({ id: 'ledger-2' }),
      },
    };
    const service = buildService();
    await service.awardPoints(tx as never, {
      userId: 'user-1',
      points: 40,
      reason: RANKING_POINT_REASON.TRIP_COMPLETION,
      sourceType: 'trip',
      sourceId: 'trip-2',
      incrementTripsCompleted: true,
    });
    expect(tx.userRanking.update).toHaveBeenCalledWith({
      where: { userId: 'user-1' },
      data: { rank: RANK.ADVENTURER },
    });
  });
});

describe('RankingService.computeTopNProgress', () => {
  const service = buildService();

  it('reports remaining points to enter Top 10', () => {
    const aggregates = Array.from({ length: 12 }, (_, i) => ({
      userId: `u${i}`,
      points: 1000 - i * 10,
    }));
    const result = service.computeTopNProgress(aggregates, 850, null);
    expect(result.nextTierLabel).toBe('Top 10');
    expect(result.nextRankPoints).toBe(911);
    expect(result.progressHint).toContain('pts');
  });

  it('keeps Top 10 hint when already inside', () => {
    const aggregates = [
      { userId: 'a', points: 100 },
      { userId: 'b', points: 90 },
    ];
    const result = service.computeTopNProgress(aggregates, 100, 1);
    expect(result.progressHint).toContain('#1');
  });
});

describe('RankingService.claimQuest', () => {
  it('rejects incomplete progress', async () => {
    const prisma = {
      rankingQuestDefinition: {
        findFirst: jest.fn().mockResolvedValue({
          id: 'q1',
          code: 'COMPLETE_TRIP',
          pointsReward: 100,
          targetCount: 1,
          isActive: true,
        }),
      },
      rankingQuestClaim: {
        findUnique: jest.fn().mockResolvedValue(null),
      },
      tripCompletion: {
        count: jest.fn().mockResolvedValue(0),
      },
    };
    const service = buildService(prisma);
    await expect(service.claimQuest('user-1', 'q1')).rejects.toBeInstanceOf(
      BadRequestException,
    );
  });

  it('throws when quest missing', async () => {
    const prisma = {
      rankingQuestDefinition: {
        findFirst: jest.fn().mockResolvedValue(null),
      },
    };
    const service = buildService(prisma);
    await expect(service.claimQuest('user-1', 'missing')).rejects.toBeInstanceOf(
      NotFoundException,
    );
  });
});

describe('RankingService.leaderboard period', () => {
  it('returns empty when ledger has no rows', async () => {
    const prisma = {
      rankingPointLedger: {
        groupBy: jest.fn().mockResolvedValue([]),
      },
      rankingSeason: {
        findFirst: jest.fn(),
      },
      user: {
        findMany: jest.fn().mockResolvedValue([]),
      },
    };
    const service = buildService(prisma);
    const result = await service.leaderboard({
      page: 1,
      limit: 20,
      period: RankingPeriodQuery.WEEK,
    });
    expect(result.data).toEqual([]);
    expect(result.period).toBe(RankingPeriodQuery.WEEK);
  });
});

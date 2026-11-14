import { Injectable } from '@nestjs/common';
import { Prisma } from '../../../../generated/prisma/client';
import { TRAVEL_TIER_CODE } from '../../../../generated/prisma/enums';
import { PrismaService } from '../../../../prisma.service';
import {
  AchievementProgressDto,
  TravelTierDto,
} from './dto/trip-mission-response.dto';
import {
  CULTURE_PLACE_CATEGORIES,
  FOOD_PLACE_CATEGORIES,
  NATURE_PLACE_CATEGORIES,
} from './trip-mission.constants';

type Tx = Prisma.TransactionClient;

const TIER_LABELS: Record<TRAVEL_TIER_CODE, string> = {
  ROOKIE: 'Tân binh',
  EXPLORER: 'Khám phá',
  TRAVELER: 'Lữ khách',
  ADVENTURER: 'Nhà thám hiểm',
  LEGEND: 'Huyền thoại',
};

type TierRule = {
  code: TRAVEL_TIER_CODE;
  multiplier: number;
  minTrips: number;
  minCities: number;
};

const TIER_RULES: TierRule[] = [
  { code: TRAVEL_TIER_CODE.LEGEND, multiplier: 1.5, minTrips: 30, minCities: 10 },
  { code: TRAVEL_TIER_CODE.ADVENTURER, multiplier: 1.35, minTrips: 15, minCities: 6 },
  { code: TRAVEL_TIER_CODE.TRAVELER, multiplier: 1.2, minTrips: 7, minCities: 3 },
  { code: TRAVEL_TIER_CODE.EXPLORER, multiplier: 1.1, minTrips: 3, minCities: 0 },
  { code: TRAVEL_TIER_CODE.ROOKIE, multiplier: 1.0, minTrips: 1, minCities: 0 },
];

function resolveTier(tripsCompleted: number, distinctCities: number): TierRule {
  for (const rule of TIER_RULES) {
    if (
      tripsCompleted >= rule.minTrips &&
      distinctCities >= rule.minCities
    ) {
      return rule;
    }
  }
  return {
    code: TRAVEL_TIER_CODE.ROOKIE,
    multiplier: 1.0,
    minTrips: 0,
    minCities: 0,
  };
}

function nextTier(
  current: TRAVEL_TIER_CODE,
  tripsCompleted: number,
  distinctCities: number,
): TravelTierDto['next'] {
  const ascending = [...TIER_RULES].reverse();
  const idx = ascending.findIndex((r) => r.code === current);
  const next = ascending[idx + 1];
  if (!next) {
    return null;
  }
  return {
    code: next.code,
    multiplier: next.multiplier,
    tripsRemaining: Math.max(0, next.minTrips - tripsCompleted),
    citiesRemaining: Math.max(0, next.minCities - distinctCities),
  };
}

@Injectable()
export class TravelTierService {
  constructor(private readonly prisma: PrismaService) {}

  async getMultiplier(userId: string, tx: Tx = this.prisma): Promise<number> {
    const tier = await tx.userTravelTier.findUnique({
      where: { userId },
      select: { multiplier: true },
    });
    if (!tier) {
      return 1;
    }
    return Number(tier.multiplier);
  }

  async afterTripCompletion(
    tx: Tx,
    userId: string,
  ): Promise<TravelTierDto> {
    const [tripsCompleted, distinctCities] = await Promise.all([
      tx.tripCompletion.count({
        where: { member: { userId } },
      }),
      this.countDistinctCities(tx, userId),
    ]);

    const rule = resolveTier(tripsCompleted, distinctCities);
    const row = await tx.userTravelTier.upsert({
      where: { userId },
      create: {
        userId,
        tierCode: rule.code,
        multiplier: rule.multiplier,
        tripsCompleted,
        distinctCities,
      },
      update: {
        tierCode: rule.code,
        multiplier: rule.multiplier,
        tripsCompleted,
        distinctCities,
      },
    });

    await this.syncAchievements(tx, userId);

    return this.mapTier(row);
  }

  async getTravelTierDto(userId: string): Promise<TravelTierDto> {
    const existing = await this.prisma.userTravelTier.findUnique({
      where: { userId },
    });
    if (existing) {
      return this.mapTier(existing);
    }

    const [tripsCompleted, distinctCities] = await Promise.all([
      this.prisma.tripCompletion.count({
        where: { member: { userId } },
      }),
      this.countDistinctCities(this.prisma, userId),
    ]);
    const rule = resolveTier(
      Math.max(tripsCompleted, 0),
      distinctCities,
    );
    // Do not persist until first completion; still show ROOKIE defaults.
    if (tripsCompleted === 0) {
      return {
        code: TRAVEL_TIER_CODE.ROOKIE,
        label: TIER_LABELS.ROOKIE,
        multiplier: 1,
        tripsCompleted: 0,
        distinctCities,
        next: nextTier(TRAVEL_TIER_CODE.ROOKIE, 0, distinctCities),
      };
    }
    return {
      code: rule.code,
      label: TIER_LABELS[rule.code],
      multiplier: rule.multiplier,
      tripsCompleted,
      distinctCities,
      next: nextTier(rule.code, tripsCompleted, distinctCities),
    };
  }

  async listAchievements(userId: string): Promise<AchievementProgressDto[]> {
    const defs = await this.prisma.achievementDefinition.findMany({
      where: { isActive: true },
      orderBy: { sortOrder: 'asc' },
    });
    const progress = await this.prisma.userAchievementProgress.findMany({
      where: { userId },
    });
    const byAchievement = new Map(
      progress.map((p) => [p.achievementId, p]),
    );

    return defs.map((def) => {
      const row = byAchievement.get(def.id);
      const current = row?.currentCount ?? 0;
      return {
        code: def.code,
        title: def.title,
        rarity: def.rarity,
        current,
        target: def.targetCount,
        unlocked: row?.unlockedAt != null || current >= def.targetCount,
      };
    });
  }

  private async syncAchievements(tx: Tx, userId: string): Promise<void> {
    const defs = await tx.achievementDefinition.findMany({
      where: { isActive: true },
    });
    if (defs.length === 0) {
      return;
    }

    const metrics = await this.computeMetrics(tx, userId);

    for (const def of defs) {
      const current = metrics[def.metric] ?? 0;
      const unlocked = current >= def.targetCount;
      const existing = await tx.userAchievementProgress.findUnique({
        where: {
          userId_achievementId: {
            userId,
            achievementId: def.id,
          },
        },
      });
      if (existing) {
        await tx.userAchievementProgress.update({
          where: { id: existing.id },
          data: {
            currentCount: current,
            unlockedAt: unlocked
              ? (existing.unlockedAt ?? new Date())
              : null,
          },
        });
      } else {
        await tx.userAchievementProgress.create({
          data: {
            userId,
            achievementId: def.id,
            currentCount: current,
            unlockedAt: unlocked ? new Date() : null,
          },
        });
      }
    }
  }

  private async computeMetrics(
    tx: Tx,
    userId: string,
  ): Promise<Record<string, number>> {
    const checkins = await tx.tripCheckin.findMany({
      where: { userId },
      select: {
        placeId: true,
        place: { select: { city: true, category: true } },
      },
    });

    const food = new Set<string>();
    const culture = new Set<string>();
    const nature = new Set<string>();
    const cities = new Set<string>();

    for (const row of checkins) {
      const cat = String(row.place.category).toUpperCase();
      cities.add(row.place.city.trim().toLowerCase());
      if ((FOOD_PLACE_CATEGORIES as readonly string[]).includes(cat)) {
        food.add(row.placeId);
      }
      if ((CULTURE_PLACE_CATEGORIES as readonly string[]).includes(cat)) {
        culture.add(row.placeId);
      }
      if ((NATURE_PLACE_CATEGORIES as readonly string[]).includes(cat)) {
        nature.add(row.placeId);
      }
    }

    const memories = await tx.tripMedia.count({
      where: { media: { userId } },
    });

    return {
      FOOD_CHECKINS: food.size,
      CULTURE_CHECKINS: culture.size,
      NATURE_CHECKINS: nature.size,
      DISTINCT_CITIES: [...cities].filter(Boolean).length,
      MEMORIES: memories,
    };
  }

  private async countDistinctCities(
    tx: Tx | PrismaService,
    userId: string,
  ): Promise<number> {
    const rows = await tx.tripCheckin.findMany({
      where: { userId },
      select: { place: { select: { city: true } } },
    });
    return new Set(
      rows
        .map((r) => r.place.city.trim().toLowerCase())
        .filter((c) => c.length > 0),
    ).size;
  }

  private mapTier(row: {
    tierCode: TRAVEL_TIER_CODE;
    multiplier: Prisma.Decimal | number;
    tripsCompleted: number;
    distinctCities: number;
  }): TravelTierDto {
    return {
      code: row.tierCode,
      label: TIER_LABELS[row.tierCode],
      multiplier: Number(row.multiplier),
      tripsCompleted: row.tripsCompleted,
      distinctCities: row.distinctCities,
      next: nextTier(row.tierCode, row.tripsCompleted, row.distinctCities),
    };
  }
}

/** Exported for unit tests. */
export function resolveTravelTierForTest(
  tripsCompleted: number,
  distinctCities: number,
) {
  return resolveTier(tripsCompleted, distinctCities);
}

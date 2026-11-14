import { Injectable } from '@nestjs/common';
import { Prisma } from '../../../../generated/prisma/client';
import {
  TRIP_MISSION_SCOPE,
  TRIP_MISSION_VERIFY,
} from '../../../../generated/prisma/enums';
import { PrismaService } from '../../../../prisma.service';
import {
  CheckinEvidence,
  VerifyPayload,
  computeMissionProgress,
} from './trip-mission-verify';
import { MISSION_POINTS_CAP } from './trip-mission.constants';

type Tx = Prisma.TransactionClient;

export type MissionProgressSnapshot = {
  instanceId: string;
  code: string;
  pointsReward: number;
  scope: string;
  currentCount: number;
  targetCount: number;
  completed: boolean;
  completedAt: Date | null;
  claimedInCompletion: boolean;
};

@Injectable()
export class TripMissionProgressService {
  constructor(private readonly prisma: PrismaService) {}

  async recomputeForMember(
    tripId: string,
    userId: string,
    memberId: string,
    tx: Tx = this.prisma,
  ): Promise<MissionProgressSnapshot[]> {
    const instances = await tx.tripMissionInstance.findMany({
      where: { tripId },
      orderBy: [{ sortOrder: 'asc' }, { createdAt: 'asc' }],
    });
    if (instances.length === 0) {
      return [];
    }

    const [checkins, historicalCities, memoryCount, distinctPlaces] =
      await Promise.all([
        this.loadCheckinEvidence(tx, tripId, userId),
        this.loadHistoricalCities(tx, userId, tripId),
        this.countMemories(tx, tripId, userId),
        tx.itineraryItem.findMany({
          where: { tripId },
          distinct: ['placeId'],
          select: { placeId: true },
        }),
      ]);

    const snapshots: MissionProgressSnapshot[] = [];

    for (const instance of instances) {
      const currentCount = computeMissionProgress({
        verifyType: instance.verifyType,
        verifyPayload: instance.verifyPayload as VerifyPayload,
        targetCount: instance.targetCount,
        itineraryPlaceCount: distinctPlaces.length,
        checkins,
        historicalCities,
        memoryCount,
      });

      const completed = currentCount >= instance.targetCount;
      const existing = await tx.tripMissionProgress.findUnique({
        where: {
          instanceId_memberId: {
            instanceId: instance.id,
            memberId,
          },
        },
      });

      const row = existing
        ? await tx.tripMissionProgress.update({
            where: { id: existing.id },
            data: {
              currentCount,
              completedAt: completed
                ? (existing.completedAt ?? new Date())
                : null,
            },
          })
        : await tx.tripMissionProgress.create({
            data: {
              instanceId: instance.id,
              memberId,
              userId,
              currentCount,
              completedAt: completed ? new Date() : null,
            },
          });

      snapshots.push({
        instanceId: instance.id,
        code: instance.code,
        pointsReward: instance.pointsReward,
        scope: instance.scope,
        currentCount: row.currentCount,
        targetCount: instance.targetCount,
        completed: row.completedAt != null,
        completedAt: row.completedAt,
        claimedInCompletion: row.claimedInCompletion,
      });
    }

    return snapshots;
  }

  async recomputeFromCheckin(checkinId: string): Promise<void> {
    const checkin = await this.prisma.tripCheckin.findUnique({
      where: { id: checkinId },
      select: { tripId: true, userId: true, memberId: true },
    });
    if (!checkin) {
      return;
    }
    const hasInstances = await this.prisma.tripMissionInstance.count({
      where: { tripId: checkin.tripId },
    });
    if (hasInstances === 0) {
      return;
    }
    await this.recomputeForMember(
      checkin.tripId,
      checkin.userId,
      checkin.memberId,
    );
  }

  async recomputeFromMemories(
    tripId: string,
    memoryIds: string[],
  ): Promise<void> {
    if (memoryIds.length === 0) {
      return;
    }
    const memory = await this.prisma.tripMedia.findFirst({
      where: { id: { in: memoryIds }, tripId },
      select: {
        media: { select: { userId: true } },
      },
    });
    const userId = memory?.media.userId;
    if (!userId) {
      return;
    }
    const member = await this.prisma.tripMember.findUnique({
      where: { tripId_userId: { tripId, userId } },
      select: { id: true },
    });
    if (!member) {
      return;
    }
    const hasInstances = await this.prisma.tripMissionInstance.count({
      where: { tripId },
    });
    if (hasInstances === 0) {
      return;
    }
    await this.recomputeForMember(tripId, userId, member.id);
  }

  sumMissionPoints(snapshots: MissionProgressSnapshot[]): number {
    const earned = snapshots
      .filter(
        (s) =>
          s.completed &&
          s.scope === TRIP_MISSION_SCOPE.PERSONAL,
      )
      .reduce((sum, s) => sum + s.pointsReward, 0);
    return Math.min(MISSION_POINTS_CAP, earned);
  }

  async markClaimed(
    tx: Tx,
    tripId: string,
    memberId: string,
  ): Promise<void> {
    const instances = await tx.tripMissionInstance.findMany({
      where: { tripId },
      select: { id: true },
    });
    if (instances.length === 0) {
      return;
    }
    await tx.tripMissionProgress.updateMany({
      where: {
        memberId,
        instanceId: { in: instances.map((i) => i.id) },
        completedAt: { not: null },
      },
      data: { claimedInCompletion: true },
    });
  }

  private async loadCheckinEvidence(
    tx: Tx,
    tripId: string,
    userId: string,
  ): Promise<CheckinEvidence[]> {
    const rows = await tx.tripCheckin.findMany({
      where: { tripId, userId },
      select: {
        placeId: true,
        place: { select: { city: true, category: true } },
      },
    });
    return rows.map((row) => ({
      placeId: row.placeId,
      city: row.place.city,
      category: row.place.category,
    }));
  }

  private async loadHistoricalCities(
    tx: Tx,
    userId: string,
    excludeTripId: string,
  ): Promise<Set<string>> {
    const rows = await tx.tripCheckin.findMany({
      where: {
        userId,
        tripId: { not: excludeTripId },
      },
      select: { place: { select: { city: true } } },
      distinct: ['placeId'],
    });
    return new Set(
      rows
        .map((r) => r.place.city.trim().toLowerCase())
        .filter((c) => c.length > 0),
    );
  }

  private async countMemories(
    tx: Tx,
    tripId: string,
    userId: string,
  ): Promise<number> {
    return tx.tripMedia.count({
      where: {
        tripId,
        media: { userId },
      },
    });
  }
}

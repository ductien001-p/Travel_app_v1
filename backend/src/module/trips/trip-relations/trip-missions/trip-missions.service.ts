import { Injectable } from '@nestjs/common';
import { Prisma } from '../../../../generated/prisma/client';
import {
  TRIP_MISSION_GROUP,
  TRIP_MISSION_SCOPE,
  TRIP_MISSION_VERIFY,
} from '../../../../generated/prisma/enums';
import { PrismaService } from '../../../../prisma.service';
import { TripAccessPolicy } from '../../policies';
import {
  MISSION_POINTS_CAP,
  missionCtaForVerify,
} from './trip-mission.constants';
import { planTripMissions, SeedTemplate } from './trip-mission-seed';
import { TripMissionProgressService } from './trip-mission-progress.service';
import {
  TripDetailMissionsPreviewDto,
  TripMissionItemDto,
  TripMissionsPageDto,
} from './dto/trip-mission-response.dto';

type Tx = Prisma.TransactionClient;

@Injectable()
export class TripMissionsService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly progressService: TripMissionProgressService,
  ) {}

  async listForViewer(
    tripId: string,
    userId: string,
  ): Promise<TripMissionsPageDto> {
    const member = await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'READ',
    );
    await this.ensureSeeded(tripId, userId);
    const snapshots = await this.progressService.recomputeForMember(
      tripId,
      userId,
      member.id,
    );
    return this.buildPage(tripId, snapshots);
  }

  async getPreviewForMember(
    tripId: string,
    userId: string,
    memberId: string,
  ): Promise<TripDetailMissionsPreviewDto | null> {
    await this.ensureSeeded(tripId, userId);
    const snapshots = await this.progressService.recomputeForMember(
      tripId,
      userId,
      memberId,
    );
    const page = await this.buildPage(tripId, snapshots);
    return {
      completedCount: page.completedCount,
      totalCount: page.totalCount,
      missionPointsPending: page.missionPointsPending,
      missionPointsCap: page.missionPointsCap,
      items: page.items,
    };
  }

  /**
   * Idempotent seed of mission instances for a trip.
   * Safe to call from GET, trip detail, or completion.
   */
  async ensureSeeded(
    tripId: string,
    userId: string,
    tx: Tx = this.prisma,
  ): Promise<void> {
    const existing = await tx.tripMissionInstance.count({ where: { tripId } });
    if (existing > 0) {
      return;
    }

    const [templates, itineraryPlaces, historicalCities] = await Promise.all([
      tx.tripMissionTemplate.findMany({
        where: { isActive: true },
        include: { seedRules: true },
        orderBy: { sortOrder: 'asc' },
      }),
      tx.itineraryItem.findMany({
        where: { tripId },
        distinct: ['placeId'],
        select: {
          placeId: true,
          place: { select: { city: true, category: true } },
        },
      }),
      this.loadHistoricalCities(tx, userId, tripId),
    ]);

    if (templates.length === 0) {
      return;
    }

    const itineraryCategories = new Set(
      itineraryPlaces.map((p) => String(p.place.category).toUpperCase()),
    );
    const itineraryCities = new Set(
      itineraryPlaces.map((p) => p.place.city.trim().toLowerCase()).filter(Boolean),
    );

    const plan = planTripMissions(templates as SeedTemplate[], {
      itineraryPlaceCount: itineraryPlaces.length,
      itineraryCategories,
      itineraryCities,
      historicalCities,
    });

    if (plan.length === 0) {
      return;
    }

    try {
      await tx.tripMissionInstance.createMany({
        data: plan.map((item) => ({
          tripId,
          templateId: item.templateId,
          code: item.code,
          group: item.group as TRIP_MISSION_GROUP,
          title: item.title,
          subtitle: item.subtitle,
          icon: item.icon,
          verifyType: item.verifyType as TRIP_MISSION_VERIFY,
          verifyPayload: item.verifyPayload as Prisma.InputJsonValue,
          targetCount: item.targetCount,
          pointsReward: item.pointsReward,
          scope: item.scope as TRIP_MISSION_SCOPE,
          sortOrder: item.sortOrder,
        })),
        skipDuplicates: true,
      });
    } catch (error) {
      if (
        error instanceof Prisma.PrismaClientKnownRequestError &&
        error.code === 'P2002'
      ) {
        return;
      }
      throw error;
    }
  }

  async settleForCompletion(
    tx: Tx,
    tripId: string,
    userId: string,
    memberId: string,
  ): Promise<{
    missionPoints: number;
    missionsCompleted: number;
    snapshots: Awaited<
      ReturnType<TripMissionProgressService['recomputeForMember']>
    >;
  }> {
    await this.ensureSeeded(tripId, userId, tx);
    const snapshots = await this.progressService.recomputeForMember(
      tripId,
      userId,
      memberId,
      tx,
    );
    const missionPoints = this.progressService.sumMissionPoints(snapshots);
    const missionsCompleted = snapshots.filter((s) => s.completed).length;
    await this.progressService.markClaimed(tx, tripId, memberId);
    return { missionPoints, missionsCompleted, snapshots };
  }

  private async buildPage(
    tripId: string,
    snapshots: Awaited<
      ReturnType<TripMissionProgressService['recomputeForMember']>
    >,
  ): Promise<TripMissionsPageDto> {
    const instances = await this.prisma.tripMissionInstance.findMany({
      where: { tripId },
      orderBy: [{ sortOrder: 'asc' }, { createdAt: 'asc' }],
    });
    const byId = new Map(snapshots.map((s) => [s.instanceId, s]));

    const items: TripMissionItemDto[] = instances.map((instance) => {
      const snap = byId.get(instance.id);
      const progressCurrent = snap?.currentCount ?? 0;
      const completed = snap?.completed ?? false;
      return {
        id: instance.id,
        code: instance.code,
        group: instance.group,
        title: instance.title,
        subtitle: instance.subtitle,
        icon: instance.icon,
        verifyType: instance.verifyType,
        pointsReward: instance.pointsReward,
        progressCurrent,
        progressTarget: instance.targetCount,
        completed,
        cta: missionCtaForVerify(instance.verifyType),
      };
    });

    const completedCount = items.filter((i) => i.completed).length;
    const rawEarned = items
      .filter((i) => i.completed)
      .reduce((sum, i) => sum + i.pointsReward, 0);

    return {
      completedCount,
      totalCount: items.length,
      missionPointsEarned: rawEarned,
      missionPointsCap: MISSION_POINTS_CAP,
      missionPointsPending: Math.min(MISSION_POINTS_CAP, rawEarned),
      items,
    };
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
    });
    return new Set(
      rows
        .map((r) => r.place.city.trim().toLowerCase())
        .filter((c) => c.length > 0),
    );
  }
}

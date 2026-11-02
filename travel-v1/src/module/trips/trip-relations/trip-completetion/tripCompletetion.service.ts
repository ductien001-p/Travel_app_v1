import {
  BadRequestException,
  ConflictException,
  Injectable,
} from '@nestjs/common';

import { PrismaService } from '../../../../prisma.service';

import { MEMBER_STATUS, TRIP_STATUS } from '../../../../generated/prisma/enums';

import { Prisma } from '../../../../generated/prisma/client';
import { TimePolicy, TripAccessPolicy, TripPolicy } from '../../policies';
import { lockTripRow } from '../../trip-lock';
import { RankingService } from '../../../ranking/ranking.service';
import {
  completionPoints,
  countCompletionProgress,
} from './completion-progress';

@Injectable()
export class TripCompletionService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly rankingService: RankingService,
  ) {}

  async completeTrip(tripId: string, userId: string) {
    // The trip row lock serializes concurrent completions and check-in changes,
    // so the threshold and "everyone completed" checks see consistent data.
    const result = await this.prisma.$transaction(async (tx) => {
      // =========================================================
      // 1. ACTIVE MEMBER
      // =========================================================
      const member = await TripAccessPolicy.authorize(
        tx,
        tripId,
        userId,
        'COMPLETE_TRIP',
      );

      await lockTripRow(tx, tripId);

      // =========================================================
      // 2. TRIP MUST HAVE STARTED
      // =========================================================
      const trip = await tx.trip.findUniqueOrThrow({
        where: { id: tripId },
        select: {
          status: true,
          startDate: true,
        },
      });
      TripPolicy.assertStarted(
        { status: trip.status, startDate: toIsoDate(trip.startDate) },
        TimePolicy.today(),
      );

      // =========================================================
      // 3. EXISTING COMPLETION
      // =========================================================
      const existing = await tx.tripCompletion.findUnique({
        where: { memberId: member.id },
        select: { id: true },
      });
      if (existing) {
        throw new ConflictException('You have already completed this trip');
      }

      // =========================================================
      // 4. CHECK-IN THRESHOLD
      // =========================================================
      const { totalPlaces, checkinCount } = await countCompletionProgress(
        tx,
        tripId,
        userId,
      );
      if (totalPlaces === 0) {
        throw new BadRequestException('This trip has no itinerary items');
      }
      try {
        TripPolicy.assertCompletionThreshold(checkinCount, totalPlaces);
      } catch {
        throw new BadRequestException(
          `You need to check in at least 50% of the trip's places to complete the trip. ` +
            `Current progress: ${checkinCount}/${totalPlaces}`,
        );
      }

      // =========================================================
      // 5. PERSIST + STATUS TRANSITIONS
      // =========================================================
      const completion = await tx.tripCompletion.create({
        data: {
          memberId: member.id,
          tripId,
          pointsAwarded: completionPoints(checkinCount),
        },
      });

      let status = trip.status;
      if (status === TRIP_STATUS.UPCOMING) {
        TripPolicy.assertStatusTransition(status, TRIP_STATUS.ONGOING);
        status = TRIP_STATUS.ONGOING;
      }
      if (await this.isTripCompletedStatus(tx, tripId)) {
        TripPolicy.assertStatusTransition(status, TRIP_STATUS.COMPLETED);
        status = TRIP_STATUS.COMPLETED;
      }
      if (status !== trip.status) {
        await tx.trip.update({ where: { id: tripId }, data: { status } });
      }

      // Same transaction as the completion, so points can never be lost or
      // awarded twice.
      await this.rankingService.awardTripCompletion(
        tx,
        userId,
        completion.pointsAwarded,
      );

      return { completion, totalPlaces, checkinCount };
    });

    // =========================================================
    // 6. PUBLIC RESPONSE DATA
    // =========================================================
    return {
      tripId,
      userId,

      totalPlaces: result.totalPlaces,
      totalCheckins: result.checkinCount,

      completionPercent: Math.round(
        (result.checkinCount / result.totalPlaces) * 100,
      ),

      pointsAwarded: result.completion.pointsAwarded,

      completion: result.completion,
    };
  }

  private async isTripCompletedStatus(
    tx: Prisma.TransactionClient,
    tripId: string,
  ): Promise<boolean> {
    const activeMemberCount = await tx.tripMember.count({
      where: {
        tripId,
        status: MEMBER_STATUS.ACTIVE,
      },
    });

    if (activeMemberCount === 0) {
      return false;
    }

    const completionCount = await tx.tripCompletion.count({
      where: {
        tripId,

        member: {
          status: MEMBER_STATUS.ACTIVE,
        },
      },
    });

    return activeMemberCount === completionCount;
  }
}

function toIsoDate(date: Date): string {
  return date.toISOString().slice(0, 10);
}

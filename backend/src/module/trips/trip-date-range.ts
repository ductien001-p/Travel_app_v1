import { BadRequestException } from '@nestjs/common';
import { Prisma } from '../../generated/prisma/client';
import {
  JOIN_REQUEST_STATUS,
  MEMBER_STATUS,
  NOTIFICATION_TYPE,
  TRIP_STATUS,
} from '../../generated/prisma/enums';
import {
  hasPublishLeadTime,
  isActiveRecruitment,
  recruitmentExpiresAt,
} from './trip-relations/trip-recruitment/recruitment.policy';

/** Trip dates are required columns, so drafts without destinations use this. */
export const DRAFT_PLACEHOLDER_DATE = new Date(0);

export function tripDateRange(
  sortedDestinations: Array<{ startDate: Date; endDate: Date }>,
) {
  if (sortedDestinations.length === 0) {
    return {
      startDate: DRAFT_PLACEHOLDER_DATE,
      endDate: DRAFT_PLACEHOLDER_DATE,
    };
  }
  return {
    startDate: sortedDestinations[0].startDate,
    endDate: sortedDestinations[sortedDestinations.length - 1].endDate,
  };
}

type DatedStop = { id: string; startDate: Date; endDate: Date };

/**
 * The only writer of Trip.startDate and Trip.endDate after a trip exists.
 * Callers compute the next stop list with tripDateRange's inputs and pass
 * the stops from before the mutation so a pure activity edit never lands here.
 */
export async function applyTripDateRange(
  tx: Prisma.TransactionClient,
  input: {
    trip: {
      id: string;
      name: string;
      status: TRIP_STATUS;
      startDate: Date;
      endDate: Date;
      ownerId: string | null;
    };
    previousDestinations: DatedStop[];
    nextDestinations: DatedStop[];
    acknowledgeRecruitmentImpact?: boolean;
    actorId: string;
    now?: Date;
  },
): Promise<{ startDate: Date; endDate: Date }> {
  const now = input.now ?? new Date();
  const range = tripDateRange(input.nextDestinations);
  const recruitment = await tx.tripRecruitment.findUnique({
    where: { tripId: input.trip.id },
    select: { state: true, expiresAt: true },
  });
  const destinationSetChanged = !sameIdSet(
    input.previousDestinations,
    input.nextDestinations,
  );
  const datesChanged =
    input.trip.startDate.getTime() !== range.startDate.getTime() ||
    input.trip.endDate.getTime() !== range.endDate.getTime() ||
    !sameStopDates(input.previousDestinations, input.nextDestinations);
  const active = isActiveRecruitment(recruitment, input.trip.status, now);
  let nextExpiresAt: Date | null = null;

  if (active && (destinationSetChanged || datesChanged)) {
    if (!input.acknowledgeRecruitmentImpact) {
      throw new BadRequestException({
        code: 'RECRUITMENT_IMPACT_ACK_REQUIRED',
        message:
          'Confirm the change before moving dates or destinations on an open recruitment',
      });
    }
    if (!hasPublishLeadTime(range.startDate, now)) {
      throw new BadRequestException({
        code: 'START_TOO_SOON',
        message:
          'An open recruitment must keep at least 48 hours before departure',
      });
    }
    nextExpiresAt = recruitmentExpiresAt(range.startDate);
    await tx.tripRecruitment.update({
      where: { tripId: input.trip.id },
      data: { expiresAt: nextExpiresAt },
    });
    await notifyRecruitmentDateChange(tx, {
      tripId: input.trip.id,
      tripName: input.trip.name,
      actorId: input.actorId,
      expiresAt: nextExpiresAt,
    });
  }

  await tx.trip.update({
    where: { id: input.trip.id },
    data: {
      startDate: range.startDate,
      endDate: range.endDate,
    },
  });

  return range;
}

function sameIdSet(previous: DatedStop[], next: DatedStop[]): boolean {
  const left = previous.map((stop) => stop.id).sort();
  const right = next.map((stop) => stop.id).sort();
  return (
    left.length === right.length &&
    left.every((id, index) => id === right[index])
  );
}

function sameStopDates(previous: DatedStop[], next: DatedStop[]): boolean {
  if (previous.length !== next.length) return false;
  const nextById = new Map(next.map((stop) => [stop.id, stop]));
  return previous.every((stop) => {
    const match = nextById.get(stop.id);
    return (
      match !== undefined &&
      match.startDate.getTime() === stop.startDate.getTime() &&
      match.endDate.getTime() === stop.endDate.getTime()
    );
  });
}

async function notifyRecruitmentDateChange(
  tx: Prisma.TransactionClient,
  input: {
    tripId: string;
    tripName: string;
    actorId: string;
    expiresAt: Date;
  },
): Promise<void> {
  const [members, requests] = await Promise.all([
    tx.tripMember.findMany({
      where: { tripId: input.tripId, status: MEMBER_STATUS.ACTIVE },
      select: { userId: true },
    }),
    tx.tripJoinRequest.findMany({
      where: { tripId: input.tripId, status: JOIN_REQUEST_STATUS.PENDING },
      select: { requesterId: true },
    }),
  ]);
  const userIds = [
    ...new Set([
      ...members.map((member) => member.userId),
      ...requests.map((request) => request.requesterId),
    ]),
  ];
  if (userIds.length === 0) return;
  const message = `Lịch trình "${input.tripName}" vừa đổi ngày. Bài tuyển hết hạn lúc ${input.expiresAt.toISOString()}.`;
  await tx.notification.createMany({
    data: userIds.map((userId) => ({
      userId,
      actorId: input.actorId,
      tripId: input.tripId,
      type: NOTIFICATION_TYPE.TRIP_RECRUITMENT_DATES_CHANGED,
      title: 'Ngày chuyến đi đã đổi',
      message,
    })),
  });
}

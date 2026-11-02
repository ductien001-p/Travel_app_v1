import { Prisma } from '../../../../generated/prisma/client';
import {
  MEMBER_STATUS,
  RECRUITMENT_STATE,
  TRIP_STATUS,
} from '../../../../generated/prisma/enums';
import { isActiveRecruitment } from './recruitment.policy';

/**
 * Runs inside a transaction that already holds the trip row lock.
 * Only an unexpired OPEN/FULL post on an UPCOMING trip moves between
 * OPEN and FULL. Closed, unpublished, expired, and non-upcoming posts stay.
 */
export async function reconcileRecruitmentState(
  tx: Prisma.TransactionClient,
  tripId: string,
  now: Date = new Date(),
): Promise<RECRUITMENT_STATE | null> {
  const recruitment = await tx.tripRecruitment.findUnique({
    where: { tripId },
    select: {
      state: true,
      expiresAt: true,
      trip: { select: { status: true, maxMembers: true } },
    },
  });
  if (!recruitment) return null;
  if (
    !isActiveRecruitment(
      recruitment,
      recruitment.trip.status,
      now,
    )
  ) {
    return recruitment.state;
  }

  const activeMemberCount = await tx.tripMember.count({
    where: { tripId, status: MEMBER_STATUS.ACTIVE },
  });
  const next =
    activeMemberCount >= recruitment.trip.maxMembers
      ? RECRUITMENT_STATE.FULL
      : RECRUITMENT_STATE.OPEN;
  if (next === recruitment.state) return recruitment.state;
  if (recruitment.trip.status !== TRIP_STATUS.UPCOMING) {
    return recruitment.state;
  }

  await tx.tripRecruitment.update({
    where: { tripId },
    data: { state: next },
  });
  return next;
}

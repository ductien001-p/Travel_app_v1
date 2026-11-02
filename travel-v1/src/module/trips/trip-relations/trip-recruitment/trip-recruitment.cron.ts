import { Injectable } from '@nestjs/common';
import { Cron } from '@nestjs/schedule';
import { DateTime } from 'luxon';
import { Prisma } from '../../../../generated/prisma/client';
import {
  JOIN_REQUEST_STATUS,
  NOTIFICATION_TYPE,
  RECRUITMENT_ORIGIN,
  RECRUITMENT_STATE,
  TRIP_STATUS,
} from '../../../../generated/prisma/enums';
import { PrismaService } from '../../../../prisma.service';
import {
  PUBLISH_WIZARD_DRAFT_TTL_DAYS,
  RECRUITMENT_CRON_LOCK_KEY,
} from './recruitment.constants';
import { idempotencyFreshAfter } from './recruitment.policy';

@Injectable()
export class TripRecruitmentCron {
  constructor(private readonly prisma: PrismaService) {}

  /** Daily UTC pass: expire posts, drop abandoned wizard drafts, drop old keys. */
  @Cron('5 0 * * *', { timeZone: 'UTC' })
  async run(now: Date = new Date()): Promise<void> {
    await this.prisma.$transaction(async (tx) => {
      const locked = await tx.$queryRaw<Array<{ locked: boolean }>>`
        SELECT pg_try_advisory_xact_lock(hashtextextended(${RECRUITMENT_CRON_LOCK_KEY}, 0)) AS locked
      `;
      if (!locked[0]?.locked) return;
      await expireRecruitments(tx, now);
      await deleteAbandonedWizardDrafts(tx, now);
      await deleteExpiredIdempotencyKeys(tx, now);
    });
  }
}

/**
 * Session-level `pg_try_advisory_lock` would stick to a pooled connection.
 * The transaction form releases with the job, and only the instance that
 * updates a row sends the pending-request notification.
 */
export async function expireRecruitments(
  tx: Prisma.TransactionClient,
  now: Date,
): Promise<number> {
  const due = await tx.tripRecruitment.findMany({
    where: {
      state: { in: [RECRUITMENT_STATE.OPEN, RECRUITMENT_STATE.FULL] },
      expiresAt: { lte: now },
    },
    select: {
      tripId: true,
      previousVisibility: true,
      trip: { select: { name: true, ownerId: true } },
    },
  });
  let notified = 0;
  for (const row of due) {
    const updated = await tx.tripRecruitment.updateMany({
      where: {
        tripId: row.tripId,
        state: { in: [RECRUITMENT_STATE.OPEN, RECRUITMENT_STATE.FULL] },
        expiresAt: { lte: now },
      },
      data: { state: RECRUITMENT_STATE.CLOSED, previousVisibility: null },
    });
    if (updated.count !== 1) continue;
    if (row.previousVisibility) {
      await tx.trip.update({
        where: { id: row.tripId },
        data: { visibility: row.previousVisibility },
      });
    }
    const pending = await tx.tripJoinRequest.findMany({
      where: { tripId: row.tripId, status: JOIN_REQUEST_STATUS.PENDING },
      select: { requesterId: true },
    });
    if (pending.length === 0 || !row.trip.ownerId) continue;
    await tx.notification.createMany({
      data: pending.map((request) => ({
        userId: request.requesterId,
        actorId: row.trip.ownerId,
        tripId: row.tripId,
        type: NOTIFICATION_TYPE.TRIP_RECRUITMENT_CLOSED,
        title: 'Bài tuyển đã hết hạn',
        message: `Bài tuyển chuyến "${row.trip.name}" đã đóng vì sắp khởi hành.`,
      })),
    });
    notified += pending.length;
  }
  return notified;
}

export async function deleteAbandonedWizardDrafts(
  tx: Prisma.TransactionClient,
  now: Date,
): Promise<number> {
  const cutoff = DateTime.fromJSDate(now, { zone: 'utc' })
    .toUTC()
    .minus({ days: PUBLISH_WIZARD_DRAFT_TTL_DAYS })
    .toJSDate();
  const result = await tx.trip.deleteMany({
    where: {
      status: TRIP_STATUS.DRAFT,
      updatedAt: { lt: cutoff },
      recruitment: { is: { origin: RECRUITMENT_ORIGIN.PUBLISH_WIZARD } },
      itineraryItems: { none: {} },
    },
  });
  return result.count;
}

export async function deleteExpiredIdempotencyKeys(
  tx: Prisma.TransactionClient,
  now: Date,
): Promise<number> {
  const result = await tx.tripPublishIdempotency.deleteMany({
    where: { createdAt: { lte: idempotencyFreshAfter(now) } },
  });
  return result.count;
}

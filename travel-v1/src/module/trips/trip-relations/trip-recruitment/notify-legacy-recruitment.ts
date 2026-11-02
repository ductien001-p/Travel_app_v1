import { Prisma } from '../../../../generated/prisma/client';
import {
  NOTIFICATION_TYPE,
  RECRUITMENT_ORIGIN,
  RECRUITMENT_STATE,
} from '../../../../generated/prisma/enums';

type LegacyNotifier = {
  tripRecruitment: {
    findMany: (args: {
      where: Prisma.TripRecruitmentWhereInput;
      include: {
        trip: { select: { ownerId: true; name: true } };
      };
    }) => Promise<
      Array<{
        tripId: string;
        trip: { ownerId: string | null; name: string };
      }>
    >;
    update: (args: {
      where: { tripId: string };
      data: { notifiedAt: Date };
    }) => Promise<unknown>;
  };
  notification: {
    create: (args: {
      data: {
        userId: string;
        tripId: string;
        type: NOTIFICATION_TYPE;
        title: string;
        message: string;
      };
    }) => Promise<unknown>;
  };
};

/** One-shot filter. Wizard rows created later never match. */
export const legacyRecruitmentNotificationWhere = {
  origin: RECRUITMENT_ORIGIN.LEGACY_BACKFILL,
  state: RECRUITMENT_STATE.NOT_PUBLISHED,
  notifiedAt: null,
} satisfies Prisma.TripRecruitmentWhereInput;

export async function notifyLegacyRecruitmentGaps(
  prisma: LegacyNotifier,
  now: Date = new Date(),
): Promise<number> {
  const rows = await prisma.tripRecruitment.findMany({
    where: legacyRecruitmentNotificationWhere,
    include: { trip: { select: { ownerId: true, name: true } } },
  });
  let sent = 0;
  for (const row of rows) {
    if (row.trip.ownerId) {
      await prisma.notification.create({
        data: {
          userId: row.trip.ownerId,
          tripId: row.tripId,
          type: NOTIFICATION_TYPE.TRIP_RECRUITMENT_INCOMPLETE,
          title: 'Chuyến đi chưa thể đăng cộng đồng',
          message: `Chuyến "${row.trip.name}" còn thiếu mô tả hoặc ảnh bìa. Bổ sung rồi đăng từ trang Khám phá.`,
        },
      });
      sent += 1;
    }
    await prisma.tripRecruitment.update({
      where: { tripId: row.tripId },
      data: { notifiedAt: now },
    });
  }
  return sent;
}

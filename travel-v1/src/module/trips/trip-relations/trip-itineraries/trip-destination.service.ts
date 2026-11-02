import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';

import { PrismaService } from '../../../../prisma.service';
import {
  addCivilDays,
  diffInCivilDays,
  toCivilDate,
} from '../../../../untils/date.until';
import { Prisma } from '../../../../generated/prisma/client';
import { GalleryStatus } from '../../../../generated/prisma/enums';
import { S3Service } from '../../../../uploads/s3/s3.service';
import { DestinationPolicy, TripAccessPolicy } from '../../policies';
import { lockTripRow } from '../../trip-lock';
import { applyTripDateRange } from '../../trip-date-range';
export const ITINERARY_PLACE_SELECT = {
  id: true,
  name: true,
  description: true,
  category: true,
  city: true,
  country: true,
  address: true,
  latitude: true,
  longitude: true,
  coverImages: {
    where: { status: GalleryStatus.ACTIVE },
    orderBy: [{ isCover: 'desc' }, { score: 'desc' }],
    take: 1,
    select: {
      media: { select: { objectKey: true, deletedAt: true } },
    },
  },
} satisfies Prisma.PlaceSelect;

type DestinationTimelineInput = {
  id?: string;
  startDate: Date;
  endDate: Date;
  order: number;
  city?: string;
  country?: string;
};

@Injectable()
export class TripItinerariesService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
  ) {}

  // =========================================================
  // GET TRIP ITINERARY
  // =========================================================

  async getTripItinerary(tripId: string, userId: string) {
    const member = await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'READ',
    );

    return {
      destinations: await this.loadItineraryDestinations(tripId),
      canManageItinerary: TripAccessPolicy.can(member, 'MANAGE_ITINERARY'),
    };
  }

  /**
   * Full itinerary of a trip without any access check; callers must have
   * authorized the reader (membership or a valid share link) first.
   */
  async loadItineraryDestinations(tripId: string) {
    const destinations = await this.prisma.tripDestination.findMany({
      where: {
        tripId,
      },

      orderBy: {
        order: 'asc',
      },

      include: {
        coverMedia: { select: { objectKey: true, deletedAt: true } },
        itineraryDays: {
          orderBy: {
            dayNumber: 'asc',
          },

          include: {
            activities: {
              orderBy: {
                orderIndex: 'asc',
              },

              include: {
                place: { select: ITINERARY_PLACE_SELECT },
              },
            },
          },
        },
      },
    });

    return destinations.map((destination) => ({
      ...this.withDestinationCover(destination),
      itineraryDays: destination.itineraryDays.map((day) =>
        this.withDaySummary(day),
      ),
    }));
  }

  // =========================================================
  // GET DESTINATION ITINERARY
  // =========================================================

  async getDestinationItinerary(
    tripId: string,
    destinationId: string,
    userId: string,
  ) {
    await TripAccessPolicy.authorize(this.prisma, tripId, userId, 'READ');

    const destination = await this.prisma.tripDestination.findFirst({
      where: {
        id: destinationId,
        tripId,
      },

      include: {
        coverMedia: { select: { objectKey: true, deletedAt: true } },
        itineraryDays: {
          orderBy: {
            dayNumber: 'asc',
          },

          include: {
            activities: {
              orderBy: {
                orderIndex: 'asc',
              },

              include: {
                place: { select: ITINERARY_PLACE_SELECT },
              },
            },
          },
        },
      },
    });

    if (!destination) {
      throw new NotFoundException('Destination not found in this trip');
    }

    return {
      ...this.withDestinationCover(destination),
      itineraryDays: destination.itineraryDays.map((day) =>
        this.withDaySummary(day),
      ),
    };
  }

  // =========================================================
  // CREATE DAYS FOR DESTINATION
  // =========================================================

  /**
   * Dùng khi tạo TripDestination.
   *
   * Destination:
   *   startDate = 2026-09-01
   *   endDate   = 2026-09-03
   *
   * => tự tạo:
   *
   * Day 1 - 2026-09-01
   * Day 2 - 2026-09-02
   * Day 3 - 2026-09-03
   */
  async createDaysForDestination(
    tx: Prisma.TransactionClient,
    tripId: string,
    destinationId: string,
  ) {
    const destination = await tx.tripDestination.findFirst({
      where: {
        id: destinationId,
        tripId,
      },
    });
    const trip = await tx.trip.findUnique({
      where: {
        id: tripId,
      },
      select: {
        id: true,
        startDate: true,
        endDate: true,
      },
    });
    if (!trip) {
      throw new NotFoundException('Trip not found');
    }

    if (!destination) {
      throw new NotFoundException('Destination not found in this trip');
    }

    if (!destination.startDate || !destination.endDate) {
      throw new BadRequestException(
        'Destination must have startDate and endDate',
      );
    }

    DestinationPolicy.validatePersistedDateRange(
      destination.startDate,
      destination.endDate,
    );

    const existingDays = await tx.itineraryDay.findMany({
      where: {
        destinationId,
      },
      orderBy: {
        dayNumber: 'asc',
      },
    });
    // Không tạo lại nếu đã tồn tại
    if (existingDays.length > 0) {
      return existingDays;
    }

    // ==========================================
    // BUILD DAYS
    // ==========================================

    const dayInputs = await this.buildDaysForDestination(
      tx,
      tripId,
      destination,
    );

    if (dayInputs.length === 0) {
      return [];
    }

    // ==========================================
    // CREATE DAYS
    // ==========================================

    await tx.itineraryDay.createMany({
      data: dayInputs.map((day) => ({
        tripId,
        destinationId: day.destinationId,
        dayNumber: day.dayNumber,
        date: day.date,
      })),
    });

    // ==========================================
    // RETURN CREATED DAYS
    // ==========================================

    return tx.itineraryDay.findMany({
      where: {
        destinationId,
      },
      orderBy: {
        dayNumber: 'asc',
      },
    });
  }

  /**
   * Synchronizes days without replacing records whose destination and civil
   * date still exist. This preserves day ids and every relation attached to
   * those days.
   */
  async syncTripItineraryDays(
    tx: Prisma.TransactionClient,
    tripId: string,
    destinations: Array<DestinationTimelineInput & { id: string }>,
  ): Promise<void> {
    const existingDays = await tx.itineraryDay.findMany({
      where: { tripId },
      include: { _count: { select: { activities: true } } },
    });

    const desiredKeys = new Set<string>();
    const missingDays: Array<{ destinationId: string; date: Date }> = [];
    const existingKeys = new Set(
      existingDays.map((day) =>
        this.dayKey(day.destinationId, toCivilDate(day.date)),
      ),
    );

    for (const destination of destinations) {
      for (const date of this.buildDateRange(
        destination.startDate,
        destination.endDate,
      )) {
        const key = this.dayKey(destination.id, date);
        desiredKeys.add(key);
        if (!existingKeys.has(key)) {
          missingDays.push({ destinationId: destination.id, date });
        }
      }
    }

    const daysToDelete = existingDays.filter(
      (day) =>
        !desiredKeys.has(this.dayKey(day.destinationId, toCivilDate(day.date))),
    );

    if (daysToDelete.some((day) => day._count.activities > 0)) {
      throw new BadRequestException({
        code: 'ITINERARY_DAY_HAS_ACTIVITIES',
        message: 'Cannot remove itinerary days because they contain activities',
      });
    }

    if (daysToDelete.length > 0) {
      await tx.itineraryDay.deleteMany({
        where: { id: { in: daysToDelete.map((day) => day.id) } },
      });
    }

    if (missingDays.length > 0) {
      const maxDayNumber = await this.getMaxTripDayNumber(tx, tripId);
      await tx.itineraryDay.createMany({
        data: missingDays.map((day, index) => ({
          tripId,
          destinationId: day.destinationId,
          date: day.date,
          dayNumber: maxDayNumber + index + 1,
        })),
      });
    }

    await this.recalculateTripDayNumbers(tx, tripId);
  }

  // =========================================================
  // DELETE DESTINATION
  // =========================================================

  async deleteDestination(
    tripId: string,
    destinationId: string,
    userId: string,
    acknowledgeRecruitmentImpact = false,
  ) {
    await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'MANAGE_DESTINATIONS',
    );

    await this.prisma.$transaction(async (tx) => {
      // Activity writers take the same lock, so none can land on these days
      // between the check below and the delete.
      if (!(await lockTripRow(tx, tripId))) {
        throw new NotFoundException('Trip not found');
      }

      const destination = await tx.tripDestination.findFirst({
        where: { id: destinationId, tripId },
        select: { id: true },
      });
      if (!destination) {
        throw new NotFoundException('Destination not found in this trip');
      }

      const activityCount = await tx.itineraryItem.count({
        where: { tripId, day: { destinationId } },
      });
      if (activityCount > 0) {
        throw new BadRequestException(
          'Cannot delete a destination that contains itinerary activities',
        );
      }

      const before = await tx.tripDestination.findMany({
        where: { tripId },
        orderBy: { order: 'asc' },
      });
      const trip = await tx.trip.findUniqueOrThrow({
        where: { id: tripId },
        select: {
          id: true,
          name: true,
          status: true,
          startDate: true,
          endDate: true,
          ownerId: true,
        },
      });

      await tx.itineraryDay.deleteMany({
        where: { tripId, destinationId },
      });
      await tx.tripDestination.delete({ where: { id: destinationId } });

      const remaining = await tx.tripDestination.findMany({
        where: { tripId },
        orderBy: { order: 'asc' },
      });
      if (remaining.length === 0) {
        throw new BadRequestException(
          'Trip must have at least one destination',
        );
      }

      await this.recalculateTripDayNumbers(tx, tripId);
      await applyTripDateRange(tx, {
        trip,
        previousDestinations: before,
        nextDestinations: remaining,
        acknowledgeRecruitmentImpact,
        actorId: userId,
      });
    });
  }

  // =========================================================
  // GET DAY
  // =========================================================

  /** The day and its destination, as needed to validate an activity schedule. */
  async getDayOrThrow(
    client: Pick<Prisma.TransactionClient, 'itineraryDay'>,
    tripId: string,
    dayId: string,
  ) {
    const day = await client.itineraryDay.findFirst({
      where: { id: dayId, tripId },
      include: { destination: true },
    });

    if (!day) {
      throw new NotFoundException('Day not found in this trip');
    }

    return day;
  }

  // =========================================================
  // RECALCULATE GLOBAL DAY NUMBER
  // =========================================================

  /**
   * Day number được đánh liên tục trên toàn Trip.
   *
   * Hanoi
   * Day 1
   * Day 2
   *
   * Da Nang
   * Day 3
   * Day 4
   *
   * HCMC
   * Day 5
   */
  async recalculateTripDayNumbers(
    tx: Prisma.TransactionClient,
    tripId: string,
  ) {
    // (tripId, dayNumber) is unique and Postgres checks it per row, so every
    // day is parked on a distinct negative number before the final flip.
    await tx.$executeRaw`
      UPDATE "ItineraryDay" AS day
      SET "dayNumber" = -ranked.position
      FROM (
        SELECT d.id,
          ROW_NUMBER() OVER (
            ORDER BY d."date" ASC, destination."order" ASC, d.id ASC
          ) AS position
        FROM "ItineraryDay" d
        JOIN "TripDestination" destination ON destination.id = d."destinationId"
        WHERE d."tripId" = ${tripId}
      ) AS ranked
      WHERE day.id = ranked.id
    `;
    await tx.$executeRaw`
      UPDATE "ItineraryDay"
      SET "dayNumber" = -"dayNumber"
      WHERE "tripId" = ${tripId} AND "dayNumber" < 0
    `;
  }

  // =========================================================
  // BUILD DAYS
  // =========================================================

  private async buildDaysForDestination(
    tx: Prisma.TransactionClient,
    tripId: string,
    destination: {
      id: string;
      startDate: Date | null;
      endDate: Date | null;
    },
  ) {
    if (!destination.startDate || !destination.endDate) {
      return [];
    }

    const dates = this.buildDateRange(
      destination.startDate,
      destination.endDate,
    );

    const maxDayNumber = await this.getMaxTripDayNumber(tx, tripId);

    return dates.map((date, index) => ({
      tripId,
      destinationId: destination.id,
      dayNumber: maxDayNumber + index + 1,
      date,
    }));
  }
  // =========================================================
  // BUILD DATE RANGE
  // =========================================================
  private buildDateRange(startDate: Date, endDate: Date): Date[] {
    const start = toCivilDate(startDate);
    const end = toCivilDate(endDate);

    const totalDays = diffInCivilDays(start, end);

    if (totalDays <= 0) {
      return [];
    }

    return Array.from({ length: totalDays }, (_, index) =>
      addCivilDays(start, index),
    );
  }

  private dayKey(destinationId: string, date: Date): string {
    return `${destinationId}:${toCivilDate(date).toISOString()}`;
  }

  private withDestinationCover<
    T extends {
      coverMedia?: { objectKey: string; deletedAt: Date | null } | null;
    },
  >(destination: T) {
    const { coverMedia, ...data } = destination;
    return {
      ...data,
      coverImageUrl:
        coverMedia && coverMedia.deletedAt === null
          ? this.s3.getPublicUrl(coverMedia.objectKey)
          : null,
    };
  }

  private withDaySummary<
    T extends {
      activities: Array<{
        estimatedDuration: number | null;
        estimatedCost: { toString(): string } | number | string | null;
      }>;
    },
  >(day: T) {
    const estimatedDurationMinutes = day.activities.reduce(
      (total, item) => total + (item.estimatedDuration ?? 0),
      0,
    );
    const estimatedCost = day.activities
      .reduce(
        (total, item) => total.plus(item.estimatedCost?.toString() ?? 0),
        new Prisma.Decimal(0),
      )
      .toFixed(2);

    return {
      ...day,
      activities: day.activities.map((activity) => {
        const place = 'place' in activity ? activity.place : undefined;
        if (!place || typeof place !== 'object') return activity;
        const typedPlace = place as {
          coverImages?: Array<{
            media: { objectKey: string; deletedAt: Date | null };
          }>;
        };
        const cover = typedPlace.coverImages?.[0]?.media;
        const placeWithoutGallery = { ...typedPlace };
        delete placeWithoutGallery.coverImages;
        return {
          ...activity,
          place: {
            ...placeWithoutGallery,
            imageUrl:
              cover && cover.deletedAt === null
                ? this.s3.getPublicUrl(cover.objectKey)
                : null,
          },
        };
      }),
      summary: {
        activityCount: day.activities.length,
        estimatedDurationMinutes,
        estimatedCost,
      },
    };
  }

  // =========================================================
  // GET MAX DAY NUMBER
  // =========================================================

  private async getMaxTripDayNumber(
    tx: Prisma.TransactionClient,
    tripId: string,
  ): Promise<number> {
    const result = await tx.itineraryDay.aggregate({
      where: {
        tripId,
      },

      _max: {
        dayNumber: true,
      },
    });

    return result._max.dayNumber ?? 0;
  }
}

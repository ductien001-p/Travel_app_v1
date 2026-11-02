import {
  Injectable,
  NotFoundException,
  BadRequestException,
  ConflictException,
} from '@nestjs/common';
import { Prisma } from '../../../../generated/prisma/client';
import type { ItineraryItem } from '../../../../generated/prisma/client';
import {
  MEMBER_STATUS,
  PlaceStatus,
  TIMELINE_EVENT_TYPE,
  TIMELINE_TARGET_TYPE,
  TRIP_STATUS,
} from '../../../../generated/prisma/enums';
import { PrismaService } from '../../../../prisma.service';
import { calculateDistanceMeters } from '../../../../untils/geo.until';
import { CheckinDto } from './dto/checkin-activity.dto';
import { CreateActivityDto } from './dto/create-activity.dto';
import { UpdateActivityDto } from './dto/update-activity.dto';
import {
  ITINERARY_PLACE_SELECT,
  TripItinerariesService,
} from './trip-destination.service';
import { TripTimelineService } from '../trip-timeline/tripTimeline.service';
import { TripGateway } from '../../../../websocket/gateway';
import { EventEmitter2 } from '@nestjs/event-emitter';
import { TripCheckinedEvent } from '../../../../events/trip-checkined.event';
import { CreateItineraryItemsBatchDto } from './dto/create-itinerary-items-batch.dto';
import { ReorderItineraryItemsDto } from './dto/reorder-itinerary-items.dto';
import { ActivityPolicy, TripAccessPolicy } from '../../policies';
import { lockTripRow } from '../../trip-lock';
import { completionPoints } from '../trip-completetion/completion-progress';

const ACTIVITY_INDEX_GAP = 1000;
/** Below this gap, halving again risks float rounding onto a neighbour. */
const MIN_ORDER_INDEX_GAP = 1e-6;
const CHECKIN_RADIUS_METERS = 150;
const CHECKIN_TRIP_STATUSES: readonly TRIP_STATUS[] = [
  TRIP_STATUS.UPCOMING,
  TRIP_STATUS.ONGOING,
];

function activePlaceCoverKey(place: {
  coverImages?: Array<{ media: { objectKey: string; deletedAt: Date | null } }>;
}): string | null {
  const media = place.coverImages?.[0]?.media;
  return media && media.deletedAt === null ? media.objectKey : null;
}

@Injectable()
export class TripItinerariesActivitiesService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly tripItinerariesService: TripItinerariesService,
    private readonly tripGateway: TripGateway,
    private readonly tripTimelineService: TripTimelineService,
    private readonly eventEmitter: EventEmitter2,
  ) {}

  //Logic: user nhap title goi cotroller place searchPlaceEmbeddings, lay placeId tu ket qua search, sau do goi createActivity voi placeId va title
  async createActivity(
    tripId: string,
    dayId: string,
    userId: string,
    dto: CreateActivityDto,
  ) {
    await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'MANAGE_ITINERARY',
    );

    if (dto.insertAfterActivityId && dto.insertBeforeActivityId) {
      throw new BadRequestException(
        'Use either insertAfterActivityId or insertBeforeActivityId, not both',
      );
    }

    const result = await this.prisma.$transaction(async (tx) => {
      if (!dto.placeId?.trim()) {
        throw new BadRequestException('A valid placeId is required');
      }
      await lockTripRow(tx, tripId);
      const day = await this.tripItinerariesService.getDayOrThrow(
        tx,
        tripId,
        dayId,
      );

      const place = await tx.place.findFirst({
        where: { id: dto.placeId, status: PlaceStatus.APPROVED },
        select: { id: true, name: true },
      });
      if (!place) {
        throw new BadRequestException('Place not found or is not approved');
      }

      const title = dto.title?.trim() || place.name.trim();
      if (!title) {
        throw new BadRequestException('Activity title is required');
      }

      const siblings = await tx.itineraryItem.findMany({
        where: { dayId },
        orderBy: { orderIndex: 'asc' },
      });

      if (dto.startTime !== undefined || dto.estimatedDuration !== undefined) {
        ActivityPolicy.validatePersistedSchedule(
          {
            tripId,
            dayId,
            placeId: dto.placeId,
            startTime: dto.startTime,
            estimatedDuration: dto.estimatedDuration,
          },
          day,
          siblings,
        );
      }

      const orderIndex = await this.resolveInsertOrderIndex(
        tx,
        siblings,
        this.resolveInsertPosition(siblings, dto),
      );

      const created = await tx.itineraryItem.create({
        data: {
          dayId,
          tripId,
          placeId: dto.placeId,
          title,
          notes: dto.notes?.trim() || null,
          startTime: dto.startTime ? new Date(dto.startTime) : null,
          estimatedDuration: dto.estimatedDuration,
          estimatedCost: dto.estimatedCost,
          orderIndex,
        },
        include: { place: { select: ITINERARY_PLACE_SELECT } },
      });
      const completedPlaceIds = await this.syncPlacesCompletionStatus(
        tx,
        tripId,
        [created.placeId],
      );
      const activity = {
        ...created,
        isCheckin: completedPlaceIds.has(created.placeId),
      };
      const timelineEvent = await this.tripTimelineService.createEvent(
        tx,
        tripId,
        userId,
        {
          type: TIMELINE_EVENT_TYPE.ACTIVITY_ADDED,
          content: `Đã thêm một hoạt động mới`,
          metadata: {
            activityTitle: created.title,
            placeName: place.name,
            dayNumber: day.dayNumber,
            startTime: created.startTime?.toISOString() ?? null,
          },
          target: { type: TIMELINE_TARGET_TYPE.ACTIVITY, id: created.id },
        },
      );
      return {
        activity,
        timelineEvent,
      };
    });
    this.tripGateway.emitTimelineEvent(tripId, result.timelineEvent);
    return result.activity;
  }

  async updateActivity(
    tripId: string,
    activityId: string,
    dto: UpdateActivityDto,
    userId: string,
  ) {
    await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'MANAGE_ITINERARY',
    );

    if (dto.title !== undefined && !dto.title.trim()) {
      throw new BadRequestException('Activity title cannot be empty');
    }

    const result = await this.prisma.$transaction(async (tx) => {
      await lockTripRow(tx, tripId);
      const activity = await this.getActivityOrThrow(tripId, activityId, tx);

      let normalizedPlaceId: string | undefined;
      if (dto.placeId !== undefined) {
        normalizedPlaceId = dto.placeId.trim();
        if (!normalizedPlaceId) {
          throw new BadRequestException('A valid placeId is required');
        }

        const place = await tx.place.findFirst({
          where: { id: normalizedPlaceId, status: PlaceStatus.APPROVED },
          select: { id: true },
        });
        if (!place) {
          throw new BadRequestException('Place not found or is not approved');
        }

        if (normalizedPlaceId !== activity.placeId) {
          const checkin = await tx.tripCheckin.findFirst({
            where: { activityId },
            select: { id: true },
          });
          ActivityPolicy.assertPlaceMutable(
            {
              id: activity.id,
              tripId,
              dayId: activity.dayId,
              placeId: activity.placeId,
              isCheckin: Boolean(checkin),
            },
            normalizedPlaceId,
          );
        }
      }

      if (dto.startTime !== undefined || dto.estimatedDuration !== undefined) {
        const siblings = await tx.itineraryItem.findMany({
          where: { dayId: activity.dayId },
        });
        ActivityPolicy.validatePersistedSchedule(
          {
            id: activity.id,
            tripId,
            dayId: activity.dayId,
            placeId: normalizedPlaceId ?? activity.placeId,
            startTime:
              dto.startTime === undefined
                ? activity.startTime?.toISOString()
                : dto.startTime,
            estimatedDuration:
              dto.estimatedDuration === undefined
                ? activity.estimatedDuration
                : dto.estimatedDuration,
          },
          activity.day,
          siblings,
        );
      }

      const saved = await tx.itineraryItem.update({
        where: { id: activity.id },
        data: {
          title: dto.title?.trim(),
          notes:
            dto.notes === undefined
              ? undefined
              : dto.notes
                ? dto.notes.trim() || null
                : null,
          startTime:
            dto.startTime === undefined
              ? undefined
              : dto.startTime
                ? new Date(dto.startTime)
                : null,
          estimatedDuration:
            dto.estimatedDuration === undefined
              ? undefined
              : dto.estimatedDuration,
          estimatedCost:
            dto.estimatedCost === undefined ? undefined : dto.estimatedCost,
          placeId: normalizedPlaceId,
        },
        include: { place: { select: ITINERARY_PLACE_SELECT } },
      });

      let updatedActivity = saved;
      if (saved.placeId !== activity.placeId) {
        const completedPlaceIds = await this.syncPlacesCompletionStatus(
          tx,
          tripId,
          [activity.placeId, saved.placeId],
        );
        updatedActivity = {
          ...saved,
          isCheckin: completedPlaceIds.has(saved.placeId),
        };
      }

      const timelineEvent = await this.tripTimelineService.createEvent(
        tx,
        tripId,
        userId,
        {
          type: TIMELINE_EVENT_TYPE.ACTIVITY_UPDATED,
          content: `Đã cập nhật một hoạt động`,
          metadata: {
            activityTitle: saved.title,
            placeName: saved.place?.name ?? null,
            dayNumber: activity.day.dayNumber,
            previousStartTime: activity.startTime?.toISOString() ?? null,
            startTime: saved.startTime?.toISOString() ?? null,
          },
          target: { type: TIMELINE_TARGET_TYPE.ACTIVITY, id: saved.id },
        },
      );
      return {
        updatedActivity,
        timelineEvent,
      };
    });
    this.tripGateway.emitTimelineEvent(tripId, result.timelineEvent);
    return result.updatedActivity;
  }

  async deleteActivity(
    tripId: string,
    activityId: string,
    userId: string,
  ): Promise<void> {
    await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'MANAGE_ITINERARY',
    );

    const activity = await this.getActivityOrThrow(tripId, activityId);

    const result = await this.prisma.$transaction(async (tx) => {
      // No target: the activity no longer exists to be opened.
      const timelineEvent = await this.tripTimelineService.createEvent(
        tx,
        tripId,
        userId,
        {
          type: TIMELINE_EVENT_TYPE.ACTIVITY_DELETED,
          content: 'Đã xóa một hoạt động',
          metadata: {
            activityTitle: activity.title,
            dayNumber: activity.day.dayNumber,
          },
        },
      );

      await tx.itineraryItem.delete({
        where: {
          id: activity.id,
        },
      });

      return {
        timelineEvent,
      };
    });

    this.tripGateway.emitTimelineEvent(tripId, result.timelineEvent);
  }

  // ─────────────────────────────────────────────
  // CHECK-IN
  // ─────────────────────────────────────────────

  async checkin(
    tripId: string,
    activityId: string,
    dto: CheckinDto,
    userId: string,
  ) {
    await TripAccessPolicy.authorize(this.prisma, tripId, userId, 'CHECK_IN');

    const activity = await this.prisma.itineraryItem.findUnique({
      where: { id: activityId },
      include: {
        day: { include: { destination: true } },
        place: { select: ITINERARY_PLACE_SELECT },
        trip: { select: { status: true } },
      },
    });

    if (!activity || activity.day.destination.tripId !== tripId) {
      throw new NotFoundException('Activity not found in this trip');
    }
    if (!CHECKIN_TRIP_STATUSES.includes(activity.trip.status)) {
      throw new ConflictException(
        `Cannot check in while the trip is ${activity.trip.status}`,
      );
    }

    const distance = calculateDistanceMeters(
      dto.latitude,
      dto.longitude,
      activity.place.latitude,
      activity.place.longitude,
    );

    if (distance > CHECKIN_RADIUS_METERS) {
      throw new BadRequestException(
        `You are ${Math.round(distance)}m away from this place. ` +
          `Must be within ${CHECKIN_RADIUS_METERS}m to check in.`,
      );
    }

    const result = await this.prisma.$transaction(async (tx) => {
      await lockTripRow(tx, tripId);
      const member = await tx.tripMember.findUnique({
        where: {
          tripId_userId: {
            tripId,
            userId,
          },
        },
      });

      TripAccessPolicy.assertAllowed(member, 'CHECK_IN');

      // Đã check-in rồi thì báo lỗi rõ ràng (nhờ @@unique constraint)
      const existing = await tx.tripCheckin.findUnique({
        where: {
          tripId_userId_placeId: {
            tripId,
            userId,
            placeId: activity.placeId,
          },
        },
      });
      if (existing) {
        throw new ConflictException('You already checked in to this place');
      }
      let checkin;
      try {
        checkin = await tx.tripCheckin.create({
          data: {
            tripId,
            userId,
            placeId: activity.placeId,
            memberId: member.id,
            activityId,
            latitude: dto.latitude,
            longitude: dto.longitude,
          },
        });
      } catch (error: unknown) {
        if (
          error instanceof Prisma.PrismaClientKnownRequestError &&
          error.code === 'P2002'
        ) {
          throw new ConflictException('You already checked in to this place');
        }
        throw error;
      }
      const allCheckedIn = await this.syncPlaceCompletionStatus(
        tx,
        tripId,
        activity.placeId,
      );
      const timelineEvent = await this.tripTimelineService.createEvent(
        tx,
        tripId,
        userId,
        {
          type: TIMELINE_EVENT_TYPE.ACTIVITY_CHECKIN,
          content: `Đã check-in hoạt động`,
          metadata: {
            activityTitle: activity.title,
            placeName: activity.place.name,
            placeArea: activity.place.city || null,
            latitude: activity.place.latitude,
            longitude: activity.place.longitude,
            placeMediaKey: activePlaceCoverKey(activity.place),
            // Reaching this point means the distance check passed.
            verified: true,
            pointsEarned: completionPoints(1),
          },
          target: { type: TIMELINE_TARGET_TYPE.ACTIVITY, id: activity.id },
        },
      );
      return {
        allCheckedIn,
        checkin,
        timelineEvent,
      };
    });
    this.tripGateway.emitTimelineEvent(tripId, result.timelineEvent);
    this.eventEmitter.emit(
      'trip.checkin',
      new TripCheckinedEvent(result.checkin.id),
    );
    return result.checkin;
  }

  async uncheckin(
    tripId: string,
    activityId: string,
    userId: string,
  ): Promise<void> {
    await TripAccessPolicy.authorize(this.prisma, tripId, userId, 'CHECK_IN');

    const activity = await this.getActivityOrThrow(tripId, activityId);

    const member = await this.prisma.tripMember.findUnique({
      where: {
        tripId_userId: {
          tripId,
          userId,
        },
      },

      select: {
        id: true,
        role: true,
        status: true,
      },
    });

    TripAccessPolicy.assertAllowed(member, 'CHECK_IN');

    await this.prisma.$transaction(async (tx) => {
      await lockTripRow(tx, tripId);
      const existing = await tx.tripCheckin.findUnique({
        where: {
          tripId_userId_placeId: {
            tripId,
            userId,
            placeId: activity.placeId,
          },
        },
      });
      if (!existing) {
        throw new NotFoundException('You have not checked in to this place');
      }
      const completion = await tx.tripCompletion.findUnique({
        where: { memberId: member.id },
        select: { id: true },
      });
      if (completion) {
        throw new ConflictException(
          'Check-ins cannot be removed after completing the trip',
        );
      }

      await tx.tripCheckin.delete({
        where: {
          id: existing.id,
        },
      });

      await this.syncPlaceCompletionStatus(tx, tripId, activity.placeId);
    });
  }

  //Dung khi leave trip hoac hanh dong gi do anh huong den checkin cua cac activity, de dong bo lai trang thai hoan thanh cua tat ca activities trong trip
  async recalculateAllActivitiesCompletion(
    tx: Prisma.TransactionClient,
    tripId: string,
  ) {
    await this.syncPlacesCompletionStatus(tx, tripId);
  }

  async getTripCompletionStatus(tripId: string, userId: string) {
    await TripAccessPolicy.authorize(this.prisma, tripId, userId, 'READ');

    const [items, checkins] = await Promise.all([
      this.prisma.itineraryItem.findMany({
        where: { tripId },
        distinct: ['placeId'],
        select: { placeId: true },
      }),
      this.prisma.tripCheckin.findMany({
        where: { tripId, userId },
        distinct: ['placeId'],
        select: { placeId: true },
      }),
    ]);

    const itineraryPlaceIds = new Set(items.map((item) => item.placeId));
    const checkedPlaceIds = new Set(
      checkins
        .map((checkin) => checkin.placeId)
        .filter((placeId) => itineraryPlaceIds.has(placeId)),
    );
    const totalCount = itineraryPlaceIds.size;
    const completedCount = checkedPlaceIds.size;

    return {
      totalActivities: totalCount,
      completedActivities: completedCount,
      progressPercent:
        totalCount === 0 ? 0 : Math.round((completedCount / totalCount) * 100),
      isTripCompleted: totalCount > 0 && completedCount === totalCount,
    };
  }

  async createItemsBatch(
    tripId: string,
    dto: CreateItineraryItemsBatchDto,
    userId: string,
  ) {
    /*
     * 1. Check permission
     */
    await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'BATCH_ITINERARY',
    );

    const dayIds = [...new Set(dto.items.map((item) => item.dayId))];
    const placeIds = [...new Set(dto.items.map((item) => item.placeId))];

    return this.prisma.$transaction(async (tx) => {
      if (!(await lockTripRow(tx, tripId))) {
        throw new NotFoundException('Trip not found');
      }

      const days = await tx.itineraryDay.findMany({
        where: { id: { in: dayIds }, tripId },
        include: { destination: true },
      });
      const daysById = new Map(days.map((day) => [day.id, day]));
      const invalidDayIds = dayIds.filter((id) => !daysById.has(id));
      if (invalidDayIds.length > 0) {
        throw new BadRequestException({
          message: 'One or more dayIds do not belong to this trip',
          invalidDayIds,
        });
      }

      const places = await tx.place.findMany({
        where: { id: { in: placeIds }, status: PlaceStatus.APPROVED },
        select: { id: true },
      });
      const approvedPlaceIds = new Set(places.map((place) => place.id));
      const invalidPlaceIds = placeIds.filter(
        (id) => !approvedPlaceIds.has(id),
      );
      if (invalidPlaceIds.length > 0) {
        throw new BadRequestException({
          message: 'One or more places are missing or not approved',
          invalidPlaceIds,
        });
      }

      // Each scheduled item is checked against existing activities and the
      // items before it in the same batch, exactly like createActivity.
      const scheduled = await tx.itineraryItem.findMany({
        where: { dayId: { in: dayIds } },
        select: {
          id: true,
          tripId: true,
          dayId: true,
          placeId: true,
          startTime: true,
          estimatedDuration: true,
        },
      });
      for (const [index, item] of dto.items.entries()) {
        if (
          item.startTime === undefined &&
          item.estimatedDuration === undefined
        ) {
          continue;
        }
        const pending = {
          id: `batch-item-${index}`,
          tripId,
          dayId: item.dayId,
          placeId: item.placeId,
        };
        ActivityPolicy.validatePersistedSchedule(
          {
            ...pending,
            startTime: item.startTime,
            estimatedDuration: item.estimatedDuration,
          },
          daysById.get(item.dayId)!,
          scheduled,
        );
        scheduled.push({
          ...pending,
          startTime: item.startTime ? new Date(item.startTime) : null,
          estimatedDuration: item.estimatedDuration ?? null,
        });
      }

      const orderIndexes = await this.assignBatchOrderIndexes(
        tx,
        dayIds,
        dto.items,
      );
      const createdItems: ItineraryItem[] = [];

      for (const [index, item] of dto.items.entries()) {
        const created = await tx.itineraryItem.create({
          data: {
            tripId,

            dayId: item.dayId,

            placeId: item.placeId,

            title: item.title.trim(),

            notes: item.notes?.trim() || null,

            startTime: item.startTime ? new Date(item.startTime) : null,

            estimatedDuration: item.estimatedDuration,

            estimatedCost: item.estimatedCost,

            orderIndex: orderIndexes[index],
          },
          include: { place: { select: ITINERARY_PLACE_SELECT } },
        });

        createdItems.push(created);
      }

      const completedPlaceIds = await this.syncPlacesCompletionStatus(
        tx,
        tripId,
        placeIds,
      );

      return {
        success: true,

        createdCount: createdItems.length,

        items: createdItems.map((item) => ({
          ...item,
          isCheckin: completedPlaceIds.has(item.placeId),
        })),
      };
    });
  }

  async reorderItems(
    tripId: string,
    dayId: string,
    dto: ReorderItineraryItemsDto,
    userId: string,
  ) {
    await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'REORDER_ITINERARY',
    );

    if (new Set(dto.orderedItemIds).size !== dto.orderedItemIds.length) {
      throw new BadRequestException(
        'orderedItemIds must not contain duplicates',
      );
    }

    return this.prisma.$transaction(async (tx) => {
      await lockTripRow(tx, tripId);
      const day = await tx.itineraryDay.findFirst({
        where: { id: dayId, tripId },
        select: { id: true },
      });
      if (!day) {
        throw new NotFoundException('Day not found in this trip');
      }

      const dayItems = await tx.itineraryItem.findMany({
        where: { dayId },
        select: { id: true },
      });
      const dayItemIds = new Set(dayItems.map((item) => item.id));
      const invalidItemIds = dto.orderedItemIds.filter(
        (id) => !dayItemIds.has(id),
      );
      const requestedIds = new Set(dto.orderedItemIds);
      const missingItemIds = dayItems
        .map((item) => item.id)
        .filter((id) => !requestedIds.has(id));

      if (invalidItemIds.length > 0 || missingItemIds.length > 0) {
        throw new BadRequestException({
          message:
            'orderedItemIds must contain every item in this day exactly once',
          invalidItemIds,
          missingItemIds,
        });
      }

      for (const [index, id] of dto.orderedItemIds.entries()) {
        await tx.itineraryItem.update({
          where: { id },
          data: { orderIndex: (index + 1) * ACTIVITY_INDEX_GAP },
        });
      }

      return tx.itineraryItem.findMany({
        where: { dayId },
        orderBy: { orderIndex: 'asc' },
        include: { place: { select: ITINERARY_PLACE_SELECT } },
      });
    });
  }

  //Dung de dong bo 1 activity sau khi checkin/uncheckin, thay vi dong bo tat ca activities nhu recalculateAllActivitiesCompletion
  private async syncPlaceCompletionStatus(
    tx: Prisma.TransactionClient,
    tripId: string,
    placeId: string,
  ) {
    const completed = await this.syncPlacesCompletionStatus(tx, tripId, [
      placeId,
    ]);
    return completed.has(placeId);
  }

  /**
   * Marks activities as checked in when every active member has checked in at
   * their place. Runs a fixed number of queries regardless of place count.
   * Omitting placeIds recalculates every place in the trip.
   */
  private async syncPlacesCompletionStatus(
    tx: Prisma.TransactionClient,
    tripId: string,
    placeIds?: string[],
  ): Promise<Set<string>> {
    const places = placeIds
      ? [...new Set(placeIds)]
      : (
          await tx.itineraryItem.findMany({
            where: { tripId },
            distinct: ['placeId'],
            select: { placeId: true },
          })
        ).map((item) => item.placeId);
    if (places.length === 0) return new Set();

    const activeMembers = await tx.tripMember.findMany({
      where: { tripId, status: MEMBER_STATUS.ACTIVE },
      select: { id: true },
    });
    const checkins = await tx.tripCheckin.findMany({
      where: { tripId, placeId: { in: places } },
      select: { memberId: true, placeId: true },
    });

    const membersByPlace = new Map<string, Set<string>>();
    for (const { placeId, memberId } of checkins) {
      const members = membersByPlace.get(placeId) ?? new Set<string>();
      members.add(memberId);
      membersByPlace.set(placeId, members);
    }

    const completed = new Set(
      places.filter(
        (placeId) =>
          activeMembers.length > 0 &&
          activeMembers.every((member) =>
            membersByPlace.get(placeId)?.has(member.id),
          ),
      ),
    );
    const incomplete = places.filter((placeId) => !completed.has(placeId));

    if (completed.size > 0) {
      await tx.itineraryItem.updateMany({
        where: { tripId, placeId: { in: [...completed] } },
        data: { isCheckin: true },
      });
    }
    if (incomplete.length > 0) {
      await tx.itineraryItem.updateMany({
        where: { tripId, placeId: { in: incomplete } },
        data: { isCheckin: false },
      });
    }

    return completed;
  }

  private async getActivityOrThrow(
    tripId: string,
    activityId: string,
    client: Pick<Prisma.TransactionClient, 'itineraryItem'> = this.prisma,
  ) {
    const activity = await client.itineraryItem.findUnique({
      where: { id: activityId },
      include: { day: { include: { destination: true } } },
    });

    if (!activity || activity.day.destination.tripId !== tripId) {
      throw new NotFoundException('Activity not found in this trip');
    }

    return activity;
  }

  /**
   * Appends batch items after each day's existing activities. The client's
   * orderIndex only orders items within the batch; items without it keep
   * their request order after the ones that have it.
   */
  private async assignBatchOrderIndexes(
    tx: Prisma.TransactionClient,
    dayIds: string[],
    items: Array<{ dayId: string; orderIndex?: number }>,
  ): Promise<number[]> {
    const maxByDay = await tx.itineraryItem.groupBy({
      by: ['dayId'],
      where: { dayId: { in: dayIds } },
      _max: { orderIndex: true },
    });
    const nextByDay = new Map(
      maxByDay.map((group) => [group.dayId, group._max.orderIndex ?? 0]),
    );

    const ordered = items
      .map((item, requestIndex) => ({ item, requestIndex }))
      .sort(
        (a, b) =>
          (a.item.orderIndex ?? Number.POSITIVE_INFINITY) -
            (b.item.orderIndex ?? Number.POSITIVE_INFINITY) ||
          a.requestIndex - b.requestIndex,
      );

    const orderIndexes = new Array<number>(items.length);
    for (const { item, requestIndex } of ordered) {
      const next = (nextByDay.get(item.dayId) ?? 0) + ACTIVITY_INDEX_GAP;
      nextByDay.set(item.dayId, next);
      orderIndexes[requestIndex] = next;
    }
    return orderIndexes;
  }

  /** Index in `siblings` (sorted by orderIndex) where the new activity goes. */
  private resolveInsertPosition(
    siblings: Array<{ id: string }>,
    dto: Pick<
      CreateActivityDto,
      'insertAfterActivityId' | 'insertBeforeActivityId'
    >,
  ): number {
    const anchorId = dto.insertAfterActivityId ?? dto.insertBeforeActivityId;
    if (!anchorId) return siblings.length;

    const anchor = siblings.findIndex((activity) => activity.id === anchorId);
    if (anchor === -1) {
      const field = dto.insertAfterActivityId
        ? 'insertAfterActivityId'
        : 'insertBeforeActivityId';
      throw new BadRequestException(`${field} does not belong to this day`);
    }
    return dto.insertAfterActivityId ? anchor + 1 : anchor;
  }

  /**
   * Picks an orderIndex between the neighbours of `position`. When repeated
   * inserts at one spot have exhausted the float gap there, the whole day is
   * renumbered first so the midpoint is always distinct from both neighbours.
   */
  private async resolveInsertOrderIndex(
    tx: Prisma.TransactionClient,
    siblings: Array<{ id: string; orderIndex: number }>,
    position: number,
  ): Promise<number> {
    const midpoint = this.midpointOrderIndex(siblings, position);
    if (midpoint !== null) return midpoint;

    await this.renumberDay(
      tx,
      siblings.map((activity) => activity.id),
    );
    const renumbered = siblings.map((activity, index) => ({
      ...activity,
      orderIndex: (index + 1) * ACTIVITY_INDEX_GAP,
    }));
    return this.midpointOrderIndex(renumbered, position)!;
  }

  /** Null when the neighbours are too close to fit a distinct index between. */
  private midpointOrderIndex(
    siblings: Array<{ orderIndex: number }>,
    position: number,
  ): number | null {
    const prev = siblings[position - 1]?.orderIndex;
    const next = siblings[position]?.orderIndex;
    if (prev === undefined && next === undefined) return ACTIVITY_INDEX_GAP;
    if (next === undefined) return prev + ACTIVITY_INDEX_GAP;

    const lower = prev ?? 0;
    if (next - lower < MIN_ORDER_INDEX_GAP) return null;
    return (lower + next) / 2;
  }

  private async renumberDay(
    tx: Prisma.TransactionClient,
    orderedActivityIds: string[],
  ): Promise<void> {
    for (const [index, id] of orderedActivityIds.entries()) {
      await tx.itineraryItem.update({
        where: { id },
        data: { orderIndex: (index + 1) * ACTIVITY_INDEX_GAP },
      });
    }
  }
}

import {
  BadRequestException,
  Injectable,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { CreateTripDto } from './dto/create-trip.dto';
import { CreateTripDraftDto } from './dto/create-trip-draft.dto';
import { UpdateTripDto } from './dto/update-trip.dto';
import { QueryTripDto } from './dto/query-trip.dto';
import { PrismaService } from '../../prisma.service';
import {
  MEMBER_STATUS,
  PlaceStatus,
  TIMELINE_EVENT_TYPE,
  TIMELINE_TARGET_TYPE,
  TRIP_ROLE,
  TRIP_STATUS,
} from '../../generated/prisma/enums';
import { Prisma } from '../../generated/prisma/client';
import { TripRoomWS } from './trip-gateway.service';
import { lockTripRow } from './trip-lock';
import { generateInviteCode } from './trip-relations/trip-invitations/invite-code';
import { TripItinerariesService } from './trip-relations/trip-itineraries/trip-destination.service';
import { createPaginationMeta } from '../../common/contracts/pagination-meta.dto';
import { S3Service } from '../../uploads/s3/s3.service';
import { TripInterestService } from './trip-relations/trip-interests/trip-interest.service';
import { TripTimelineService } from './trip-relations/trip-timeline/tripTimeline.service';
import { reconcileRecruitmentState } from './trip-relations/trip-recruitment/recruitment-state';
import { buildCommunityDiscoverWhere } from './trip-discover/trip-discover.where';
import { applyTripDateRange, tripDateRange } from './trip-date-range';
import {
  buildTripReadAccessWhere,
  DestinationPolicy,
  TripAccessPolicy,
  TimePolicy,
  TripInterestPolicy,
  TripPolicy,
  TripResourcePolicy,
} from './policies';

const EDITABLE_TRIP_STATUSES: readonly TRIP_STATUS[] = [
  TRIP_STATUS.DRAFT,
  TRIP_STATUS.UPCOMING,
  TRIP_STATUS.ONGOING,
];

const DELETABLE_TRIP_STATUSES: readonly TRIP_STATUS[] = [
  TRIP_STATUS.DRAFT,
  TRIP_STATUS.UPCOMING,
];

const TRIP_WRITE_INCLUDE = {
  destinations: {
    orderBy: { order: 'asc' },
    include: {
      itineraryDays: {
        orderBy: { dayNumber: 'asc' },
        include: { activities: { orderBy: { orderIndex: 'asc' } } },
      },
    },
  },
  members: true,
  interests: { include: { interest: true } },
} satisfies Prisma.TripInclude;

type PendingPlaceInput = { order: number; pendingPlaceIds?: string[] };

type TripActivityStats = {
  totalActivities: number;
  completedActivities: number;
  checkinCount: number;
  nextActivity: { id: string; title: string; startTime: Date | null } | null;
};

const EMPTY_ACTIVITY_STATS: TripActivityStats = {
  totalActivities: 0,
  completedActivities: 0,
  checkinCount: 0,
  nextActivity: null,
};

function withoutPendingPlaces<T extends { pendingPlaceIds?: string[] }>(
  destination: T,
): Omit<T, 'pendingPlaceIds'> {
  const persistable: Partial<T> = { ...destination };
  delete persistable.pendingPlaceIds;
  return persistable as Omit<T, 'pendingPlaceIds'>;
}

@Injectable()
export class TripsService {
  private readonly logger = new Logger(TripsService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly tripRoomWS: TripRoomWS,
    private readonly tripDestinationService: TripItinerariesService,
    private readonly s3: S3Service,
    private readonly tripInterestService: TripInterestService,
    private readonly tripTimelineService: TripTimelineService,
  ) {}

  async finalizeTrip(tripId: string, userId: string) {
    return this.prisma.$transaction((tx) =>
      this.finalizeDraftInTransaction(tx, tripId, userId),
    );
  }

  /**
   * Draft → UPCOMING writes, including the timeline row. Callers that publish
   * in the same transaction use this instead of finalizeTrip, which commits
   * on its own.
   */
  async finalizeDraftInTransaction(
    tx: Prisma.TransactionClient,
    tripId: string,
    userId: string,
  ) {
    await TripAccessPolicy.authorizeOwner(tx, tripId, userId);
    const trip = await tx.trip.findFirst({
      where: { id: tripId, status: TRIP_STATUS.DRAFT },
      include: { destinations: { orderBy: { order: 'asc' } } },
    });

    if (!trip) {
      throw new NotFoundException('Trip draft not found');
    }

    if (!trip.name?.trim()) {
      throw new BadRequestException({
        code: 'TRIP_NAME_REQUIRED',
        message: 'Trip name is required',
      });
    }

    if (!trip.budgetLevel) {
      throw new BadRequestException({
        code: 'TRIP_BUDGET_REQUIRED',
        message: 'Budget level is required',
      });
    }

    if (trip.destinations.length === 0) {
      throw new BadRequestException({
        code: 'TRIP_DESTINATION_REQUIRED',
        message: 'At least one destination is required',
      });
    }

    DestinationPolicy.validatePersistedTimeline(trip.destinations);
    this.assertTripNotStarted(trip.destinations);
    TripPolicy.assertStatusTransition('DRAFT', 'UPCOMING');

    const { count } = await tx.trip.updateMany({
      where: { id: tripId, status: TRIP_STATUS.DRAFT },
      data: {
        status: TRIP_STATUS.UPCOMING,
        finalizedAt: new Date(),
      },
    });

    if (count === 0) {
      throw new NotFoundException('Trip draft not found');
    }

    await applyTripDateRange(tx, {
      trip: {
        id: trip.id,
        name: trip.name,
        status: TRIP_STATUS.DRAFT,
        startDate: trip.startDate,
        endDate: trip.endDate,
        ownerId: trip.ownerId,
      },
      previousDestinations: trip.destinations,
      nextDestinations: trip.destinations,
      actorId: userId,
    });

    const finalized = await tx.trip.findUniqueOrThrow({
      where: { id: tripId },
      include: TRIP_WRITE_INCLUDE,
    });
    await this.recordTripCreated(tx, finalized, userId);

    return {
      ...finalized,
      tripInterests: finalized.interests.map((item) => item.interest),
    };
  }

  async createTrip(ownerId: string, dto: CreateTripDto) {
    return this.createTripRecord(ownerId, dto, TRIP_STATUS.UPCOMING);
  }

  async createDraft(ownerId: string, dto: CreateTripDraftDto) {
    return this.createTripRecord(ownerId, dto, TRIP_STATUS.DRAFT);
  }

  async getDestinationCatalog(query?: string) {
    const destinations = await this.prisma.destinationCatalog.findMany({
      where: {
        isActive: true,
        ...(query?.trim()
          ? {
              OR: [
                { name: { contains: query.trim(), mode: 'insensitive' } },
                { country: { contains: query.trim(), mode: 'insensitive' } },
              ],
            }
          : {}),
      },
      include: { coverMedia: true },
      orderBy: [{ country: 'asc' }, { name: 'asc' }],
    });

    return destinations.map(({ coverMedia, ...destination }) => ({
      ...destination,
      coverImageUrl:
        coverMedia && coverMedia.deletedAt === null
          ? this.s3.getPublicUrl(coverMedia.objectKey)
          : null,
    }));
  }

  async updateTrip(id: string, userId: string, dto: UpdateTripDto) {
    const {
      addDestinations = [],
      removeDestinationIds = [],
      updateDestinations = [],
      coverMediaId,
      interestIds,
      estimatedBudgetPerPerson,
      budgetCurrency,
      name,
      maxMembers,
      acknowledgeRecruitmentImpact,
      ...tripScalars
    } = dto;

    const removeIds = [...new Set(removeDestinationIds)];
    const updateIds = updateDestinations.map((destination) => destination.id);
    if (new Set(updateIds).size !== updateIds.length) {
      throw new BadRequestException('Destination updates must have unique ids');
    }
    if (updateIds.some((destinationId) => removeIds.includes(destinationId))) {
      throw new BadRequestException(
        'A destination cannot be updated and removed in the same request',
      );
    }

    await TripAccessPolicy.authorizeOwner(this.prisma, id, userId);

    if (coverMediaId) {
      await TripResourcePolicy.assertMediaOwned(
        this.prisma,
        userId,
        coverMediaId,
      );
    }

    const [addInputs, updateInputs] = await Promise.all([
      this.hydrateDestinationSnapshots(addDestinations),
      this.hydrateDestinationSnapshots(updateDestinations),
    ]);

    return this.prisma.$transaction(async (tx) => {
      // Serialises with activity writers before itinerary days are removed.
      await lockTripRow(tx, id);
      const current = await tx.trip.findUniqueOrThrow({
        where: { id },
        select: {
          id: true,
          name: true,
          ownerId: true,
          status: true,
          startDate: true,
          endDate: true,
          estimatedBudgetPerPerson: true,
          budgetCurrency: true,
          _count: {
            select: { members: { where: { status: MEMBER_STATUS.ACTIVE } } },
          },
        },
      });

      this.assertTripEditable(current.status);
      const isDraft = current.status === TRIP_STATUS.DRAFT;

      const trimmedName = name?.trim();
      if (trimmedName === '' && !isDraft) {
        throw new BadRequestException({
          code: 'TRIP_NAME_REQUIRED',
          message: 'Trip name is required',
        });
      }

      if (tripScalars.budgetLevel === null && !isDraft) {
        throw new BadRequestException({
          code: 'TRIP_BUDGET_REQUIRED',
          message: 'Budget level is required',
        });
      }

      if (maxMembers !== undefined && maxMembers < current._count.members) {
        throw new BadRequestException({
          code: 'MAX_MEMBERS_BELOW_ACTIVE',
          message: 'maxMembers cannot be lower than the number of members',
        });
      }

      const budgetData = this.resolveBudgetUpdate(
        current,
        estimatedBudgetPerPerson,
        budgetCurrency,
      );

      const currentDestinations = await tx.tripDestination.findMany({
        where: { tripId: id },
        orderBy: { order: 'asc' },
      });
      const currentIds = new Set(currentDestinations.map((item) => item.id));
      if (
        [...removeIds, ...updateIds].some(
          (destinationId) => !currentIds.has(destinationId),
        )
      ) {
        throw new BadRequestException(
          'One or more destinations do not belong to this trip',
        );
      }

      const updatesById = new Map(
        updateInputs.map((destination) => [destination.id, destination]),
      );
      const finalPreview = [
        ...currentDestinations
          .filter((destination) => !removeIds.includes(destination.id))
          .map((destination) => ({
            ...destination,
            ...updatesById.get(destination.id),
          })),
        ...addInputs.map((destination, index) => ({
          ...destination,
          id: `new-${index}`,
        })),
      ];

      // Drafts may be saved without any destination; finalize enforces it.
      if (!isDraft || finalPreview.length > 0) {
        DestinationPolicy.validatePersistedTimeline(finalPreview);
      }

      const pendingPlaceNames = await this.loadPendingPlaceNames(tx, addInputs);

      const mayReuseOrders = updateInputs.length > 0 || addInputs.length > 0;
      if (mayReuseOrders) {
        await this.parkDestinationOrders(tx, id);
      }

      for (const { id: destinationId, ...data } of updateInputs) {
        await tx.tripDestination.update({
          where: { id: destinationId },
          data,
        });
      }

      if (addInputs.length > 0) {
        await tx.tripDestination.createMany({
          data: addInputs.map((destination) => ({
            tripId: id,
            ...withoutPendingPlaces(destination),
          })),
        });
      }

      if (mayReuseOrders) {
        await this.restoreParkedDestinationOrders(tx, id, removeIds);
      }

      const persistedDestinations = await tx.tripDestination.findMany({
        where: { tripId: id, id: { notIn: removeIds } },
        orderBy: { order: 'asc' },
      });

      await this.tripDestinationService.syncTripItineraryDays(
        tx,
        id,
        persistedDestinations,
      );

      await this.attachPendingPlaces(
        tx,
        id,
        persistedDestinations,
        addInputs,
        pendingPlaceNames,
      );

      if (removeIds.length > 0) {
        await tx.tripDestination.deleteMany({
          where: { tripId: id, id: { in: removeIds } },
        });
      }

      if (interestIds !== undefined) {
        await this.tripInterestService.replaceTripInterests(
          tx,
          id,
          interestIds,
        );
      }

      await applyTripDateRange(tx, {
        trip: {
          id,
          name: trimmedName || current.name,
          status: current.status,
          startDate: current.startDate,
          endDate: current.endDate,
          ownerId: current.ownerId,
        },
        previousDestinations: currentDestinations,
        nextDestinations: persistedDestinations,
        acknowledgeRecruitmentImpact,
        actorId: userId,
      });

      const trip = await tx.trip.update({
        where: { id },
        data: {
          ...tripScalars,
          ...budgetData,
          name: trimmedName,
          maxMembers,
          coverMediaId,
        },
        include: { ...TRIP_WRITE_INCLUDE, coverMedia: true },
      });
      if (maxMembers !== undefined) {
        await reconcileRecruitmentState(tx, id);
      }

      return {
        ...trip,
        tripInterests: trip.interests.map((item) => item.interest),
      };
    });
  }

  async queryTrip(query: QueryTripDto, userId: string) {
    const {
      search,
      status,
      page = 1,
      limit = 20,
      discover,
      destinationCatalogId,
      mine,
      ...filters
    } = query;

    const filterWhere: Prisma.TripWhereInput = {
      ...filters,
      ...(search ? { name: { contains: search, mode: 'insensitive' } } : {}),
      ...(destinationCatalogId
        ? {
            destinations: {
              some: { destinationId: destinationCatalogId },
            },
          }
        : {}),
    };

    const discoverWhere: Prisma.TripWhereInput | undefined = discover
      ? buildCommunityDiscoverWhere(userId, new Date())
      : undefined;

    const accessWhere: Prisma.TripWhereInput = mine
      ? {
          OR: [
            { ownerId: userId },
            {
              members: {
                some: { userId, status: MEMBER_STATUS.ACTIVE },
              },
            },
          ],
        }
      : buildTripReadAccessWhere(userId);

    // Drafts are listed by GET /trips/my-drafts, never in the trip list.
    const baseWhere: Prisma.TripWhereInput = {
      AND: [
        accessWhere,
        { status: { not: TRIP_STATUS.DRAFT } },
        filterWhere,
        ...(discoverWhere ? [discoverWhere] : []),
      ],
    };

    // Discover always pins UPCOMING. Otherwise the status tab only affects
    // the page data, not the summary.
    const listWhere: Prisma.TripWhereInput = discover
      ? baseWhere
      : status
        ? { AND: [baseWhere, { status }] }
        : baseWhere;

    const [trips, total, statusGroups, totalCheckins] =
      await this.prisma.$transaction([
        this.prisma.trip.findMany({
          where: listWhere,
          skip: (page - 1) * limit,
          take: limit,
          orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
          select: {
            id: true,
            name: true,
            description: true,
            startDate: true,
            endDate: true,
            budgetLevel: true,
            maxMembers: true,
            tripType: true,
            visibility: true,
            status: true,
            coverMedia: { select: { objectKey: true, deletedAt: true } },
            owner: {
              select: {
                id: true,
                displayname: true,
                username: true,
                avatar: { select: { objectKey: true, deletedAt: true } },
              },
            },
            _count: {
              select: {
                members: { where: { status: MEMBER_STATUS.ACTIVE } },
              },
            },
            members: {
              where: { status: MEMBER_STATUS.ACTIVE },
              take: 4,
              orderBy: { joinedAt: 'asc' },
              select: {
                id: true,
                user: {
                  select: {
                    username: true,
                    avatar: { select: { objectKey: true, deletedAt: true } },
                  },
                },
              },
            },
            destinations: {
              orderBy: { order: 'asc' },
              select: {
                id: true,
                city: true,
                country: true,
                lat: true,
                lng: true,
                order: true,
                startDate: true,
                endDate: true,
                destinationType: true,
              },
            },
            recruitment: {
              select: {
                state: true,
                expiresAt: true,
                requirements: true,
                estimatedBudgetPerPerson: true,
                urgent: true,
              },
            },
          },
        }),
        this.prisma.trip.count({ where: listWhere }),
        this.prisma.trip.groupBy({
          by: ['status'],
          orderBy: { status: 'asc' },
          where: baseWhere,
          _count: { status: true },
        }),
        this.prisma.tripCheckin.count({
          where: { member: { userId } },
        }),
      ]);

    const summary = {
      total: 0,
      upcoming: 0,
      ongoing: 0,
      completed: 0,
      cancelled: 0,
      notCompleted: 0,
      totalCheckins,
    };

    for (const group of statusGroups) {
      const count =
        typeof group._count === 'object' ? (group._count.status ?? 0) : 0;
      summary.total += count;

      switch (group.status) {
        case TRIP_STATUS.UPCOMING:
          summary.upcoming = count;
          break;
        case TRIP_STATUS.ONGOING:
          summary.ongoing = count;
          break;
        case TRIP_STATUS.COMPLETED:
          summary.completed = count;
          break;
        case TRIP_STATUS.CANCELLED:
          summary.cancelled = count;
          break;
        case TRIP_STATUS.NOTCOMPLETED:
          summary.notCompleted = count;
          break;
      }
    }

    const activityStats = await this.loadActivityStats(
      trips.map((trip) => trip.id),
      new Date(),
    );

    const data = trips.map((trip) => {
      const stats = activityStats.get(trip.id) ?? EMPTY_ACTIVITY_STATS;
      const progressPercent =
        stats.totalActivities === 0
          ? 0
          : Math.round(
              (stats.completedActivities / stats.totalActivities) * 100,
            );
      const memberCount = trip._count.members;

      return {
        id: trip.id,
        name: trip.name,
        description: trip.description,
        startDate: trip.startDate,
        endDate: trip.endDate,
        budgetLevel: trip.budgetLevel,
        maxMembers: trip.maxMembers,
        tripType: trip.tripType,
        visibility: trip.visibility,
        status: trip.status,
        destinations: trip.destinations,
        memberCount,
        memberPreviews: trip.members.map((member) => ({
          id: member.id,
          username: member.user.username,
          avatarUrl: this.toPublicUrl(member.user.avatar),
        })),
        owner: trip.owner
          ? {
              id: trip.owner.id,
              displayname: trip.owner.displayname,
              username: trip.owner.username,
              avatarUrl: this.toPublicUrl(trip.owner.avatar),
            }
          : null,
        recruiting: memberCount < trip.maxMembers,
        coverImageUrl: this.toPublicUrl(trip.coverMedia),
        checkinCount: stats.checkinCount,
        totalActivities: stats.totalActivities,
        completedActivities: stats.completedActivities,
        progressPercent,
        nextActivity: discover ? null : stats.nextActivity,
        ...(discover
          ? {
              requirements: trip.recruitment?.requirements ?? null,
              estimatedBudgetPerPerson:
                trip.recruitment?.estimatedBudgetPerPerson?.toString() ?? null,
              slotsRemaining: Math.max(0, trip.maxMembers - memberCount),
              expiresAt: trip.recruitment?.expiresAt ?? null,
              urgent: trip.recruitment?.urgent ?? false,
            }
          : {}),
      };
    });

    return {
      data,
      meta: createPaginationMeta(page, limit, total),
      summary,
    };
  }

  async getMyDrafts(userId: string) {
    const drafts = await this.prisma.trip.findMany({
      where: {
        ownerId: userId,
        status: TRIP_STATUS.DRAFT,
      },
      orderBy: { createdAt: 'desc' },
      include: {
        coverMedia: {
          select: { id: true, objectKey: true, deletedAt: true },
        },
        destinations: { orderBy: { order: 'asc' } },
      },
    });

    return drafts.map(({ coverMedia, ...draftData }) => ({
      ...draftData,
      coverImageUrl: this.toPublicUrl(coverMedia),
    }));
  }

  async deleteTrip(id: string, userId: string): Promise<void> {
    await this.prisma.$transaction(async (tx) => {
      if (!(await lockTripRow(tx, id))) {
        throw new NotFoundException('Trip not found');
      }
      await TripAccessPolicy.authorizeOwner(tx, id, userId);

      const trip = await tx.trip.findUniqueOrThrow({
        where: { id },
        select: { status: true },
      });
      if (!DELETABLE_TRIP_STATUSES.includes(trip.status)) {
        throw new BadRequestException({
          code: 'TRIP_NOT_DELETABLE',
          message: 'Only draft or upcoming trips can be deleted',
        });
      }

      // ON DELETE RESTRICT: ItineraryDay -> TripDestination and
      // TripExpense.payer -> TripMember would block the trip cascade.
      await tx.itineraryDay.deleteMany({ where: { tripId: id } });
      await tx.tripExpense.deleteMany({ where: { tripId: id } });
      await tx.trip.delete({ where: { id } });
    });

    try {
      this.tripRoomWS.removeTripRoom(id);
    } catch (error) {
      this.logger.error(
        `Failed to remove room trip:${id}`,
        error instanceof Error ? error.stack : undefined,
      );
    }
  }

  private async recordTripCreated(
    tx: Prisma.TransactionClient,
    trip: {
      id: string;
      name: string;
      startDate: Date;
      endDate: Date;
      destinations: unknown[];
    },
    ownerId: string,
  ): Promise<void> {
    await this.tripTimelineService.createEvent(tx, trip.id, ownerId, {
      type: TIMELINE_EVENT_TYPE.TRIP_CREATED,
      content: 'Đã tạo chuyến đi',
      metadata: {
        tripName: trip.name,
        startDate: trip.startDate.toISOString(),
        endDate: trip.endDate.toISOString(),
        destinationCount: trip.destinations.length,
      },
      target: { type: TIMELINE_TARGET_TYPE.TRIP, id: trip.id },
    });
  }

  private async createTripRecord(
    ownerId: string,
    dto: CreateTripDraftDto,
    status: typeof TRIP_STATUS.DRAFT | typeof TRIP_STATUS.UPCOMING,
  ) {
    const {
      destinations = [],
      coverMediaId,
      interestIds = [],
      estimatedBudgetPerPerson,
      budgetCurrency,
      name,
      maxMembers,
      ...rest
    } = dto;
    const isFinal = status === TRIP_STATUS.UPCOMING;
    const trimmedName = name?.trim() ?? '';

    if (isFinal && !trimmedName) {
      throw new BadRequestException({
        code: 'TRIP_NAME_REQUIRED',
        message: 'Trip name is required',
      });
    }

    if (isFinal && !rest.budgetLevel) {
      throw new BadRequestException({
        code: 'TRIP_BUDGET_REQUIRED',
        message: 'Budget level is required',
      });
    }

    if (isFinal && destinations.length === 0) {
      throw new BadRequestException({
        code: 'TRIP_DESTINATION_REQUIRED',
        message: 'At least one destination is required',
      });
    }

    const budgetData = this.toBudgetData(
      estimatedBudgetPerPerson,
      budgetCurrency,
    );

    if (coverMediaId) {
      await TripResourcePolicy.assertMediaOwned(
        this.prisma,
        ownerId,
        coverMediaId,
      );
    }

    const sortedDestinations = (
      await this.hydrateDestinationSnapshots(destinations)
    ).sort((a, b) => a.order - b.order);

    if (sortedDestinations.length > 0) {
      DestinationPolicy.validatePersistedTimeline(sortedDestinations);
    }
    if (isFinal) {
      this.assertTripNotStarted(sortedDestinations);
    }

    return this.prisma.$transaction(async (tx) => {
      const validatedInterestIds = await TripInterestPolicy.validateIds(
        tx,
        interestIds,
      );
      const pendingPlaceNames = await this.loadPendingPlaceNames(
        tx,
        sortedDestinations,
      );

      const trip = await tx.trip.create({
        data: {
          ...rest,
          ...budgetData,
          ...tripDateRange(sortedDestinations),
          name: trimmedName,
          maxMembers: maxMembers ?? 1,
          ownerId,
          status,
          finalizedAt: isFinal ? new Date() : null,
          coverMediaId: coverMediaId ?? null,
          inviteCode: generateInviteCode(),
          members: {
            create: { userId: ownerId, role: TRIP_ROLE.OWNER },
          },
          destinations:
            sortedDestinations.length > 0
              ? { create: sortedDestinations.map(withoutPendingPlaces) }
              : undefined,
          interests:
            validatedInterestIds.length > 0
              ? {
                  create: validatedInterestIds.map((interestId) => ({
                    interestId,
                  })),
                }
              : undefined,
        },
        select: {
          id: true,
          destinations: { select: { id: true, order: true } },
        },
      });

      for (const destination of trip.destinations) {
        await this.tripDestinationService.createDaysForDestination(
          tx,
          trip.id,
          destination.id,
        );
      }
      if (trip.destinations.length > 0) {
        await this.tripDestinationService.recalculateTripDayNumbers(
          tx,
          trip.id,
        );
      }

      await this.attachPendingPlaces(
        tx,
        trip.id,
        trip.destinations,
        sortedDestinations,
        pendingPlaceNames,
      );

      const created = await tx.trip.findUniqueOrThrow({
        where: { id: trip.id },
        include: TRIP_WRITE_INCLUDE,
      });
      if (isFinal) {
        await this.recordTripCreated(tx, created, ownerId);
      }

      return {
        ...created,
        tripInterests: created.interests.map((item) => item.interest),
      };
    });
  }

  /**
   * (tripId, order) is unique and checked per row. Moving every stop to a
   * negative order first lets updates swap or reuse orders without
   * transient conflicts; orders are non-negative, so `-1 - order` is free.
   */
  private async parkDestinationOrders(
    tx: Prisma.TransactionClient,
    tripId: string,
  ): Promise<void> {
    await tx.$executeRaw`
      UPDATE "TripDestination"
      SET "order" = -1 - "order"
      WHERE "tripId" = ${tripId}
    `;
  }

  /** Restores stops whose order was not rewritten; removed stops stay parked. */
  private async restoreParkedDestinationOrders(
    tx: Prisma.TransactionClient,
    tripId: string,
    removedIds: string[],
  ): Promise<void> {
    await tx.$executeRaw`
      UPDATE "TripDestination"
      SET "order" = -1 - "order"
      WHERE "tripId" = ${tripId}
        AND "order" < 0
        AND NOT ("id" = ANY(${removedIds}::text[]))
    `;
  }

  /** `sortedDestinations` is a validated timeline, so the first stop starts the trip. */
  private assertTripNotStarted(
    sortedDestinations: Array<{ startDate: Date }>,
  ): void {
    const [first] = sortedDestinations;
    TripPolicy.assertNotStartedYet(
      first.startDate.toISOString().slice(0, 10),
      TimePolicy.today(),
    );
  }

  private assertTripEditable(status: TRIP_STATUS): void {
    if (!EDITABLE_TRIP_STATUSES.includes(status)) {
      throw new BadRequestException({
        code: 'TRIP_NOT_EDITABLE',
        message: 'Completed or cancelled trips cannot be edited',
      });
    }
  }

  private toBudgetData(
    estimatedBudgetPerPerson?: string | null,
    budgetCurrency?: string | null,
  ) {
    const budget = estimatedBudgetPerPerson ?? undefined;
    const currency = budgetCurrency ?? undefined;
    TripPolicy.validateBudgetFields(budget, currency);

    return {
      estimatedBudgetPerPerson:
        budget === undefined ? null : new Prisma.Decimal(budget),
      budgetCurrency: currency?.toUpperCase() ?? null,
    };
  }

  /** Merges a partial budget update with the stored values before validating. */
  private resolveBudgetUpdate(
    current: {
      estimatedBudgetPerPerson: Prisma.Decimal | null;
      budgetCurrency: string | null;
    },
    estimatedBudgetPerPerson?: string | null,
    budgetCurrency?: string | null,
  ) {
    if (
      estimatedBudgetPerPerson === undefined &&
      budgetCurrency === undefined
    ) {
      return {};
    }

    return this.toBudgetData(
      estimatedBudgetPerPerson === undefined
        ? current.estimatedBudgetPerPerson?.toString()
        : estimatedBudgetPerPerson,
      budgetCurrency === undefined ? current.budgetCurrency : budgetCurrency,
    );
  }

  private async loadPendingPlaceNames(
    tx: Prisma.TransactionClient,
    destinations: PendingPlaceInput[],
  ): Promise<Map<string, string>> {
    const placeIds = [
      ...new Set(
        destinations.flatMap(
          (destination) => destination.pendingPlaceIds ?? [],
        ),
      ),
    ];
    if (placeIds.length === 0) return new Map();

    const places = await tx.place.findMany({
      where: { id: { in: placeIds }, status: PlaceStatus.APPROVED },
      select: { id: true, name: true },
    });
    if (places.length !== placeIds.length) {
      throw new BadRequestException(
        'One or more pending places are unavailable',
      );
    }

    return new Map(places.map((place) => [place.id, place.name]));
  }

  /** Adds each destination's pending places to its first itinerary day. */
  private async attachPendingPlaces(
    tx: Prisma.TransactionClient,
    tripId: string,
    persistedDestinations: Array<{ id: string; order: number }>,
    inputs: PendingPlaceInput[],
    placeNames: Map<string, string>,
  ): Promise<void> {
    const destinationIdByOrder = new Map(
      persistedDestinations.map((destination) => [
        destination.order,
        destination.id,
      ]),
    );

    for (const input of inputs) {
      if (!input.pendingPlaceIds?.length) continue;

      const destinationId = destinationIdByOrder.get(input.order);
      const firstDay = destinationId
        ? await tx.itineraryDay.findFirst({
            where: { tripId, destinationId },
            orderBy: { dayNumber: 'asc' },
            select: { id: true },
          })
        : null;
      if (!firstDay) {
        throw new BadRequestException(
          'Unable to map pending places to an itinerary day',
        );
      }

      await tx.itineraryItem.createMany({
        data: input.pendingPlaceIds.map((placeId, index) => ({
          tripId,
          dayId: firstDay.id,
          placeId,
          title: placeNames.get(placeId) ?? '',
          orderIndex: index + 1,
        })),
      });
    }
  }

  private async loadActivityStats(
    tripIds: string[],
    now: Date,
  ): Promise<Map<string, TripActivityStats>> {
    const stats = new Map<string, TripActivityStats>();
    if (tripIds.length === 0) return stats;

    const [activityGroups, checkinGroups, upcomingActivities] =
      await Promise.all([
        this.prisma.itineraryItem.groupBy({
          by: ['tripId', 'isCheckin'],
          where: { tripId: { in: tripIds } },
          _count: { _all: true },
        }),
        this.prisma.tripCheckin.groupBy({
          by: ['tripId'],
          where: { tripId: { in: tripIds }, activityId: { not: null } },
          _count: { _all: true },
        }),
        this.prisma.itineraryItem.findMany({
          where: { tripId: { in: tripIds }, startTime: { gt: now } },
          orderBy: [{ tripId: 'asc' }, { startTime: 'asc' }],
          distinct: ['tripId'],
          select: { id: true, title: true, startTime: true, tripId: true },
        }),
      ]);

    const statsFor = (tripId: string): TripActivityStats => {
      let tripStats = stats.get(tripId);
      if (!tripStats) {
        tripStats = { ...EMPTY_ACTIVITY_STATS };
        stats.set(tripId, tripStats);
      }
      return tripStats;
    };

    for (const group of activityGroups) {
      const tripStats = statsFor(group.tripId);
      tripStats.totalActivities += group._count._all;
      if (group.isCheckin) {
        tripStats.completedActivities += group._count._all;
      }
    }

    for (const group of checkinGroups) {
      statsFor(group.tripId).checkinCount = group._count._all;
    }

    for (const { tripId, ...activity } of upcomingActivities) {
      statsFor(tripId).nextActivity = activity;
    }

    return stats;
  }

  private toPublicUrl(
    media: { objectKey: string; deletedAt: Date | null } | null | undefined,
  ): string | null {
    return media && media.deletedAt === null
      ? this.s3.getPublicUrl(media.objectKey)
      : null;
  }

  /** Copies catalog display data so later catalog edits do not change trips. */
  private async hydrateDestinationSnapshots<
    T extends { destinationId?: string | null },
  >(destinations: T[]): Promise<T[]> {
    const catalogIds = [
      ...new Set(
        destinations
          .map((destination) => destination.destinationId)
          .filter((id): id is string => Boolean(id)),
      ),
    ];
    if (catalogIds.length === 0) return destinations;

    const catalog = await this.prisma.destinationCatalog.findMany({
      where: { id: { in: catalogIds }, isActive: true },
    });
    const catalogById = new Map(catalog.map((item) => [item.id, item]));

    return destinations.map((destination) => {
      if (!destination.destinationId) return destination;
      const source = catalogById.get(destination.destinationId);
      if (!source) {
        throw new BadRequestException(
          `Destination catalog item ${destination.destinationId} was not found`,
        );
      }
      return {
        ...destination,
        city: source.name,
        country: source.country,
        lat: source.lat,
        lng: source.lng,
        destinationType: source.type,
        highlights: source.highlights,
        coverMediaId: source.coverMediaId,
      };
    });
  }
}

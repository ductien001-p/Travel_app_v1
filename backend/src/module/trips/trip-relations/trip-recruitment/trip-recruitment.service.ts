import { randomUUID } from 'crypto';
import {
  BadRequestException,
  ConflictException,
  Inject,
  Injectable,
  NotFoundException,
  UnprocessableEntityException,
  forwardRef,
} from '@nestjs/common';
import { Prisma } from '../../../../generated/prisma/client';
import {
  JOIN_REQUEST_STATUS,
  MEMBER_STATUS,
  NOTIFICATION_TYPE,
  RECRUITMENT_ORIGIN,
  RECRUITMENT_STATE,
  TIMELINE_EVENT_TYPE,
  TIMELINE_TARGET_TYPE,
  TRIP_STATUS,
  TRIP_VISIBILITY,
} from '../../../../generated/prisma/enums';
import { PrismaService } from '../../../../prisma.service';
import { S3Service } from '../../../../uploads/s3/s3.service';
import { lockRecruitmentOwner, lockTripRow } from '../../trip-lock';
import { TripAccessPolicy } from '../../policies';
import { TripTimelineService } from '../trip-timeline/tripTimeline.service';
import { TripsService } from '../../trips.service';
import { PatchRecruitmentDto } from './dto/patch-recruitment.dto';
import {
  PublishDraftDto,
  RecruitmentMineDto,
  RecruitmentMineTripDto,
  RecruitmentPublishResultDto,
  RecruitmentSummaryDto,
} from './dto/recruitment-response.dto';
import { reconcileRecruitmentState } from './recruitment-state';
import {
  activeRecruitmentWhere,
  effectiveRecruitmentState,
  idempotencyFreshAfter,
  isActiveRecruitment,
  isEffectiveOpen,
  isFreshIdempotencyKey,
  recruitmentBlockers,
  recruitmentExpiresAt,
  snapshotPreviousVisibility,
} from './recruitment.policy';

type PublishRow = {
  id: string;
  tripId: string;
  createdAt: Date;
};

@Injectable()
export class TripRecruitmentService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
    private readonly timeline: TripTimelineService,
    @Inject(forwardRef(() => TripsService))
    private readonly trips: TripsService,
  ) {}

  async summary(ownerId: string): Promise<RecruitmentSummaryDto> {
    const activeRecruitmentCount = await this.prisma.tripRecruitment.count({
      where: activeRecruitmentWhere(ownerId, new Date()),
    });
    return { activeRecruitmentCount };
  }

  async mine(ownerId: string): Promise<RecruitmentMineDto> {
    const now = new Date();
    const [trips, draft, activeRecruitmentCount] = await Promise.all([
      this.prisma.trip.findMany({
        where: { ownerId, status: TRIP_STATUS.UPCOMING },
        orderBy: [{ startDate: 'asc' }, { id: 'asc' }],
        include: mineTripInclude,
      }),
      this.prisma.trip.findFirst({
        where: {
          ownerId,
          status: TRIP_STATUS.DRAFT,
          recruitment: { origin: RECRUITMENT_ORIGIN.PUBLISH_WIZARD },
        },
        orderBy: [{ updatedAt: 'desc' }, { id: 'desc' }],
        include: {
          coverMedia: { select: { objectKey: true, deletedAt: true } },
          recruitment: { select: { draftStep: true, urgent: true } },
        },
      }),
      this.prisma.tripRecruitment.count({
        where: activeRecruitmentWhere(ownerId, now),
      }),
    ]);

    const pendingGroups =
      trips.length === 0
        ? []
        : await this.prisma.tripJoinRequest.groupBy({
            by: ['tripId'],
            where: {
              tripId: { in: trips.map((trip) => trip.id) },
              status: JOIN_REQUEST_STATUS.PENDING,
            },
            _count: { _all: true },
          });
    const pendingByTrip = new Map(
      pendingGroups.map((group) => [
        group.tripId,
        typeof group._count === 'object' ? (group._count._all ?? 0) : 0,
      ]),
    );

    return {
      activeRecruitmentCount,
      latestPublishDraft: draft ? this.toDraft(draft) : null,
      trips: trips.map((trip) => {
        const selfActive = isActiveRecruitment(
          trip.recruitment,
          trip.status,
          now,
        );
        return this.toMineTrip(
          trip,
          pendingByTrip.get(trip.id) ?? 0,
          selfActive
            ? Math.max(0, activeRecruitmentCount - 1)
            : activeRecruitmentCount,
          now,
        );
      }),
    };
  }

  async patch(
    tripId: string,
    userId: string,
    dto: PatchRecruitmentDto,
  ): Promise<RecruitmentPublishResultDto> {
    if (dto.origin === RECRUITMENT_ORIGIN.LEGACY_BACKFILL) {
      throw new BadRequestException({
        code: 'RECRUITMENT_ORIGIN_INVALID',
        message: 'Legacy origin is reserved for backfill',
      });
    }
    if (dto.maxMembers !== undefined || dto.budgetLevel !== undefined) {
      await this.trips.updateTrip(tripId, userId, {
        ...(dto.maxMembers !== undefined ? { maxMembers: dto.maxMembers } : {}),
        ...(dto.budgetLevel !== undefined
          ? { budgetLevel: dto.budgetLevel }
          : {}),
        acknowledgeRecruitmentImpact: dto.acknowledgeRecruitmentImpact,
      });
    }

    return this.prisma.$transaction(async (tx) => {
      if (!(await lockTripRow(tx, tripId))) {
        throw new NotFoundException('Trip not found');
      }
      await TripAccessPolicy.authorizeOwner(tx, tripId, userId);
      const trip = await tx.trip.findUniqueOrThrow({
        where: { id: tripId },
        select: { id: true, status: true, visibility: true },
      });
      const existing = await tx.tripRecruitment.findUnique({
        where: { tripId },
      });
      const origin = existing
        ? existing.origin
        : this.originForNewRow(trip.status, dto.origin);
      const budget = this.parseBudget(dto.estimatedBudgetPerPerson);
      await tx.tripRecruitment.upsert({
        where: { tripId },
        create: {
          tripId,
          state: RECRUITMENT_STATE.NOT_PUBLISHED,
          origin,
          requirements: dto.requirements ?? null,
          estimatedBudgetPerPerson: budget === undefined ? null : budget,
          draftStep: dto.draftStep ?? null,
          urgent: dto.urgent ?? false,
        },
        update: {
          ...(dto.requirements !== undefined
            ? { requirements: dto.requirements }
            : {}),
          ...(budget !== undefined ? { estimatedBudgetPerPerson: budget } : {}),
          ...(dto.draftStep !== undefined ? { draftStep: dto.draftStep } : {}),
          ...(dto.urgent !== undefined ? { urgent: dto.urgent } : {}),
        },
      });
      await reconcileRecruitmentState(tx, tripId);
      return this.readResult(tx, tripId);
    });
  }

  async publish(
    ownerId: string,
    tripId: string,
    idempotencyKey: string | undefined,
  ): Promise<RecruitmentPublishResultDto> {
    const key = idempotencyKey?.trim();
    if (!key) {
      throw new BadRequestException({
        code: 'IDEMPOTENCY_KEY_REQUIRED',
        message: 'Idempotency-Key is required',
      });
    }
    const now = new Date();
    const replay = await this.prisma.tripPublishIdempotency.findUnique({
      where: { ownerId_key: { ownerId, key } },
    });
    if (replay && isFreshIdempotencyKey(replay.createdAt, now)) {
      return this.replayResult(replay, tripId);
    }

    return this.prisma.$transaction(async (tx) => {
      await lockRecruitmentOwner(tx, ownerId);
      if (!(await lockTripRow(tx, tripId))) {
        throw new NotFoundException('Trip not found');
      }
      const existingKey = await tx.tripPublishIdempotency.findUnique({
        where: { ownerId_key: { ownerId, key } },
      });
      if (existingKey && isFreshIdempotencyKey(existingKey.createdAt, now)) {
        return this.replayResult(existingKey, tripId, tx);
      }
      if (existingKey) {
        await tx.tripPublishIdempotency.delete({
          where: { id: existingKey.id },
        });
      }

      const loaded = await this.loadOwnedTrip(tx, tripId, ownerId);
      if (isEffectiveOpen(loaded.recruitment, loaded.status, now)) {
        throw new ConflictException({
          code: 'RECRUITMENT_ALREADY_OPEN',
          message: 'This trip is already open for members',
        });
      }
      if (isActiveRecruitment(loaded.recruitment, loaded.status, now)) {
        throw new ConflictException({
          code: 'RECRUITMENT_ALREADY_OPEN',
          message: 'This trip already has an active recruitment post',
        });
      }

      const inserted = await tx.$queryRaw<Array<{ id: string }>>`
        INSERT INTO "trip_publish_idempotency" ("id", "ownerId", "key", "tripId", "createdAt")
        VALUES (${randomUUID()}, ${ownerId}, ${key}, ${tripId}, ${now})
        ON CONFLICT ("ownerId", "key") DO NOTHING
        RETURNING "id"
      `;
      if (inserted.length === 0) {
        const winner = await tx.tripPublishIdempotency.findUniqueOrThrow({
          where: { ownerId_key: { ownerId, key } },
        });
        return this.replayResult(winner, tripId, tx);
      }

      if (loaded.status === TRIP_STATUS.DRAFT) {
        await this.trips.finalizeDraftInTransaction(tx, tripId, ownerId);
      }
      const trip = await this.loadOwnedTrip(tx, tripId, ownerId);
      await this.assertPublishable(tx, trip, ownerId, now);
      await this.activate(tx, trip, ownerId, now);
      return this.readResult(tx, tripId);
    });
  }

  async close(
    tripId: string,
    userId: string,
  ): Promise<RecruitmentPublishResultDto> {
    return this.prisma.$transaction(async (tx) => {
      const trip = await this.lockOwned(tx, tripId, userId);
      const recruitment = trip.recruitment;
      if (!recruitment) {
        throw new NotFoundException('Recruitment post not found');
      }
      if (
        recruitment.state === RECRUITMENT_STATE.CLOSED ||
        recruitment.state === RECRUITMENT_STATE.NOT_PUBLISHED
      ) {
        return this.readResult(tx, tripId);
      }
      const restore = recruitment.previousVisibility;
      await tx.tripRecruitment.update({
        where: { tripId },
        data: { state: RECRUITMENT_STATE.CLOSED, previousVisibility: null },
      });
      if (restore) {
        await tx.trip.update({
          where: { id: tripId },
          data: { visibility: restore },
        });
      }
      await this.notifyPending(tx, {
        tripId,
        tripName: trip.name,
        actorId: userId,
        title: 'Bài tuyển đã đóng',
        message: `Bài tuyển chuyến "${trip.name}" đã đóng.`,
      });
      return this.readResult(tx, tripId);
    });
  }

  async reopen(
    tripId: string,
    userId: string,
  ): Promise<RecruitmentPublishResultDto> {
    const now = new Date();
    return this.prisma.$transaction(async (tx) => {
      const trip = await this.lockOwned(tx, tripId, userId);
      if (isEffectiveOpen(trip.recruitment, trip.status, now)) {
        throw new ConflictException({
          code: 'RECRUITMENT_ALREADY_OPEN',
          message: 'This trip is already open for members',
        });
      }
      if (
        !trip.recruitment ||
        trip.recruitment.state === RECRUITMENT_STATE.NOT_PUBLISHED
      ) {
        throw new BadRequestException({
          code: 'RECRUITMENT_NOT_CLOSED',
          message: 'Only a closed post can be reopened',
        });
      }
      await this.assertPublishable(tx, trip, userId, now);
      await this.activate(tx, trip, userId, now);
      return this.readResult(tx, tripId);
    });
  }

  private async replayResult(
    row: PublishRow,
    tripId: string,
    tx: Prisma.TransactionClient | PrismaService = this.prisma,
  ): Promise<RecruitmentPublishResultDto> {
    if (row.tripId !== tripId) {
      throw new UnprocessableEntityException({
        code: 'IDEMPOTENCY_KEY_TRIP_MISMATCH',
        message: 'Idempotency-Key was already used for a different trip',
      });
    }
    return this.readResult(tx, row.tripId);
  }

  private async activate(
    tx: Prisma.TransactionClient,
    trip: OwnedTrip,
    actorId: string,
    now: Date,
  ): Promise<void> {
    const expiresAt = recruitmentExpiresAt(trip.startDate);
    const existing = trip.recruitment;
    const previousVisibility = existing?.previousVisibility ?? trip.visibility;
    const origin =
      existing?.origin ??
      (trip.status === TRIP_STATUS.DRAFT
        ? RECRUITMENT_ORIGIN.PUBLISH_WIZARD
        : RECRUITMENT_ORIGIN.EXISTING_TRIP);
    await tx.trip.update({
      where: { id: trip.id },
      data: { visibility: TRIP_VISIBILITY.PUBLIC },
    });
    await tx.tripRecruitment.upsert({
      where: { tripId: trip.id },
      create: {
        tripId: trip.id,
        state: RECRUITMENT_STATE.OPEN,
        origin,
        publishedAt: now,
        expiresAt,
        previousVisibility,
        requirements: existing?.requirements ?? null,
        estimatedBudgetPerPerson: existing?.estimatedBudgetPerPerson ?? null,
        draftStep: existing?.draftStep ?? null,
      },
      update: {
        state: RECRUITMENT_STATE.OPEN,
        publishedAt: now,
        expiresAt,
        ...snapshotPreviousVisibility(
          existing?.previousVisibility,
          trip.visibility,
        ),
      },
    });
    await this.timeline.createEvent(tx, trip.id, actorId, {
      type: TIMELINE_EVENT_TYPE.TRIP_PUBLISHED,
      content: 'Đã đăng chuyến đi lên cộng đồng',
      metadata: {
        tripName: trip.name,
        expiresAt: expiresAt.toISOString(),
      },
      target: { type: TIMELINE_TARGET_TYPE.TRIP, id: trip.id },
    });
    await reconcileRecruitmentState(tx, trip.id, now);
  }

  private async assertPublishable(
    tx: Prisma.TransactionClient,
    trip: OwnedTrip,
    ownerId: string,
    now: Date,
  ): Promise<void> {
    const [activeRecruitmentCount, activeMemberCount] = await Promise.all([
      tx.tripRecruitment.count({
        where: activeRecruitmentWhere(ownerId, now, trip.id),
      }),
      tx.tripMember.count({
        where: { tripId: trip.id, status: MEMBER_STATUS.ACTIVE },
      }),
    ]);
    const blockers = recruitmentBlockers({
      startDate: trip.startDate,
      activeRecruitmentCount,
      activeMemberCount,
      maxMembers: trip.maxMembers,
      description: trip.description,
      hasCover: this.hasCover(trip.coverMedia),
      now,
    });
    if (blockers.length > 0) {
      throw new BadRequestException({
        code: blockers[0],
        message: 'Trip cannot be published',
        details: { blockers },
      });
    }
  }

  private async lockOwned(
    tx: Prisma.TransactionClient,
    tripId: string,
    userId: string,
  ): Promise<OwnedTrip> {
    await lockRecruitmentOwner(tx, userId);
    if (!(await lockTripRow(tx, tripId))) {
      throw new NotFoundException('Trip not found');
    }
    await TripAccessPolicy.authorizeOwner(tx, tripId, userId);
    return this.loadOwnedTrip(tx, tripId, userId);
  }

  private async loadOwnedTrip(
    tx: Prisma.TransactionClient,
    tripId: string,
    ownerId: string,
  ): Promise<OwnedTrip> {
    const trip = await tx.trip.findFirst({
      where: { id: tripId, ownerId },
      select: ownedTripSelect,
    });
    if (!trip) throw new NotFoundException('Trip not found');
    return trip;
  }

  private async readResult(
    tx: Prisma.TransactionClient | PrismaService,
    tripId: string,
  ): Promise<RecruitmentPublishResultDto> {
    const trip = await tx.trip.findUniqueOrThrow({
      where: { id: tripId },
      select: {
        id: true,
        visibility: true,
        recruitment: {
          select: {
            state: true,
            publishedAt: true,
            expiresAt: true,
            previousVisibility: true,
          },
        },
      },
    });
    const now = new Date();
    return {
      tripId: trip.id,
      state: trip.recruitment?.state ?? RECRUITMENT_STATE.NOT_PUBLISHED,
      effectiveState: effectiveRecruitmentState(trip.recruitment, now),
      publishedAt: trip.recruitment?.publishedAt ?? null,
      expiresAt: trip.recruitment?.expiresAt ?? null,
      visibility: trip.visibility,
      previousVisibility: trip.recruitment?.previousVisibility ?? null,
    };
  }

  private async notifyPending(
    tx: Prisma.TransactionClient,
    input: {
      tripId: string;
      tripName: string;
      actorId: string;
      title: string;
      message: string;
    },
  ): Promise<number> {
    const requests = await tx.tripJoinRequest.findMany({
      where: { tripId: input.tripId, status: JOIN_REQUEST_STATUS.PENDING },
      select: { requesterId: true },
    });
    if (requests.length === 0) return 0;
    await tx.notification.createMany({
      data: requests.map((request) => ({
        userId: request.requesterId,
        actorId: input.actorId,
        tripId: input.tripId,
        type: NOTIFICATION_TYPE.TRIP_RECRUITMENT_CLOSED,
        title: input.title,
        message: input.message,
      })),
    });
    return requests.length;
  }

  private originForNewRow(
    status: TRIP_STATUS,
    requested?: RECRUITMENT_ORIGIN,
  ): RECRUITMENT_ORIGIN {
    if (
      requested === RECRUITMENT_ORIGIN.PUBLISH_WIZARD &&
      status !== TRIP_STATUS.DRAFT
    ) {
      throw new BadRequestException({
        code: 'RECRUITMENT_ORIGIN_INVALID',
        message: 'Publish wizard origin is only for a draft',
      });
    }
    if (requested === RECRUITMENT_ORIGIN.PUBLISH_WIZARD) {
      return RECRUITMENT_ORIGIN.PUBLISH_WIZARD;
    }
    return RECRUITMENT_ORIGIN.EXISTING_TRIP;
  }

  private parseBudget(
    value: string | undefined,
  ): Prisma.Decimal | null | undefined {
    if (value === undefined) return undefined;
    const trimmed = value.trim();
    if (!trimmed) return null;
    let decimal: Prisma.Decimal;
    try {
      decimal = new Prisma.Decimal(trimmed);
    } catch {
      throw new BadRequestException({
        code: 'RECRUITMENT_BUDGET_INVALID',
        message: 'estimatedBudgetPerPerson must be a decimal string',
      });
    }
    if (decimal.isNeg()) {
      throw new BadRequestException({
        code: 'RECRUITMENT_BUDGET_INVALID',
        message: 'estimatedBudgetPerPerson must be greater than or equal to 0',
      });
    }
    return decimal;
  }

  private toDraft(draft: {
    id: string;
    name: string;
    description: string | null;
    startDate: Date;
    endDate: Date;
    maxMembers: number;
    budgetLevel: string | null;
    updatedAt: Date;
    coverMedia: { objectKey: string; deletedAt: Date | null } | null;
    recruitment: { draftStep: number | null; urgent: boolean } | null;
  }): PublishDraftDto {
    return {
      tripId: draft.id,
      name: draft.name,
      description: draft.description,
      coverImageUrl: this.toPublicUrl(draft.coverMedia),
      draftStep: draft.recruitment?.draftStep ?? null,
      startDate: draft.startDate,
      endDate: draft.endDate,
      maxMembers: draft.maxMembers,
      budgetLevel: draft.budgetLevel,
      urgent: draft.recruitment?.urgent ?? false,
      updatedAt: draft.updatedAt,
    };
  }

  private toMineTrip(
    trip: MineTrip,
    pendingRequestCount: number,
    otherActiveCount: number,
    now: Date,
  ): RecruitmentMineTripDto {
    const memberCount = trip._count.members;
    const blockers = recruitmentBlockers({
      startDate: trip.startDate,
      activeRecruitmentCount: otherActiveCount,
      activeMemberCount: memberCount,
      maxMembers: trip.maxMembers,
      description: trip.description,
      hasCover: this.hasCover(trip.coverMedia),
      now,
    });
    const alreadyActive = isActiveRecruitment(
      trip.recruitment,
      trip.status,
      now,
    );
    return {
      tripId: trip.id,
      name: trip.name,
      description: trip.description,
      coverImageUrl: this.toPublicUrl(trip.coverMedia),
      startDate: trip.startDate,
      endDate: trip.endDate,
      maxMembers: trip.maxMembers,
      memberCount,
      pendingRequestCount,
      slotsRemaining: Math.max(0, trip.maxMembers - memberCount),
      requirements: trip.recruitment?.requirements ?? null,
      estimatedBudgetPerPerson:
        trip.recruitment?.estimatedBudgetPerPerson?.toString() ?? null,
      budgetLevel: trip.budgetLevel,
      expiresAt: trip.recruitment?.expiresAt ?? null,
      effectiveState: effectiveRecruitmentState(trip.recruitment, now),
      canPublish: !alreadyActive && blockers.length === 0,
      blockers: alreadyActive ? [] : blockers,
      destinationLabels: trip.destinations.map((stop) => stop.city),
      urgent: trip.recruitment?.urgent ?? false,
    };
  }

  private hasCover(
    media: { objectKey: string; deletedAt: Date | null } | null,
  ): boolean {
    return media !== null && media.deletedAt === null;
  }

  private toPublicUrl(
    media: { objectKey: string; deletedAt: Date | null } | null,
  ): string | null {
    if (!media || media.deletedAt !== null) return null;
    return this.s3.getPublicUrl(media.objectKey);
  }
}

const mediaSelect = {
  objectKey: true,
  deletedAt: true,
} satisfies Prisma.UploadedMediaSelect;

const mineTripInclude = {
  coverMedia: { select: mediaSelect },
  destinations: { orderBy: { order: 'asc' as const }, select: { city: true } },
  recruitment: true,
  _count: { select: { members: { where: { status: MEMBER_STATUS.ACTIVE } } } },
} satisfies Prisma.TripInclude;

type MineTrip = Prisma.TripGetPayload<{ include: typeof mineTripInclude }>;

const ownedTripSelect = {
  id: true,
  name: true,
  description: true,
  status: true,
  visibility: true,
  startDate: true,
  endDate: true,
  maxMembers: true,
  ownerId: true,
  budgetLevel: true,
  coverMedia: { select: mediaSelect },
  destinations: { orderBy: { order: 'asc' as const }, select: { id: true } },
  recruitment: true,
} satisfies Prisma.TripSelect;

type OwnedTrip = Prisma.TripGetPayload<{ select: typeof ownedTripSelect }>;

export { idempotencyFreshAfter };

import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  Injectable,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { Prisma } from '../../../../generated/prisma/client';
import {
  HOST_STATUS,
  JOIN_REQUEST_STATUS,
  MEMBER_STATUS,
  NOTIFICATION_TYPE,
  TIMELINE_EVENT_TYPE,
  TIMELINE_TARGET_TYPE,
  TRAVEL_DNA_TYPE,
  TRIP_ROLE,
  TRIP_STATUS,
  TRIP_VISIBILITY,
} from '../../../../generated/prisma/enums';
import { PrismaService } from '../../../../prisma.service';
import { NotificationsService } from '../../../../notification/notification.service';
import { PushNotificationsService } from '../../../../notification/push-notification.service';
import { S3Service } from '../../../../uploads/s3/s3.service';
import { TripGateway } from '../../../../websocket/gateway';
import { TripAccessPolicy, TripMembershipPolicy } from '../../policies';
import { lockTripRow } from '../../trip-lock';
import { reconcileRecruitmentState } from '../trip-recruitment/recruitment-state';
import { isEffectiveOpen } from '../trip-recruitment/recruitment.policy';
import { TripTimelineService } from '../trip-timeline/tripTimeline.service';
import type { TimelineMetadataByType } from '../trip-timeline/timeline-metadata';
import { QueryJoinRequestsDto } from './dto/query-join-requests.dto';
import { UpdateJoinRequestSettingsDto } from './dto/join-request-settings.dto';
import { RequestToJoinDto } from './dto/request-to-join.dto';
import {
  TravelDnaScore,
  TripDnaProfile,
  buildTripDnaProfile,
  joinRequestMatchScore,
  topTravelPersona,
} from './join-request-match';

const MEDIA_URL_SELECT = {
  objectKey: true,
  deletedAt: true,
} satisfies Prisma.UploadedMediaSelect;

const JOIN_REQUEST_SELECT = {
  id: true,
  tripId: true,
  status: true,
  message: true,
  createdAt: true,
  decidedAt: true,
  requester: {
    select: {
      id: true,
      displayname: true,
      username: true,
      hostStatus: true,
      avatar: { select: MEDIA_URL_SELECT },
    },
  },
} satisfies Prisma.TripJoinRequestSelect;

type JoinRequestRecord = Prisma.TripJoinRequestGetPayload<{
  select: typeof JOIN_REQUEST_SELECT;
}>;

type JoinVia = TimelineMetadataByType['MEMBER_JOINED']['via'];

type PushTarget = { userIds: string[]; title: string; body: string };

export type JoinRequestResponse = {
  id: string;
  tripId: string;
  status: JOIN_REQUEST_STATUS;
  requester: {
    id: string;
    displayName: string;
    username: string;
    avatarUrl: string | null;
    isVerified: boolean;
    isOnline: boolean;
  };
  message: string | null;
  travelPersona: string | null;
  personaType: TRAVEL_DNA_TYPE | null;
  matchScore: number | null;
  /** Reserved for a written explanation of the score; not generated yet. */
  matchNote: string | null;
  createdAt: Date;
  decidedAt: Date | null;
};

export type JoinRequestCounts = Record<
  'pending' | 'approved' | 'rejected',
  number
>;

/** Trip summary shown before the viewer sends a join request. */
export type JoinInvitePreview = {
  inviteCode: string;
  tripId: string;
  name: string;
  coverImageUrl: string | null;
  startDate: Date;
  endDate: Date;
  ownerDisplayName: string;
  memberCount: number;
  maxMembers: number;
  matchScore: number | null;
};

function normalizeInviteCode(raw: string): string {
  return raw.replace(/[^A-Za-z0-9]/gi, '').toUpperCase();
}

function rethrowMembershipConflict(error: unknown): never {
  if (
    error instanceof Prisma.PrismaClientKnownRequestError &&
    (error.code === 'P2002' || error.code === 'P2034')
  ) {
    throw new ConflictException(
      'Trip membership changed while joining; please retry',
    );
  }
  throw error;
}

function assertPending(status: JOIN_REQUEST_STATUS): void {
  if (status !== JOIN_REQUEST_STATUS.PENDING) {
    throw new ConflictException('Join request is no longer pending');
  }
}

@Injectable()
export class TripJoinRequestsService {
  private readonly logger = new Logger(TripJoinRequestsService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
    private readonly notifications: NotificationsService,
    private readonly pushNotifications: PushNotificationsService,
    private readonly tripTimelineService: TripTimelineService,
    private readonly tripGateway: TripGateway,
  ) {}

  /**
   * Looks up a trip by invite code so the viewer can preview it before asking
   * to join. Does not create a join request.
   */
  async previewByInviteCode(
    inviteCode: string,
    userId: string,
  ): Promise<JoinInvitePreview> {
    return this.previewJoin({ inviteCode }, userId);
  }

  /**
   * Preview a PUBLIC trip before requesting to join by trip id (Community Explore).
   */
  async previewByTripId(
    tripId: string,
    userId: string,
  ): Promise<JoinInvitePreview> {
    return this.previewJoin({ tripId }, userId);
  }

  /**
   * Joining with the invite code asks the owner and admins for approval.
   * Friends of the owner join right away when the trip auto-approves them.
   * PRIVATE trips remain joinable via invite code.
   */
  async requestToJoin(
    inviteCode: string,
    userId: string,
    dto: RequestToJoinDto,
  ): Promise<JoinRequestResponse> {
    return this.createJoinRequest({ inviteCode }, userId, dto, 'INVITE_CODE');
  }

  /**
   * Community Explore: request to join a PUBLIC trip by id (no invite code).
   */
  async requestToJoinByTripId(
    tripId: string,
    userId: string,
    dto: RequestToJoinDto,
  ): Promise<JoinRequestResponse> {
    return this.createJoinRequest({ tripId }, userId, dto, 'JOIN_REQUEST');
  }

  private async previewJoin(
    lookup: { tripId: string } | { inviteCode: string },
    userId: string,
  ): Promise<JoinInvitePreview> {
    const trip = await this.findTripForPreview(lookup);
    if ('tripId' in lookup && trip.visibility !== TRIP_VISIBILITY.PUBLIC) {
      throw new ForbiddenException('Only public trips can be joined by id');
    }
    if ('tripId' in lookup) {
      await this.assertEffectivelyOpen(this.prisma, trip.id, trip.status);
    }

    const dnaByUser = await this.loadTravelDna([userId]);
    const profile = buildTripDnaProfile(
      trip.tripType,
      trip.itineraryItems.map((item) => item.place.category),
    );

    return {
      inviteCode: trip.inviteCode,
      tripId: trip.id,
      name: trip.name,
      coverImageUrl:
        trip.coverMedia && trip.coverMedia.deletedAt === null
          ? this.s3.getPublicUrl(trip.coverMedia.objectKey)
          : null,
      startDate: trip.startDate,
      endDate: trip.endDate,
      ownerDisplayName: trip.owner?.displayname ?? 'Trưởng nhóm',
      memberCount: trip.members.length,
      maxMembers: trip.maxMembers,
      matchScore: joinRequestMatchScore(profile, dnaByUser.get(userId) ?? []),
    };
  }

  private async findTripForPreview(
    lookup: { tripId: string } | { inviteCode: string },
  ) {
    const select = {
      id: true,
      name: true,
      inviteCode: true,
      visibility: true,
      status: true,
      startDate: true,
      endDate: true,
      maxMembers: true,
      tripType: true,
      coverMedia: { select: MEDIA_URL_SELECT },
      owner: { select: { displayname: true } },
      members: {
        where: { status: MEMBER_STATUS.ACTIVE },
        select: { id: true },
      },
      itineraryItems: {
        select: { place: { select: { category: true } } },
      },
    } as const;

    if ('inviteCode' in lookup) {
      const code = normalizeInviteCode(lookup.inviteCode);
      if (!code) {
        throw new NotFoundException('Mã mời không hợp lệ');
      }
      const trip = await this.prisma.trip.findUnique({
        where: { inviteCode: code },
        select,
      });
      if (!trip) {
        throw new NotFoundException('Mã mời không hợp lệ');
      }
      return trip;
    }

    const trip = await this.prisma.trip.findUnique({
      where: { id: lookup.tripId },
      select,
    });
    if (!trip) {
      throw new NotFoundException('Trip not found');
    }
    return trip;
  }

  private async createJoinRequest(
    lookup: { tripId: string } | { inviteCode: string },
    userId: string,
    dto: RequestToJoinDto,
    via: JoinVia,
  ): Promise<JoinRequestResponse> {
    // Serializable so the capacity check and an auto-approved join cannot
    // interleave with another join and overfill the trip.
    const result = await this.prisma
      .$transaction(
        async (tx) => {
          const trip = await this.findTripForJoin(tx, lookup);
          if (
            'tripId' in lookup &&
            trip.visibility !== TRIP_VISIBILITY.PUBLIC
          ) {
            throw new ForbiddenException(
              'Only public trips can be joined by id',
            );
          }
          if ('tripId' in lookup) {
            await this.assertEffectivelyOpen(tx, trip.id, trip.status);
          }

          await this.assertJoinable(tx, trip, userId);

          const previous = await tx.tripJoinRequest.findUnique({
            where: {
              tripId_requesterId: { tripId: trip.id, requesterId: userId },
            },
            select: { status: true },
          });
          if (previous?.status === JOIN_REQUEST_STATUS.PENDING) {
            throw new ConflictException('Join request is already pending');
          }

          const autoApprove =
            trip.autoApproveFriends &&
            trip.ownerId !== null &&
            (await this.areFriends(tx, trip.ownerId, userId));
          const now = new Date();
          // Asking again reopens the request as a new one.
          const fields = {
            status: autoApprove
              ? JOIN_REQUEST_STATUS.APPROVED
              : JOIN_REQUEST_STATUS.PENDING,
            message: dto.message ?? null,
            decidedById: null,
            decidedAt: autoApprove ? now : null,
            createdAt: now,
          };
          const request = await tx.tripJoinRequest.upsert({
            where: {
              tripId_requesterId: { tripId: trip.id, requesterId: userId },
            },
            create: { tripId: trip.id, requesterId: userId, ...fields },
            update: fields,
            select: { id: true },
          });

          if (autoApprove) {
            const timelineEvent = await this.activateMember(
              tx,
              trip.id,
              userId,
              via,
            );
            if (!(await lockTripRow(tx, trip.id))) {
              throw new NotFoundException('Trip not found');
            }
            await reconcileRecruitmentState(tx, trip.id);
            return {
              approved: true as const,
              tripId: trip.id,
              requestId: request.id,
              timelineEvent,
            };
          }

          const push = await this.notifyReviewers(tx, trip, userId);
          return {
            approved: false as const,
            tripId: trip.id,
            requestId: request.id,
            push,
          };
        },
        { isolationLevel: Prisma.TransactionIsolationLevel.Serializable },
      )
      .catch(rethrowMembershipConflict);

    if (result.approved) {
      this.tripGateway.emitTimelineEvent(result.tripId, result.timelineEvent);
    } else {
      this.sendPush(result.push, NOTIFICATION_TYPE.TRIP_JOIN_REQUEST, {
        tripId: result.tripId,
        requestId: result.requestId,
      });
    }

    return this.getResponse(result.requestId);
  }

  private async findTripForJoin(
    tx: Prisma.TransactionClient,
    lookup: { tripId: string } | { inviteCode: string },
  ) {
    const select = {
      id: true,
      name: true,
      status: true,
      maxMembers: true,
      ownerId: true,
      autoApproveFriends: true,
      visibility: true,
    } as const;

    if ('inviteCode' in lookup) {
      const code = normalizeInviteCode(lookup.inviteCode);
      if (!code) {
        throw new NotFoundException('Mã mời không hợp lệ');
      }
      const trip = await tx.trip.findUnique({
        where: { inviteCode: code },
        select,
      });
      if (!trip) throw new NotFoundException('Mã mời không hợp lệ');
      return trip;
    }

    const trip = await tx.trip.findUnique({
      where: { id: lookup.tripId },
      select,
    });
    if (!trip) throw new NotFoundException('Trip not found');
    return trip;
  }

  async getJoinRequests(
    tripId: string,
    userId: string,
    query: QueryJoinRequestsDto,
  ): Promise<{
    data: JoinRequestResponse[];
    meta: {
      nextCursor: string | null;
      hasMore: boolean;
      counts: JoinRequestCounts;
    };
  }> {
    await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'MANAGE_JOIN_REQUESTS',
    );

    const { status, limit, cursor } = query;
    const where = { tripId, status } satisfies Prisma.TripJoinRequestWhereInput;

    // The cursor must belong to the same trip and tab, otherwise `skip: 1`
    // would silently drop a valid request.
    if (cursor) {
      const cursorExists = await this.prisma.tripJoinRequest.findFirst({
        where: { ...where, id: cursor },
        select: { id: true },
      });
      if (!cursorExists) {
        throw new BadRequestException('Invalid cursor for this trip');
      }
    }

    const [rows, groups] = await Promise.all([
      this.prisma.tripJoinRequest.findMany({
        where,
        take: limit + 1,
        ...(cursor ? { cursor: { id: cursor }, skip: 1 } : {}),
        orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
        select: JOIN_REQUEST_SELECT,
      }),
      this.prisma.tripJoinRequest.groupBy({
        by: ['status'],
        where: { tripId },
        orderBy: { status: 'asc' },
        _count: { _all: true },
      }),
    ]);

    const hasMore = rows.length > limit;
    const items = hasMore ? rows.slice(0, limit) : rows;
    const counts: JoinRequestCounts = { pending: 0, approved: 0, rejected: 0 };
    for (const group of groups) {
      const total =
        typeof group._count === 'object' ? (group._count._all ?? 0) : 0;
      counts[statusKey(group.status)] = total;
    }

    return {
      data: await this.toResponses(tripId, items),
      meta: {
        nextCursor: hasMore ? items[items.length - 1].id : null,
        hasMore,
        counts,
      },
    };
  }

  async approve(
    tripId: string,
    requestId: string,
    userId: string,
  ): Promise<JoinRequestResponse> {
    const result = await this.prisma
      .$transaction(
        async (tx) => {
          await TripAccessPolicy.authorize(
            tx,
            tripId,
            userId,
            'MANAGE_JOIN_REQUESTS',
          );
          const request = await this.findRequest(tx, tripId, requestId);
          assertPending(request.status);
          await this.assertJoinable(
            tx,
            { id: tripId, ...request.trip },
            request.requesterId,
          );

          await this.decide(
            tx,
            requestId,
            JOIN_REQUEST_STATUS.APPROVED,
            userId,
          );
          const timelineEvent = await this.activateMember(
            tx,
            tripId,
            request.requesterId,
            'JOIN_REQUEST',
          );
          if (!(await lockTripRow(tx, tripId))) {
            throw new NotFoundException('Trip not found');
          }
          await reconcileRecruitmentState(tx, tripId);

          const push: PushTarget = {
            userIds: [request.requesterId],
            title: 'Yêu cầu tham gia đã được duyệt',
            body: `Bạn đã trở thành thành viên chuyến đi "${request.trip.name}"`,
          };
          await this.notifications.create(tx, {
            userId: request.requesterId,
            actorId: userId,
            tripId,
            type: NOTIFICATION_TYPE.TRIP_JOIN_REQUEST_APPROVED,
            title: push.title,
            message: push.body,
          });
          return { timelineEvent, push };
        },
        { isolationLevel: Prisma.TransactionIsolationLevel.Serializable },
      )
      .catch(rethrowMembershipConflict);

    this.tripGateway.emitTimelineEvent(tripId, result.timelineEvent);
    this.sendPush(result.push, NOTIFICATION_TYPE.TRIP_JOIN_REQUEST_APPROVED, {
      tripId,
      requestId,
    });
    return this.getResponse(requestId);
  }

  async reject(
    tripId: string,
    requestId: string,
    userId: string,
  ): Promise<JoinRequestResponse> {
    const push = await this.prisma.$transaction(async (tx) => {
      await TripAccessPolicy.authorize(
        tx,
        tripId,
        userId,
        'MANAGE_JOIN_REQUESTS',
      );
      const request = await this.findRequest(tx, tripId, requestId);
      assertPending(request.status);
      await this.decide(tx, requestId, JOIN_REQUEST_STATUS.REJECTED, userId);

      const target: PushTarget = {
        userIds: [request.requesterId],
        title: 'Yêu cầu tham gia bị từ chối',
        body: `Yêu cầu tham gia chuyến đi "${request.trip.name}" chưa được chấp nhận`,
      };
      await this.notifications.create(tx, {
        userId: request.requesterId,
        actorId: userId,
        tripId,
        type: NOTIFICATION_TYPE.TRIP_JOIN_REQUEST_REJECTED,
        title: target.title,
        message: target.body,
      });
      return target;
    });

    this.sendPush(push, NOTIFICATION_TYPE.TRIP_JOIN_REQUEST_REJECTED, {
      tripId,
      requestId,
    });
    return this.getResponse(requestId);
  }

  async getSettings(tripId: string, userId: string) {
    await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'MANAGE_JOIN_REQUESTS',
    );
    return this.prisma.trip.findUniqueOrThrow({
      where: { id: tripId },
      select: { autoApproveFriends: true },
    });
  }

  async updateSettings(
    tripId: string,
    userId: string,
    dto: UpdateJoinRequestSettingsDto,
  ) {
    return this.prisma.$transaction(async (tx) => {
      await TripAccessPolicy.authorize(
        tx,
        tripId,
        userId,
        'MANAGE_JOIN_REQUESTS',
      );
      return tx.trip.update({
        where: { id: tripId },
        data: { autoApproveFriends: dto.autoApproveFriends },
        select: { autoApproveFriends: true },
      });
    });
  }

  private async assertEffectivelyOpen(
    client: Pick<Prisma.TransactionClient, 'tripRecruitment'>,
    tripId: string,
    status: string,
  ): Promise<void> {
    const recruitment = await client.tripRecruitment.findUnique({
      where: { tripId },
      select: { state: true, expiresAt: true },
    });
    if (
      !isEffectiveOpen(
        recruitment,
        status as TRIP_STATUS,
      )
    ) {
      throw new NotFoundException('Trip is not open for members');
    }
  }

  private async assertJoinable(
    tx: Prisma.TransactionClient,
    trip: { id: string; status: string; maxMembers: number | null },
    userId: string,
  ): Promise<void> {
    const [existingMember, activeMemberCount] = await Promise.all([
      tx.tripMember.findUnique({
        where: { tripId_userId: { tripId: trip.id, userId } },
        select: { status: true },
      }),
      tx.tripMember.count({
        where: { tripId: trip.id, status: MEMBER_STATUS.ACTIVE },
      }),
    ]);
    TripMembershipPolicy.assertJoinable({
      status: trip.status,
      maxMembers: trip.maxMembers,
      activeMemberCount,
      previousMemberStatus: existingMember?.status,
    });
  }

  private async findRequest(
    tx: Prisma.TransactionClient,
    tripId: string,
    requestId: string,
  ) {
    const request = await tx.tripJoinRequest.findFirst({
      where: { id: requestId, tripId },
      select: {
        requesterId: true,
        status: true,
        trip: { select: { name: true, status: true, maxMembers: true } },
      },
    });
    if (!request) throw new NotFoundException('Join request not found');
    return request;
  }

  /** Only a still-pending request is decided, so two reviewers cannot both win. */
  private async decide(
    tx: Prisma.TransactionClient,
    requestId: string,
    status: JOIN_REQUEST_STATUS,
    reviewerId: string,
  ): Promise<void> {
    const decided = await tx.tripJoinRequest.updateMany({
      where: { id: requestId, status: JOIN_REQUEST_STATUS.PENDING },
      data: { status, decidedById: reviewerId, decidedAt: new Date() },
    });
    if (decided.count !== 1) {
      throw new ConflictException('Join request is no longer pending');
    }
  }

  private async activateMember(
    tx: Prisma.TransactionClient,
    tripId: string,
    userId: string,
    via: JoinVia,
  ) {
    const member = await tx.tripMember.upsert({
      where: { tripId_userId: { tripId, userId } },
      create: { tripId, userId, status: MEMBER_STATUS.ACTIVE },
      update: {
        role: TRIP_ROLE.MEMBER,
        joinedAt: new Date(),
        status: MEMBER_STATUS.ACTIVE,
        leftAt: null,
      },
    });
    return this.tripTimelineService.createEvent(tx, tripId, userId, {
      type: TIMELINE_EVENT_TYPE.MEMBER_JOINED,
      content: 'Đã tham gia chuyến đi',
      metadata: { via },
      target: { type: TIMELINE_TARGET_TYPE.MEMBER, id: member.id },
    });
  }

  private async notifyReviewers(
    tx: Prisma.TransactionClient,
    trip: { id: string; name: string },
    requesterId: string,
  ): Promise<PushTarget> {
    const [requester, reviewers] = await Promise.all([
      tx.user.findUniqueOrThrow({
        where: { id: requesterId },
        select: { displayname: true },
      }),
      tx.tripMember.findMany({
        where: {
          tripId: trip.id,
          status: MEMBER_STATUS.ACTIVE,
          role: { in: [TRIP_ROLE.OWNER, TRIP_ROLE.ADMIN] },
        },
        select: { userId: true },
      }),
    ]);

    const push: PushTarget = {
      userIds: reviewers.map((reviewer) => reviewer.userId),
      title: 'Yêu cầu tham gia mới',
      body: `${requester.displayname} muốn tham gia chuyến đi "${trip.name}"`,
    };
    for (const userId of push.userIds) {
      await this.notifications.create(tx, {
        userId,
        actorId: requesterId,
        tripId: trip.id,
        type: NOTIFICATION_TYPE.TRIP_JOIN_REQUEST,
        title: push.title,
        message: push.body,
      });
    }
    return push;
  }

  private async areFriends(
    tx: Prisma.TransactionClient,
    userId: string,
    otherUserId: string,
  ): Promise<boolean> {
    const friendship = await tx.friendship.findFirst({
      where: {
        OR: [
          { userId, friendId: otherUserId },
          { userId: otherUserId, friendId: userId },
        ],
      },
      select: { id: true },
    });
    return friendship !== null;
  }

  /** The notification is already stored; a push failure must not fail the request. */
  private sendPush(
    target: PushTarget,
    type: NOTIFICATION_TYPE,
    data: { tripId: string; requestId: string },
  ): void {
    for (const userId of target.userIds) {
      this.pushNotifications
        .sendToUser(userId, {
          title: target.title,
          body: target.body,
          data: { type, ...data },
        })
        .catch((error: unknown) => {
          this.logger.warn(
            `Failed to push ${type} to user ${userId}: ${
              error instanceof Error ? error.message : 'unknown error'
            }`,
          );
        });
    }
  }

  private async getResponse(requestId: string): Promise<JoinRequestResponse> {
    const request = await this.prisma.tripJoinRequest.findUniqueOrThrow({
      where: { id: requestId },
      select: JOIN_REQUEST_SELECT,
    });
    const [response] = await this.toResponses(request.tripId, [request]);
    return response;
  }

  private async toResponses(
    tripId: string,
    requests: JoinRequestRecord[],
  ): Promise<JoinRequestResponse[]> {
    if (requests.length === 0) return [];
    const requesterIds = requests.map((request) => request.requester.id);
    const [profile, dnaByUser, onlineUserIds] = await Promise.all([
      this.loadTripDnaProfile(tripId),
      this.loadTravelDna(requesterIds),
      this.loadOnlineUserIds(requesterIds),
    ]);

    return requests.map((request) => {
      const { requester } = request;
      const dna = dnaByUser.get(requester.id) ?? [];
      const persona = topTravelPersona(dna);
      return {
        id: request.id,
        tripId: request.tripId,
        status: request.status,
        requester: {
          id: requester.id,
          displayName: requester.displayname,
          username: requester.username,
          avatarUrl:
            requester.avatar && requester.avatar.deletedAt === null
              ? this.s3.getPublicUrl(requester.avatar.objectKey)
              : null,
          isVerified: requester.hostStatus === HOST_STATUS.APPROVED,
          isOnline: onlineUserIds.has(requester.id),
        },
        message: request.message,
        travelPersona: persona?.travelPersona ?? null,
        personaType: persona?.personaType ?? null,
        matchScore: joinRequestMatchScore(profile, dna),
        matchNote: null,
        createdAt: request.createdAt,
        decidedAt: request.decidedAt,
      };
    });
  }

  private async loadTripDnaProfile(tripId: string): Promise<TripDnaProfile> {
    const trip = await this.prisma.trip.findUniqueOrThrow({
      where: { id: tripId },
      select: {
        tripType: true,
        itineraryItems: { select: { place: { select: { category: true } } } },
      },
    });
    return buildTripDnaProfile(
      trip.tripType,
      trip.itineraryItems.map((item) => item.place.category),
    );
  }

  private async loadTravelDna(
    userIds: string[],
  ): Promise<Map<string, TravelDnaScore[]>> {
    const rows = await this.prisma.userTravelDNA.findMany({
      where: { userId: { in: userIds }, score: { gt: 0 } },
      select: { userId: true, type: true, score: true },
    });
    const byUser = new Map<string, TravelDnaScore[]>();
    for (const { userId, type, score } of rows) {
      const scores = byUser.get(userId) ?? [];
      scores.push({ type, score });
      byUser.set(userId, scores);
    }
    return byUser;
  }

  /** Presence is best effort; the list must load even if sockets are down. */
  private async loadOnlineUserIds(userIds: string[]): Promise<Set<string>> {
    try {
      return await this.tripGateway.getConnectedUserIds(userIds);
    } catch (error) {
      this.logger.warn(
        `Failed to read presence of join requesters: ${
          error instanceof Error ? error.message : 'unknown error'
        }`,
      );
      return new Set();
    }
  }
}

function statusKey(status: JOIN_REQUEST_STATUS): keyof JoinRequestCounts {
  switch (status) {
    case JOIN_REQUEST_STATUS.PENDING:
      return 'pending';
    case JOIN_REQUEST_STATUS.APPROVED:
      return 'approved';
    case JOIN_REQUEST_STATUS.REJECTED:
      return 'rejected';
  }
}

import { Injectable, Logger, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../../../prisma.service';
import { S3Service } from '../../../uploads/s3/s3.service';
import { Prisma } from '../../../generated/prisma/client';
import {
  CURRENCY,
  MEMBER_STATUS,
  TRIP_ROLE,
  TRIP_STATUS,
} from '../../../generated/prisma/enums';
import { TRAVEL_DNA_CONFIG } from '../../travelDNA/travel.constant';
import { TripRoomWS } from '../trip-gateway.service';
import {
  buildTripReadAccessWhere,
  TimePolicy,
  TripAccessPolicy,
  TripPolicy,
  TripPolicyError,
} from '../policies';
import { isEffectiveOpen } from '../trip-relations/trip-recruitment/recruitment.policy';
import {
  CompletionProgress,
  completionPoints,
  countCompletionProgress,
} from '../trip-relations/trip-completetion/completion-progress';

const MEMORY_PREVIEW_LIMIT = 6;
/** Older events are paged through GET /trips/timeline/:tripId. */
const TIMELINE_PREVIEW_LIMIT = 5;
const NEW_MEMBER_WINDOW_MS = 3 * 24 * 60 * 60 * 1000;

const CURRENT_DESTINATION_STATUSES: readonly TRIP_STATUS[] = [
  TRIP_STATUS.UPCOMING,
  TRIP_STATUS.ONGOING,
];

const MEDIA_URL_SELECT = {
  objectKey: true,
  deletedAt: true,
} satisfies Prisma.UploadedMediaSelect;

/** Other members' preferences (notificationEnabled) are not exposed. */
const TRIP_DETAIL_SELECT = {
  id: true,
  name: true,
  description: true,
  status: true,
  visibility: true,
  tripType: true,
  startDate: true,
  endDate: true,
  maxMembers: true,
  budgetLevel: true,
  budgetCurrency: true,
  inviteCode: true,
  coverMedia: { select: MEDIA_URL_SELECT },
  destinations: {
    orderBy: { order: 'asc' },
    select: {
      id: true,
      city: true,
      country: true,
      order: true,
      startDate: true,
      endDate: true,
    },
  },
  members: {
    where: { status: MEMBER_STATUS.ACTIVE },
    orderBy: { joinedAt: 'asc' },
    select: {
      id: true,
      userId: true,
      role: true,
      status: true,
      joinedAt: true,
      user: {
        select: { displayname: true, avatar: { select: MEDIA_URL_SELECT } },
      },
    },
  },
  recruitment: {
    select: {
      state: true,
      expiresAt: true,
      requirements: true,
      estimatedBudgetPerPerson: true,
    },
  },
} satisfies Prisma.TripSelect;

type TripDetailRecord = Prisma.TripGetPayload<{
  select: typeof TRIP_DETAIL_SELECT;
}>;
type TripDetailMemberRecord = TripDetailRecord['members'][number];
type MediaUrlSource = { objectKey: string; deletedAt: Date | null } | null;

type ExpenseSection = {
  summary: { totalAmount: number; currency: CURRENCY };
  /** Keyed by TripMember.id (the expense payer). */
  spentByMember: Map<string, number>;
};

type MemorySection = {
  preview: {
    totalCount: number;
    items: Array<{
      id: string;
      imageUrl: string;
      caption: string | null;
      authorName: string | null;
    }>;
  };
  /** Keyed by User.id (the uploader). */
  countByUser: Map<string, number>;
};

type TimelineSection = {
  preview: {
    totalCount: number;
    items: Array<{
      id: string;
      type: string;
      actorName: string;
      actorAvatarUrl: string | null;
      content: string;
      createdAt: Date;
    }>;
  };
  /** Keyed by TripMember.id; only covers members active in the preview. */
  latestContentByMember: Map<string, string>;
};

type CompletionReward = { points: number; canClaim: boolean; claimed: boolean };

@Injectable()
export class TripDetailService {
  private readonly logger = new Logger(TripDetailService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
    private readonly tripRoomWS: TripRoomWS,
  ) {}

  async getTripDetail(tripId: string, userId: string) {
    const trip = await this.prisma.trip.findFirst({
      where: { id: tripId, ...buildTripReadAccessWhere(userId) },
      select: TRIP_DETAIL_SELECT,
    });

    if (!trip) {
      throw new NotFoundException('Trip not found');
    }

    const viewer = trip.members.find((member) => member.userId === userId);
    const now = new Date();

    // Expenses, memories, timeline and rewards are member-only, even on
    // public trips; outsiders get null for those sections.
    const [activity, personas, onlineUserIds, expenses, memories, timeline] =
      await Promise.all([
        this.loadActivitySummary(trip.id, trip.members.length, now),
        this.loadTravelPersonas(trip.members.map((member) => member.userId)),
        TripAccessPolicy.can(viewer, 'READ')
          ? this.loadOnlineUserIds(trip.id)
          : new Set<string>(),
        TripAccessPolicy.can(viewer, 'READ_EXPENSES')
          ? this.loadExpenses(trip)
          : null,
        TripAccessPolicy.can(viewer, 'READ_MEMORIES')
          ? this.loadMemories(trip.id)
          : null,
        TripAccessPolicy.can(viewer, 'READ_TIMELINE')
          ? this.loadTimeline(trip.id)
          : null,
      ]);
    const completionReward =
      viewer && TripAccessPolicy.can(viewer, 'COMPLETE_TRIP')
        ? await this.loadCompletionReward(trip, viewer)
        : null;

    const openPost = isEffectiveOpen(trip.recruitment, trip.status, now);
    const memberCount = trip.members.length;

    return {
      id: trip.id,
      name: trip.name,
      description: trip.description,
      coverImageUrl: this.toPublicUrl(trip.coverMedia),
      status: trip.status,
      visibility: trip.visibility,
      tripType: trip.tripType,
      startDate: trip.startDate,
      endDate: trip.endDate,
      maxMembers: trip.maxMembers,
      budgetLevel: trip.budgetLevel,
      inviteCode: TripAccessPolicy.can(viewer, 'INVITE_MEMBER')
        ? trip.inviteCode
        : null,
      viewer: { userId, role: viewer?.role ?? null },
      expenseSummary: expenses?.summary ?? null,
      checkinProgress: {
        completedCount: activity.completedCount,
        totalCount: activity.totalCount,
        pointsEarned: completionReward?.claimed ? completionReward.points : 0,
      },
      members: trip.members.map((member) => ({
        id: member.id,
        userId: member.userId,
        displayName: member.user.displayname,
        avatarUrl: this.toPublicUrl(member.user.avatar),
        role: member.role,
        joinedAt: member.joinedAt,
        travelPersona: personas.get(member.userId) ?? null,
        activityNote: timeline?.latestContentByMember.get(member.id) ?? null,
        isOnline: onlineUserIds.has(member.userId),
        isNewMember: isNewMember(member, now),
        amountSpent: expenses
          ? (expenses.spentByMember.get(member.id) ?? 0)
          : null,
        memoryCount: memories?.countByUser.get(member.userId) ?? 0,
      })),
      destinations: withCurrentDestination(
        trip.destinations,
        trip.status,
        TimePolicy.today(),
      ),
      nextActivity: viewer ? activity.nextActivity : null,
      memories: memories?.preview ?? null,
      completionReward,
      timeline: timeline?.preview ?? null,
      requirements: openPost ? (trip.recruitment?.requirements ?? null) : null,
      estimatedBudgetPerPerson: openPost
        ? (trip.recruitment?.estimatedBudgetPerPerson?.toString() ?? null)
        : null,
      slotsRemaining: openPost
        ? Math.max(0, trip.maxMembers - memberCount)
        : null,
      expiresAt: openPost ? (trip.recruitment?.expiresAt ?? null) : null,
    };
  }

  /** Group progress: an activity counts once every active member checked in. */
  private async loadActivitySummary(
    tripId: string,
    activeMemberCount: number,
    now: Date,
  ) {
    const [groups, next] = await Promise.all([
      this.prisma.itineraryItem.groupBy({
        by: ['isCheckin'],
        where: { tripId },
        _count: { _all: true },
      }),
      this.prisma.itineraryItem.findFirst({
        where: { tripId, startTime: { gt: now } },
        orderBy: [{ startTime: 'asc' }, { id: 'asc' }],
        select: {
          id: true,
          title: true,
          notes: true,
          startTime: true,
          placeId: true,
        },
      }),
    ]);

    let totalCount = 0;
    let completedCount = 0;
    for (const group of groups) {
      totalCount += group._count._all;
      if (group.isCheckin) completedCount += group._count._all;
    }

    // Check-ins are unique per (trip, user, place), so this counts members.
    const checkedInCount = next
      ? await this.prisma.tripCheckin.count({
          where: {
            tripId,
            placeId: next.placeId,
            member: { status: MEMBER_STATUS.ACTIVE },
          },
        })
      : 0;

    return {
      totalCount,
      completedCount,
      nextActivity: next
        ? {
            id: next.id,
            title: next.title,
            description: next.notes,
            startTime: next.startTime,
            confirmedCount: checkedInCount,
            totalCount: activeMemberCount,
          }
        : null,
    };
  }

  /** Each member's strongest Travel DNA badge, e.g. "Beach Lover 🏖️". */
  private async loadTravelPersonas(
    userIds: string[],
  ): Promise<Map<string, string>> {
    const personas = new Map<string, string>();
    if (userIds.length === 0) return personas;

    const rows = await this.prisma.userTravelDNA.findMany({
      where: { userId: { in: userIds }, score: { gt: 0 } },
      orderBy: [{ score: 'desc' }, { type: 'asc' }],
      select: { userId: true, type: true },
    });
    for (const { userId, type } of rows) {
      if (personas.has(userId)) continue;
      const badge = TRAVEL_DNA_CONFIG[type];
      personas.set(userId, `${badge.name} ${badge.icon}`);
    }
    return personas;
  }

  /** Presence is best effort; the detail must load even if sockets are down. */
  private async loadOnlineUserIds(tripId: string): Promise<Set<string>> {
    try {
      return await this.tripRoomWS.getOnlineUserIds(tripId);
    } catch (error) {
      this.logger.warn(
        `Failed to read presence for trip ${tripId}: ${
          error instanceof Error ? error.message : 'unknown error'
        }`,
      );
      return new Set();
    }
  }

  private async loadExpenses(trip: TripDetailRecord): Promise<ExpenseSection> {
    const groups = await this.prisma.tripExpense.groupBy({
      by: ['payerId', 'currency'],
      where: { tripId: trip.id, deletedAt: null },
      _sum: { amount: true },
    });

    // Amounts are never converted between currencies, so the summary only
    // adds up expenses recorded in its own currency.
    const currency = summaryCurrency(
      groups.map((group) => group.currency),
      trip.budgetCurrency,
    );
    let total = new Prisma.Decimal(0);
    const spentByMember = new Map<string, number>();
    for (const group of groups) {
      if (group.currency !== currency || !group._sum.amount) continue;
      total = total.add(group._sum.amount);
      spentByMember.set(
        group.payerId,
        (spentByMember.get(group.payerId) ?? 0) + group._sum.amount.toNumber(),
      );
    }

    return {
      summary: { totalAmount: total.toNumber(), currency },
      spentByMember,
    };
  }

  private async loadMemories(tripId: string): Promise<MemorySection> {
    const [uploaderGroups, rows] = await Promise.all([
      // TripMedia.mediaId is unique, so each media row is one memory.
      this.prisma.uploadedMedia.groupBy({
        by: ['userId'],
        where: { deletedAt: null, tripMedias: { some: { tripId } } },
        _count: { _all: true },
      }),
      this.prisma.tripMedia.findMany({
        where: { tripId, media: { deletedAt: null } },
        orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
        take: MEMORY_PREVIEW_LIMIT,
        select: {
          id: true,
          caption: true,
          media: {
            select: {
              objectKey: true,
              user: { select: { displayname: true } },
            },
          },
        },
      }),
    ]);

    let totalCount = 0;
    const countByUser = new Map<string, number>();
    for (const group of uploaderGroups) {
      totalCount += group._count._all;
      if (group.userId) countByUser.set(group.userId, group._count._all);
    }

    return {
      preview: {
        totalCount,
        items: rows.map((row) => ({
          id: row.id,
          imageUrl: this.s3.getPublicUrl(row.media.objectKey),
          caption: row.caption,
          authorName: row.media.user?.displayname ?? null,
        })),
      },
      countByUser,
    };
  }

  private async loadTimeline(tripId: string): Promise<TimelineSection> {
    const [events, totalCount] = await Promise.all([
      this.prisma.tripTimelineEvent.findMany({
        where: { tripId },
        orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
        take: TIMELINE_PREVIEW_LIMIT,
        select: {
          id: true,
          type: true,
          content: true,
          createdAt: true,
          memberId: true,
          member: {
            select: {
              user: {
                select: {
                  displayname: true,
                  avatar: { select: MEDIA_URL_SELECT },
                },
              },
            },
          },
        },
      }),
      this.prisma.tripTimelineEvent.count({ where: { tripId } }),
    ]);

    const latestContentByMember = new Map<string, string>();
    for (const event of events) {
      if (!latestContentByMember.has(event.memberId)) {
        latestContentByMember.set(event.memberId, event.content);
      }
    }

    return {
      preview: {
        totalCount,
        items: events.map((event) => ({
          id: event.id,
          type: event.type,
          actorName: event.member.user.displayname,
          actorAvatarUrl: this.toPublicUrl(event.member.user.avatar),
          content: event.content,
          createdAt: event.createdAt,
        })),
      },
      latestContentByMember,
    };
  }

  /** Mirrors the rules of POST /trips/:tripId/completion for the viewer. */
  private async loadCompletionReward(
    trip: TripDetailRecord,
    viewer: TripDetailMemberRecord,
  ): Promise<CompletionReward> {
    const [completion, progress] = await Promise.all([
      this.prisma.tripCompletion.findUnique({
        where: { memberId: viewer.id },
        select: { pointsAwarded: true },
      }),
      countCompletionProgress(this.prisma, trip.id, viewer.userId),
    ]);

    if (completion) {
      return {
        points: completion.pointsAwarded,
        canClaim: false,
        claimed: true,
      };
    }
    return {
      points: completionPoints(progress.checkinCount),
      canClaim: canCompleteTrip(trip, progress, TimePolicy.today()),
      claimed: false,
    };
  }

  private toPublicUrl(media: MediaUrlSource): string | null {
    return media && media.deletedAt === null
      ? this.s3.getPublicUrl(media.objectKey)
      : null;
  }
}

function isNewMember(member: TripDetailMemberRecord, now: Date): boolean {
  return (
    member.role === TRIP_ROLE.MEMBER &&
    now.getTime() - member.joinedAt.getTime() < NEW_MEMBER_WINDOW_MS
  );
}

function summaryCurrency(
  usedCurrencies: CURRENCY[],
  budgetCurrency: string | null,
): CURRENCY {
  const distinct = new Set(usedCurrencies);
  if (distinct.size === 1) return [...distinct][0];
  return isCurrency(budgetCurrency) ? budgetCurrency : CURRENCY.VND;
}

function isCurrency(value: string | null): value is CURRENCY {
  return Object.values<string>(CURRENCY).includes(value ?? '');
}

/**
 * On a transfer day two stops contain today; the later one is where the
 * group is heading, so it is the current one.
 */
function withCurrentDestination<
  T extends { id: string; startDate: Date; endDate: Date },
>(destinations: T[], status: TRIP_STATUS, today: string) {
  const current = CURRENT_DESTINATION_STATUSES.includes(status)
    ? destinations.findLast(
        (destination) =>
          toIsoDate(destination.startDate) <= today &&
          today <= toIsoDate(destination.endDate),
      )
    : undefined;
  return destinations.map((destination) => ({
    ...destination,
    isCurrent: destination.id === current?.id,
  }));
}

function canCompleteTrip(
  trip: Pick<TripDetailRecord, 'status' | 'startDate'>,
  progress: CompletionProgress,
  today: string,
): boolean {
  try {
    TripPolicy.assertStarted(
      { status: trip.status, startDate: toIsoDate(trip.startDate) },
      today,
    );
    TripPolicy.assertCompletionThreshold(
      progress.checkinCount,
      progress.totalPlaces,
    );
    return true;
  } catch (error) {
    if (error instanceof TripPolicyError) return false;
    throw error;
  }
}

function toIsoDate(date: Date): string {
  return date.toISOString().slice(0, 10);
}

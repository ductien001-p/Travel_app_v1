import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../../prisma.service';
import { S3Service } from '../../uploads/s3/s3.service';
import { TravelDnaService } from '../travelDNA/travel-dna.service';
import {
  BudgetLevel,
  GalleryStatus,
  MEMBER_STATUS,
  RANK,
  TRIP_STATUS,
} from '../../generated/prisma/enums';

const COUNTED_TRIP_STATUSES: TRIP_STATUS[] = [
  TRIP_STATUS.UPCOMING,
  TRIP_STATUS.ONGOING,
  TRIP_STATUS.COMPLETED,
  TRIP_STATUS.NOTCOMPLETED,
];

const SAVED_PLACE_LIMIT = 20;
const POST_LIMIT = 12;
const MEMORY_PREVIEW_LIMIT = 2;
const HIGHLIGHT_LIMIT = 3;

type MediaRef = { objectKey: string; deletedAt: Date | null } | null;

type ShowcaseTripRecord = {
  id: string;
  name: string;
  status: TRIP_STATUS;
  startDate: Date;
  endDate: Date;
  budgetLevel: BudgetLevel | null;
  maxMembers: number;
  coverMedia: MediaRef;
  destinations: { highlights: string[] }[];
  _count: { members: number };
};

const tripInclude = {
  coverMedia: { select: { objectKey: true, deletedAt: true } },
  destinations: {
    orderBy: { order: 'asc' as const },
    select: { highlights: true },
  },
  _count: {
    select: {
      members: { where: { status: MEMBER_STATUS.ACTIVE } },
    },
  },
};

@Injectable()
export class ProfileShowcaseService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly travelDna: TravelDnaService,
    private readonly s3: S3Service,
  ) {}

  async getShowcase(userId: string) {
    const user = await this.prisma.user.findFirst({
      where: { id: userId, deletedAt: null },
      select: { id: true, hostStatus: true },
    });
    if (!user) {
      throw new NotFoundException('User not found');
    }

    const activeMembership = {
      members: { some: { userId, status: MEMBER_STATUS.ACTIVE } },
    };

    const [
      travelDna,
      ranking,
      tripCount,
      followerCount,
      followingCount,
      ongoing,
      upcoming,
      memoryCount,
      memoryRows,
      savedCount,
      savedRows,
      postCount,
      postRows,
    ] = await Promise.all([
      this.travelDna.getUserTravelDNA(userId),
      this.loadRanking(userId),
      this.prisma.tripMember.count({
        where: {
          userId,
          status: MEMBER_STATUS.ACTIVE,
          trip: { status: { in: COUNTED_TRIP_STATUSES } },
        },
      }),
      this.prisma.userFollow.count({ where: { followingId: userId } }),
      this.prisma.userFollow.count({ where: { followerId: userId } }),
      this.prisma.trip.findFirst({
        where: { status: TRIP_STATUS.ONGOING, ...activeMembership },
        orderBy: { startDate: 'desc' },
        include: tripInclude,
      }),
      this.prisma.trip.findFirst({
        where: { status: TRIP_STATUS.UPCOMING, ...activeMembership },
        orderBy: { startDate: 'asc' },
        include: tripInclude,
      }),
      this.prisma.tripMedia.count({ where: { trip: activeMembership } }),
      this.prisma.tripMedia.findMany({
        where: { trip: activeMembership },
        orderBy: { createdAt: 'desc' },
        take: MEMORY_PREVIEW_LIMIT,
        select: {
          id: true,
          media: { select: { objectKey: true, deletedAt: true } },
        },
      }),
      this.prisma.savedPlace.count({ where: { userId } }),
      this.prisma.savedPlace.findMany({
        where: { userId },
        orderBy: { createdAt: 'desc' },
        take: SAVED_PLACE_LIMIT,
        select: {
          id: true,
          placeId: true,
          place: {
            select: {
              name: true,
              city: true,
              country: true,
              category: true,
              coverImages: {
                where: { status: GalleryStatus.ACTIVE },
                orderBy: [{ isCover: 'desc' }, { score: 'desc' }],
                take: 1,
                select: {
                  media: { select: { objectKey: true, deletedAt: true } },
                },
              },
            },
          },
        },
      }),
      this.prisma.post.count({
        where: { authorId: userId, deletedAt: null },
      }),
      this.prisma.post.findMany({
        where: { authorId: userId, deletedAt: null },
        orderBy: { createdAt: 'desc' },
        take: POST_LIMIT,
        select: {
          id: true,
          caption: true,
          postMedias: {
            orderBy: { orderIndex: 'asc' },
            take: 1,
            select: {
              media: { select: { objectKey: true, deletedAt: true } },
            },
          },
        },
      }),
    ]);

    const activityStats = await this.loadActivityStats(
      [ongoing?.id, upcoming?.id].filter((id): id is string => Boolean(id)),
    );

    return {
      hostStatus: user.hostStatus,
      ranking,
      social: { tripCount, followerCount, followingCount },
      travelDna,
      ongoingTrip: this.toTrip(ongoing, activityStats),
      upcomingTrip: this.toTrip(upcoming, activityStats),
      memories: {
        totalCount: memoryCount,
        items: memoryRows.flatMap((row) => {
          const imageUrl = this.publicUrl(row.media);
          return imageUrl ? [{ id: row.id, imageUrl }] : [];
        }),
      },
      savedPlaces: {
        count: savedCount,
        items: savedRows.map((row) => ({
          id: row.id,
          placeId: row.placeId,
          name: row.place.name,
          city: row.place.city,
          country: row.place.country,
          category: row.place.category,
          coverImageUrl: this.publicUrl(row.place.coverImages[0]?.media),
        })),
      },
      posts: {
        count: postCount,
        items: postRows.map((row) => ({
          id: row.id,
          caption: row.caption,
          imageUrl: this.publicUrl(row.postMedias[0]?.media),
        })),
      },
    };
  }

  private async loadRanking(userId: string) {
    const [ranking, latest] = await Promise.all([
      this.prisma.userRanking.findUnique({ where: { userId } }),
      this.prisma.dailyLeaderboard.findFirst({
        orderBy: { date: 'desc' },
        select: { date: true },
      }),
    ]);

    let leaderboardRanking: number | null = null;
    let percentile: number | null = null;
    if (latest) {
      const [entry, total] = await Promise.all([
        this.prisma.dailyLeaderboard.findUnique({
          where: { userId_date: { userId, date: latest.date } },
          select: { ranking: true },
        }),
        this.prisma.dailyLeaderboard.count({ where: { date: latest.date } }),
      ]);
      leaderboardRanking = entry?.ranking ?? null;
      if (leaderboardRanking != null && total > 0) {
        percentile = Math.max(1, Math.ceil((leaderboardRanking / total) * 100));
      }
    }

    return {
      userId,
      totalPoints: ranking?.totalPoints ?? 0,
      totalTripsCompleted: ranking?.tripsCompleted ?? 0,
      rank: ranking?.rank ?? RANK.BEGINNER,
      ranking: leaderboardRanking,
      percentile,
    };
  }

  private async loadActivityStats(tripIds: string[]) {
    const stats = new Map<
      string,
      { totalActivities: number; completedActivities: number }
    >();
    if (tripIds.length === 0) return stats;

    const groups = await this.prisma.itineraryItem.groupBy({
      by: ['tripId', 'isCheckin'],
      where: { tripId: { in: tripIds } },
      _count: { _all: true },
    });

    for (const group of groups) {
      const current = stats.get(group.tripId) ?? {
        totalActivities: 0,
        completedActivities: 0,
      };
      current.totalActivities += group._count._all;
      if (group.isCheckin) current.completedActivities += group._count._all;
      stats.set(group.tripId, current);
    }
    return stats;
  }

  private toTrip(
    trip: ShowcaseTripRecord | null,
    stats: Map<
      string,
      { totalActivities: number; completedActivities: number }
    >,
  ) {
    if (!trip) return null;
    const activity = stats.get(trip.id) ?? {
      totalActivities: 0,
      completedActivities: 0,
    };
    const highlights: string[] = [];
    for (const destination of trip.destinations) {
      for (const highlight of destination.highlights) {
        if (!highlight || highlights.includes(highlight)) continue;
        highlights.push(highlight);
        if (highlights.length === HIGHLIGHT_LIMIT) break;
      }
      if (highlights.length === HIGHLIGHT_LIMIT) break;
    }
    return {
      id: trip.id,
      name: trip.name,
      coverImageUrl: this.publicUrl(trip.coverMedia),
      status: trip.status,
      startDate: trip.startDate,
      endDate: trip.endDate,
      budgetLevel: trip.budgetLevel,
      maxMembers: trip.maxMembers,
      memberCount: trip._count.members,
      totalActivities: activity.totalActivities,
      completedActivities: activity.completedActivities,
      highlights,
    };
  }

  private publicUrl(media: MediaRef | undefined): string | null {
    if (!media || media.deletedAt) return null;
    return this.s3.getPublicUrl(media.objectKey);
  }
}

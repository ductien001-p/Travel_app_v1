import { Injectable, NotFoundException } from '@nestjs/common';
import { createPaginationMeta } from '../../../common/contracts/pagination-meta.dto';
import { Prisma } from '../../../generated/prisma/client';
import { MEMBER_STATUS, TRIP_STATUS } from '../../../generated/prisma/enums';
import { PrismaService } from '../../../prisma.service';
import { S3Service } from '../../../uploads/s3/s3.service';
import { QueryDiscoverTripDto } from '../dto/query-discover-trip.dto';
import {
  rankDiscoverTrips,
  type DiscoverRankTrip,
  type DiscoverViewerProfile,
} from './trip-discover-rank';
import {
  buildDiscoverListWhere,
  type DiscoverCategory,
} from './trip-discover.where';

const PAST_TRIP_TAKE = 40;

const discoverTripSelect = {
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
  createdAt: true,
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
    select: { members: { where: { status: MEMBER_STATUS.ACTIVE } } },
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
      requirements: true,
      estimatedBudgetPerPerson: true,
      expiresAt: true,
      urgent: true,
    },
  },
  interests: { select: { interest: { select: { name: true } } } },
  itineraryItems: { select: { place: { select: { category: true } } } },
} satisfies Prisma.TripSelect;

type DiscoverTripRow = Prisma.TripGetPayload<{
  select: typeof discoverTripSelect;
}>;

type RankableTrip = DiscoverRankTrip & { row: DiscoverTripRow };

@Injectable()
export class TripDiscoverService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
  ) {}

  async discover(query: QueryDiscoverTripDto, userId: string) {
    const now = new Date();
    const category: DiscoverCategory = query.category ?? 'all';
    const timezoneOffsetMinutes = query.timezoneOffsetMinutes ?? 420;
    const page = query.page ?? 1;
    const limit = query.limit ?? 20;

    const [viewer, pastTrips, trips] = await Promise.all([
      this.prisma.user.findUnique({
        where: { id: userId },
        select: {
          budgetLevel: true,
          interests: true,
          travelStyle: { select: { type: true, score: true } },
        },
      }),
      this.prisma.trip.findMany({
        where: {
          status: { not: TRIP_STATUS.DRAFT },
          OR: [
            { ownerId: userId },
            {
              members: {
                some: { userId, status: MEMBER_STATUS.ACTIVE },
              },
            },
          ],
        },
        orderBy: { createdAt: 'desc' },
        take: PAST_TRIP_TAKE,
        select: {
          destinations: { select: { city: true, destinationType: true } },
        },
      }),
      this.prisma.trip.findMany({
        where: buildDiscoverListWhere({
          userId,
          now,
          category,
          timezoneOffsetMinutes,
          search: query.search,
          destinationCatalogId: query.destinationCatalogId,
        }),
        select: discoverTripSelect,
      }),
    ]);

    if (!viewer) throw new NotFoundException('User not found');

    const profile = toViewerProfile(viewer, pastTrips);
    const ranked = rankDiscoverTrips(
      trips.map(toRankableTrip),
      profile,
      query.seed,
      now,
    );
    const pageItems = ranked.slice((page - 1) * limit, page * limit);

    return {
      data: pageItems.map((entry) =>
        toDiscoverListItem(entry.item.row, entry.matchScore, (media) =>
          this.toPublicUrl(media),
        ),
      ),
      meta: createPaginationMeta(page, limit, ranked.length),
    };
  }

  private toPublicUrl(
    media: { objectKey: string; deletedAt: Date | null } | null | undefined,
  ): string | null {
    return media && media.deletedAt === null
      ? this.s3.getPublicUrl(media.objectKey)
      : null;
  }
}

function toViewerProfile(
  viewer: {
    budgetLevel: DiscoverViewerProfile['budgetLevel'];
    interests: string[];
    travelStyle: Array<{
      type: DiscoverViewerProfile['dna'][number]['type'];
      score: number;
    }>;
  },
  pastTrips: Array<{
    destinations: Array<{ city: string; destinationType: string | null }>;
  }>,
): DiscoverViewerProfile {
  const pastCities: string[] = [];
  const pastDestinationTypes: string[] = [];
  for (const trip of pastTrips) {
    for (const destination of trip.destinations) {
      pastCities.push(destination.city);
      if (destination.destinationType) {
        pastDestinationTypes.push(destination.destinationType);
      }
    }
  }
  return {
    dna: viewer.travelStyle.map((entry) => ({
      type: entry.type,
      score: entry.score,
    })),
    budgetLevel: viewer.budgetLevel,
    interests: viewer.interests,
    pastCities,
    pastDestinationTypes,
  };
}

function toRankableTrip(row: DiscoverTripRow): RankableTrip {
  const memberCount = row._count.members;
  return {
    id: row.id,
    createdAt: row.createdAt,
    tripType: row.tripType,
    budgetLevel: row.budgetLevel,
    interestNames: row.interests.map((link) => link.interest.name),
    cities: row.destinations.map((destination) => destination.city),
    destinationTypes: row.destinations.flatMap((destination) =>
      destination.destinationType ? [destination.destinationType] : [],
    ),
    placeCategories: row.itineraryItems.map((item) => item.place.category),
    slotsRemaining: Math.max(0, row.maxMembers - memberCount),
    expiresAt: row.recruitment?.expiresAt ?? null,
    row,
  };
}

function toDiscoverListItem(
  trip: DiscoverTripRow,
  matchScore: number | null,
  toPublicUrl: (
    media: { objectKey: string; deletedAt: Date | null } | null | undefined,
  ) => string | null,
) {
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
      avatarUrl: toPublicUrl(member.user.avatar),
    })),
    owner: trip.owner
      ? {
          id: trip.owner.id,
          displayname: trip.owner.displayname,
          username: trip.owner.username,
          avatarUrl: toPublicUrl(trip.owner.avatar),
        }
      : null,
    recruiting: memberCount < trip.maxMembers,
    coverImageUrl: toPublicUrl(trip.coverMedia),
    // Discover cards do not show check-in progress.
    checkinCount: 0,
    totalActivities: 0,
    completedActivities: 0,
    progressPercent: 0,
    nextActivity: null,
    requirements: trip.recruitment?.requirements ?? null,
    estimatedBudgetPerPerson:
      trip.recruitment?.estimatedBudgetPerPerson?.toString() ?? null,
    slotsRemaining: Math.max(0, trip.maxMembers - memberCount),
    expiresAt: trip.recruitment?.expiresAt ?? null,
    urgent: trip.recruitment?.urgent ?? false,
    matchScore,
  };
}

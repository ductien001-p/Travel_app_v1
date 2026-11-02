import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../prisma.service';
import {
  PlaceStatus,
  TRAVEL_DNA_TYPE,
  TRIP_STATUS,
  TRIP_VISIBILITY,
} from '../../generated/prisma/enums';
import { S3Service } from '../../uploads/s3/s3.service';
import {
  buildTripDnaProfile,
  dnaSimilarity,
  joinRequestMatchScore,
  topTravelPersona,
  type TravelDnaScore,
} from '../trips/trip-relations/trip-join-requests/join-request-match';
import { TRAVEL_DNA_CONFIG, travelDnaBadgeTitle } from './travel.constant';
import { Prisma } from '../../generated/prisma/client';

const RADAR_AXIS_LIMIT = 6;
const FIT_PLACE_LIMIT = 2;
const JOURNEY_CANDIDATE_LIMIT = 50;
const COMPANION_MIN_MATCH = 70;
const PERCENTILE_MIN_SAMPLE = 20;

type MediaRef = { objectKey: string; deletedAt: Date | null } | null;

type StoredBadge = {
  type: TRAVEL_DNA_TYPE;
  name: string;
  icon: string;
  description: string;
  score: number;
  tripTypeCount: number;
  activityCount: number;
  createdAt: Date;
  updatedAt: Date;
};

@Injectable()
export class TravelDnaService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
  ) {}
  async processCheckin(checkinId: string) {
    const checkin = await this.prisma.tripCheckin.findUnique({
      where: {
        id: checkinId,
      },

      select: {
        id: true,
        memberId: true,
        userId: true,
        tripId: true,
        trip: {
          select: {
            tripType: true,
          },
        },
        place: {
          select: {
            category: true,
          },
        },
      },
    });

    if (!checkin) {
      throw new Error(`Checkin ${checkinId} not found`);
    }

    const { userId, trip } = checkin;
    const placeCategory = checkin.place.category;

    // ---------------------------------------
    // Check first checkin in this trip
    // ---------------------------------------

    const checkinCount = await this.prisma.tripCheckin.count({
      where: {
        tripId: checkin.tripId,
        userId,
      },
    });

    const isFirstCheckinInTrip = checkinCount === 1;

    // ---------------------------------------
    // Find matching DNA
    // ---------------------------------------

    const tripDNA: TRAVEL_DNA_TYPE[] = [];
    const activityDNA: TRAVEL_DNA_TYPE[] = [];

    for (const type of Object.values(TRAVEL_DNA_TYPE)) {
      const config = TRAVEL_DNA_CONFIG[type];

      if (
        isFirstCheckinInTrip &&
        config.tripTypes.length > 0 &&
        config.tripTypes.includes(trip.tripType)
      ) {
        tripDNA.push(type);
      }

      if (
        config.activities.length > 0 &&
        config.activities.includes(placeCategory)
      ) {
        activityDNA.push(type);
      }
    }

    // ---------------------------------------
    // Atomic update
    // ---------------------------------------

    return this.prisma.$transaction(async (tx) => {
      // Prevent duplicate processing
      const existingEvent = await tx.travelDNAEvent.findUnique({
        where: {
          checkinId,
        },
      });

      if (existingEvent) {
        return {
          processed: false,
        };
      }

      await tx.travelDNAEvent.create({
        data: {
          checkinId,
          userId,
        },
      });

      // -------------------------------------
      // Update stats
      // -------------------------------------

      const stats = await tx.userTravelStats.upsert({
        where: {
          userId,
        },

        create: {
          userId,

          totalTrips: isFirstCheckinInTrip ? 1 : 0,

          totalActivities: 1,
        },

        update: {
          totalTrips: {
            increment: isFirstCheckinInTrip ? 1 : 0,
          },

          totalActivities: {
            increment: 1,
          },
        },
      });

      // -------------------------------------
      // Trip DNA
      // -------------------------------------

      for (const type of tripDNA) {
        await tx.userTravelDNA.upsert({
          where: {
            userId_type: {
              userId,
              type,
            },
          },

          create: {
            userId,
            type,
            score: 0,
            tripTypeCount: 1,
            activityCount: 0,
          },

          update: {
            tripTypeCount: {
              increment: 1,
            },
          },
        });
      }

      // -------------------------------------
      // Activity DNA
      // -------------------------------------

      for (const type of activityDNA) {
        await tx.userTravelDNA.upsert({
          where: {
            userId_type: {
              userId,
              type,
            },
          },

          create: {
            userId,
            type,
            score: 0,
            tripTypeCount: 0,
            activityCount: 1,
          },

          update: {
            activityCount: {
              increment: 1,
            },
          },
        });
      }

      // -------------------------------------
      // Recalculate scores
      // -------------------------------------

      await this.updateScores(tx, userId, stats);

      return {
        processed: true,
        userId,
        tripDNA,
        activityDNA,
      };
    });
  }

  async getUserTravelDNA(userId: string) {
    const dnaList = await this.prisma.userTravelDNA.findMany({
      where: {
        userId,
        score: {
          gt: 0,
        },
      },
      orderBy: {
        score: 'desc',
      },
    });

    const result = dnaList.map((dna) => {
      const config = TRAVEL_DNA_CONFIG[dna.type];

      return {
        type: dna.type,

        name: config.name,

        icon: config.icon,

        description: config.description,

        score: dna.score,

        tripTypeCount: dna.tripTypeCount,

        activityCount: dna.activityCount,

        createdAt: dna.createdAt,
        updatedAt: dna.updatedAt,
      };
    });

    return {
      dominant: result[0] ?? null,

      topBadges: result.slice(0, 3),

      all: result,
    };
  }

  async getRadar(userId: string) {
    const dna = await this.getUserTravelDNA(userId);
    const viewerScores = dna.all.map((badge) => ({
      type: badge.type,
      score: badge.score,
    }));
    const axes = dna.all.slice(0, RADAR_AXIS_LIMIT);

    const [community, fitPlaces, journey, companions] = await Promise.all([
      this.loadCommunity(),
      this.loadFitPlaces(axes.map((axis) => axis.type)),
      this.loadJourney(viewerScores),
      this.loadCompanions(userId, viewerScores),
    ]);

    return {
      dna: this.toRadarDna(dna),
      community,
      dominantPercentile: await this.loadDominantPercentile(
        dna.dominant,
        community,
      ),
      fitPlaces,
      journey,
      companions,
    };
  }

  private toRadarDna(dna: {
    dominant: StoredBadge | null;
    topBadges: StoredBadge[];
    all: StoredBadge[];
  }) {
    return {
      dominant: dna.dominant ? this.withRadarCopy(dna.dominant) : null,
      topBadges: dna.topBadges.map((badge) => this.withRadarCopy(badge)),
      all: dna.all.map((badge) => this.withRadarCopy(badge)),
    };
  }

  private withRadarCopy(badge: StoredBadge) {
    return {
      ...badge,
      createdAt: badge.createdAt.toISOString(),
      updatedAt: badge.updatedAt.toISOString(),
      shortLabel: TRAVEL_DNA_CONFIG[badge.type].shortLabel,
      badgeTitle: travelDnaBadgeTitle(badge.type, badge.score),
    };
  }

  private async loadCommunity() {
    const rows = await this.prisma.userTravelDNA.groupBy({
      by: ['type'],
      where: { score: { gt: 0 } },
      _avg: { score: true },
      _count: { _all: true },
    });
    const byType = new Map(rows.map((row) => [row.type, row]));

    return Object.values(TRAVEL_DNA_TYPE).map((type) => {
      const row = byType.get(type);
      const average = row?._avg.score;
      return {
        type,
        averageScore: average == null ? 0 : Math.round(average),
        sampleCount: row?._count._all ?? 0,
      };
    });
  }

  private async loadDominantPercentile(
    dominant: StoredBadge | null,
    community: Array<{ type: TRAVEL_DNA_TYPE; sampleCount: number }>,
  ) {
    if (!dominant) return null;
    const sample =
      community.find((row) => row.type === dominant.type)?.sampleCount ?? 0;
    if (sample < PERCENTILE_MIN_SAMPLE) return null;

    const lower = await this.prisma.userTravelDNA.count({
      where: {
        type: dominant.type,
        score: { gt: 0, lt: dominant.score },
      },
    });
    return Math.round((lower / sample) * 100);
  }

  private async loadFitPlaces(types: TRAVEL_DNA_TYPE[]) {
    return Promise.all(
      types.map(async (type) => {
        const categories = TRAVEL_DNA_CONFIG[type].activities;
        if (categories.length === 0) {
          return { type, places: [] };
        }

        const places = await this.prisma.place.findMany({
          where: {
            status: PlaceStatus.APPROVED,
            category: { in: categories },
          },
          orderBy: [{ averageRating: 'desc' }, { id: 'asc' }],
          take: FIT_PLACE_LIMIT,
          select: { id: true, name: true, city: true },
        });
        return { type, places };
      }),
    );
  }

  private async loadJourney(viewerScores: TravelDnaScore[]) {
    const trips = await this.prisma.trip.findMany({
      where: {
        visibility: TRIP_VISIBILITY.PUBLIC,
        status: { in: [TRIP_STATUS.UPCOMING, TRIP_STATUS.ONGOING] },
      },
      orderBy: { updatedAt: 'desc' },
      take: JOURNEY_CANDIDATE_LIMIT,
      select: {
        id: true,
        name: true,
        tripType: true,
        startDate: true,
        endDate: true,
        coverMedia: { select: { objectKey: true, deletedAt: true } },
        itineraryItems: {
          select: { place: { select: { category: true } } },
        },
        _count: { select: { itineraryItems: true } },
      },
    });

    let best: {
      trip: (typeof trips)[number];
      matchPercent: number;
    } | null = null;

    for (const trip of trips) {
      const profile = buildTripDnaProfile(
        trip.tripType,
        trip.itineraryItems.map((item) => item.place.category),
      );
      const matchPercent = joinRequestMatchScore(profile, viewerScores);
      if (matchPercent == null) continue;
      if (!best || matchPercent > best.matchPercent) {
        best = { trip, matchPercent };
      }
    }

    if (!best) return null;
    return {
      tripId: best.trip.id,
      name: best.trip.name,
      matchPercent: best.matchPercent,
      startDate: best.trip.startDate.toISOString(),
      endDate: best.trip.endDate.toISOString(),
      coverImageUrl: this.publicUrl(best.trip.coverMedia),
      activityCount: best.trip._count.itineraryItems,
    };
  }

  private async loadCompanions(userId: string, viewerScores: TravelDnaScore[]) {
    const friendships = await this.prisma.friendship.findMany({
      where: { userId },
      select: { friendId: true },
    });
    const friendIds = [
      ...new Set(friendships.map((row) => row.friendId)),
    ].filter((friendId) => friendId !== userId);
    if (friendIds.length === 0) return [];

    const [users, dnaRows] = await Promise.all([
      this.prisma.user.findMany({
        where: { id: { in: friendIds }, deletedAt: null },
        select: {
          id: true,
          displayname: true,
          username: true,
          avatar: { select: { objectKey: true, deletedAt: true } },
        },
      }),
      this.prisma.userTravelDNA.findMany({
        where: { userId: { in: friendIds }, score: { gt: 0 } },
        select: { userId: true, type: true, score: true },
      }),
    ]);

    const scoresByUser = new Map<string, TravelDnaScore[]>();
    for (const row of dnaRows) {
      const scores = scoresByUser.get(row.userId) ?? [];
      scores.push({ type: row.type, score: row.score });
      scoresByUser.set(row.userId, scores);
    }

    const companions = users.flatMap((user) => {
      const scores = scoresByUser.get(user.id);
      if (!scores) return [];
      const matchPercent = dnaSimilarity(viewerScores, scores);
      if (matchPercent == null || matchPercent < COMPANION_MIN_MATCH) {
        return [];
      }
      const persona = topTravelPersona(scores);
      if (!persona) return [];
      const badge = TRAVEL_DNA_CONFIG[persona.personaType];
      return [
        {
          userId: user.id,
          displayName: user.displayname,
          username: user.username,
          avatarUrl: this.publicUrl(user.avatar),
          matchPercent,
          persona: { name: badge.name, icon: badge.icon },
        },
      ];
    });

    companions.sort((left, right) => {
      if (right.matchPercent !== left.matchPercent) {
        return right.matchPercent - left.matchPercent;
      }
      return left.userId.localeCompare(right.userId);
    });
    return companions;
  }

  private publicUrl(media: MediaRef | undefined) {
    if (!media || media.deletedAt) return null;
    return this.s3.getPublicUrl(media.objectKey);
  }

  private async updateScores(
    tx: Prisma.TransactionClient,
    userId: string,
    stats: {
      totalTrips: number;
      totalActivities: number;
    },
  ) {
    const factor = this.getExperienceFactor(stats.totalTrips);

    const dnaList = await tx.userTravelDNA.findMany({
      where: {
        userId,
      },
    });

    for (const dna of dnaList) {
      const config = TRAVEL_DNA_CONFIG[dna.type];

      let ratio = 0;

      // =====================================
      // TRIP DNA
      // =====================================

      if (config.tripTypes.length > 0) {
        ratio = stats.totalTrips > 0 ? dna.tripTypeCount / stats.totalTrips : 0;
      }

      // =====================================
      // ACTIVITY DNA
      // =====================================
      else if (config.activities.length > 0) {
        ratio =
          stats.totalActivities > 0
            ? dna.activityCount / stats.totalActivities
            : 0;
      }

      const score = Math.round(ratio * 100 * factor);

      await tx.userTravelDNA.update({
        where: {
          id: dna.id,
        },

        data: {
          score,
        },
      });
    }
  }
  private getExperienceFactor(totalTrips: number): number {
    if (totalTrips < 5) {
      return 1;
    } else if (totalTrips < 10) {
      return 1.2;
    } else if (totalTrips < 20) {
      return 1.5;
    } else {
      return 2;
    }
  }
}

import { Injectable, NotFoundException } from '@nestjs/common';

import { PrismaService } from '../../../../prisma.service';
import { TripAccessPolicy } from '../../policies';
import { RouteService } from '../../route/route.service';
import type { RouteSegmentRequest } from '../../route/route.service';

/** Each leg may cost a paid provider call, so a single day is bounded. */
export const MAX_DAY_ROUTE_STOPS = 25;

export type DayRouteUnavailableReason =
  'MISSING_COORDINATES' | 'PROVIDER_UNAVAILABLE' | 'STOP_LIMIT_EXCEEDED';

export type DayRouteLeg = {
  fromActivityId: string;
  toActivityId: string;
  available: boolean;
  distanceMeters: number | null;
  durationSeconds: number | null;
  polyline: string | null;
  unavailableReason: DayRouteUnavailableReason | null;
};

export type DayRoute = {
  dayId: string;
  available: boolean;
  totalDistanceMeters: number;
  totalDurationSeconds: number;
  legs: DayRouteLeg[];
};

type RouteStop = {
  id: string;
  placeId: string;
  place: { latitude: number; longitude: number };
};

@Injectable()
export class TripItineraryViewerService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly routes: RouteService,
  ) {}

  /** Places the current member has checked in to on this trip. */
  async listMyCheckins(tripId: string, userId: string) {
    await TripAccessPolicy.authorize(this.prisma, tripId, userId, 'READ');

    return this.prisma.tripCheckin.findMany({
      where: { tripId, userId },
      orderBy: { visitedAt: 'asc' },
      select: { activityId: true, placeId: true, visitedAt: true },
    });
  }

  /** Road route between consecutive activities of one itinerary day. */
  async getDayRoute(
    tripId: string,
    dayId: string,
    userId: string,
  ): Promise<DayRoute> {
    await TripAccessPolicy.authorize(this.prisma, tripId, userId, 'READ');

    const day = await this.prisma.itineraryDay.findFirst({
      where: { id: dayId, tripId },
      select: {
        id: true,
        activities: {
          orderBy: { orderIndex: 'asc' },
          select: {
            id: true,
            placeId: true,
            place: { select: { latitude: true, longitude: true } },
          },
        },
      },
    });
    if (!day) throw new NotFoundException('Day not found in this trip');

    const legs = await this.buildLegs(day.activities);
    return {
      dayId: day.id,
      available: legs.every((leg) => leg.available),
      totalDistanceMeters: this.sum(legs, (leg) => leg.distanceMeters),
      totalDurationSeconds: this.sum(legs, (leg) => leg.durationSeconds),
      legs,
    };
  }

  private async buildLegs(stops: RouteStop[]): Promise<DayRouteLeg[]> {
    const pairs = stops
      .slice(1)
      .map((to, index) => ({ from: stops[index], to }));
    const routable = pairs.slice(0, MAX_DAY_ROUTE_STOPS - 1);

    // Two activities at the same place need no provider call.
    const requests: RouteSegmentRequest[] = [];
    const requestIndexByPair = new Map<number, number>();
    routable.forEach(({ from, to }, index) => {
      if (from.placeId === to.placeId) return;
      requestIndexByPair.set(index, requests.length);
      requests.push({ origin: from.place, destination: to.place });
    });
    const results = await this.routes.getRoutes(requests);

    return pairs.map(({ from, to }, index): DayRouteLeg => {
      const base = { fromActivityId: from.id, toActivityId: to.id };
      if (index >= routable.length) {
        return this.unavailableLeg(base, 'STOP_LIMIT_EXCEEDED');
      }
      const resultIndex = requestIndexByPair.get(index);
      if (resultIndex === undefined) {
        return {
          ...base,
          available: true,
          distanceMeters: 0,
          durationSeconds: 0,
          polyline: null,
          unavailableReason: null,
        };
      }
      const result = results[resultIndex];
      if (!result.available) {
        return this.unavailableLeg(base, result.unavailableReason);
      }
      return {
        ...base,
        available: true,
        distanceMeters: result.distanceMeters,
        durationSeconds: result.durationSeconds,
        polyline: result.polyline,
        unavailableReason: null,
      };
    });
  }

  private unavailableLeg(
    base: Pick<DayRouteLeg, 'fromActivityId' | 'toActivityId'>,
    reason: DayRouteUnavailableReason,
  ): DayRouteLeg {
    return {
      ...base,
      available: false,
      distanceMeters: null,
      durationSeconds: null,
      polyline: null,
      unavailableReason: reason,
    };
  }

  private sum(
    legs: DayRouteLeg[],
    pick: (leg: DayRouteLeg) => number | null,
  ): number {
    return legs.reduce((total, leg) => total + (pick(leg) ?? 0), 0);
  }
}

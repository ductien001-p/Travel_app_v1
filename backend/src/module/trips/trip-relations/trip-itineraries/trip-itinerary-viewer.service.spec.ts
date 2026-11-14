import { NotFoundException } from '@nestjs/common';
import {
  MAX_DAY_ROUTE_STOPS,
  TripItineraryViewerService,
} from './trip-itinerary-viewer.service';

describe('TripItineraryViewerService', () => {
  const tripId = 'trip-1';
  const userId = 'user-1';

  const stop = (index: number, placeId = `place-${index}`) => ({
    id: `activity-${index}`,
    placeId,
    place: { latitude: 16 + index / 100, longitude: 108 + index / 100 },
  });

  const route = (distanceMeters: number) => ({
    available: true,
    distanceMeters,
    durationSeconds: distanceMeters / 10,
    polyline: `poly-${distanceMeters}`,
  });

  type SetupOptions = {
    member?: { role: string; status: string } | null;
    day?: Record<string, unknown> | null;
    routes?: unknown[];
  };

  function setup({
    member = { role: 'MEMBER', status: 'ACTIVE' },
    day = null,
    routes = [],
  }: SetupOptions = {}) {
    const prisma = {
      trip: { findUnique: jest.fn().mockResolvedValue({ id: tripId }) },
      tripMember: { findUnique: jest.fn().mockResolvedValue(member) },
      tripCheckin: {
        findMany: jest.fn().mockResolvedValue([
          {
            activityId: 'activity-1',
            placeId: 'place-1',
            visitedAt: new Date('2026-07-16T02:00:00.000Z'),
          },
        ]),
      },
      itineraryDay: { findFirst: jest.fn().mockResolvedValue(day) },
    };
    const routeService = { getRoutes: jest.fn().mockResolvedValue(routes) };
    return {
      service: new TripItineraryViewerService(
        prisma as never,
        routeService as never,
      ),
      prisma,
      routeService,
    };
  }

  describe('listMyCheckins', () => {
    it('reads only the caller check-ins on this trip', async () => {
      const { service, prisma } = setup();

      const result = await service.listMyCheckins(tripId, userId);

      expect(result).toHaveLength(1);
      expect(prisma.tripCheckin.findMany).toHaveBeenCalledWith(
        expect.objectContaining({
          where: { tripId, userId },
          select: { activityId: true, placeId: true, visitedAt: true },
        }),
      );
    });

    it('rejects users who are not active members', async () => {
      const { service, prisma } = setup({
        member: { role: 'MEMBER', status: 'LEFT' },
      });

      await expect(service.listMyCheckins(tripId, userId)).rejects.toThrow(
        NotFoundException,
      );
      expect(prisma.tripCheckin.findMany).not.toHaveBeenCalled();
    });
  });

  describe('getDayRoute', () => {
    it('returns 404 when the day does not belong to the trip', async () => {
      const { service } = setup({ day: null });

      await expect(
        service.getDayRoute(tripId, 'day-x', userId),
      ).rejects.toThrow(NotFoundException);
    });

    it('returns an empty available route for a day with one activity', async () => {
      const { service, routeService } = setup({
        day: { id: 'day-1', activities: [stop(1)] },
      });

      const result = await service.getDayRoute(tripId, 'day-1', userId);

      expect(result).toEqual({
        dayId: 'day-1',
        available: true,
        totalDistanceMeters: 0,
        totalDurationSeconds: 0,
        legs: [],
      });
      expect(routeService.getRoutes).toHaveBeenCalledWith([]);
    });

    it('sums consecutive legs and skips the provider for a repeated place', async () => {
      const { service, routeService } = setup({
        day: {
          id: 'day-1',
          activities: [stop(1), stop(2), stop(3, 'place-2')],
        },
        routes: [route(1200)],
      });

      const result = await service.getDayRoute(tripId, 'day-1', userId);

      expect(routeService.getRoutes).toHaveBeenCalledWith([
        { origin: stop(1).place, destination: stop(2).place },
      ]);
      expect(result.available).toBe(true);
      expect(result.totalDistanceMeters).toBe(1200);
      expect(result.legs[1]).toMatchObject({
        fromActivityId: 'activity-2',
        toActivityId: 'activity-3',
        available: true,
        distanceMeters: 0,
        polyline: null,
      });
    });

    it('marks provider failures unavailable and totals only available legs', async () => {
      const { service } = setup({
        day: { id: 'day-1', activities: [stop(1), stop(2), stop(3)] },
        routes: [
          route(800),
          {
            available: false,
            distanceMeters: null,
            durationSeconds: null,
            polyline: null,
            unavailableReason: 'PROVIDER_UNAVAILABLE',
          },
        ],
      });

      const result = await service.getDayRoute(tripId, 'day-1', userId);

      expect(result.available).toBe(false);
      expect(result.totalDistanceMeters).toBe(800);
      expect(result.legs[1]).toMatchObject({
        available: false,
        unavailableReason: 'PROVIDER_UNAVAILABLE',
      });
    });

    it('caps provider calls at the day stop limit', async () => {
      const activities = Array.from(
        { length: MAX_DAY_ROUTE_STOPS + 2 },
        (_, index) => stop(index),
      );
      const { service, routeService } = setup({
        day: { id: 'day-1', activities },
        routes: Array.from({ length: MAX_DAY_ROUTE_STOPS - 1 }, () =>
          route(100),
        ),
      });

      const result = await service.getDayRoute(tripId, 'day-1', userId);

      expect(routeService.getRoutes.mock.calls[0][0]).toHaveLength(
        MAX_DAY_ROUTE_STOPS - 1,
      );
      expect(result.legs).toHaveLength(MAX_DAY_ROUTE_STOPS + 1);
      expect(result.legs.at(-1)).toMatchObject({
        available: false,
        unavailableReason: 'STOP_LIMIT_EXCEEDED',
      });
      expect(result.available).toBe(false);
    });
  });
});

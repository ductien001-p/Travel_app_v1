import { BadRequestException } from '@nestjs/common';
import { TripItinerariesService } from './trip-destination.service';
import { DestinationPolicy } from '../../policies';
import { Prisma } from '../../../../generated/prisma/client';

describe('TripItinerariesService destination timeline sync', () => {
  const tripId = 'trip-1';
  const destinationId = 'destination-1';
  const date = (day: number) => new Date(Date.UTC(2026, 9, day));

  function setup(existingDays: Array<Record<string, unknown>>) {
    const tx = {
      $executeRaw: jest.fn().mockResolvedValue(0),
      itineraryDay: {
        findMany: jest
          .fn()
          .mockResolvedValueOnce(existingDays)
          .mockResolvedValueOnce(existingDays),
        deleteMany: jest.fn().mockResolvedValue({ count: 0 }),
        createMany: jest.fn().mockResolvedValue({ count: 0 }),
        aggregate: jest.fn().mockResolvedValue({ _max: { dayNumber: 3 } }),
        update: jest.fn().mockResolvedValue({}),
      },
    };
    return {
      service: new TripItinerariesService({} as never, {} as never),
      tx,
    };
  }

  it('rejects destinations whose inclusive date ranges overlap', () => {
    expect(() =>
      DestinationPolicy.validatePersistedTimeline([
        { order: 1, startDate: date(1), endDate: date(3) },
        { order: 2, startDate: date(3), endDate: date(5) },
      ]),
    ).toThrow(BadRequestException);
  });

  it('extends a destination without replacing existing day records', async () => {
    const existing = [1, 2, 3].map((day) => ({
      id: `day-${day}`,
      destinationId,
      date: date(day),
      dayNumber: day,
      _count: { activities: day < 3 ? 1 : 0 },
    }));
    const { service, tx } = setup(existing);

    await service.syncTripItineraryDays(tx as never, tripId, [
      {
        id: destinationId,
        order: 1,
        startDate: date(1),
        endDate: date(5),
      },
    ]);

    expect(tx.itineraryDay.deleteMany).not.toHaveBeenCalled();
    expect(tx.itineraryDay.createMany).toHaveBeenCalledWith({
      data: expect.arrayContaining([
        expect.objectContaining({ date: date(4) }),
        expect.objectContaining({ date: date(5) }),
      ]),
    });
  });

  it('deletes only empty days removed by a shortened range', async () => {
    const existing = [1, 2, 3, 4, 5].map((day) => ({
      id: `day-${day}`,
      destinationId,
      date: date(day),
      dayNumber: day,
      _count: { activities: 0 },
    }));
    const { service, tx } = setup(existing);

    await service.syncTripItineraryDays(tx as never, tripId, [
      {
        id: destinationId,
        order: 1,
        startDate: date(1),
        endDate: date(3),
      },
    ]);

    expect(tx.itineraryDay.deleteMany).toHaveBeenCalledWith({
      where: { id: { in: ['day-4', 'day-5'] } },
    });
  });

  it('rejects shortening when a removed day has activities', async () => {
    const existing = [1, 2, 3, 4, 5].map((day) => ({
      id: `day-${day}`,
      destinationId,
      date: date(day),
      dayNumber: day,
      _count: { activities: day === 5 ? 1 : 0 },
    }));
    const { service, tx } = setup(existing);

    await expect(
      service.syncTripItineraryDays(tx as never, tripId, [
        {
          id: destinationId,
          order: 1,
          startDate: date(1),
          endDate: date(3),
        },
      ]),
    ).rejects.toMatchObject({
      response: expect.objectContaining({
        code: 'ITINERARY_DAY_HAS_ACTIVITIES',
      }),
    });
    expect(tx.itineraryDay.deleteMany).not.toHaveBeenCalled();
  });

  it('renumbers trip days with two set-based statements', async () => {
    const { service, tx } = setup([]);

    await service.recalculateTripDayNumbers(tx as never, tripId);

    expect(tx.$executeRaw).toHaveBeenCalledTimes(2);
    expect(tx.itineraryDay.update).not.toHaveBeenCalled();
    const [park, flip] = tx.$executeRaw.mock.calls;
    expect(park.join(' ')).toContain('ROW_NUMBER()');
    expect(park).toContain(tripId);
    expect(flip.join(' ')).toContain('"dayNumber" < 0');
  });
});

describe('TripItinerariesService.deleteDestination', () => {
  function setup(activityCount: number) {
    const tx = {
      $queryRaw: jest.fn().mockResolvedValue([{ id: 'trip-1' }]),
      $executeRaw: jest.fn().mockResolvedValue(0),
      tripDestination: {
        findFirst: jest.fn().mockResolvedValue({ id: 'destination-1' }),
        delete: jest.fn().mockResolvedValue({}),
        findMany: jest.fn().mockResolvedValue([
          {
            id: 'destination-2',
            startDate: new Date('2026-10-05T00:00:00.000Z'),
            endDate: new Date('2026-10-06T00:00:00.000Z'),
          },
        ]),
      },
      itineraryItem: { count: jest.fn().mockResolvedValue(activityCount) },
      itineraryDay: {
        deleteMany: jest.fn().mockResolvedValue({ count: 2 }),
        findMany: jest.fn().mockResolvedValue([]),
      },
      trip: {
        findUniqueOrThrow: jest.fn().mockResolvedValue({
          id: 'trip-1',
          name: 'Trip',
          status: 'UPCOMING',
          ownerId: 'owner-1',
          startDate: new Date('2026-10-01T00:00:00.000Z'),
          endDate: new Date('2026-10-06T00:00:00.000Z'),
        }),
        update: jest.fn().mockResolvedValue({}),
      },
      tripRecruitment: {
        findUnique: jest.fn().mockResolvedValue(null),
      },
    };
    const prisma = {
      tripMember: {
        findUnique: jest
          .fn()
          .mockResolvedValue({ role: 'OWNER', status: 'ACTIVE' }),
      },
      $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
        Promise.resolve(callback(tx)),
      ),
    };
    return {
      service: new TripItinerariesService(prisma as never, {} as never),
      tx,
    };
  }

  it('checks for activities under the trip lock before deleting', async () => {
    const { service, tx } = setup(0);

    await service.deleteDestination('trip-1', 'destination-1', 'owner-1');

    const lockOrder = tx.$queryRaw.mock.invocationCallOrder[0];
    const countOrder = tx.itineraryItem.count.mock.invocationCallOrder[0];
    expect(lockOrder).toBeLessThan(countOrder);
    expect(tx.itineraryItem.count).toHaveBeenCalledWith({
      where: { tripId: 'trip-1', day: { destinationId: 'destination-1' } },
    });
    expect(tx.tripDestination.delete).toHaveBeenCalledWith({
      where: { id: 'destination-1' },
    });
  });

  it('refuses to delete a destination that has activities', async () => {
    const { service, tx } = setup(1);

    await expect(
      service.deleteDestination('trip-1', 'destination-1', 'owner-1'),
    ).rejects.toBeInstanceOf(BadRequestException);
    expect(tx.itineraryDay.deleteMany).not.toHaveBeenCalled();
    expect(tx.tripDestination.delete).not.toHaveBeenCalled();
  });
});

describe('TripItinerariesService day summary', () => {
  it('returns activity count, duration and cost without travel fields', async () => {
    const prisma = {
      tripMember: {
        findUnique: jest
          .fn()
          .mockResolvedValue({ role: 'MEMBER', status: 'ACTIVE' }),
      },
      tripDestination: {
        findMany: jest.fn().mockResolvedValue([
          {
            id: 'destination-1',
            itineraryDays: [
              {
                id: 'day-1',
                activities: [
                  {
                    estimatedDuration: 60,
                    estimatedCost: new Prisma.Decimal(100000),
                  },
                  {
                    estimatedDuration: 90,
                    estimatedCost: new Prisma.Decimal(250000),
                  },
                ],
              },
            ],
          },
        ]),
      },
    };
    const service = new TripItinerariesService(prisma as never, {} as never);

    const result = await service.getTripItinerary('trip-1', 'user-1');

    expect(result.destinations[0].itineraryDays[0].summary).toEqual({
      activityCount: 2,
      estimatedDurationMinutes: 150,
      estimatedCost: '350000.00',
    });
    expect(result.destinations[0].itineraryDays[0].summary).not.toHaveProperty(
      'travelDuration',
    );
  });
});

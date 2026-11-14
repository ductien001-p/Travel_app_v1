import { ConflictException, NotFoundException } from '@nestjs/common';
import { TripCompletionService } from './tripCompletetion.service';
import { MEMBER_STATUS, TRIP_STATUS } from '../../../../generated/prisma/enums';

describe('TripCompletionService', () => {
  const PAST = new Date('2020-01-01T00:00:00.000Z');
  const FUTURE = new Date('2999-01-01T00:00:00.000Z');

  function setup(
    options: {
      status?: TRIP_STATUS;
      startDate?: Date;
      existing?: { id: string } | null;
      activeMembers?: number;
      completions?: number;
      member?: Record<string, unknown> | null;
      tripExists?: boolean;
      missionPoints?: number;
      multiplier?: number;
    } = {},
  ) {
    const tx = {
      $queryRaw: jest.fn().mockResolvedValue([{ id: 'trip-1' }]),
      tripMember: {
        findUnique: jest.fn().mockResolvedValue(
          options.member === undefined
            ? {
                id: 'member-1',
                userId: 'user-1',
                tripId: 'trip-1',
                role: 'MEMBER',
                status: MEMBER_STATUS.ACTIVE,
              }
            : options.member,
        ),
        count: jest.fn().mockResolvedValue(options.activeMembers ?? 2),
      },
      trip: {
        findUnique: jest
          .fn()
          .mockResolvedValue(
            options.tripExists === false ? null : { id: 'trip-1' },
          ),
        findUniqueOrThrow: jest.fn().mockResolvedValue({
          status: options.status ?? TRIP_STATUS.ONGOING,
          startDate: options.startDate ?? PAST,
        }),
        update: jest.fn(),
      },
      tripCompletion: {
        findUnique: jest.fn().mockResolvedValue(options.existing ?? null),
        create: jest.fn().mockImplementation(({ data }) =>
          Promise.resolve({
            id: 'completion-1',
            tripId: 'trip-1',
            memberId: 'member-1',
            pointsAwarded: data.pointsAwarded,
            completedAt: new Date('2024-01-01T00:00:00.000Z'),
          }),
        ),
        count: jest.fn().mockResolvedValue(options.completions ?? 1),
      },
      itineraryItem: {
        findMany: jest
          .fn()
          .mockResolvedValue([
            { placeId: 'A' },
            { placeId: 'HOTEL' },
            { placeId: 'B' },
            { placeId: 'C' },
          ]),
      },
      tripCheckin: {
        findMany: jest
          .fn()
          .mockResolvedValue([{ placeId: 'A' }, { placeId: 'HOTEL' }]),
      },
    };
    const prisma = {
      $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
        callback(tx),
      ),
    };
    const ranking = { awardTripCompletion: jest.fn() };
    const missions = {
      settleForCompletion: jest.fn().mockResolvedValue({
        missionPoints: options.missionPoints ?? 0,
        missionsCompleted: options.missionPoints ? 1 : 0,
        snapshots: [],
      }),
    };
    const travelTier = {
      getMultiplier: jest.fn().mockResolvedValue(options.multiplier ?? 1),
      afterTripCompletion: jest.fn().mockResolvedValue({}),
    };
    const service = new TripCompletionService(
      prisma as never,
      ranking as never,
      missions as never,
      travelTier as never,
    );
    return { service, tx, ranking, missions, travelTier };
  }

  it('calculates completion and points from distinct itinerary places', async () => {
    const { service, tx, ranking } = setup();

    const result = await service.completeTrip('trip-1', 'user-1');

    expect(result).toEqual(
      expect.objectContaining({
        totalPlaces: 4,
        totalCheckins: 2,
        completionPercent: 50,
        pointsAwarded: 10,
        basePoints: 10,
        missionPoints: 0,
        multiplierUsed: 1,
      }),
    );
    expect(tx.$queryRaw).toHaveBeenCalled();
    expect(tx.itineraryItem.findMany).toHaveBeenCalledWith(
      expect.objectContaining({ distinct: ['placeId'] }),
    );
    expect(ranking.awardTripCompletion).toHaveBeenCalledWith(
      tx,
      'user-1',
      10,
      'trip-1',
    );
  });

  it('applies mission points and multiplier to final score', async () => {
    const { service, ranking, travelTier } = setup({
      missionPoints: 60,
      multiplier: 1.2,
    });

    const result = await service.completeTrip('trip-1', 'user-1');

    // (10 + 60) * 1.2 = 84
    expect(result.pointsAwarded).toBe(84);
    expect(result.basePoints).toBe(10);
    expect(result.missionPoints).toBe(60);
    expect(result.multiplierUsed).toBe(1.2);
    expect(ranking.awardTripCompletion).toHaveBeenCalledWith(
      expect.anything(),
      'user-1',
      84,
      'trip-1',
    );
    expect(travelTier.afterTripCompletion).toHaveBeenCalled();
  });

  it('reports a missing trip as not found', async () => {
    const { service, ranking } = setup({ member: null, tripExists: false });

    await expect(
      service.completeTrip('missing', 'user-1'),
    ).rejects.toBeInstanceOf(NotFoundException);
    expect(ranking.awardTripCompletion).not.toHaveBeenCalled();
  });

  it('rejects completing a trip that has not started yet', async () => {
    const { service, tx, ranking } = setup({
      status: TRIP_STATUS.UPCOMING,
      startDate: FUTURE,
    });

    await expect(
      service.completeTrip('trip-1', 'user-1'),
    ).rejects.toMatchObject({
      response: expect.objectContaining({ code: 'TRIP_STATUS_INVALID' }),
    });
    expect(tx.tripCompletion.create).not.toHaveBeenCalled();
    expect(ranking.awardTripCompletion).not.toHaveBeenCalled();
  });

  it.each([TRIP_STATUS.DRAFT, TRIP_STATUS.CANCELLED, TRIP_STATUS.COMPLETED])(
    'rejects completing a %s trip',
    async (status) => {
      const { service, tx } = setup({ status });

      await expect(
        service.completeTrip('trip-1', 'user-1'),
      ).rejects.toMatchObject({
        response: expect.objectContaining({ code: 'TRIP_STATUS_INVALID' }),
      });
      expect(tx.tripCompletion.create).not.toHaveBeenCalled();
    },
  );

  it('rejects a second completion by the same member', async () => {
    const { service, tx } = setup({ existing: { id: 'completion-0' } });

    await expect(
      service.completeTrip('trip-1', 'user-1'),
    ).rejects.toBeInstanceOf(ConflictException);
    expect(tx.tripCompletion.create).not.toHaveBeenCalled();
  });

  it('moves a started UPCOMING trip to ONGOING', async () => {
    const { service, tx } = setup({ status: TRIP_STATUS.UPCOMING });

    await service.completeTrip('trip-1', 'user-1');

    expect(tx.trip.update).toHaveBeenCalledWith({
      where: { id: 'trip-1' },
      data: { status: TRIP_STATUS.ONGOING },
    });
  });

  it('marks the trip COMPLETED once every active member completed', async () => {
    const { service, tx } = setup({ activeMembers: 2, completions: 2 });

    await service.completeTrip('trip-1', 'user-1');

    expect(tx.trip.update).toHaveBeenCalledWith({
      where: { id: 'trip-1' },
      data: { status: TRIP_STATUS.COMPLETED },
    });
  });
});

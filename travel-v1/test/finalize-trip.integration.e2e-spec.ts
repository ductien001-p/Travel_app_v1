import { ForbiddenException, NotFoundException } from '@nestjs/common';
import {
  BudgetLevel,
  MEMBER_STATUS,
  TRIP_ROLE,
  TRIP_STATUS,
  TRIP_TYPE,
  TRIP_VISIBILITY,
  USER_STATUS,
} from '../src/generated/prisma/enums';
import { Prisma } from '../src/generated/prisma/client';
import { TripsController } from '../src/module/trips/trips.controller';
import { TripsService } from '../src/module/trips/trips.service';
import { TripTimelineService } from '../src/module/trips/trip-relations/trip-timeline/tripTimeline.service';
import { PrismaService } from '../src/prisma.service';

jest.mock('nanoid', () => ({
  customAlphabet: () => () => 'INTEGRATION',
}));

describe('finalizeTrip PostgreSQL integration', () => {
  let prisma: PrismaService;
  let service: TripsService;
  let sequence = 0;

  const databaseName = (() => {
    const raw = process.env.DATABASE_URL;
    if (!raw) return '';
    return new URL(raw).pathname.replace(/^\//, '');
  })();

  beforeAll(async () => {
    if (!databaseName.startsWith('travel_finalize_test_')) {
      throw new Error(
        'Refusing to run: DATABASE_URL is not an isolated finalize test database',
      );
    }

    prisma = new PrismaService();
    await prisma.$connect();
    service = new TripsService(
      prisma,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      new TripTimelineService(prisma, {
        getPublicUrl: (key: string) => `https://cdn.test/${key}`,
      } as never),
    );
  });

  afterAll(async () => {
    await prisma?.$disconnect();
  });

  async function createUser(label: string) {
    const suffix = `${Date.now()}-${sequence++}`;
    return prisma.user.create({
      data: {
        username: `finalize-${label}-${suffix}`,
        displayname: `Finalize ${label}`,
        email: `finalize-${label}-${suffix}@example.test`,
        status: USER_STATUS.ACTIVE,
      },
    });
  }

  async function createDraft(options?: {
    memberRole?: TRIP_ROLE;
    memberStatus?: MEMBER_STATUS;
    overlappingDestinations?: boolean;
  }) {
    const owner = await createUser('owner');
    const suffix = `${Date.now()}-${sequence++}`;
    const firstStart = new Date('2026-11-01T00:00:00.000Z');
    const firstEnd = new Date('2026-11-03T00:00:00.000Z');
    const secondStart = options?.overlappingDestinations
      ? new Date('2026-11-03T00:00:00.000Z')
      : new Date('2026-11-04T00:00:00.000Z');
    const secondEnd = new Date('2026-11-06T00:00:00.000Z');
    const interest = await prisma.interest.create({
      data: { name: `integration-interest-${suffix}` },
    });

    const trip = await prisma.trip.create({
      data: {
        ownerId: owner.id,
        name: 'PostgreSQL Finalize Verification',
        startDate: new Date('2026-01-01T00:00:00.000Z'),
        endDate: new Date('2026-01-02T00:00:00.000Z'),
        budgetLevel: BudgetLevel.MEDIUM,
        maxMembers: 4,
        inviteCode: `F${sequence.toString().padStart(7, '0')}${suffix}`,
        tripType: TRIP_TYPE.FRIENDS,
        visibility: TRIP_VISIBILITY.PRIVATE,
        status: TRIP_STATUS.DRAFT,
        members: {
          create: {
            userId: owner.id,
            role: options?.memberRole ?? TRIP_ROLE.OWNER,
            status: options?.memberStatus ?? MEMBER_STATUS.ACTIVE,
          },
        },
        destinations: {
          create: [
            {
              city: 'Da Nang',
              country: 'VN',
              lat: 16.0544,
              lng: 108.2022,
              order: 1,
              startDate: firstStart,
              endDate: firstEnd,
            },
            {
              city: 'Hoi An',
              country: 'VN',
              lat: 15.8801,
              lng: 108.338,
              order: 2,
              startDate: secondStart,
              endDate: secondEnd,
            },
          ],
        },
        interests: { create: { interestId: interest.id } },
      },
    });

    return { trip, owner, firstStart, secondEnd };
  }

  it('TEST 01: finalizes a valid draft and returns the established relations', async () => {
    const fixture = await createDraft();
    const controller = new TripsController(
      service,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
    );

    const response = await controller.finalize(
      fixture.trip.id,
      fixture.owner.id,
    );
    const result = response.data;
    const persisted = await prisma.trip.findUniqueOrThrow({
      where: { id: fixture.trip.id },
    });

    expect(response.message).toBe('Trip finalized successfully');
    expect(response).toEqual({
      data: expect.objectContaining({
        id: fixture.trip.id,
        status: TRIP_STATUS.UPCOMING,
        destinations: expect.any(Array),
        interests: expect.any(Array),
        members: expect.any(Array),
      }),
      message: 'Trip finalized successfully',
    });
    expect(result.status).toBe(TRIP_STATUS.UPCOMING);
    expect(result.startDate).toEqual(fixture.firstStart);
    expect(result.endDate).toEqual(fixture.secondEnd);
    expect(result.finalizedAt).toBeInstanceOf(Date);
    expect(result.destinations).toHaveLength(2);
    expect(result.destinations[0]).toHaveProperty('itineraryDays');
    expect(result.interests).toHaveLength(1);
    expect(result.interests[0]).toHaveProperty('interest');
    expect(result.members).toHaveLength(1);
    expect(persisted).toMatchObject({
      status: TRIP_STATUS.UPCOMING,
      startDate: fixture.firstStart,
      endDate: fixture.secondEnd,
    });
    await expect(
      prisma.tripTimelineEvent.findMany({
        where: { tripId: fixture.trip.id },
        select: { type: true, targetType: true, metadata: true },
      }),
    ).resolves.toEqual([
      {
        type: 'TRIP_CREATED',
        targetType: 'TRIP',
        metadata: {
          tripName: 'PostgreSQL Finalize Verification',
          startDate: fixture.firstStart.toISOString(),
          endDate: fixture.secondEnd.toISOString(),
          destinationCount: 2,
        },
      },
    ]);
  });

  it('TEST 02: rolls back a conditional update when a controlled post-update error occurs', async () => {
    const fixture = await createDraft();
    const originalTransaction = prisma.$transaction.bind(prisma);

    const transactionSpy = jest
      .spyOn(prisma, '$transaction')
      .mockImplementationOnce(((
        work: (tx: Prisma.TransactionClient) => Promise<unknown>,
      ) =>
        originalTransaction(async (tx: Prisma.TransactionClient) => {
          const faultingTrip = new Proxy(tx.trip, {
            get(target, prop) {
              if (prop !== 'updateMany') return Reflect.get(target, prop);
              return async (args: Prisma.TripUpdateManyArgs) => {
                await target.updateMany(args);
                throw new Error('CONTROLLED_POST_UPDATE_FAILURE');
              };
            },
          });
          const faultingTx = new Proxy(tx, {
            get: (target, prop) =>
              prop === 'trip' ? faultingTrip : Reflect.get(target, prop),
          });
          return work(faultingTx);
        })) as never);

    try {
      await expect(
        service.finalizeTrip(fixture.trip.id, fixture.owner.id),
      ).rejects.toThrow('CONTROLLED_POST_UPDATE_FAILURE');
    } finally {
      transactionSpy.mockRestore();
    }

    const persisted = await prisma.trip.findUniqueOrThrow({
      where: { id: fixture.trip.id },
    });
    expect(persisted.status).toBe(TRIP_STATUS.DRAFT);
    expect(persisted.startDate).toEqual(new Date('2026-01-01T00:00:00.000Z'));
    expect(persisted.endDate).toEqual(new Date('2026-01-02T00:00:00.000Z'));
    expect(persisted.finalizedAt).toBeNull();
  });

  it('TEST 03: permits exactly one of two concurrent finalizations', async () => {
    const fixture = await createDraft();

    const results = await Promise.allSettled([
      service.finalizeTrip(fixture.trip.id, fixture.owner.id),
      service.finalizeTrip(fixture.trip.id, fixture.owner.id),
    ]);
    const fulfilled = results.filter((result) => result.status === 'fulfilled');
    const rejected = results.filter((result) => result.status === 'rejected');
    const persisted = await prisma.trip.findUniqueOrThrow({
      where: { id: fixture.trip.id },
    });

    expect(fulfilled).toHaveLength(1);
    expect(rejected).toHaveLength(1);
    expect((rejected[0] as PromiseRejectedResult).reason).toBeInstanceOf(
      NotFoundException,
    );
    expect((rejected[0] as PromiseRejectedResult).reason.message).toBe(
      'Trip draft not found',
    );
    expect(persisted.status).toBe(TRIP_STATUS.UPCOMING);
    expect(persisted.finalizedAt).toBeInstanceOf(Date);
  });

  it('TEST 04: enforces owner role and active membership', async () => {
    const activeOwner = await createDraft();
    await expect(
      service.finalizeTrip(activeOwner.trip.id, activeOwner.owner.id),
    ).resolves.toMatchObject({ status: TRIP_STATUS.UPCOMING });

    const memberOwner = await createDraft({ memberRole: TRIP_ROLE.MEMBER });
    await expect(
      service.finalizeTrip(memberOwner.trip.id, memberOwner.owner.id),
    ).rejects.toMatchObject({
      constructor: ForbiddenException,
      message: 'Role not allowed: EDIT_TRIP',
    });

    const inactiveOwner = await createDraft({
      memberStatus: MEMBER_STATUS.LEFT,
    });
    await expect(
      service.finalizeTrip(inactiveOwner.trip.id, inactiveOwner.owner.id),
    ).rejects.toMatchObject({
      constructor: ForbiddenException,
      message: 'Active trip membership required',
    });

    const states = await prisma.trip.findMany({
      where: { id: { in: [memberOwner.trip.id, inactiveOwner.trip.id] } },
      select: { status: true },
    });
    expect(states.every(({ status }) => status === TRIP_STATUS.DRAFT)).toBe(
      true,
    );
  });

  it('TEST 05: rejects an overlapping destination timeline without writes', async () => {
    const fixture = await createDraft({ overlappingDestinations: true });

    await expect(
      service.finalizeTrip(fixture.trip.id, fixture.owner.id),
    ).rejects.toMatchObject({
      response: expect.objectContaining({ code: 'DESTINATION_OVERLAP' }),
    });

    const persisted = await prisma.trip.findUniqueOrThrow({
      where: { id: fixture.trip.id },
    });
    expect(persisted.status).toBe(TRIP_STATUS.DRAFT);
    expect(persisted.finalizedAt).toBeNull();
  });
});

import {
  BadRequestException,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import {
  MEMBER_STATUS,
  TRIP_STATUS,
  TRIP_VISIBILITY,
} from '../../generated/prisma/enums';
import { Prisma } from '../../generated/prisma/client';

jest.mock('nanoid', () => ({
  customAlphabet: () => () => 'TESTCODE',
}));

import { TripsService } from './trips.service';

function timelineStub() {
  return { createEvent: jest.fn().mockResolvedValue({ id: 'event-1' }) };
}

/** Shape read by TripAccessPolicy.authorizeOwner. */
function ownerRow(
  ownerId = 'user-1',
  member: { role: string; status: string } | null = {
    role: 'OWNER',
    status: 'ACTIVE',
  },
) {
  return {
    ownerId,
    members: member ? [{ id: 'member-1', userId: 'user-1', ...member }] : [],
  };
}

const FUTURE_START = new Date('2099-10-01T00:00:00.000Z');
const FUTURE_END = new Date('2099-10-03T00:00:00.000Z');
const PAST_START = new Date('2000-01-01T00:00:00.000Z');
const PAST_END = new Date('2000-01-02T00:00:00.000Z');

describe('TripsService read visibility', () => {
  const trip = {
    id: 'trip-1',
    name: 'Private trip',
    description: null,
    inviteCode: 'SECRET12',
    startDate: new Date('2026-01-01'),
    endDate: new Date('2026-01-02'),
    budgetLevel: null,
    maxMembers: 4,
    tripType: 'FRIENDS',
    visibility: TRIP_VISIBILITY.PRIVATE,
    status: 'UPCOMING',
    coverMedia: null,
    owner: {
      id: 'owner-1',
      displayname: 'Owner',
      username: 'owner',
      avatar: null,
    },
    destinations: [],
    members: [],
    _count: { members: 0 },
    interests: [],
  };

  function setup() {
    const prisma = {
      trip: {
        findMany: jest.fn().mockResolvedValue([trip]),
        count: jest.fn().mockResolvedValue(1),
        groupBy: jest.fn().mockResolvedValue([]),
      },
      tripCheckin: {
        count: jest.fn().mockResolvedValue(0),
        groupBy: jest.fn().mockResolvedValue([]),
      },
      itineraryItem: {
        groupBy: jest.fn().mockResolvedValue([]),
        findMany: jest.fn().mockResolvedValue([]),
      },
      $transaction: jest.fn(async (operations: Promise<unknown>[]) =>
        Promise.all(operations),
      ),
    };
    const s3 = {
      getPublicUrl: jest.fn((key: string) => `https://cdn.test/${key}`),
    };
    const service = new TripsService(
      prisma as never,
      {} as never,
      {} as never,
      s3 as never,
      {} as never,
      timelineStub() as never,
    );
    return { service, prisma };
  }

  it('keeps authorization in an AND branch that client filters cannot replace', async () => {
    const { service, prisma } = setup();
    const result = await service.queryTrip(
      { ownerId: 'someone-else' },
      'user-1',
    );
    const where = prisma.trip.findMany.mock.calls[0][0].where;
    expect(where.AND[0].OR).toEqual(
      expect.arrayContaining([
        {
          visibility: TRIP_VISIBILITY.PUBLIC,
          status: { not: TRIP_STATUS.DRAFT },
        },
        { ownerId: 'user-1' },
        {
          members: { some: { userId: 'user-1', status: MEMBER_STATUS.ACTIVE } },
        },
      ]),
    );
    expect(where.AND).toContainEqual({ status: { not: TRIP_STATUS.DRAFT } });
    expect(result.data[0]).not.toHaveProperty('inviteCode');
  });

  it('counts NOTCOMPLETED trips in the summary', async () => {
    const { service, prisma } = setup();
    prisma.trip.groupBy.mockResolvedValue([
      { status: TRIP_STATUS.UPCOMING, _count: { status: 2 } },
      { status: TRIP_STATUS.NOTCOMPLETED, _count: { status: 3 } },
    ]);

    const result = await service.queryTrip({}, 'user-1');

    expect(result.summary).toMatchObject({
      total: 5,
      upcoming: 2,
      notCompleted: 3,
    });
  });

  it('builds activity progress from aggregate queries', async () => {
    const { service, prisma } = setup();
    const startTime = new Date('2999-01-01T08:00:00.000Z');
    prisma.itineraryItem.groupBy.mockResolvedValue([
      { tripId: 'trip-1', isCheckin: true, _count: { _all: 1 } },
      { tripId: 'trip-1', isCheckin: false, _count: { _all: 3 } },
    ]);
    prisma.tripCheckin.groupBy.mockResolvedValue([
      { tripId: 'trip-1', _count: { _all: 5 } },
    ]);
    prisma.itineraryItem.findMany.mockResolvedValue([
      { tripId: 'trip-1', id: 'activity-9', title: 'Breakfast', startTime },
    ]);

    const result = await service.queryTrip({}, 'user-1');

    expect(result.data[0]).toMatchObject({
      totalActivities: 4,
      completedActivities: 1,
      progressPercent: 25,
      checkinCount: 5,
      nextActivity: { id: 'activity-9', title: 'Breakfast', startTime },
      owner: {
        id: 'owner-1',
        displayname: 'Owner',
        username: 'owner',
        avatarUrl: null,
      },
      recruiting: true,
    });
  });

  it('mine=true lists only trips the caller owns or has joined', async () => {
    const { service, prisma } = setup();
    await service.queryTrip({ mine: true }, 'user-1');
    const where = prisma.trip.findMany.mock.calls[0][0].where;
    expect(where.AND[0]).toEqual({
      OR: [
        { ownerId: 'user-1' },
        {
          members: { some: { userId: 'user-1', status: MEMBER_STATUS.ACTIVE } },
        },
      ],
    });
  });

  it('filters by destinationCatalogId', async () => {
    const { service, prisma } = setup();
    await service.queryTrip(
      { destinationCatalogId: 'catalog-danang' },
      'user-1',
    );
    const where = prisma.trip.findMany.mock.calls[0][0].where;
    expect(where.AND).toContainEqual({
      destinations: { some: { destinationId: 'catalog-danang' } },
    });
  });

  it('applies discover mode: PUBLIC UPCOMING and excludes joined/owned', async () => {
    const { service, prisma } = setup();
    await service.queryTrip({ discover: true, status: TRIP_STATUS.ONGOING }, 'user-1');
    const where = prisma.trip.findMany.mock.calls[0][0].where;
    expect(where.AND).toEqual(
      expect.arrayContaining([
        {
          visibility: TRIP_VISIBILITY.PUBLIC,
          status: TRIP_STATUS.UPCOMING,
          recruitment: {
            is: {
              state: 'OPEN',
              expiresAt: { gt: expect.any(Date) },
            },
          },
          NOT: {
            OR: [
              { ownerId: 'user-1' },
              {
                members: {
                  some: {
                    userId: 'user-1',
                    status: MEMBER_STATUS.ACTIVE,
                  },
                },
              },
            ],
          },
        },
      ]),
    );
    // Discover pins UPCOMING; client status must not override listWhere.
    expect(where.AND).not.toContainEqual({ status: TRIP_STATUS.ONGOING });
    expect(
      prisma.trip.findMany.mock.calls[0][0].select.destinations.select,
    ).toMatchObject({ destinationType: true });
  });
});

describe('TripsService createTrip', () => {
  const startDate = FUTURE_START;
  const endDate = FUTURE_END;

  function setup() {
    const tx = {
      place: {
        findMany: jest
          .fn()
          .mockResolvedValue([{ id: 'place-1', name: 'Dragon Bridge' }]),
      },
      trip: {
        create: jest.fn().mockResolvedValue({
          id: 'trip-1',
          destinations: [{ id: 'destination-1', order: 1 }],
        }),
        findUniqueOrThrow: jest.fn().mockResolvedValue({
          id: 'trip-1',
          name: 'Da Nang',
          status: TRIP_STATUS.UPCOMING,
          startDate,
          endDate,
          destinations: [{ id: 'destination-1' }],
          interests: [],
        }),
      },
      itineraryDay: {
        findFirst: jest.fn().mockResolvedValue({ id: 'day-1' }),
      },
      itineraryItem: {
        createMany: jest.fn().mockResolvedValue({ count: 1 }),
      },
    };
    const prisma = {
      $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
        callback(tx),
      ),
    };
    const itineraries = {
      createDaysForDestination: jest.fn().mockResolvedValue([]),
      recalculateTripDayNumbers: jest.fn().mockResolvedValue(undefined),
    };
    const timeline = timelineStub();
    const service = new TripsService(
      prisma as never,
      {} as never,
      itineraries as never,
      {} as never,
      {} as never,
      timeline as never,
    );
    return { service, tx, itineraries, timeline };
  }

  const dto = {
    name: '  Da Nang  ',
    maxMembers: 4,
    budgetLevel: 'MEDIUM',
    destinations: [
      {
        city: 'Da Nang',
        country: 'VN',
        lat: 16,
        lng: 108,
        order: 1,
        startDate,
        endDate,
        pendingPlaceIds: ['place-1'],
      },
    ],
  } as never;

  it('records TRIP_CREATED in the same transaction as the trip', async () => {
    const { service, tx, timeline } = setup();

    await service.createTrip('user-1', dto);

    expect(timeline.createEvent).toHaveBeenCalledWith(tx, 'trip-1', 'user-1', {
      type: 'TRIP_CREATED',
      content: 'Đã tạo chuyến đi',
      metadata: {
        tripName: 'Da Nang',
        startDate: startDate.toISOString(),
        endDate: endDate.toISOString(),
        destinationCount: 1,
      },
      target: { type: 'TRIP', id: 'trip-1' },
    });
  });

  it('does not record a timeline event for a private draft', async () => {
    const { service, timeline } = setup();

    await service.createDraft('user-1', { name: 'Draft' });

    expect(timeline.createEvent).not.toHaveBeenCalled();
  });

  it('creates an UPCOMING, finalized trip without leaking pendingPlaceIds to Prisma', async () => {
    const { service, tx, itineraries } = setup();

    await service.createTrip('user-1', dto);

    const data = tx.trip.create.mock.calls[0][0].data;
    expect(data).toMatchObject({
      name: 'Da Nang',
      status: TRIP_STATUS.UPCOMING,
      startDate,
      endDate,
      finalizedAt: expect.any(Date),
    });
    expect(data.destinations.create[0]).not.toHaveProperty('pendingPlaceIds');
    expect(itineraries.createDaysForDestination).toHaveBeenCalledWith(
      tx,
      'trip-1',
      'destination-1',
    );
    expect(tx.itineraryItem.createMany).toHaveBeenCalledWith({
      data: [
        {
          tripId: 'trip-1',
          dayId: 'day-1',
          placeId: 'place-1',
          title: 'Dragon Bridge',
          orderIndex: 1,
        },
      ],
    });
  });

  it('creates drafts as DRAFT without a finalized date', async () => {
    const { service, tx } = setup();

    await service.createDraft('user-1', dto);

    expect(tx.trip.create.mock.calls[0][0].data).toMatchObject({
      status: TRIP_STATUS.DRAFT,
      finalizedAt: null,
    });
  });

  it('rejects a trip whose name is blank', async () => {
    const { service } = setup();
    await expect(
      service.createTrip('user-1', {
        ...(dto as object),
        name: '   ',
      } as never),
    ).rejects.toMatchObject({
      response: expect.objectContaining({ code: 'TRIP_NAME_REQUIRED' }),
    });
  });

  it('requires a budget level like finalize does', async () => {
    const { service, tx } = setup();
    await expect(
      service.createTrip('user-1', {
        ...(dto as object),
        budgetLevel: undefined,
      } as never),
    ).rejects.toMatchObject({
      response: expect.objectContaining({ code: 'TRIP_BUDGET_REQUIRED' }),
    });
    expect(tx.trip.create).not.toHaveBeenCalled();
  });

  it('still lets a draft be saved without a budget level', async () => {
    const { service, tx } = setup();

    await service.createDraft('user-1', {
      ...(dto as object),
      budgetLevel: undefined,
    });

    expect(tx.trip.create).toHaveBeenCalled();
  });

  const pastDto = {
    ...(dto as object),
    destinations: [
      {
        ...(dto as unknown as { destinations: object[] }).destinations[0],
        startDate: PAST_START,
        endDate: PAST_END,
      },
    ],
  } as never;

  it('rejects creating a finalized trip that starts in the past', async () => {
    const { service, tx } = setup();

    await expect(service.createTrip('user-1', pastDto)).rejects.toMatchObject({
      response: expect.objectContaining({ code: 'TRIP_START_IN_PAST' }),
    });
    expect(tx.trip.create).not.toHaveBeenCalled();
  });

  it('still lets a draft keep past dates until it is finalized', async () => {
    const { service, tx } = setup();

    await service.createDraft('user-1', pastDto);

    expect(tx.trip.create).toHaveBeenCalled();
  });
});

describe('TripsService updateTrip', () => {
  function setup(current: Record<string, unknown> = {}) {
    const tx = {
      $queryRaw: jest.fn().mockResolvedValue([{ id: 'trip-1' }]),
      trip: {
        findUniqueOrThrow: jest.fn().mockResolvedValue({
          id: 'trip-1',
          name: 'Draft',
          ownerId: 'user-1',
          status: TRIP_STATUS.DRAFT,
          startDate: new Date('2099-01-01T00:00:00.000Z'),
          endDate: new Date('2099-01-02T00:00:00.000Z'),
          estimatedBudgetPerPerson: null,
          budgetCurrency: null,
          _count: { members: 1 },
          ...current,
        }),
        update: jest.fn().mockResolvedValue({ id: 'trip-1', interests: [] }),
      },
      tripDestination: {
        findMany: jest.fn().mockResolvedValue([]),
      },
      tripRecruitment: {
        findUnique: jest.fn().mockResolvedValue(null),
        update: jest.fn().mockResolvedValue({}),
      },
    };
    const prisma = {
      trip: {
        findUnique: jest.fn().mockResolvedValue(ownerRow()),
      },
      $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
        callback(tx),
      ),
    };
    const itineraries = {
      syncTripItineraryDays: jest.fn().mockResolvedValue(undefined),
    };
    const service = new TripsService(
      prisma as never,
      {} as never,
      itineraries as never,
      {} as never,
      {} as never,
      timelineStub() as never,
    );
    return { service, tx };
  }

  it('renames a draft that has no destination yet', async () => {
    const { service, tx } = setup();

    await service.updateTrip('trip-1', 'user-1', { name: ' New name ' });

    const named = tx.trip.update.mock.calls
      .map((call) => call[0].data as { name?: string })
      .find((data) => data.name === 'New name');
    expect(named).toMatchObject({ name: 'New name' });
  });

  it.each([
    TRIP_STATUS.COMPLETED,
    TRIP_STATUS.CANCELLED,
    TRIP_STATUS.NOTCOMPLETED,
  ])('rejects edits to a %s trip', async (status) => {
    const { service, tx } = setup({ status });

    await expect(
      service.updateTrip('trip-1', 'user-1', { name: 'x' }),
    ).rejects.toMatchObject({
      response: expect.objectContaining({ code: 'TRIP_NOT_EDITABLE' }),
    });
    expect(tx.trip.update).not.toHaveBeenCalled();
  });

  it('rejects maxMembers below the active member count', async () => {
    const { service } = setup({ _count: { members: 3 } });

    await expect(
      service.updateTrip('trip-1', 'user-1', { maxMembers: 2 }),
    ).rejects.toMatchObject({
      response: expect.objectContaining({ code: 'MAX_MEMBERS_BELOW_ACTIVE' }),
    });
  });

  it('updates the currency alone by merging the stored budget', async () => {
    const { service, tx } = setup({
      estimatedBudgetPerPerson: new Prisma.Decimal(100),
      budgetCurrency: 'VND',
    });

    await service.updateTrip('trip-1', 'user-1', { budgetCurrency: 'usd' });

    const data = tx.trip.update.mock.calls
      .map((call) => call[0].data as { budgetCurrency?: string; estimatedBudgetPerPerson?: { toString(): string } })
      .find((item) => item.budgetCurrency === 'USD');
    expect(data?.estimatedBudgetPerPerson?.toString()).toBe('100');
  });

  it('requires at least one destination once the trip is not a draft', async () => {
    const { service } = setup({ status: TRIP_STATUS.UPCOMING });

    await expect(
      service.updateTrip('trip-1', 'user-1', { name: 'x' }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('locks the trip row before reading it', async () => {
    const { service, tx } = setup();

    await service.updateTrip('trip-1', 'user-1', { name: 'x' });

    expect(tx.$queryRaw).toHaveBeenCalled();
  });

  it('only lets drafts clear the budget level', async () => {
    const { service, tx } = setup({ status: TRIP_STATUS.UPCOMING });

    await expect(
      service.updateTrip('trip-1', 'user-1', {
        budgetLevel: null as never,
      }),
    ).rejects.toMatchObject({
      response: expect.objectContaining({ code: 'TRIP_BUDGET_REQUIRED' }),
    });
    expect(tx.trip.update).not.toHaveBeenCalled();
  });
});

describe('TripsService deleteTrip', () => {
  function setup(status: TRIP_STATUS) {
    const tx = {
      $queryRaw: jest.fn().mockResolvedValue([{ id: 'trip-1' }]),
      trip: {
        findUnique: jest.fn().mockResolvedValue(ownerRow()),
        findUniqueOrThrow: jest.fn().mockResolvedValue({ status }),
        delete: jest.fn().mockResolvedValue({ id: 'trip-1' }),
      },
      itineraryDay: {
        deleteMany: jest.fn().mockResolvedValue({ count: 0 }),
      },
      tripExpense: {
        deleteMany: jest.fn().mockResolvedValue({ count: 0 }),
      },
    };
    const prisma = {
      $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
        callback(tx),
      ),
    };
    const tripRoomWS = { removeTripRoom: jest.fn() };
    const service = new TripsService(
      prisma as never,
      tripRoomWS as never,
      {} as never,
      {} as never,
      {} as never,
      timelineStub() as never,
    );
    return { service, tx, tripRoomWS };
  }

  it.each([TRIP_STATUS.DRAFT, TRIP_STATUS.UPCOMING])(
    'deletes a %s trip with its RESTRICT dependants and closes the room',
    async (status) => {
      const { service, tx, tripRoomWS } = setup(status);

      await service.deleteTrip('trip-1', 'user-1');

      expect(tx.$queryRaw).toHaveBeenCalled();
      expect(tx.itineraryDay.deleteMany).toHaveBeenCalledWith({
        where: { tripId: 'trip-1' },
      });
      expect(tx.tripExpense.deleteMany).toHaveBeenCalledWith({
        where: { tripId: 'trip-1' },
      });
      expect(tx.trip.delete).toHaveBeenCalledWith({ where: { id: 'trip-1' } });
      expect(tripRoomWS.removeTripRoom).toHaveBeenCalledWith('trip-1');
    },
  );

  it.each([TRIP_STATUS.ONGOING, TRIP_STATUS.COMPLETED, TRIP_STATUS.CANCELLED])(
    'rejects deleting a %s trip',
    async (status) => {
      const { service, tx, tripRoomWS } = setup(status);

      await expect(
        service.deleteTrip('trip-1', 'user-1'),
      ).rejects.toMatchObject({
        response: expect.objectContaining({ code: 'TRIP_NOT_DELETABLE' }),
      });
      expect(tx.trip.delete).not.toHaveBeenCalled();
      expect(tripRoomWS.removeTripRoom).not.toHaveBeenCalled();
    },
  );

  it('returns 404 when the trip does not exist', async () => {
    const { service, tx } = setup(TRIP_STATUS.UPCOMING);
    tx.$queryRaw.mockResolvedValue([]);

    await expect(service.deleteTrip('trip-1', 'user-1')).rejects.toBeInstanceOf(
      NotFoundException,
    );
  });

  it('only lets the owner delete the trip', async () => {
    const { service, tx } = setup(TRIP_STATUS.UPCOMING);
    tx.trip.findUnique.mockResolvedValue(ownerRow('someone-else'));

    await expect(service.deleteTrip('trip-1', 'user-1')).rejects.toBeInstanceOf(
      ForbiddenException,
    );
    expect(tx.trip.delete).not.toHaveBeenCalled();
  });
});

describe('TripsService finalizeTrip', () => {
  const itineraryDays = [{ id: 'day-1', activities: [{ id: 'activity-1' }] }];
  const draft = {
    id: 'trip-1',
    ownerId: 'user-1',
    name: 'Da Nang',
    status: 'DRAFT',
    startDate: FUTURE_START,
    endDate: FUTURE_END,
    tripType: 'FRIENDS',
    budgetLevel: 'MEDIUM',
    destinations: [
      {
        id: 'destination-1',
        city: 'Da Nang',
        country: 'VN',
        lat: 0,
        lng: 0,
        order: 1,
        startDate: FUTURE_START,
        endDate: FUTURE_END,
      },
    ],
  };
  const finalized = {
    ...draft,
    status: 'UPCOMING',
    startDate: FUTURE_START,
    endDate: FUTURE_END,
    destinations: [{ ...draft.destinations[0], itineraryDays }],
    interests: [],
    members: [],
  };

  function setup() {
    const tx = {
      trip: {
        findUnique: jest.fn().mockResolvedValue(ownerRow()),
        findFirst: jest.fn().mockResolvedValue(draft),
        updateMany: jest.fn().mockResolvedValue({ count: 1 }),
        update: jest.fn().mockResolvedValue({}),
        findUniqueOrThrow: jest.fn().mockResolvedValue(finalized),
      },
      tripRecruitment: {
        findUnique: jest.fn().mockResolvedValue(null),
      },
    };
    const prisma = {
      $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
        callback(tx),
      ),
    };
    const service = new TripsService(
      prisma as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      timelineStub() as never,
    );
    return { service, prisma, tx };
  }

  it('requires the caller to be the owner', async () => {
    const { service, tx } = setup();
    tx.trip.findUnique.mockResolvedValue(ownerRow('someone-else'));
    await expect(
      service.finalizeTrip('trip-1', 'user-1'),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });

  it('requires an active OWNER membership', async () => {
    const { service, tx } = setup();
    tx.trip.findUnique.mockResolvedValue(
      ownerRow('user-1', { role: 'OWNER', status: 'LEFT' }),
    );
    await expect(
      service.finalizeTrip('trip-1', 'user-1'),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });

  it('rejects an ADMIN even when Trip.ownerId matches', async () => {
    const { service, tx } = setup();
    tx.trip.findUnique.mockResolvedValue(
      ownerRow('user-1', { role: 'ADMIN', status: 'ACTIVE' }),
    );
    await expect(
      service.finalizeTrip('trip-1', 'user-1'),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });

  it('rejects finalizing a draft whose first destination already started', async () => {
    const { service, tx } = setup();
    tx.trip.findFirst.mockResolvedValue({
      ...draft,
      destinations: [
        { ...draft.destinations[0], startDate: PAST_START, endDate: PAST_END },
      ],
    });
    await expect(
      service.finalizeTrip('trip-1', 'user-1'),
    ).rejects.toMatchObject({
      response: expect.objectContaining({ code: 'TRIP_START_IN_PAST' }),
    });
    expect(tx.trip.updateMany).not.toHaveBeenCalled();
  });

  it('keeps the not-found contracts for a missing trip and a non-draft trip', async () => {
    const missing = setup();
    missing.tx.trip.findUnique.mockResolvedValue(null);
    await expect(
      missing.service.finalizeTrip('trip-1', 'user-1'),
    ).rejects.toThrow('Trip not found');

    const nonDraft = setup();
    nonDraft.tx.trip.findFirst.mockResolvedValue(null);
    await expect(
      nonDraft.service.finalizeTrip('trip-1', 'user-1'),
    ).rejects.toThrow('Trip draft not found');
  });

  it.each([
    ['name', '', 'TRIP_NAME_REQUIRED'],
    ['budgetLevel', null, 'TRIP_BUDGET_REQUIRED'],
  ])('rejects a draft missing %s', async (field, value, code) => {
    const { service, tx } = setup();
    tx.trip.findFirst.mockResolvedValue({
      ...draft,
      [field]: value,
    });
    await expect(
      service.finalizeTrip('trip-1', 'user-1'),
    ).rejects.toMatchObject({
      response: expect.objectContaining({ code }),
    });
  });

  it('requires at least one destination', async () => {
    const { service, tx } = setup();
    tx.trip.findFirst.mockResolvedValue({
      ...draft,
      destinations: [],
    });
    await expect(
      service.finalizeTrip('trip-1', 'user-1'),
    ).rejects.toMatchObject({
      response: expect.objectContaining({ code: 'TRIP_DESTINATION_REQUIRED' }),
    });
  });

  it('rejects an invalid destination timeline', async () => {
    const { service, tx } = setup();
    tx.trip.findFirst.mockResolvedValue({
      ...draft,
      destinations: [
        draft.destinations[0],
        { ...draft.destinations[0], id: 'destination-2', order: 2 },
      ],
    });
    await expect(
      service.finalizeTrip('trip-1', 'user-1'),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('finalizes in one transaction and preserves the response shape and itinerary days', async () => {
    const { service, prisma, tx } = setup();

    const result = await service.finalizeTrip('trip-1', 'user-1');

    expect(prisma.$transaction).toHaveBeenCalledTimes(1);
    expect(tx.trip.findFirst).toHaveBeenCalledWith(
      expect.objectContaining({
        where: { id: 'trip-1', status: 'DRAFT' },
      }),
    );
    expect(tx.trip.updateMany).toHaveBeenCalledWith({
      where: { id: 'trip-1', status: 'DRAFT' },
      data: {
        status: 'UPCOMING',
        finalizedAt: expect.any(Date),
      },
    });
    expect(tx.trip.update).toHaveBeenCalledWith({
      where: { id: 'trip-1' },
      data: {
        startDate: draft.destinations[0].startDate,
        endDate: draft.destinations[0].endDate,
      },
    });
    expect(result).toEqual({ ...finalized, tripInterests: [] });
    expect(result.destinations[0].itineraryDays[0].id).toBe('day-1');
  });

  it('exposes interests as tripInterests like the create and update responses', async () => {
    const { service, tx } = setup();
    const interest = { id: 'interest-1', name: 'Ẩm thực' };
    tx.trip.findUniqueOrThrow.mockResolvedValue({
      ...finalized,
      interests: [
        { id: 'link-1', tripId: 'trip-1', interestId: interest.id, interest },
      ],
    });

    const result = await service.finalizeTrip('trip-1', 'user-1');

    expect(result.tripInterests).toEqual([interest]);
  });

  it('propagates an error so the transaction can roll back', async () => {
    const { service, tx } = setup();
    tx.trip.findUniqueOrThrow.mockRejectedValue(
      new Error('response read failed'),
    );
    await expect(service.finalizeTrip('trip-1', 'user-1')).rejects.toThrow(
      'response read failed',
    );
  });

  it('maps the losing concurrent finalize to the existing draft-not-found contract', async () => {
    const { service, tx } = setup();
    tx.trip.updateMany
      .mockResolvedValueOnce({ count: 1 })
      .mockResolvedValueOnce({ count: 0 });
    const results = await Promise.allSettled([
      service.finalizeTrip('trip-1', 'user-1'),
      service.finalizeTrip('trip-1', 'user-1'),
    ]);
    expect(results[0].status).toBe('fulfilled');
    expect(results[1]).toMatchObject({
      status: 'rejected',
      reason: expect.any(NotFoundException),
    });
  });
});

describe('TripsService destination snapshots', () => {
  it('copies catalog display data without any timezone', async () => {
    const prisma = {
      destinationCatalog: {
        findMany: jest.fn().mockResolvedValue([
          {
            id: 'catalog-1',
            name: 'Da Nang',
            country: 'Vietnam',
            lat: 16.0544,
            lng: 108.2022,
            type: 'BEACH',
            highlights: ['My Khe'],
            coverMediaId: null,
          },
        ]),
      },
    };
    const service = new TripsService(
      prisma as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      timelineStub() as never,
    );

    const [destination] = await (
      service as unknown as {
        hydrateDestinationSnapshots: (input: unknown[]) => Promise<any[]>;
      }
    ).hydrateDestinationSnapshots([
      {
        destinationId: 'catalog-1',
        city: 'ignored',
        country: 'ignored',
        lat: 0,
        lng: 0,
        order: 1,
        startDate: new Date('2026-10-10T00:00:00.000Z'),
        endDate: new Date('2026-10-11T00:00:00.000Z'),
      },
    ]);

    expect(destination).toMatchObject({
      city: 'Da Nang',
      country: 'Vietnam',
      lat: 16.0544,
      lng: 108.2022,
      destinationType: 'BEACH',
      highlights: ['My Khe'],
    });
    expect(destination).not.toHaveProperty('timeZone');
  });
});

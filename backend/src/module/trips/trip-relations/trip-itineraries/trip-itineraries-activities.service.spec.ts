import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import { PlaceStatus } from '../../../../generated/prisma/enums';
import { TripItinerariesActivitiesService } from './trip-itineraries-activities.service';
import { TripAccessPolicy } from '../../policies';

/** Mocks used by the trip lock and the batched place-completion sync. */
function lockAndSyncMocks(
  options: {
    activeMemberIds?: string[];
    checkins?: Array<{ memberId: string; placeId: string }>;
  } = {},
) {
  return {
    $queryRaw: jest.fn().mockResolvedValue([{ id: 'trip-1' }]),
    tripMember: {
      findMany: jest
        .fn()
        .mockResolvedValue(
          (options.activeMemberIds ?? ['member-1']).map((id) => ({ id })),
        ),
      findUnique: jest.fn().mockResolvedValue({
        id: 'member-1',
        user: { displayname: 'Owner', username: 'owner' },
      }),
    },
    tripCheckin: {
      findMany: jest.fn().mockResolvedValue(options.checkins ?? []),
      findFirst: jest.fn().mockResolvedValue(null),
    },
    updateMany: jest.fn().mockResolvedValue({ count: 1 }),
  };
}

describe('TripItinerariesActivitiesService.createActivity', () => {
  function setup(
    place: { id: string; name: string } | null,
    checkins: Array<{ memberId: string; placeId: string }> = [],
  ) {
    const shared = lockAndSyncMocks({ checkins });
    const tx = {
      $queryRaw: shared.$queryRaw,
      tripMember: shared.tripMember,
      tripCheckin: shared.tripCheckin,
      itineraryDay: { count: jest.fn().mockResolvedValue(1) },
      place: { findFirst: jest.fn().mockResolvedValue(place) },
      itineraryItem: {
        findMany: jest.fn().mockResolvedValue([]),
        create: jest
          .fn()
          .mockImplementation(({ data }) => ({ id: 'activity-1', ...data })),
        updateMany: shared.updateMany,
      },
    };
    const prisma = {
      tripMember: {
        findUnique: jest.fn().mockResolvedValue({
          id: 'member-1',
          role: 'ADMIN',
          status: 'ACTIVE',
        }),
      },
      trip: {
        findUnique: jest.fn().mockResolvedValue({ id: 'trip-1' }),
      },
      $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
        Promise.resolve(callback(tx)),
      ),
    };
    const itineraries = {
      getDayOrThrow: jest.fn().mockResolvedValue({
        id: 'day-1',
        dayNumber: 2,
      }),
    };
    const gateway = {
      emitTimelineEvent: jest.fn(),
      emitChatMessage: jest.fn(),
    };
    const timeline = {
      createEvent: jest.fn().mockResolvedValue({ id: 'event-1' }),
    };
    const tripMessages = {
      createAutoMessage: jest.fn().mockResolvedValue({
        id: 'chat-sys-1',
        messageType: 'SYSTEM',
        content: 'Place',
        createdAt: new Date(),
        metadata: { icon: 'add_location_alt', richText: 'x' },
        sender: {
          id: 'member-1',
          role: 'OWNER',
          user: {
            id: 'owner-1',
            username: 'owner',
            displayname: 'Owner',
            avatar: null,
          },
        },
        reactions: [],
      }),
      mapStoredMessageToUi: jest.fn().mockReturnValue({ id: 'chat-sys-1' }),
    };
    const events = { emit: jest.fn() };
    return {
      service: new TripItinerariesActivitiesService(
        prisma as never,
        itineraries as never,
        gateway as never,
        timeline as never,
        tripMessages as never,
        events as never,
      ),
      tx,
      itineraries,
      tripMessages,
    };
  }

  function createdOrderIndex(tx: ReturnType<typeof setup>['tx']): number {
    return tx.itineraryItem.create.mock.calls[0][0].data.orderIndex;
  }

  const siblings = [
    { id: 'a', orderIndex: 1000 },
    { id: 'b', orderIndex: 2000 },
  ];

  it('appends to the end of the day by default', async () => {
    const { service, tx } = setup({ id: 'place-1', name: 'Hoi An' });
    tx.itineraryItem.findMany.mockResolvedValueOnce(siblings);
    await service.createActivity('trip-1', 'day-1', 'owner-1', {
      placeId: 'place-1',
    });
    expect(createdOrderIndex(tx)).toBe(3000);
  });

  it('inserts between an anchor and the next activity', async () => {
    const { service, tx } = setup({ id: 'place-1', name: 'Hoi An' });
    tx.itineraryItem.findMany.mockResolvedValueOnce(siblings);
    await service.createActivity('trip-1', 'day-1', 'owner-1', {
      placeId: 'place-1',
      insertAfterActivityId: 'a',
    });
    expect(createdOrderIndex(tx)).toBe(1500);
  });

  it('inserts at the start of the day before the first activity', async () => {
    const { service, tx } = setup({ id: 'place-1', name: 'Hoi An' });
    tx.itineraryItem.findMany.mockResolvedValueOnce(siblings);
    await service.createActivity('trip-1', 'day-1', 'owner-1', {
      placeId: 'place-1',
      insertBeforeActivityId: 'a',
    });
    expect(createdOrderIndex(tx)).toBe(500);
  });

  it('renumbers the day when the gap at the insert point is exhausted', async () => {
    const { service, tx } = setup({ id: 'place-1', name: 'Hoi An' });
    Object.assign(tx.itineraryItem, { update: jest.fn() });
    tx.itineraryItem.findMany.mockResolvedValueOnce([
      { id: 'a', orderIndex: 1000 },
      { id: 'b', orderIndex: 1000 + 1e-9 },
    ]);
    await service.createActivity('trip-1', 'day-1', 'owner-1', {
      placeId: 'place-1',
      insertAfterActivityId: 'a',
    });
    const update = (tx.itineraryItem as unknown as { update: jest.Mock })
      .update;
    expect(update).toHaveBeenCalledWith({
      where: { id: 'a' },
      data: { orderIndex: 1000 },
    });
    expect(update).toHaveBeenCalledWith({
      where: { id: 'b' },
      data: { orderIndex: 2000 },
    });
    expect(createdOrderIndex(tx)).toBe(1500);
  });

  it('rejects both insert anchors at once', async () => {
    const { service, tx } = setup({ id: 'place-1', name: 'Hoi An' });
    await expect(
      service.createActivity('trip-1', 'day-1', 'owner-1', {
        placeId: 'place-1',
        insertAfterActivityId: 'a',
        insertBeforeActivityId: 'b',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
    expect(tx.itineraryItem.create).not.toHaveBeenCalled();
  });

  it('trims and stores an explicit non-empty title', async () => {
    const { service, tx } = setup({ id: 'place-1', name: 'Hoi An' });
    await service.createActivity('trip-1', 'day-1', 'owner-1', {
      placeId: 'place-1',
      title: '  Lunch  ',
    });
    expect(tx.itineraryItem.create).toHaveBeenCalledWith(
      expect.objectContaining({
        data: expect.objectContaining({ title: 'Lunch' }),
      }),
    );
  });

  it('uses an approved place name when title is omitted', async () => {
    const { service, tx } = setup({ id: 'place-1', name: 'Hoi An' });
    await service.createActivity('trip-1', 'day-1', 'owner-1', {
      placeId: 'place-1',
    });
    expect(tx.place.findFirst).toHaveBeenCalledWith({
      where: { id: 'place-1', status: PlaceStatus.APPROVED },
      select: { id: true, name: true },
    });
    expect(tx.itineraryItem.create).toHaveBeenCalledWith(
      expect.objectContaining({
        data: expect.objectContaining({ title: 'Hoi An' }),
      }),
    );
  });

  it('trims and stores optional activity notes', async () => {
    const { service, tx } = setup({ id: 'place-1', name: 'Hoi An' });
    await service.createActivity('trip-1', 'day-1', 'owner-1', {
      placeId: 'place-1',
      notes: '  Bring sunscreen  ',
    });
    expect(tx.itineraryItem.create).toHaveBeenCalledWith(
      expect.objectContaining({
        data: expect.objectContaining({ notes: 'Bring sunscreen' }),
      }),
    );
  });

  it('returns 400 instead of reaching Prisma create without a valid place/title', async () => {
    const { service, tx } = setup(null);
    await expect(
      service.createActivity('trip-1', 'day-1', 'owner-1', {
        placeId: 'missing',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
    expect(tx.itineraryItem.create).not.toHaveBeenCalled();
  });

  it('reads the day under the trip lock and returns 404 when it is gone', async () => {
    const { service, tx, itineraries } = setup({
      id: 'place-1',
      name: 'Hoi An',
    });
    itineraries.getDayOrThrow.mockRejectedValueOnce(
      new NotFoundException('Day not found in this trip'),
    );

    await expect(
      service.createActivity('trip-1', 'day-1', 'owner-1', {
        placeId: 'place-1',
      }),
    ).rejects.toBeInstanceOf(NotFoundException);
    expect(itineraries.getDayOrThrow).toHaveBeenCalledWith(
      tx,
      'trip-1',
      'day-1',
    );
    expect(tx.$queryRaw.mock.invocationCallOrder[0]).toBeLessThan(
      itineraries.getDayOrThrow.mock.invocationCallOrder[0],
    );
    expect(tx.itineraryItem.create).not.toHaveBeenCalled();
  });

  it('marks a new activity checked in when every member already checked in there', async () => {
    const { service, tx } = setup({ id: 'place-1', name: 'Hoi An' }, [
      { memberId: 'member-1', placeId: 'place-1' },
    ]);

    const activity = await service.createActivity(
      'trip-1',
      'day-1',
      'owner-1',
      { placeId: 'place-1' },
    );

    expect(activity.isCheckin).toBe(true);
    expect(tx.itineraryItem.updateMany).toHaveBeenCalledWith({
      where: { tripId: 'trip-1', placeId: { in: ['place-1'] } },
      data: { isCheckin: true },
    });
  });
});

describe('TripItinerariesActivitiesService management permission', () => {
  const allowed = [
    ['OWNER', 'ACTIVE'],
    ['ADMIN', 'ACTIVE'],
  ] as const;
  const denied = [
    ['MEMBER', 'ACTIVE'],
    ['OWNER', 'LEFT'],
    ['ADMIN', 'KICKED'],
  ] as const;

  function serviceFor(role: string | null, status: string | null) {
    const prisma = {
      tripMember: {
        findUnique: jest
          .fn()
          .mockResolvedValue(role === null ? null : { role, status }),
      },
    };
    return new TripItinerariesActivitiesService(
      prisma as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
    );
  }

  it.each(allowed)('allows active %s', (role, status) => {
    expect(() =>
      TripAccessPolicy.assertAllowed({ role, status }, 'MANAGE_ITINERARY'),
    ).not.toThrow();
  });

  it.each(denied)('denies role %s with status %s', (role, status) => {
    expect(() =>
      TripAccessPolicy.assertAllowed(
        { role, status },
        'MANAGE_ITINERARY',
      ),
    ).toThrow(ForbiddenException);
  });

  it('hides the trip when there is no membership row', () => {
    expect(() =>
      TripAccessPolicy.assertAllowed(null, 'MANAGE_ITINERARY'),
    ).toThrow(NotFoundException);
  });

  it.each(['createActivity', 'updateActivity', 'deleteActivity'] as const)(
    '%s checks the shared management policy before accessing activity data',
    async (method) => {
      const service = serviceFor('MEMBER', 'ACTIVE');
      const call =
        method === 'createActivity'
          ? service.createActivity('trip-1', 'day-1', 'user-1', {
              placeId: 'place-1',
            })
          : method === 'updateActivity'
            ? service.updateActivity('trip-1', 'activity-1', {}, 'user-1')
            : service.deleteActivity('trip-1', 'activity-1', 'user-1');

      await expect(call).rejects.toBeInstanceOf(ForbiddenException);
    },
  );
});

describe('TripItinerariesActivitiesService.updateActivity', () => {
  function setup() {
    const day = new Date('2026-10-02T00:00:00.000Z');
    const activity = {
      id: 'activity-1',
      tripId: 'trip-1',
      dayId: 'day-1',
      placeId: 'place-1',
      startTime: null,
      estimatedDuration: null,
      day: {
        id: 'day-1',
        tripId: 'trip-1',
        destinationId: 'destination-1',
        date: day,
        destination: {
          id: 'destination-1',
          tripId: 'trip-1',
          startDate: new Date('2026-10-01T00:00:00.000Z'),
          endDate: new Date('2026-10-03T00:00:00.000Z'),
          order: 1,
        },
      },
    };
    const shared = lockAndSyncMocks();
    const tx = {
      $queryRaw: shared.$queryRaw,
      tripMember: shared.tripMember,
      tripCheckin: shared.tripCheckin,
      place: {
        findFirst: jest.fn().mockResolvedValue({ id: 'place-2' }),
      },
      itineraryItem: {
        findUnique: jest.fn().mockResolvedValue(activity),
        findMany: jest.fn().mockResolvedValue([activity]),
        update: jest.fn().mockImplementation(({ data }) => ({
          ...activity,
          ...data,
          placeId: data.placeId ?? activity.placeId,
        })),
        updateMany: shared.updateMany,
      },
    };
    const prisma = {
      tripMember: {
        findUnique: jest
          .fn()
          .mockResolvedValue({ role: 'ADMIN', status: 'ACTIVE' }),
      },
      $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
        Promise.resolve(callback(tx)),
      ),
    };
    const service = new TripItinerariesActivitiesService(
      prisma as never,
      {} as never,
      { emitTimelineEvent: jest.fn(), emitChatMessage: jest.fn() } as never,
      { createEvent: jest.fn().mockResolvedValue({ id: 'event-1' }) } as never,
      {
        createAutoMessage: jest.fn().mockResolvedValue({
          id: 'chat-sys-1',
          messageType: 'SYSTEM',
          content: 'Place',
          createdAt: new Date(),
          metadata: {},
          sender: {
            id: 'm1',
            role: 'OWNER',
            user: {
              id: 'owner-1',
              username: 'o',
              displayname: 'O',
              avatar: null,
            },
          },
          reactions: [],
        }),
        mapStoredMessageToUi: jest.fn().mockReturnValue({ id: 'chat-sys-1' }),
      } as never,
      { emit: jest.fn() } as never,
    );
    return { service, prisma, tx };
  }

  it('updates non-schedule fields without loading siblings', async () => {
    const { service, tx } = setup();

    await service.updateActivity(
      'trip-1',
      'activity-1',
      { title: 'Dinner' },
      'user-1',
    );

    expect(tx.$queryRaw).toHaveBeenCalled();
    expect(tx.itineraryItem.findMany).not.toHaveBeenCalled();
    expect(tx.itineraryItem.update).toHaveBeenCalledWith(
      expect.objectContaining({
        data: expect.objectContaining({ title: 'Dinner' }),
      }),
    );
  });

  it('schedules a start time on the itinerary day in UTC', async () => {
    const { service, tx } = setup();

    await service.updateActivity(
      'trip-1',
      'activity-1',
      { startTime: '2026-10-02T09:00:00Z', estimatedDuration: 60 },
      'user-1',
    );

    expect(tx.itineraryItem.update).toHaveBeenCalled();
  });

  it('rejects a start time whose UTC date is another itinerary day', async () => {
    const { service, tx } = setup();

    await expect(
      service.updateActivity(
        'trip-1',
        'activity-1',
        { startTime: '2026-10-02T05:00:00+07:00', estimatedDuration: 60 },
        'user-1',
      ),
    ).rejects.toMatchObject({
      response: expect.objectContaining({ code: 'ACTIVITY_DAY_MISMATCH' }),
    });
    expect(tx.itineraryItem.update).not.toHaveBeenCalled();
  });

  it('allows clearing the schedule', async () => {
    const { service, tx } = setup();

    await service.updateActivity(
      'trip-1',
      'activity-1',
      { startTime: null, estimatedDuration: null },
      'user-1',
    );

    expect(tx.itineraryItem.update).toHaveBeenCalled();
  });

  it('rejects moving an activity to a place that is not approved', async () => {
    const { service, tx } = setup();
    tx.place.findFirst.mockResolvedValue(null);

    await expect(
      service.updateActivity(
        'trip-1',
        'activity-1',
        { placeId: 'pending-place' },
        'user-1',
      ),
    ).rejects.toBeInstanceOf(BadRequestException);
    expect(tx.itineraryItem.update).not.toHaveBeenCalled();
  });

  it('locks the place of an activity that already has a check-in', async () => {
    const { service, tx } = setup();
    tx.tripCheckin.findFirst.mockResolvedValue({ id: 'checkin-1' });

    await expect(
      service.updateActivity(
        'trip-1',
        'activity-1',
        { placeId: 'place-2' },
        'user-1',
      ),
    ).rejects.toMatchObject({
      response: expect.objectContaining({ code: 'CHECKED_IN_PLACE_LOCKED' }),
    });
    expect(tx.itineraryItem.update).not.toHaveBeenCalled();
  });

  it('re-syncs completion for both the old and the new place', async () => {
    const { service, tx } = setup();

    await service.updateActivity(
      'trip-1',
      'activity-1',
      { placeId: 'place-2' },
      'user-1',
    );

    expect(tx.tripCheckin.findMany).toHaveBeenCalledWith({
      where: { tripId: 'trip-1', placeId: { in: ['place-1', 'place-2'] } },
      select: { memberId: true, placeId: true },
    });
  });
});

describe('TripItinerariesActivitiesService place reuse and reorder', () => {
  function setup() {
    const tx = {
      $queryRaw: jest.fn().mockResolvedValue([{ id: 'trip-1' }]),
      itineraryDay: {
        findFirst: jest.fn().mockResolvedValue({ id: 'day-1' }),
      },
      itineraryItem: {
        findMany: jest
          .fn()
          .mockResolvedValue([{ id: 'item-1' }, { id: 'item-2' }]),
        update: jest.fn().mockResolvedValue({}),
      },
    };
    const prisma = {
      trip: { findUnique: jest.fn().mockResolvedValue({ id: 'trip-1' }) },
      tripMember: {
        findUnique: jest.fn().mockResolvedValue({
          role: 'OWNER',
          status: 'ACTIVE',
        }),
      },
      $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
        Promise.resolve(callback(tx)),
      ),
    };
    const service = new TripItinerariesActivitiesService(
      prisma as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
    );
    return { service, prisma, tx };
  }

  it('reorders independent items even when their placeId may be the same', async () => {
    const { service, tx } = setup();
    tx.itineraryItem.findMany
      .mockResolvedValueOnce([{ id: 'item-1' }, { id: 'item-2' }])
      .mockResolvedValueOnce([
        { id: 'item-2', placeId: 'hotel-1' },
        { id: 'item-1', placeId: 'hotel-1' },
      ]);

    const result = await service.reorderItems(
      'trip-1',
      'day-1',
      { orderedItemIds: ['item-2', 'item-1'] },
      'owner-1',
    );

    expect(tx.itineraryItem.update).toHaveBeenNthCalledWith(1, {
      where: { id: 'item-2' },
      data: { orderIndex: 1000 },
    });
    expect(result).toHaveLength(2);
  });

  function batchSetup() {
    const destination = {
      id: 'destination-1',
      tripId: 'trip-1',
      startDate: new Date('2026-10-01T00:00:00.000Z'),
      endDate: new Date('2026-10-03T00:00:00.000Z'),
      order: 1,
    };
    const shared = lockAndSyncMocks();
    const tx = {
      $queryRaw: shared.$queryRaw,
      tripMember: shared.tripMember,
      tripCheckin: shared.tripCheckin,
      itineraryDay: {
        findMany: jest.fn().mockResolvedValue([
          {
            id: 'day-1',
            tripId: 'trip-1',
            destinationId: destination.id,
            date: new Date('2026-10-01T00:00:00.000Z'),
            destination,
          },
          {
            id: 'day-2',
            tripId: 'trip-1',
            destinationId: destination.id,
            date: new Date('2026-10-02T00:00:00.000Z'),
            destination,
          },
        ]),
      },
      place: {
        findMany: jest.fn().mockResolvedValue([{ id: 'hotel-1' }]),
      },
      itineraryItem: {
        findMany: jest.fn().mockResolvedValue([]),
        groupBy: jest.fn().mockResolvedValue([]),
        create: jest
          .fn()
          .mockImplementation(({ data }) => ({ id: data.dayId, ...data })),
        updateMany: shared.updateMany,
      },
    };
    const prisma = {
      tripMember: {
        findUnique: jest.fn().mockResolvedValue({
          role: 'OWNER',
          status: 'ACTIVE',
        }),
      },
      $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
        Promise.resolve(callback(tx)),
      ),
    };
    const service = new TripItinerariesActivitiesService(
      prisma as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
    );
    return { service, tx };
  }

  it('rejects batch items whose place is not approved', async () => {
    const { service, tx } = batchSetup();
    tx.place.findMany.mockResolvedValue([]);

    await expect(
      service.createItemsBatch(
        'trip-1',
        {
          items: [
            {
              dayId: 'day-1',
              placeId: 'pending-place',
              title: 'Pending',
              orderIndex: 1000,
            },
          ],
        },
        'owner-1',
      ),
    ).rejects.toBeInstanceOf(BadRequestException);
    expect(tx.itineraryItem.create).not.toHaveBeenCalled();
  });

  it('rejects batch items that overlap each other on the same day', async () => {
    const { service, tx } = batchSetup();

    await expect(
      service.createItemsBatch(
        'trip-1',
        {
          items: [
            {
              dayId: 'day-1',
              placeId: 'hotel-1',
              title: 'Morning',
              startTime: '2026-10-01T09:00:00Z',
              estimatedDuration: 120,
              orderIndex: 1000,
            },
            {
              dayId: 'day-1',
              placeId: 'hotel-1',
              title: 'Overlap',
              startTime: '2026-10-01T10:00:00Z',
              estimatedDuration: 60,
              orderIndex: 2000,
            },
          ],
        },
        'owner-1',
      ),
    ).rejects.toMatchObject({
      response: expect.objectContaining({ code: 'ACTIVITY_OVERLAP' }),
    });
    expect(tx.itineraryItem.create).not.toHaveBeenCalled();
  });

  it('creates repeated places in the same batch and trip', async () => {
    const { service, tx } = batchSetup();

    const result = await service.createItemsBatch(
      'trip-1',
      {
        items: [
          {
            dayId: 'day-1',
            placeId: 'hotel-1',
            title: 'Hotel day 1',
            notes: '  Early check-in  ',
            orderIndex: 1000,
          },
          {
            dayId: 'day-2',
            placeId: 'hotel-1',
            title: 'Hotel day 2',
            orderIndex: 1000,
          },
        ],
      },
      'owner-1',
    );

    expect(result.createdCount).toBe(2);
    expect(tx.$queryRaw).toHaveBeenCalled();
    expect(tx.itineraryItem.create).toHaveBeenCalledTimes(2);
    expect(tx.itineraryItem.create).toHaveBeenNthCalledWith(
      1,
      expect.objectContaining({
        data: expect.objectContaining({ notes: 'Early check-in' }),
      }),
    );
    expect(tx.itineraryItem.create.mock.calls[0][0].data).not.toHaveProperty(
      'isCheckin',
    );
    expect(result.items.every((item) => item.isCheckin === false)).toBe(true);
  });

  it('assigns orderIndex after existing activities, ordered by the client hint', async () => {
    const { service, tx } = batchSetup();
    tx.itineraryItem.groupBy.mockResolvedValue([
      { dayId: 'day-1', _max: { orderIndex: 5000 } },
    ]);

    await service.createItemsBatch(
      'trip-1',
      {
        items: [
          {
            dayId: 'day-1',
            placeId: 'hotel-1',
            title: 'Second',
            orderIndex: 7,
          },
          { dayId: 'day-1', placeId: 'hotel-1', title: 'First', orderIndex: 0 },
          { dayId: 'day-2', placeId: 'hotel-1', title: 'Other day' },
        ],
      },
      'owner-1',
    );

    const stored = tx.itineraryItem.create.mock.calls.map(
      ([args]: [{ data: { title: string; orderIndex: number } }]) => [
        args.data.title,
        args.data.orderIndex,
      ],
    );
    expect(stored).toEqual([
      ['Second', 7000],
      ['First', 6000],
      ['Other day', 1000],
    ]);
  });

  it('rejects duplicate item ids', async () => {
    const { service, prisma } = setup();
    await expect(
      service.reorderItems(
        'trip-1',
        'day-1',
        { orderedItemIds: ['item-1', 'item-1'] },
        'owner-1',
      ),
    ).rejects.toBeInstanceOf(BadRequestException);
    expect(prisma.$transaction).not.toHaveBeenCalled();
  });

  it('rejects missing ids and ids from another day without partial updates', async () => {
    const { service, tx } = setup();
    await expect(
      service.reorderItems(
        'trip-1',
        'day-1',
        { orderedItemIds: ['item-1', 'other-day-item'] },
        'owner-1',
      ),
    ).rejects.toBeInstanceOf(BadRequestException);
    expect(tx.itineraryItem.update).not.toHaveBeenCalled();
  });

  it('rejects unauthorized members before starting the transaction', async () => {
    const { service, prisma } = setup();
    prisma.tripMember.findUnique.mockResolvedValue({
      role: 'MEMBER',
      status: 'ACTIVE',
    });
    await expect(
      service.reorderItems(
        'trip-1',
        'day-1',
        { orderedItemIds: ['item-1', 'item-2'] },
        'member-1',
      ),
    ).rejects.toBeInstanceOf(ForbiddenException);
    expect(prisma.$transaction).not.toHaveBeenCalled();
  });

  it('propagates transaction failures so the database can roll back', async () => {
    const { service, prisma, tx } = setup();
    tx.itineraryItem.update
      .mockResolvedValueOnce({})
      .mockRejectedValueOnce(new Error('write failed'));
    await expect(
      service.reorderItems(
        'trip-1',
        'day-1',
        { orderedItemIds: ['item-1', 'item-2'] },
        'owner-1',
      ),
    ).rejects.toThrow('write failed');
    expect(prisma.$transaction).toHaveBeenCalledTimes(1);
  });
});

describe('TripItinerariesActivitiesService check-in', () => {
  const member = { id: 'member-1', role: 'MEMBER', status: 'ACTIVE' };

  function setup(tripStatus = 'ONGOING') {
    const activity = {
      id: 'item-2',
      tripId: 'trip-1',
      dayId: 'day-1',
      placeId: 'hotel-1',
      place: { latitude: 10, longitude: 106 },
      day: { destination: { tripId: 'trip-1' } },
      trip: { status: tripStatus },
    };
    const tx = {
      $queryRaw: jest.fn().mockResolvedValue([{ id: 'trip-1' }]),
      tripMember: {
        findUnique: jest.fn().mockResolvedValue(member),
        findMany: jest.fn().mockResolvedValue([{ id: 'member-1' }]),
      },
      tripCheckin: {
        findUnique: jest.fn().mockResolvedValue(null),
        findMany: jest.fn().mockResolvedValue([]),
        delete: jest.fn().mockResolvedValue({}),
      },
      tripCompletion: {
        findUnique: jest.fn().mockResolvedValue(null),
      },
      itineraryItem: {
        updateMany: jest.fn().mockResolvedValue({ count: 1 }),
      },
    };
    const prisma = {
      tripMember: { findUnique: jest.fn().mockResolvedValue(member) },
      itineraryItem: { findUnique: jest.fn().mockResolvedValue(activity) },
      $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
        Promise.resolve(callback(tx)),
      ),
    };
    const timeline = {
      createEvent: jest.fn().mockResolvedValue({ id: 'event-1' }),
    };
    const service = new TripItinerariesActivitiesService(
      prisma as never,
      {} as never,
      { emitTimelineEvent: jest.fn(), emitChatMessage: jest.fn() } as never,
      timeline as never,
      {
        createAutoMessage: jest.fn().mockResolvedValue({
          id: 'chat-sys-1',
          messageType: 'SYSTEM',
          content: 'Place',
          createdAt: new Date(),
          metadata: {},
          sender: {
            id: 'm1',
            role: 'OWNER',
            user: {
              id: 'owner-1',
              username: 'o',
              displayname: 'O',
              avatar: null,
            },
          },
          reactions: [],
        }),
        mapStoredMessageToUi: jest.fn().mockReturnValue({ id: 'chat-sys-1' }),
      } as never,
      { emit: jest.fn() } as never,
    );
    return { service, tx, prisma, timeline };
  }

  const here = { latitude: 10, longitude: 106 };

  it('records the place snapshot, never the member GPS, on the timeline', async () => {
    const { service, tx, prisma, timeline } = setup();
    prisma.itineraryItem.findUnique.mockResolvedValue({
      id: 'item-2',
      title: 'Ngắm bình minh',
      tripId: 'trip-1',
      dayId: 'day-1',
      placeId: 'son-tra',
      place: {
        name: 'Bán đảo Sơn Trà',
        city: 'Đà Nẵng',
        latitude: 16.1182,
        longitude: 108.2789,
        coverImages: [
          { media: { objectKey: 'places/son-tra.jpg', deletedAt: null } },
        ],
      },
      day: { destination: { tripId: 'trip-1' } },
      trip: { status: 'ONGOING' },
    });
    Object.assign(tx.tripCheckin, {
      create: jest.fn().mockResolvedValue({ id: 'checkin-1' }),
    });

    await service.checkin(
      'trip-1',
      'item-2',
      { latitude: 16.1183, longitude: 108.279 },
      'user-1',
    );

    expect(timeline.createEvent).toHaveBeenCalledWith(tx, 'trip-1', 'user-1', {
      type: 'ACTIVITY_CHECKIN',
      content: 'Đã check-in hoạt động',
      metadata: {
        activityTitle: 'Ngắm bình minh',
        placeName: 'Bán đảo Sơn Trà',
        placeArea: 'Đà Nẵng',
        latitude: 16.1182,
        longitude: 108.2789,
        placeMediaKey: 'places/son-tra.jpg',
        verified: true,
        pointsEarned: 5,
      },
      target: { type: 'ACTIVITY', id: 'item-2' },
    });
  });

  it('uses Trip/User/Place identity when rejecting a second check-in', async () => {
    const { service, tx } = setup();
    tx.tripCheckin.findUnique.mockResolvedValue({ id: 'checkin-1' });

    await expect(
      service.checkin('trip-1', 'item-2', here, 'user-1'),
    ).rejects.toBeInstanceOf(ConflictException);
    expect(tx.tripCheckin.findUnique).toHaveBeenCalledWith({
      where: {
        tripId_userId_placeId: {
          tripId: 'trip-1',
          userId: 'user-1',
          placeId: 'hotel-1',
        },
      },
    });
  });

  it.each(['DRAFT', 'COMPLETED', 'CANCELLED', 'NOTCOMPLETED'])(
    'rejects check-in while the trip is %s',
    async (status) => {
      const { service, tx } = setup(status);

      await expect(
        service.checkin('trip-1', 'item-2', here, 'user-1'),
      ).rejects.toBeInstanceOf(ConflictException);
      expect(tx.$queryRaw).not.toHaveBeenCalled();
    },
  );

  it('rejects removing a check-in after the member completed the trip', async () => {
    const { service, tx } = setup();
    tx.tripCheckin.findUnique.mockResolvedValue({ id: 'checkin-1' });
    tx.tripCompletion.findUnique.mockResolvedValue({ id: 'completion-1' });

    await expect(
      service.uncheckin('trip-1', 'item-2', 'user-1'),
    ).rejects.toBeInstanceOf(ConflictException);
    expect(tx.tripCheckin.delete).not.toHaveBeenCalled();
  });

  it('removes a check-in and re-syncs the place completion', async () => {
    const { service, tx } = setup();
    tx.tripCheckin.findUnique.mockResolvedValue({ id: 'checkin-1' });

    await service.uncheckin('trip-1', 'item-2', 'user-1');

    expect(tx.$queryRaw).toHaveBeenCalled();
    expect(tx.tripCheckin.delete).toHaveBeenCalledWith({
      where: { id: 'checkin-1' },
    });
    expect(tx.itineraryItem.updateMany).toHaveBeenCalledWith({
      where: { tripId: 'trip-1', placeId: { in: ['hotel-1'] } },
      data: { isCheckin: false },
    });
  });
});

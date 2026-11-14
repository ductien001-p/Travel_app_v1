import {
  BadRequestException,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import { MEMBER_STATUS } from '../../../../generated/prisma/enums';
import { TripTimelineService } from './tripTimeline.service';
import { toTimelineCounts } from './timeline-category';
import { readStoredMetadata } from './timeline-metadata';

const createdAt = new Date('2026-10-13T08:00:00.000Z');

function eventRow(overrides: Record<string, unknown> = {}) {
  return {
    id: 'event-1',
    tripId: 'trip-1',
    memberId: 'member-1',
    type: 'EXPENSE_CREATED',
    content: 'Đã thêm một chi phí mới',
    metadata: {
      amount: '1200000',
      currency: 'VND',
      category: 'FOOD',
      description: 'Hải sản',
      splitCount: 4,
    },
    targetType: 'EXPENSE',
    targetId: 'expense-1',
    createdAt,
    member: {
      id: 'member-1',
      user: {
        id: 'user-1',
        username: 'lan',
        displayname: 'Lan Nguyễn',
        avatar: { objectKey: 'avatars/lan.jpg', deletedAt: null },
      },
    },
    ...overrides,
  };
}

function setup(
  options: {
    member?: Record<string, unknown> | null;
    events?: Array<Record<string, unknown>>;
    cursorEvent?: Record<string, unknown> | null;
    aliveMemories?: Array<{ id: string; media: { objectKey: string } }>;
  } = {},
) {
  const prisma = {
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
    },
    trip: { findUnique: jest.fn().mockResolvedValue({ id: 'trip-1' }) },
    tripTimelineEvent: {
      findFirst: jest
        .fn()
        .mockResolvedValue(
          options.cursorEvent === undefined
            ? { id: 'cursor-1' }
            : options.cursorEvent,
        ),
      findMany: jest.fn().mockResolvedValue(options.events ?? [eventRow()]),
      groupBy: jest.fn().mockResolvedValue([
        { type: 'EXPENSE_CREATED', _count: { _all: 3 } },
        { type: 'EXPENSE_SETTLED', _count: { _all: 1 } },
        { type: 'ACTIVITY_CHECKIN', _count: { _all: 2 } },
        { type: 'MEMBER_JOINED', _count: { _all: 4 } },
        { type: 'ACTIVITY_ADDED', _count: { _all: 5 } },
      ]),
    },
    tripMedia: {
      findMany: jest.fn().mockResolvedValue(options.aliveMemories ?? []),
    },
  };
  const s3 = {
    getPublicUrl: jest.fn((key: string) => `https://cdn.test/${key}`),
  };
  const service = new TripTimelineService(prisma as never, s3 as never);
  return { service, prisma };
}

describe('TripTimelineService.getTripTimeline', () => {
  it('returns the display name, avatar URL, target and metadata of each event', async () => {
    const { service } = setup();

    const page = await service.getTripTimeline('trip-1', 'user-1');

    expect(page.data).toEqual([
      {
        id: 'event-1',
        tripId: 'trip-1',
        memberId: 'member-1',
        type: 'EXPENSE_CREATED',
        content: 'Đã thêm một chi phí mới',
        createdAt,
        targetType: 'EXPENSE',
        targetId: 'expense-1',
        member: {
          id: 'member-1',
          user: {
            id: 'user-1',
            username: 'lan',
            displayName: 'Lan Nguyễn',
            avatarUrl: 'https://cdn.test/avatars/lan.jpg',
          },
        },
        metadata: {
          amount: '1200000',
          currency: 'VND',
          category: 'FOOD',
          description: 'Hải sản',
          splitCount: 4,
        },
      },
    ]);
  });

  it('sends per-group totals with the first page only', async () => {
    const { service, prisma } = setup();

    const first = await service.getTripTimeline('trip-1', 'user-1');
    expect(first.meta).toEqual({
      nextCursor: null,
      hasMore: false,
      counts: { all: 15, checkin: 2, expense: 4, memory: 0, member: 4 },
    });

    const next = await service.getTripTimeline('trip-1', 'user-1', {
      cursor: 'cursor-1',
    });
    expect(next.meta.counts).toBeNull();
    expect(prisma.tripTimelineEvent.groupBy).toHaveBeenCalledTimes(1);
  });

  it('filters by category and validates the cursor against the same filter', async () => {
    const { service, prisma } = setup();

    await service.getTripTimeline('trip-1', 'user-1', {
      category: 'expense',
      cursor: 'cursor-1',
    });

    const expectedWhere = {
      tripId: 'trip-1',
      type: { in: ['EXPENSE_CREATED', 'EXPENSE_SETTLED'] },
    };
    expect(prisma.tripTimelineEvent.findFirst).toHaveBeenCalledWith({
      where: { ...expectedWhere, id: 'cursor-1' },
      select: { id: true },
    });
    expect(prisma.tripTimelineEvent.findMany).toHaveBeenCalledWith(
      expect.objectContaining({
        where: expectedWhere,
        cursor: { id: 'cursor-1' },
        skip: 1,
      }),
    );
  });

  it('rejects a cursor that does not belong to the filtered list', async () => {
    const { service, prisma } = setup({ cursorEvent: null });

    await expect(
      service.getTripTimeline('trip-1', 'user-1', {
        category: 'checkin',
        cursor: 'other',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
    expect(prisma.tripTimelineEvent.findMany).not.toHaveBeenCalled();
  });

  it('pages with limit + 1 and returns the last item as the next cursor', async () => {
    const { service } = setup({
      events: [
        eventRow({ id: 'e1' }),
        eventRow({ id: 'e2' }),
        eventRow({ id: 'e3' }),
      ],
    });

    const page = await service.getTripTimeline('trip-1', 'user-1', {
      limit: 2,
    });

    expect(page.data.map((event) => event.id)).toEqual(['e1', 'e2']);
    expect(page.meta).toMatchObject({ nextCursor: 'e2', hasMore: true });
  });

  it('forbids non-members', async () => {
    const { service, prisma } = setup({ member: null });

    await expect(
      service.getTripTimeline('trip-1', 'stranger'),
    ).rejects.toBeInstanceOf(NotFoundException);
    expect(prisma.tripTimelineEvent.findMany).not.toHaveBeenCalled();
  });

  it('only exposes photos of memories that still exist, in one query', async () => {
    const { service, prisma } = setup({
      events: [
        eventRow({
          id: 'memory-event',
          type: 'MEMORY_ADDED',
          metadata: { memoryIds: ['m1', 'deleted', 'm2'], caption: 'Hải Vân' },
          targetType: 'MEMORY',
          targetId: 'm1',
        }),
      ],
      aliveMemories: [
        { id: 'm2', media: { objectKey: 'trips/m2.jpg' } },
        { id: 'm1', media: { objectKey: 'trips/m1.jpg' } },
      ],
    });

    const page = await service.getTripTimeline('trip-1', 'user-1');

    expect(page.data[0].metadata).toEqual({
      caption: 'Hải Vân',
      memoryIds: ['m1', 'm2'],
      photoUrls: [
        'https://cdn.test/trips/m1.jpg',
        'https://cdn.test/trips/m2.jpg',
      ],
      photoCount: 2,
    });
    expect(prisma.tripMedia.findMany).toHaveBeenCalledTimes(1);
    expect(prisma.tripMedia.findMany).toHaveBeenCalledWith(
      expect.objectContaining({
        where: expect.objectContaining({
          id: { in: ['m1', 'deleted', 'm2'] },
          tripId: 'trip-1',
          media: { deletedAt: null },
        }),
      }),
    );
  });

  it('resolves the check-in place cover without leaking the storage key', async () => {
    const { service } = setup({
      events: [
        eventRow({
          type: 'ACTIVITY_CHECKIN',
          metadata: {
            activityTitle: 'Bán đảo Sơn Trà',
            placeName: 'Bán đảo Sơn Trà',
            placeArea: 'Đà Nẵng',
            latitude: 16.1182,
            longitude: 108.2789,
            placeMediaKey: 'places/son-tra.jpg',
            verified: true,
            pointsEarned: 5,
          },
        }),
      ],
    });

    const [event] = (await service.getTripTimeline('trip-1', 'user-1')).data;

    expect(event.metadata).toEqual({
      activityTitle: 'Bán đảo Sơn Trà',
      placeName: 'Bán đảo Sơn Trà',
      placeArea: 'Đà Nẵng',
      latitude: 16.1182,
      longitude: 108.2789,
      imageUrl: 'https://cdn.test/places/son-tra.jpg',
      verified: true,
      pointsEarned: 5,
    });
  });

  it('returns null metadata and avatar for legacy events and deleted avatars', async () => {
    const legacy = eventRow({
      metadata: null,
      targetType: null,
      targetId: null,
    });
    legacy.member.user.avatar = {
      objectKey: 'avatars/old.jpg',
      deletedAt: new Date(),
    } as never;
    const { service } = setup({ events: [legacy] });

    const [event] = (await service.getTripTimeline('trip-1', 'user-1')).data;

    expect(event.metadata).toBeNull();
    expect(event.member.user.avatarUrl).toBeNull();
    expect(event.targetType).toBeNull();
  });
});

describe('TripTimelineService.createEvent', () => {
  function activeMember(tripStatus = 'UPCOMING') {
    return {
      id: 'member-1',
      role: 'MEMBER',
      status: 'ACTIVE',
      trip: { status: tripStatus },
    };
  }

  function txFor(member: Record<string, unknown> | null) {
    return {
      tripMember: { findFirst: jest.fn().mockResolvedValue(member) },
      tripTimelineEvent: {
        create: jest.fn().mockResolvedValue(eventRow()),
      },
      tripMedia: { findMany: jest.fn().mockResolvedValue([]) },
    };
  }

  it('stores metadata and target and returns the public response shape', async () => {
    const { service } = setup();
    const tx = txFor(activeMember());

    const response = await service.createEvent(
      tx as never,
      'trip-1',
      'user-1',
      {
        type: 'EXPENSE_CREATED',
        content: 'Đã thêm một chi phí mới',
        metadata: {
          amount: '1200000',
          currency: 'VND',
          category: 'FOOD',
          description: 'Hải sản',
          splitType: 'EQUAL',
          splitCount: 4,
        },
        target: { type: 'EXPENSE', id: 'expense-1' },
      },
    );

    expect(tx.tripTimelineEvent.create).toHaveBeenCalledWith(
      expect.objectContaining({
        data: {
          tripId: 'trip-1',
          memberId: 'member-1',
          type: 'EXPENSE_CREATED',
          content: 'Đã thêm một chi phí mới',
          metadata: {
            amount: '1200000',
            currency: 'VND',
            category: 'FOOD',
            description: 'Hải sản',
            splitType: 'EQUAL',
            splitCount: 4,
          },
          targetType: 'EXPENSE',
          targetId: 'expense-1',
        },
      }),
    );
    expect(response?.member.user.displayName).toBe('Lan Nguyễn');
    expect(response?.metadata).toMatchObject({ amount: '1200000' });
  });

  it('records nothing while the trip is a draft', async () => {
    const { service } = setup();
    const tx = txFor(activeMember('DRAFT'));

    const response = await service.createEvent(
      tx as never,
      'trip-1',
      'user-1',
      {
        type: 'ACTIVITY_ADDED',
        content: 'Đã thêm một hoạt động mới',
        metadata: {
          activityTitle: 'Cà phê',
          placeName: 'Hội An',
          dayNumber: 1,
          startTime: null,
        },
      },
    );

    expect(response).toBeNull();
    expect(tx.tripTimelineEvent.create).not.toHaveBeenCalled();
  });

  it('still rejects non-members of a draft trip', async () => {
    const { service } = setup();
    const tx = txFor(null);

    await expect(
      service.createEvent(tx as never, 'trip-1', 'user-1', {
        type: 'MEMBER_LEFT',
        content: 'x',
        metadata: null,
      }),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });

  it('leaves metadata and target empty for events without details', async () => {
    const { service } = setup();
    const tx = txFor(activeMember());

    await service.createEvent(tx as never, 'trip-1', 'user-1', {
      type: 'MEMBER_LEFT',
      content: 'Đã rời khỏi chuyến đi',
      metadata: null,
    });

    expect(tx.tripTimelineEvent.create).toHaveBeenCalledWith(
      expect.objectContaining({
        data: expect.objectContaining({
          metadata: undefined,
          targetType: null,
          targetId: null,
        }),
      }),
    );
  });

  it('rejects authors without an active membership', async () => {
    const { service } = setup();
    const tx = txFor({ ...activeMember(), status: 'LEFT' });

    await expect(
      service.createEvent(tx as never, 'trip-1', 'user-1', {
        type: 'MEMBER_LEFT',
        content: 'x',
        metadata: null,
      }),
    ).rejects.toBeInstanceOf(ForbiddenException);
    expect(tx.tripTimelineEvent.create).not.toHaveBeenCalled();
  });
});

describe('timeline metadata helpers', () => {
  it('keeps only known fields with the expected type', () => {
    expect(
      readStoredMetadata({
        amount: '100',
        splitCount: 'four',
        latitude: Number.NaN,
        verified: 'yes',
        password: 'secret',
        nested: { a: 1 },
      })?.metadata,
    ).toEqual({ amount: '100' });
  });

  it.each([null, 'text', 42, ['a']])(
    'ignores non-object metadata %p',
    (raw) => {
      expect(readStoredMetadata(raw)).toBeNull();
    },
  );

  it('folds type counts into filter groups', () => {
    expect(
      toTimelineCounts([
        { type: 'MEMORY_ADDED', count: 2 },
        { type: 'MEMORY_DELETED', count: 1 },
        { type: 'MEMBER_KICKED', count: 1 },
        { type: 'TRIP_CREATED', count: 1 },
      ]),
    ).toEqual({ all: 5, checkin: 0, expense: 0, memory: 3, member: 1 });
  });
});

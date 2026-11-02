import { NotFoundException } from '@nestjs/common';
import { Prisma } from '../../../generated/prisma/client';
import {
  CURRENCY,
  MEMBER_STATUS,
  TRIP_STATUS,
  TRIP_VISIBILITY,
} from '../../../generated/prisma/enums';
import { TripDetailService } from './trip-detail.service';

const NOW = new Date('2025-07-16T08:00:00.000Z');

function member(
  id: string,
  role: 'OWNER' | 'ADMIN' | 'MEMBER',
  joinedAt = new Date('2025-07-01T00:00:00.000Z'),
) {
  return {
    id: `member-${id}`,
    userId: `user-${id}`,
    role,
    status: MEMBER_STATUS.ACTIVE,
    joinedAt,
    user: {
      displayname: `Name ${id}`,
      avatar: { objectKey: `avatars/${id}.png`, deletedAt: null },
    },
  };
}

function tripRecord(overrides: Record<string, unknown> = {}) {
  return {
    id: 'trip-1',
    name: 'Mùa hè miền Trung',
    description: 'Hành trình',
    status: TRIP_STATUS.ONGOING,
    visibility: TRIP_VISIBILITY.PUBLIC,
    tripType: 'FRIENDS',
    startDate: new Date('2025-07-15T00:00:00.000Z'),
    endDate: new Date('2025-07-20T00:00:00.000Z'),
    maxMembers: 6,
    budgetLevel: 'MEDIUM',
    budgetCurrency: null,
    inviteCode: 'TRIP-VN2025',
    coverMedia: { objectKey: 'covers/trip.png', deletedAt: null },
    destinations: [
      {
        id: 'destination-danang',
        city: 'Đà Nẵng',
        country: 'Việt Nam',
        order: 1,
        startDate: new Date('2025-07-15T00:00:00.000Z'),
        endDate: new Date('2025-07-18T00:00:00.000Z'),
      },
      {
        id: 'destination-hoian',
        city: 'Hội An',
        country: 'Việt Nam',
        order: 2,
        startDate: new Date('2025-07-18T00:00:00.000Z'),
        endDate: new Date('2025-07-20T00:00:00.000Z'),
      },
    ],
    members: [
      member('owner', 'OWNER'),
      member('admin', 'ADMIN'),
      member('new', 'MEMBER', new Date('2025-07-15T00:00:00.000Z')),
    ],
    ...overrides,
  };
}

function setup(trip: unknown = tripRecord()) {
  const prisma = {
    trip: { findFirst: jest.fn().mockResolvedValue(trip) },
    itineraryItem: {
      groupBy: jest.fn().mockResolvedValue([
        { isCheckin: true, _count: { _all: 6 } },
        { isCheckin: false, _count: { _all: 2 } },
      ]),
      findFirst: jest.fn().mockResolvedValue({
        id: 'activity-1',
        title: 'Cầu Rồng phun lửa',
        notes: 'Tập trung lúc 18:15',
        startTime: new Date('2025-07-16T11:30:00.000Z'),
        placeId: 'place-bridge',
      }),
      findMany: jest
        .fn()
        .mockResolvedValue([
          { placeId: 'A' },
          { placeId: 'B' },
          { placeId: 'C' },
          { placeId: 'D' },
        ]),
    },
    tripCheckin: {
      count: jest.fn().mockResolvedValue(2),
      findMany: jest
        .fn()
        .mockResolvedValue([{ placeId: 'A' }, { placeId: 'B' }]),
    },
    userTravelDNA: {
      findMany: jest.fn().mockResolvedValue([
        { userId: 'user-owner', type: 'BEACH_LOVER' },
        { userId: 'user-owner', type: 'FOODIE_TRAVELER' },
      ]),
    },
    tripExpense: {
      groupBy: jest.fn().mockResolvedValue([
        {
          payerId: 'member-admin',
          currency: CURRENCY.VND,
          _sum: { amount: new Prisma.Decimal('2140000') },
        },
        {
          payerId: 'member-owner',
          currency: CURRENCY.VND,
          _sum: { amount: new Prisma.Decimal('2710000') },
        },
      ]),
    },
    uploadedMedia: {
      groupBy: jest.fn().mockResolvedValue([
        { userId: 'user-admin', _count: { _all: 5 } },
        { userId: null, _count: { _all: 1 } },
      ]),
    },
    tripMedia: {
      findMany: jest.fn().mockResolvedValue([
        {
          id: 'memory-1',
          caption: 'Đỉnh Bàn Cờ',
          media: {
            objectKey: 'memories/1.png',
            user: { displayname: 'Name admin' },
          },
        },
        {
          id: 'memory-2',
          caption: null,
          media: { objectKey: 'memories/2.png', user: null },
        },
      ]),
    },
    tripTimelineEvent: {
      findMany: jest.fn().mockResolvedValue([
        {
          id: 'event-2',
          type: 'ACTIVITY_CHECKIN',
          content: 'Đã check-in hoạt động',
          createdAt: new Date('2025-07-16T07:00:00.000Z'),
          memberId: 'member-admin',
          member: {
            user: { displayname: 'Name admin', avatar: null },
          },
        },
        {
          id: 'event-1',
          type: 'EXPENSE_CREATED',
          content: 'Đã thêm một chi phí mới',
          createdAt: new Date('2025-07-15T07:00:00.000Z'),
          memberId: 'member-admin',
          member: {
            user: { displayname: 'Name admin', avatar: null },
          },
        },
      ]),
      count: jest.fn().mockResolvedValue(8),
    },
    tripCompletion: { findUnique: jest.fn().mockResolvedValue(null) },
  };
  const s3 = {
    getPublicUrl: jest.fn((key: string) => `https://cdn.test/${key}`),
  };
  const tripRoomWS = {
    getOnlineUserIds: jest.fn().mockResolvedValue(new Set(['user-admin'])),
  };
  const service = new TripDetailService(
    prisma as never,
    s3 as never,
    tripRoomWS as never,
  );
  return { service, prisma, tripRoomWS };
}

describe('TripDetailService', () => {
  beforeEach(() => {
    jest.useFakeTimers({ now: NOW });
  });

  afterEach(() => {
    jest.useRealTimers();
  });

  it('applies the shared read policy and hides inaccessible trips', async () => {
    const { service, prisma } = setup(null);

    await expect(
      service.getTripDetail('trip-1', 'outsider'),
    ).rejects.toBeInstanceOf(NotFoundException);
    expect(prisma.trip.findFirst.mock.calls[0][0].where.OR).toBeDefined();
  });

  it('returns the full trip detail contract to the owner', async () => {
    const { service } = setup();

    const result = await service.getTripDetail('trip-1', 'user-owner');

    expect(result).toMatchObject({
      id: 'trip-1',
      coverImageUrl: 'https://cdn.test/covers/trip.png',
      inviteCode: 'TRIP-VN2025',
      viewer: { userId: 'user-owner', role: 'OWNER' },
      expenseSummary: { totalAmount: 4850000, currency: CURRENCY.VND },
      checkinProgress: { completedCount: 6, totalCount: 8, pointsEarned: 0 },
      nextActivity: {
        id: 'activity-1',
        title: 'Cầu Rồng phun lửa',
        description: 'Tập trung lúc 18:15',
        confirmedCount: 2,
        totalCount: 3,
      },
      memories: {
        totalCount: 6,
        items: [
          {
            id: 'memory-1',
            imageUrl: 'https://cdn.test/memories/1.png',
            caption: 'Đỉnh Bàn Cờ',
            authorName: 'Name admin',
          },
          { id: 'memory-2', caption: null, authorName: null },
        ],
      },
      completionReward: { points: 10, canClaim: true, claimed: false },
      timeline: {
        totalCount: 8,
        items: [
          {
            id: 'event-2',
            type: 'ACTIVITY_CHECKIN',
            actorName: 'Name admin',
            actorAvatarUrl: null,
          },
          { id: 'event-1' },
        ],
      },
    });
    expect(result.destinations.map((d) => d.isCurrent)).toEqual([true, false]);
  });

  it('enriches members with persona, presence, spending and memories', async () => {
    const { service } = setup();

    const { members } = await service.getTripDetail('trip-1', 'user-owner');

    expect(members).toEqual([
      expect.objectContaining({
        id: 'member-owner',
        displayName: 'Name owner',
        avatarUrl: 'https://cdn.test/avatars/owner.png',
        role: 'OWNER',
        travelPersona: 'Beach Lover 🏖️',
        activityNote: null,
        isOnline: false,
        isNewMember: false,
        amountSpent: 2710000,
        memoryCount: 0,
      }),
      expect.objectContaining({
        id: 'member-admin',
        activityNote: 'Đã check-in hoạt động',
        isOnline: true,
        amountSpent: 2140000,
        memoryCount: 5,
      }),
      expect.objectContaining({
        id: 'member-new',
        travelPersona: null,
        isNewMember: true,
        amountSpent: 0,
      }),
    ]);
  });

  it('marks the later stop as current on a transfer day', async () => {
    jest.setSystemTime(new Date('2025-07-18T09:00:00.000Z'));
    const { service } = setup();

    const result = await service.getTripDetail('trip-1', 'user-owner');

    expect(result.destinations.map((d) => d.isCurrent)).toEqual([false, true]);
  });

  it('only shares the invite code with the owner', async () => {
    const { service } = setup();

    const result = await service.getTripDetail('trip-1', 'user-admin');

    expect(result.inviteCode).toBeNull();
    expect(result.viewer).toEqual({ userId: 'user-admin', role: 'ADMIN' });
  });

  it('hides member-only sections from non-members of a public trip', async () => {
    const { service, prisma, tripRoomWS } = setup();

    const result = await service.getTripDetail('trip-1', 'outsider');

    expect(result).toMatchObject({
      inviteCode: null,
      viewer: { userId: 'outsider', role: null },
      expenseSummary: null,
      memories: null,
      completionReward: null,
      timeline: null,
      checkinProgress: { completedCount: 6, totalCount: 8, pointsEarned: 0 },
    });
    expect(result.members[1]).toMatchObject({
      isOnline: false,
      amountSpent: null,
      memoryCount: 0,
      activityNote: null,
    });
    expect(prisma.tripExpense.groupBy).not.toHaveBeenCalled();
    expect(prisma.tripMedia.findMany).not.toHaveBeenCalled();
    expect(prisma.tripTimelineEvent.findMany).not.toHaveBeenCalled();
    expect(prisma.tripCompletion.findUnique).not.toHaveBeenCalled();
    expect(tripRoomWS.getOnlineUserIds).not.toHaveBeenCalled();
  });

  it('reports a claimed completion and the points it earned', async () => {
    const { service, prisma } = setup();
    prisma.tripCompletion.findUnique.mockResolvedValue({ pointsAwarded: 350 });

    const result = await service.getTripDetail('trip-1', 'user-owner');

    expect(result.completionReward).toEqual({
      points: 350,
      canClaim: false,
      claimed: true,
    });
    expect(result.checkinProgress.pointsEarned).toBe(350);
  });

  it('cannot claim before the trip starts', async () => {
    const { service } = setup(
      tripRecord({
        status: TRIP_STATUS.UPCOMING,
        startDate: new Date('2025-08-01T00:00:00.000Z'),
      }),
    );

    const result = await service.getTripDetail('trip-1', 'user-owner');

    expect(result.completionReward).toMatchObject({ canClaim: false });
  });

  it('has no current stop once the trip is closed', async () => {
    const { service } = setup(tripRecord({ status: TRIP_STATUS.COMPLETED }));

    const result = await service.getTripDetail('trip-1', 'user-owner');

    expect(result.destinations.every((d) => !d.isCurrent)).toBe(true);
  });

  it('cannot claim below the check-in threshold', async () => {
    const { service, prisma } = setup();
    prisma.tripCheckin.findMany.mockResolvedValue([{ placeId: 'A' }]);

    const result = await service.getTripDetail('trip-1', 'user-owner');

    expect(result.completionReward).toEqual({
      points: 5,
      canClaim: false,
      claimed: false,
    });
  });

  it('only totals expenses recorded in the summary currency', async () => {
    const { service, prisma } = setup(tripRecord({ budgetCurrency: 'USD' }));
    prisma.tripExpense.groupBy.mockResolvedValue([
      {
        payerId: 'member-owner',
        currency: CURRENCY.VND,
        _sum: { amount: new Prisma.Decimal('500000') },
      },
      {
        payerId: 'member-owner',
        currency: CURRENCY.USD,
        _sum: { amount: new Prisma.Decimal('12.5') },
      },
    ]);

    const result = await service.getTripDetail('trip-1', 'user-owner');

    expect(result.expenseSummary).toEqual({
      totalAmount: 12.5,
      currency: CURRENCY.USD,
    });
    expect(result.members[0].amountSpent).toBe(12.5);
  });

  it('still loads the detail when presence cannot be read', async () => {
    const { service, tripRoomWS } = setup();
    tripRoomWS.getOnlineUserIds.mockRejectedValue(new Error('socket down'));

    const result = await service.getTripDetail('trip-1', 'user-owner');

    expect(result.members.every((m) => !m.isOnline)).toBe(true);
  });
});

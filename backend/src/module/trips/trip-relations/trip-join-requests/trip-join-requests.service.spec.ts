import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import { Prisma } from '../../../../generated/prisma/client';
import { TripJoinRequestsService } from './trip-join-requests.service';

type Member = { userId: string; role: string; status: string };

const NOW = new Date('2026-10-15T08:00:00.000Z');

function requestRecord(overrides: Record<string, unknown> = {}) {
  return {
    id: 'request-1',
    tripId: 'trip-1',
    status: 'PENDING',
    message: 'Cho mình đi với',
    createdAt: NOW,
    decidedAt: null,
    requester: {
      id: 'user-anh',
      displayname: 'Minh Anh',
      username: 'minhanh',
      hostStatus: 'APPROVED',
      avatar: { objectKey: 'avatars/anh.jpg', deletedAt: null },
    },
    ...overrides,
  };
}

function setup(
  options: {
    trip?: Record<string, unknown> | null;
    members?: Member[];
    activeMemberCount?: number;
    previousRequest?: { status: string } | null;
    request?: Record<string, unknown> | null;
    friends?: boolean;
    decidedCount?: number;
  } = {},
) {
  const members = options.members ?? [
    { userId: 'owner-1', role: 'OWNER', status: 'ACTIVE' },
    { userId: 'admin-1', role: 'ADMIN', status: 'ACTIVE' },
  ];
  const memberOf = (userId: string) =>
    members.find((member) => member.userId === userId) ?? null;

  const tx = {
    trip: {
      findUnique: jest.fn().mockResolvedValue(
        options.trip === undefined
          ? {
              id: 'trip-1',
              name: 'Hội An',
              status: 'UPCOMING',
              maxMembers: 5,
              ownerId: 'owner-1',
              autoApproveFriends: false,
            }
          : options.trip,
      ),
      update: jest.fn((args: { data: Record<string, unknown> }) =>
        Promise.resolve(args.data),
      ),
    },
    tripMember: {
      findUnique: jest.fn(
        ({ where }: { where: { tripId_userId: { userId: string } } }) =>
          Promise.resolve(memberOf(where.tripId_userId.userId)),
      ),
      findMany: jest
        .fn()
        .mockResolvedValue(
          members
            .filter((member) => member.role !== 'MEMBER')
            .map(({ userId }) => ({ userId })),
        ),
      count: jest.fn().mockResolvedValue(options.activeMemberCount ?? 2),
      upsert: jest.fn().mockResolvedValue({ id: 'member-new' }),
    },
    tripJoinRequest: {
      findUnique: jest.fn().mockResolvedValue(options.previousRequest ?? null),
      findFirst: jest.fn().mockResolvedValue(
        options.request === undefined
          ? {
              requesterId: 'user-anh',
              status: 'PENDING',
              trip: { name: 'Hội An', status: 'UPCOMING', maxMembers: 5 },
            }
          : options.request,
      ),
      upsert: jest.fn().mockResolvedValue({ id: 'request-1' }),
      updateMany: jest
        .fn()
        .mockResolvedValue({ count: options.decidedCount ?? 1 }),
    },
    friendship: {
      findFirst: jest
        .fn()
        .mockResolvedValue(options.friends ? { id: 'friendship-1' } : null),
    },
    tripRecruitment: {
      findUnique: jest.fn().mockResolvedValue({
        state: 'OPEN',
        expiresAt: new Date('2099-01-01T00:00:00.000Z'),
        trip: { status: 'UPCOMING', maxMembers: 5 },
      }),
      update: jest.fn().mockResolvedValue({}),
    },
    $queryRaw: jest.fn().mockResolvedValue([{ id: 'trip-1' }]),
    user: {
      findUniqueOrThrow: jest
        .fn()
        .mockResolvedValue({ displayname: 'Minh Anh' }),
    },
  };

  const prisma = {
    $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
      Promise.resolve().then(() => callback(tx)),
    ),
    tripMember: tx.tripMember,
    trip: {
      findUnique: tx.trip.findUnique,
      findUniqueOrThrow: jest.fn().mockResolvedValue({
        tripType: 'OTHER',
        autoApproveFriends: true,
        itineraryItems: [
          { place: { category: 'FOOD' } },
          { place: { category: 'BEACH' } },
        ],
      }),
    },
    tripJoinRequest: {
      findUniqueOrThrow: jest.fn().mockResolvedValue(requestRecord()),
      findFirst: jest.fn().mockResolvedValue({ id: 'cursor-1' }),
      findMany: jest.fn().mockResolvedValue([requestRecord()]),
      groupBy: jest.fn().mockResolvedValue([
        { status: 'PENDING', _count: { _all: 3 } },
        { status: 'REJECTED', _count: { _all: 1 } },
      ]),
    },
    tripRecruitment: tx.tripRecruitment,
    userTravelDNA: {
      findMany: jest
        .fn()
        .mockResolvedValue([
          { userId: 'user-anh', type: 'FOODIE_TRAVELER', score: 10 },
        ]),
    },
  };
  const s3 = {
    getPublicUrl: jest.fn((key: string) => `https://cdn.test/${key}`),
  };
  const notifications = { create: jest.fn().mockResolvedValue({}) };
  const push = { sendToUser: jest.fn().mockResolvedValue(undefined) };
  const timeline = {
    createEvent: jest.fn().mockResolvedValue({ id: 'event-1' }),
  };
  const gateway = {
    emitTimelineEvent: jest.fn(),
    getConnectedUserIds: jest.fn().mockResolvedValue(new Set(['user-anh'])),
  };

  return {
    service: new TripJoinRequestsService(
      prisma as never,
      s3 as never,
      notifications as never,
      push as never,
      timeline as never,
      gateway as never,
    ),
    prisma,
    tx,
    s3,
    notifications,
    push,
    timeline,
    gateway,
  };
}

describe('TripJoinRequestsService.requestToJoin', () => {
  it('rejects an invalid invite code', async () => {
    const { service, tx } = setup({ trip: null });

    await expect(
      service.requestToJoin('bad-code', 'user-anh', {}),
    ).rejects.toBeInstanceOf(NotFoundException);
    expect(tx.tripJoinRequest.upsert).not.toHaveBeenCalled();
  });

  it('rejects a kicked member asking to come back', async () => {
    const { service, tx } = setup({
      members: [{ userId: 'user-anh', role: 'MEMBER', status: 'KICKED' }],
    });

    await expect(
      service.requestToJoin('code', 'user-anh', {}),
    ).rejects.toBeInstanceOf(ForbiddenException);
    expect(tx.tripJoinRequest.upsert).not.toHaveBeenCalled();
  });

  it('checks capacity inside a serializable transaction', async () => {
    const { service, prisma } = setup({ activeMemberCount: 5 });

    await expect(service.requestToJoin('code', 'user-anh', {})).rejects.toThrow(
      'Trip is full',
    );
    expect(prisma.$transaction).toHaveBeenCalledWith(expect.any(Function), {
      isolationLevel: 'Serializable',
    });
  });

  it('refuses a second request while one is pending', async () => {
    const { service, tx } = setup({ previousRequest: { status: 'PENDING' } });

    await expect(
      service.requestToJoin('code', 'user-anh', {}),
    ).rejects.toBeInstanceOf(ConflictException);
    expect(tx.tripJoinRequest.upsert).not.toHaveBeenCalled();
  });

  it('queues the request for the owner and admins', async () => {
    const { service, tx, notifications, push, timeline } = setup();

    const result = await service.requestToJoin('code', 'user-anh', {
      message: 'Cho mình đi với',
    });

    expect(tx.tripJoinRequest.upsert).toHaveBeenCalledWith(
      expect.objectContaining({
        create: expect.objectContaining({
          tripId: 'trip-1',
          requesterId: 'user-anh',
          status: 'PENDING',
          message: 'Cho mình đi với',
          decidedAt: null,
        }),
      }),
    );
    expect(tx.tripMember.upsert).not.toHaveBeenCalled();
    expect(timeline.createEvent).not.toHaveBeenCalled();
    expect(
      notifications.create.mock.calls.map(([, params]) => [
        params.userId,
        params.type,
      ]),
    ).toEqual([
      ['owner-1', 'TRIP_JOIN_REQUEST'],
      ['admin-1', 'TRIP_JOIN_REQUEST'],
    ]);
    expect(push.sendToUser).toHaveBeenCalledTimes(2);
    expect(result.status).toBe('PENDING');
  });

  it('lets a friend of the owner in when the trip auto-approves friends', async () => {
    const { service, tx, notifications, timeline, gateway } = setup({
      trip: {
        id: 'trip-1',
        name: 'Hội An',
        status: 'UPCOMING',
        maxMembers: 5,
        ownerId: 'owner-1',
        autoApproveFriends: true,
      },
      friends: true,
    });

    await service.requestToJoin('code', 'user-anh', {});

    expect(tx.tripJoinRequest.upsert).toHaveBeenCalledWith(
      expect.objectContaining({
        create: expect.objectContaining({
          status: 'APPROVED',
          decidedAt: expect.any(Date),
        }),
      }),
    );
    expect(tx.tripMember.upsert).toHaveBeenCalledWith(
      expect.objectContaining({
        update: expect.objectContaining({ role: 'MEMBER', status: 'ACTIVE' }),
      }),
    );
    expect(timeline.createEvent).toHaveBeenCalledWith(
      tx,
      'trip-1',
      'user-anh',
      {
        type: 'MEMBER_JOINED',
        content: 'Đã tham gia chuyến đi',
        metadata: { via: 'INVITE_CODE' },
        target: { type: 'MEMBER', id: 'member-new' },
      },
    );
    expect(gateway.emitTimelineEvent).toHaveBeenCalledWith('trip-1', {
      id: 'event-1',
    });
    expect(notifications.create).not.toHaveBeenCalled();
  });

  it('still asks for review when the requester is not a friend', async () => {
    const { service, tx } = setup({
      trip: {
        id: 'trip-1',
        name: 'Hội An',
        status: 'UPCOMING',
        maxMembers: 5,
        ownerId: 'owner-1',
        autoApproveFriends: true,
      },
      friends: false,
    });

    await service.requestToJoin('code', 'user-anh', {});

    expect(tx.tripMember.upsert).not.toHaveBeenCalled();
  });

  it('maps a serialization failure to a retryable 409', async () => {
    const { service, prisma } = setup();
    prisma.$transaction.mockRejectedValueOnce(
      new Prisma.PrismaClientKnownRequestError('conflict', {
        code: 'P2034',
        clientVersion: 'test',
      }),
    );

    await expect(
      service.requestToJoin('code', 'user-anh', {}),
    ).rejects.toBeInstanceOf(ConflictException);
  });
});

describe('TripJoinRequestsService.requestToJoinByTripId', () => {
  it('accepts a PUBLIC trip and queues a pending request', async () => {
    const { service, tx } = setup({
      trip: {
        id: 'trip-public',
        name: 'Đà Nẵng',
        status: 'UPCOMING',
        maxMembers: 5,
        ownerId: 'owner-1',
        autoApproveFriends: false,
        visibility: 'PUBLIC',
      },
    });

    const result = await service.requestToJoinByTripId(
      'trip-public',
      'user-anh',
      { message: 'Xin vào' },
    );

    expect(tx.trip.findUnique).toHaveBeenCalledWith(
      expect.objectContaining({ where: { id: 'trip-public' } }),
    );
    expect(tx.tripJoinRequest.upsert).toHaveBeenCalled();
    expect(result.status).toBe('PENDING');
  });

  it('rejects PRIVATE trips joined by id', async () => {
    const { service, tx } = setup({
      trip: {
        id: 'trip-private',
        name: 'Private',
        status: 'UPCOMING',
        maxMembers: 5,
        ownerId: 'owner-1',
        autoApproveFriends: false,
        visibility: 'PRIVATE',
      },
    });

    await expect(
      service.requestToJoinByTripId('trip-private', 'user-anh', {}),
    ).rejects.toBeInstanceOf(ForbiddenException);
    expect(tx.tripJoinRequest.upsert).not.toHaveBeenCalled();
  });

  it('auto-approves friends with JOIN_REQUEST timeline via', async () => {
    const { service, timeline } = setup({
      trip: {
        id: 'trip-public',
        name: 'Đà Nẵng',
        status: 'UPCOMING',
        maxMembers: 5,
        ownerId: 'owner-1',
        autoApproveFriends: true,
        visibility: 'PUBLIC',
      },
      friends: true,
    });

    await service.requestToJoinByTripId('trip-public', 'user-anh', {});

    expect(timeline.createEvent).toHaveBeenCalledWith(
      expect.anything(),
      'trip-public',
      'user-anh',
      expect.objectContaining({
        metadata: { via: 'JOIN_REQUEST' },
      }),
    );
  });

  it('still allows PRIVATE trips via invite code', async () => {
    const { service, tx } = setup({
      trip: {
        id: 'trip-private',
        name: 'Private',
        status: 'UPCOMING',
        maxMembers: 5,
        ownerId: 'owner-1',
        autoApproveFriends: false,
        visibility: 'PRIVATE',
      },
    });

    await service.requestToJoin('SECRET12', 'user-anh', {});
    expect(tx.tripJoinRequest.upsert).toHaveBeenCalled();
  });
});

describe('TripJoinRequestsService.previewByTripId', () => {
  it('rejects preview of a PRIVATE trip by id', async () => {
    const { service, prisma } = setup();
    prisma.trip.findUnique.mockResolvedValue({
      id: 'trip-private',
      name: 'Private',
      inviteCode: 'SECRET12',
      visibility: 'PRIVATE',
      startDate: NOW,
      endDate: NOW,
      maxMembers: 5,
      tripType: 'FRIENDS',
      coverMedia: null,
      owner: { displayname: 'Owner' },
      members: [],
      itineraryItems: [],
    });

    await expect(
      service.previewByTripId('trip-private', 'user-anh'),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });

  it('does not return the invite code when previewing a public trip by id', async () => {
    const { service, prisma } = setup();
    prisma.trip.findUnique.mockResolvedValue({
      id: 'trip-public',
      name: 'Public',
      inviteCode: 'SECRET12',
      visibility: 'PUBLIC',
      status: 'UPCOMING',
      startDate: NOW,
      endDate: NOW,
      maxMembers: 5,
      tripType: 'FRIENDS',
      coverMedia: null,
      owner: { displayname: 'Owner' },
      members: [],
      itineraryItems: [],
    });

    const preview = await service.previewByTripId('trip-public', 'user-anh');
    expect(preview.inviteCode).toBeNull();
    expect(prisma.trip.findUnique).toHaveBeenCalledWith(
      expect.objectContaining({
        select: expect.not.objectContaining({ inviteCode: true }),
      }),
    );
  });
});

describe('TripJoinRequestsService.getJoinRequests', () => {
  it('maps the requester, persona, match score and tab counts', async () => {
    const { service } = setup();

    const page = await service.getJoinRequests('trip-1', 'owner-1', {
      status: 'PENDING',
      limit: 20,
    });

    expect(page.data).toEqual([
      {
        id: 'request-1',
        tripId: 'trip-1',
        status: 'PENDING',
        requester: {
          id: 'user-anh',
          displayName: 'Minh Anh',
          username: 'minhanh',
          avatarUrl: 'https://cdn.test/avatars/anh.jpg',
          isVerified: true,
          isOnline: true,
        },
        message: 'Cho mình đi với',
        travelPersona: 'Foodie Traveler',
        personaType: 'FOODIE_TRAVELER',
        matchScore: 71,
        matchNote: null,
        createdAt: NOW,
        decidedAt: null,
      },
    ]);
    expect(page.meta).toEqual({
      nextCursor: null,
      hasMore: false,
      counts: { pending: 3, approved: 0, rejected: 1 },
    });
  });

  it('pages newest first from the cursor', async () => {
    const { service, prisma } = setup();
    prisma.tripJoinRequest.findMany.mockResolvedValueOnce([
      requestRecord({ id: 'request-2' }),
      requestRecord({ id: 'request-3' }),
    ]);

    const page = await service.getJoinRequests('trip-1', 'owner-1', {
      status: 'APPROVED',
      limit: 1,
      cursor: 'cursor-1',
    });

    expect(prisma.tripJoinRequest.findMany).toHaveBeenCalledWith(
      expect.objectContaining({
        where: { tripId: 'trip-1', status: 'APPROVED' },
        take: 2,
        cursor: { id: 'cursor-1' },
        skip: 1,
        orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
      }),
    );
    expect(page.data.map((request) => request.id)).toEqual(['request-2']);
    expect(page.meta.nextCursor).toBe('request-2');
    expect(page.meta.hasMore).toBe(true);
  });

  it('rejects a cursor of another tab', async () => {
    const { service, prisma } = setup();
    prisma.tripJoinRequest.findFirst.mockResolvedValueOnce(null);

    await expect(
      service.getJoinRequests('trip-1', 'owner-1', {
        status: 'PENDING',
        limit: 20,
        cursor: 'elsewhere',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('is only for the owner and admins', async () => {
    const { service } = setup({
      members: [{ userId: 'user-bao', role: 'MEMBER', status: 'ACTIVE' }],
    });

    await expect(
      service.getJoinRequests('trip-1', 'user-bao', {
        status: 'PENDING',
        limit: 20,
      }),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });

  it('still loads when presence is unavailable', async () => {
    const { service, gateway } = setup();
    gateway.getConnectedUserIds.mockRejectedValueOnce(new Error('down'));

    const page = await service.getJoinRequests('trip-1', 'owner-1', {
      status: 'PENDING',
      limit: 20,
    });

    expect(page.data[0].requester.isOnline).toBe(false);
  });
});

describe('TripJoinRequestsService.approve', () => {
  it('adds the requester as a member and tells them', async () => {
    const { service, tx, notifications, timeline, gateway, push } = setup();

    await service.approve('trip-1', 'request-1', 'admin-1');

    expect(tx.tripJoinRequest.updateMany).toHaveBeenCalledWith({
      where: { id: 'request-1', status: 'PENDING' },
      data: {
        status: 'APPROVED',
        decidedById: 'admin-1',
        decidedAt: expect.any(Date),
      },
    });
    expect(timeline.createEvent).toHaveBeenCalledWith(
      tx,
      'trip-1',
      'user-anh',
      {
        type: 'MEMBER_JOINED',
        content: 'Đã tham gia chuyến đi',
        metadata: { via: 'JOIN_REQUEST' },
        target: { type: 'MEMBER', id: 'member-new' },
      },
    );
    expect(notifications.create).toHaveBeenCalledWith(
      tx,
      expect.objectContaining({
        userId: 'user-anh',
        actorId: 'admin-1',
        type: 'TRIP_JOIN_REQUEST_APPROVED',
      }),
    );
    expect(gateway.emitTimelineEvent).toHaveBeenCalledWith('trip-1', {
      id: 'event-1',
    });
    expect(push.sendToUser).toHaveBeenCalledWith(
      'user-anh',
      expect.objectContaining({
        data: {
          type: 'TRIP_JOIN_REQUEST_APPROVED',
          tripId: 'trip-1',
          requestId: 'request-1',
        },
      }),
    );
  });

  it('forbids a regular member', async () => {
    const { service, tx } = setup({
      members: [{ userId: 'user-bao', role: 'MEMBER', status: 'ACTIVE' }],
    });

    await expect(
      service.approve('trip-1', 'request-1', 'user-bao'),
    ).rejects.toBeInstanceOf(ForbiddenException);
    expect(tx.tripJoinRequest.updateMany).not.toHaveBeenCalled();
  });

  it('reports a request of another trip as missing', async () => {
    const { service } = setup({ request: null });

    await expect(
      service.approve('trip-1', 'request-1', 'owner-1'),
    ).rejects.toBeInstanceOf(NotFoundException);
  });

  it('refuses a request that was already decided', async () => {
    const { service, tx } = setup({
      request: {
        requesterId: 'user-anh',
        status: 'REJECTED',
        trip: { name: 'Hội An', status: 'UPCOMING', maxMembers: 5 },
      },
    });

    await expect(
      service.approve('trip-1', 'request-1', 'owner-1'),
    ).rejects.toBeInstanceOf(ConflictException);
    expect(tx.tripMember.upsert).not.toHaveBeenCalled();
  });

  it('refuses when the trip is full', async () => {
    const { service, tx } = setup({ activeMemberCount: 5 });

    await expect(
      service.approve('trip-1', 'request-1', 'owner-1'),
    ).rejects.toThrow('Trip is full');
    expect(tx.tripJoinRequest.updateMany).not.toHaveBeenCalled();
  });

  it('loses cleanly to another reviewer deciding first', async () => {
    const { service, tx } = setup({ decidedCount: 0 });

    await expect(
      service.approve('trip-1', 'request-1', 'owner-1'),
    ).rejects.toBeInstanceOf(ConflictException);
    expect(tx.tripMember.upsert).not.toHaveBeenCalled();
  });
});

describe('TripJoinRequestsService.reject', () => {
  it('declines without adding a member and tells the requester', async () => {
    const { service, tx, notifications } = setup();

    await service.reject('trip-1', 'request-1', 'owner-1');

    expect(tx.tripJoinRequest.updateMany).toHaveBeenCalledWith({
      where: { id: 'request-1', status: 'PENDING' },
      data: {
        status: 'REJECTED',
        decidedById: 'owner-1',
        decidedAt: expect.any(Date),
      },
    });
    expect(tx.tripMember.upsert).not.toHaveBeenCalled();
    expect(notifications.create).toHaveBeenCalledWith(
      tx,
      expect.objectContaining({
        userId: 'user-anh',
        type: 'TRIP_JOIN_REQUEST_REJECTED',
      }),
    );
  });
});

describe('TripJoinRequestsService settings', () => {
  it('lets an admin change auto-approval of friends', async () => {
    const { service, tx } = setup();

    await expect(
      service.updateSettings('trip-1', 'admin-1', { autoApproveFriends: true }),
    ).resolves.toEqual({ autoApproveFriends: true });
    expect(tx.trip.update).toHaveBeenCalledWith({
      where: { id: 'trip-1' },
      data: { autoApproveFriends: true },
      select: { autoApproveFriends: true },
    });
  });

  it('hides the settings from regular members', async () => {
    const { service } = setup({
      members: [{ userId: 'user-bao', role: 'MEMBER', status: 'ACTIVE' }],
    });

    await expect(
      service.getSettings('trip-1', 'user-bao'),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });
});

describe('TripJoinRequestsService.previewByInviteCode', () => {
  const previewTrip = {
    id: 'trip-demo-summer-2025',
    name: 'Mùa Hè Rực Rỡ: Bán Đảo Sơn Trà & Phố Cổ Hội An',
    inviteCode: 'HE2025VN',
    startDate: new Date('2025-07-19T00:00:00.000Z'),
    endDate: new Date('2025-07-22T00:00:00.000Z'),
    maxMembers: 5,
    tripType: 'FRIENDS',
    coverMedia: {
      objectKey: 'trips/cover-summer.jpg',
      deletedAt: null,
    },
    owner: { displayname: 'Alex Nguyễn' },
    members: [{ id: 'm1' }, { id: 'm2' }, { id: 'm3' }, { id: 'm4' }],
    itineraryItems: [
      { place: { category: 'BEACH' } },
      { place: { category: 'FOOD' } },
    ],
  };

  it('rejects an empty or invalid invite code', async () => {
    const { service, prisma } = setup({ trip: null });

    await expect(
      service.previewByInviteCode('---', 'user-anh'),
    ).rejects.toBeInstanceOf(NotFoundException);
    expect(prisma.trip.findUnique).not.toHaveBeenCalled();
  });

  it('rejects an unknown invite code', async () => {
    const { service } = setup({ trip: null });

    await expect(
      service.previewByInviteCode('UNKNOWN1', 'user-anh'),
    ).rejects.toBeInstanceOf(NotFoundException);
  });

  it('returns the trip preview matching the join-by-code screen contract', async () => {
    const { service, prisma, s3 } = setup();
    prisma.trip.findUnique.mockResolvedValue(previewTrip);

    await expect(
      service.previewByInviteCode('he2025-vn', 'user-anh'),
    ).resolves.toEqual({
      inviteCode: 'HE2025VN',
      tripId: 'trip-demo-summer-2025',
      name: 'Mùa Hè Rực Rỡ: Bán Đảo Sơn Trà & Phố Cổ Hội An',
      coverImageUrl: 'https://cdn.test/trips/cover-summer.jpg',
      startDate: previewTrip.startDate,
      endDate: previewTrip.endDate,
      ownerDisplayName: 'Alex Nguyễn',
      memberCount: 4,
      maxMembers: 5,
      matchScore: expect.any(Number),
    });
    expect(prisma.trip.findUnique).toHaveBeenCalledWith({
      where: { inviteCode: 'HE2025VN' },
      select: expect.objectContaining({
        inviteCode: true,
        owner: { select: { displayname: true } },
      }),
    });
    expect(s3.getPublicUrl).toHaveBeenCalledWith('trips/cover-summer.jpg');
  });
});

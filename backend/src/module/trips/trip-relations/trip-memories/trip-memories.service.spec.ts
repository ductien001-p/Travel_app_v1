import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import { MEMBER_STATUS, TRIP_STATUS } from '../../../../generated/prisma/enums';
import { Prisma } from '../../../../generated/prisma/client';
import { TripMemoriesService } from './trip-memories.service';

const createdAt = new Date('2026-09-14T00:00:00Z');
const media = {
  id: 'media-1',
  userId: 'user-1',
  objectKey: 'trips/user-1/0123456789abcdef.jpg',
  mimeType: 'image/jpeg',
  width: 800,
  height: 600,
  deletedAt: null,
};
const memory = {
  id: 'memory-1',
  tripId: 'trip-1',
  caption: 'Sunset',
  createdAt,
  badge: null,
  likeCount: 0,
  likes: [] as { id: string }[],
  media: {
    ...media,
    user: { id: 'user-1', username: 'traveler', avatarId: null },
  },
};

function setup(
  options: {
    role?: string;
    tripStatus?: TRIP_STATUS;
    images?: Array<Record<string, unknown>>;
    storedMemory?: Record<string, unknown> | null;
    existingMemory?: Record<string, unknown> | null;
    listed?: Array<Record<string, unknown>>;
  } = {},
) {
  const tx = {
    tripMedia: {
      create: jest.fn(({ data }: { data: { mediaId: string } }) =>
        Promise.resolve(
          data.mediaId === media.id
            ? memory
            : {
                ...memory,
                id: `memory-${data.mediaId}`,
                media: { ...memory.media, id: data.mediaId },
              },
        ),
      ),
      delete: jest.fn().mockResolvedValue({}),
    },
  };
  const prisma = {
    trip: {
      findUnique: jest.fn().mockResolvedValue({ id: 'trip-1' }),
      findUniqueOrThrow: jest.fn().mockResolvedValue({
        status: options.tripStatus ?? TRIP_STATUS.ONGOING,
        startDate: new Date('2026-09-14T00:00:00Z'),
        endDate: new Date('2026-09-17T00:00:00Z'),
      }),
    },
    tripMember: {
      findUnique: jest.fn().mockResolvedValue({
        id: 'member-1',
        role: options.role ?? 'MEMBER',
        status: MEMBER_STATUS.ACTIVE,
      }),
    },
    uploadedMedia: {
      findMany: jest.fn().mockResolvedValue(options.images ?? [media]),
    },
    tripMedia: {
      findUnique: jest
        .fn()
        .mockResolvedValue(
          options.storedMemory === undefined ? null : options.storedMemory,
        ),
      findFirst: jest.fn().mockResolvedValue(options.existingMemory ?? null),
      findMany: jest.fn().mockResolvedValue(options.listed ?? []),
      count: jest.fn().mockResolvedValue(options.listed?.length ?? 0),
    },
    $queryRaw: jest.fn().mockResolvedValue([]),
    $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
      Promise.resolve(callback(tx)),
    ),
  };
  const s3 = {
    getPublicUrl: jest.fn((key: string) => `https://cdn.test/${key}`),
  };
  const mediaService = { validateMediaExists: jest.fn() };
  const timeline = {
    createEvent: jest.fn().mockResolvedValue({ id: 'event-1' }),
  };
  const gateway = { emitTimelineEvent: jest.fn() };
  const eventEmitter = { emit: jest.fn() };
  const service = new TripMemoriesService(
    prisma as never,
    s3 as never,
    mediaService as never,
    timeline as never,
    gateway as never,
    eventEmitter as never,
  );
  return { service, prisma, tx, timeline, gateway, mediaService, eventEmitter };
}

describe('TripMemoriesService response contract', () => {
  it('returns the same Flutter-ready shape after create as list items', async () => {
    const { service } = setup();

    await expect(
      service.createMemory('trip-1', 'user-1', {
        mediaId: 'media-1',
        caption: 'Sunset',
      }),
    ).resolves.toEqual({
      id: 'memory-1',
      tripId: 'trip-1',
      caption: 'Sunset',
      createdAt,
      imageUrl: 'https://cdn.test/trips/user-1/0123456789abcdef.jpg',
      user: { id: 'user-1', username: 'traveler', avatarId: null },
      media: { id: 'media-1', mimeType: 'image/jpeg', width: 800, height: 600 },
      badge: null,
      likeCount: 0,
      liked: false,
    });
  });

  it('uses the canonical cursor pagination shape', async () => {
    const { service } = setup();

    await expect(
      service.getMemories('trip-1', 'user-1', { limit: 20 }),
    ).resolves.toEqual({
      data: [],
      meta: { nextCursor: null, hasMore: false, totalCount: 0, dayCounts: [] },
    });
  });

  it('sends the badge as its Vietnamese label', async () => {
    const { service } = setup({
      listed: [
        { ...memory, badge: 'NIGHT' },
        { ...memory, id: 'memory-2', badge: 'SCENERY' },
        { ...memory, id: 'memory-3', badge: 'PEOPLE' },
        { ...memory, id: 'memory-4', badge: 'FOOD' },
        { ...memory, id: 'memory-5', badge: null },
      ],
    });

    const result = await service.getMemories('trip-1', 'user-1', {
      limit: 20,
    });

    expect(result.data.map((item) => item.badge)).toEqual([
      'Khoảnh khắc đêm',
      'Khoảnh khắc nổi bật',
      'Khoảnh khắc đáng nhớ',
      'Khoảnh khắc ẩm thực',
      null,
    ]);
  });
});

describe('TripMemoriesService.getMemories filters', () => {
  it('limits the list and the total to one UTC trip day and uploader', async () => {
    const { service, prisma } = setup();

    await service.getMemories('trip-1', 'user-1', {
      limit: 20,
      day: 2,
      userId: 'user-bao',
    });

    const where = {
      tripId: 'trip-1',
      media: { deletedAt: null, userId: 'user-bao' },
      createdAt: {
        gte: new Date('2026-09-15T00:00:00.000Z'),
        lt: new Date('2026-09-16T00:00:00.000Z'),
      },
    };
    expect(prisma.tripMedia.findMany).toHaveBeenCalledWith(
      expect.objectContaining({ where }),
    );
    expect(prisma.tripMedia.count).toHaveBeenCalledWith({ where });
  });

  it('counts per day for the uploader, ignoring the day filter', async () => {
    const { service, prisma } = setup();
    prisma.$queryRaw.mockResolvedValue([
      { day: 1, count: 3 },
      { day: 4, count: 2 },
    ]);

    const result = await service.getMemories('trip-1', 'user-1', {
      limit: 20,
      day: 2,
      userId: 'user-bao',
    });

    expect(result.meta.dayCounts).toEqual([
      { day: 1, count: 3 },
      { day: 4, count: 2 },
    ]);
    const [, ...params] = prisma.$queryRaw.mock.calls[0] as unknown[];
    expect(params).toEqual(
      expect.arrayContaining(['2026-09-14', 'trip-1', '2026-09-17']),
    );
    const uploader = params.find((param) => param instanceof Prisma.Sql);
    expect((uploader as Prisma.Sql).values).toEqual(['user-bao']);
  });

  it('rejects a day after the end of the trip', async () => {
    const { service, prisma } = setup();

    await expect(
      service.getMemories('trip-1', 'user-1', { limit: 20, day: 5 }),
    ).rejects.toThrow('Day is outside the trip dates');
    expect(prisma.tripMedia.findMany).not.toHaveBeenCalled();
  });

  it('only accepts a cursor issued for the same filters', async () => {
    const { service, prisma } = setup({ existingMemory: null });

    await expect(
      service.getMemories('trip-1', 'user-1', {
        limit: 20,
        cursor: 'memory-9',
        userId: 'user-bao',
      }),
    ).rejects.toThrow('Invalid cursor for this trip');
    expect(prisma.tripMedia.findFirst).toHaveBeenCalledWith({
      where: {
        tripId: 'trip-1',
        media: { deletedAt: null, userId: 'user-bao' },
        id: 'memory-9',
      },
      select: { id: true },
    });
  });

  it('skips the totals on later pages', async () => {
    const { service, prisma } = setup({ existingMemory: { id: 'memory-9' } });

    const result = await service.getMemories('trip-1', 'user-1', {
      limit: 20,
      cursor: 'memory-9',
    });

    expect(result.meta).toEqual({
      nextCursor: null,
      hasMore: false,
      totalCount: null,
      dayCounts: null,
    });
    expect(prisma.tripMedia.count).not.toHaveBeenCalled();
    expect(prisma.$queryRaw).not.toHaveBeenCalled();
  });
});

describe('TripMemoriesService.createMemory rules', () => {
  it.each([TRIP_STATUS.DRAFT, TRIP_STATUS.CANCELLED])(
    'rejects memories on a %s trip',
    async (tripStatus) => {
      const { service, tx } = setup({ tripStatus });

      await expect(
        service.createMemory('trip-1', 'user-1', { mediaId: 'media-1' }),
      ).rejects.toBeInstanceOf(ConflictException);
      expect(tx.tripMedia.create).not.toHaveBeenCalled();
    },
  );

  it('only accepts images uploaded by the member', async () => {
    const { service, prisma, tx } = setup({ images: [] });

    await expect(
      service.createMemory('trip-1', 'user-1', { mediaId: 'video-1' }),
    ).rejects.toBeInstanceOf(BadRequestException);
    expect(prisma.uploadedMedia.findMany).toHaveBeenCalledWith(
      expect.objectContaining({
        where: expect.objectContaining({
          userId: 'user-1',
          mimeType: { startsWith: 'image/' },
        }),
      }),
    );
    expect(tx.tripMedia.create).not.toHaveBeenCalled();
  });

  it('records one MEMORY_ADDED event for a single photo', async () => {
    const { service, tx, timeline } = setup();

    await service.createMemory('trip-1', 'user-1', {
      mediaId: 'media-1',
      caption: 'Sunset',
    });

    expect(timeline.createEvent).toHaveBeenCalledWith(tx, 'trip-1', 'user-1', {
      type: 'MEMORY_ADDED',
      content: 'Đã thêm một kỷ niệm mới',
      metadata: { memoryIds: ['memory-1'], caption: 'Sunset' },
      target: { type: 'MEMORY', id: 'memory-1' },
    });
  });
});

describe('TripMemoriesService.createMemories (batch)', () => {
  const second = { ...media, id: 'media-2', objectKey: 'trips/user-1/2.jpg' };

  it('creates every memory in one transaction with a single timeline event', async () => {
    const { service, prisma, tx, timeline, gateway } = setup({
      images: [media, second],
    });

    const created = await service.createMemories('trip-1', 'user-1', [
      { mediaId: 'media-1' },
      { mediaId: 'media-2', caption: '  Đèo Hải Vân ' },
    ]);

    expect(created.map((item) => item.id)).toEqual([
      'memory-1',
      'memory-media-2',
    ]);
    expect(prisma.$transaction).toHaveBeenCalledTimes(1);
    expect(tx.tripMedia.create).toHaveBeenCalledTimes(2);
    expect(timeline.createEvent).toHaveBeenCalledTimes(1);
    expect(timeline.createEvent).toHaveBeenCalledWith(tx, 'trip-1', 'user-1', {
      type: 'MEMORY_ADDED',
      content: 'Đã thêm 2 kỷ niệm mới',
      metadata: {
        memoryIds: ['memory-1', 'memory-media-2'],
        caption: 'Đèo Hải Vân',
      },
      target: { type: 'MEMORY', id: 'memory-1' },
    });
    expect(gateway.emitTimelineEvent).toHaveBeenCalledTimes(1);
  });

  it('queues the new photos for a badge once committed', async () => {
    const { service, eventEmitter } = setup({ images: [media, second] });

    await service.createMemories('trip-1', 'user-1', [
      { mediaId: 'media-1' },
      { mediaId: 'media-2' },
    ]);

    expect(eventEmitter.emit).toHaveBeenCalledWith('trip.memories.created', {
      tripId: 'trip-1',
      memoryIds: ['memory-1', 'memory-media-2'],
    });
  });

  it('rejects the whole batch when one photo is not the member image', async () => {
    const { service, tx } = setup({ images: [media] });

    await expect(
      service.createMemories('trip-1', 'user-1', [
        { mediaId: 'media-1' },
        { mediaId: 'someone-elses' },
      ]),
    ).rejects.toBeInstanceOf(BadRequestException);
    expect(tx.tripMedia.create).not.toHaveBeenCalled();
  });

  it('rejects duplicated photos in the same request', async () => {
    const { service, prisma } = setup();

    await expect(
      service.createMemories('trip-1', 'user-1', [
        { mediaId: 'media-1' },
        { mediaId: 'media-1' },
      ]),
    ).rejects.toThrow('Each photo can only be added once');
    expect(prisma.tripMember.findUnique).not.toHaveBeenCalled();
  });

  it('rejects photos that are already a memory', async () => {
    const { service, tx } = setup({
      images: [media, second],
      existingMemory: { id: 'memory-old' },
    });

    await expect(
      service.createMemories('trip-1', 'user-1', [
        { mediaId: 'media-1' },
        { mediaId: 'media-2' },
      ]),
    ).rejects.toThrow('Memory already exists for this media');
    expect(tx.tripMedia.create).not.toHaveBeenCalled();
  });

  it('does not broadcast when the transaction fails', async () => {
    const { service, tx, gateway, eventEmitter } = setup({
      images: [media, second],
    });
    tx.tripMedia.create.mockRejectedValueOnce(new Error('write failed'));

    await expect(
      service.createMemories('trip-1', 'user-1', [
        { mediaId: 'media-1' },
        { mediaId: 'media-2' },
      ]),
    ).rejects.toThrow('write failed');
    expect(gateway.emitTimelineEvent).not.toHaveBeenCalled();
    expect(eventEmitter.emit).not.toHaveBeenCalled();
  });
});

describe('TripMemoriesService.deleteMemory moderation', () => {
  const othersMemory = {
    id: 'memory-2',
    tripId: 'trip-1',
    media: { id: 'media-2', user: { id: 'someone-else' } },
  };
  const orphanMemory = {
    id: 'memory-3',
    tripId: 'trip-1',
    media: { id: 'media-3', user: null },
  };

  it('forbids a regular member from deleting another member memory', async () => {
    const { service, tx } = setup({ storedMemory: othersMemory });

    await expect(
      service.deleteMemory('memory-2', 'user-1'),
    ).rejects.toBeInstanceOf(ForbiddenException);
    expect(tx.tripMedia.delete).not.toHaveBeenCalled();
  });

  it.each(['OWNER', 'ADMIN'])(
    'lets an %s delete another member memory',
    async (role) => {
      const { service, tx } = setup({ role, storedMemory: othersMemory });

      await service.deleteMemory('memory-2', 'user-1');

      expect(tx.tripMedia.delete).toHaveBeenCalledWith({
        where: { id: 'memory-2' },
      });
    },
  );

  it('lets a moderator delete a memory whose uploader deleted their account', async () => {
    const { service, tx } = setup({
      role: 'ADMIN',
      storedMemory: orphanMemory,
    });

    await service.deleteMemory('memory-3', 'user-1');

    expect(tx.tripMedia.delete).toHaveBeenCalledWith({
      where: { id: 'memory-3' },
    });
  });
});

const viewerPhoto = {
  ...memory,
  trip: { name: 'Hội An' },
};

function viewerSetup(
  options: {
    member?: { role: string; status: string } | null;
    trip?: { id: string } | null;
    listed?: unknown[];
    total?: number;
    collections?: unknown[];
    highlight?: unknown;
    cursor?: { id: string } | null;
    createdCount?: number;
    deletedCount?: number;
    likeCount?: number;
    likes?: { id: string }[];
    stored?: unknown;
  } = {},
) {
  const tx = {
    tripMediaLike: {
      createMany: jest
        .fn()
        .mockResolvedValue({ count: options.createdCount ?? 1 }),
      deleteMany: jest
        .fn()
        .mockResolvedValue({ count: options.deletedCount ?? 1 }),
    },
    tripMedia: {
      update: jest.fn().mockResolvedValue({}),
      updateMany: jest.fn().mockResolvedValue({ count: 1 }),
    },
  };
  const prisma = {
    trip: {
      findUnique: jest
        .fn()
        .mockResolvedValue(
          options.trip === undefined ? { id: 'trip-1' } : options.trip,
        ),
      findMany: jest.fn().mockResolvedValue(options.collections ?? []),
    },
    tripMember: {
      findUnique: jest
        .fn()
        .mockResolvedValue(
          options.member === undefined
            ? { id: 'member-1', role: 'MEMBER', status: MEMBER_STATUS.ACTIVE }
            : options.member,
        ),
    },
    tripMedia: {
      findFirst: jest.fn(({ select }: { select?: Record<string, unknown> }) => {
        const cursorCheck =
          select != null &&
          Object.keys(select).length === 1 &&
          select.id === true;
        if (cursorCheck) {
          return Promise.resolve(
            options.cursor === undefined ? { id: 'memory-9' } : options.cursor,
          );
        }
        return Promise.resolve(options.highlight ?? null);
      }),
      findMany: jest.fn().mockResolvedValue(options.listed ?? []),
      count: jest.fn().mockResolvedValue(options.total ?? 0),
      findUnique: jest.fn().mockResolvedValue(
        options.stored === undefined
          ? {
              id: 'memory-1',
              tripId: 'trip-1',
              media: { deletedAt: null },
            }
          : options.stored,
      ),
      findUniqueOrThrow: jest.fn().mockResolvedValue({
        likeCount: options.likeCount ?? 1,
        likes: options.likes ?? [{ id: 'like-1' }],
      }),
    },
    $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
      Promise.resolve(callback(tx)),
    ),
  };
  const s3 = {
    getPublicUrl: jest.fn((key: string) => `https://cdn.test/${key}`),
  };
  const service = new TripMemoriesService(
    prisma as never,
    s3 as never,
    {} as never,
    {} as never,
    {} as never,
    {} as never,
  );
  return { service, prisma, tx };
}

const ownedPhotoFilter = {
  media: { userId: 'user-1', deletedAt: null },
  trip: {
    members: { some: { userId: 'user-1', status: MEMBER_STATUS.ACTIVE } },
  },
};

describe('TripMemoriesService.getMyMemories', () => {
  it('keeps only the viewer photos inside active memberships, including unfinished trips', async () => {
    const { service, prisma } = viewerSetup({ total: 3 });

    await service.getMyMemories('user-1', { limit: 20, utcOffsetMinutes: 0 });

    expect(prisma.tripMedia.findMany).toHaveBeenCalledWith(
      expect.objectContaining({
        where: ownedPhotoFilter,
        orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
      }),
    );
    const calledWhere = prisma.tripMedia.findMany.mock.calls[0][0].where;
    expect(calledWhere.trip).not.toHaveProperty('status');
    expect(calledWhere).not.toHaveProperty('visibility');
    expect(prisma.tripMedia.count).toHaveBeenCalledWith({
      where: ownedPhotoFilter,
    });
    expect(prisma.trip.findMany).toHaveBeenCalledWith(
      expect.objectContaining({
        where: {
          members: {
            some: { userId: 'user-1', status: MEMBER_STATUS.ACTIVE },
          },
          tripMedias: {
            some: { media: { userId: 'user-1', deletedAt: null } },
          },
        },
      }),
    );
  });

  it('rejects a trip the viewer has not joined instead of returning it empty', async () => {
    const { service, prisma } = viewerSetup({ member: null });

    await expect(
      service.getMyMemories('user-1', {
        limit: 20,
        tripId: 'public-trip',
        utcOffsetMinutes: 0,
      }),
    ).rejects.toBeInstanceOf(NotFoundException);
    expect(prisma.tripMedia.findMany).not.toHaveBeenCalled();
  });

  it('sorts collections by newest photo, then name', async () => {
    const sameDay = new Date('2026-10-02T00:00:00Z');
    const { service } = viewerSetup({
      collections: [
        {
          id: 'older',
          name: 'Aaa',
          status: 'COMPLETED',
          tripMedias: [{ createdAt: new Date('2026-01-01T00:00:00Z') }],
          _count: { tripMedias: 2 },
        },
        {
          id: 'later-name',
          name: 'Zzz',
          status: 'NOTCOMPLETED',
          tripMedias: [{ createdAt: sameDay }],
          _count: { tripMedias: 4 },
        },
        {
          id: 'earlier-name',
          name: 'Mmm',
          status: 'ONGOING',
          tripMedias: [{ createdAt: sameDay }],
          _count: { tripMedias: 1 },
        },
      ],
    });

    const result = await service.getMyMemories('user-1', {
      limit: 20,
      utcOffsetMinutes: 0,
    });

    expect(result.collections).toEqual([
      {
        tripId: 'earlier-name',
        name: 'Mmm',
        status: 'ONGOING',
        memoryCount: 1,
      },
      {
        tripId: 'later-name',
        name: 'Zzz',
        status: 'NOTCOMPLETED',
        memoryCount: 4,
      },
      { tripId: 'older', name: 'Aaa', status: 'COMPLETED', memoryCount: 2 },
    ]);
  });

  it('counts and searches only the selected trip caption', async () => {
    const { service, prisma } = viewerSetup({ total: 1 });

    const result = await service.getMyMemories('user-1', {
      limit: 20,
      tripId: 'trip-1',
      q: '  sunset ',
      year: 2026,
      month: 10,
      utcOffsetMinutes: 0,
    });

    const where = {
      ...ownedPhotoFilter,
      tripId: 'trip-1',
      caption: { contains: 'sunset', mode: 'insensitive' },
    };
    expect(prisma.tripMedia.count).toHaveBeenCalledWith({ where });
    expect(result.meta.totalCount).toBe(1);
    const highlightWhere = prisma.tripMedia.findFirst.mock.calls[0][0].where;
    expect(highlightWhere).not.toHaveProperty('caption');
  });

  it('omits collections, highlight and total on a later page', async () => {
    const { service, prisma } = viewerSetup({
      cursor: { id: 'memory-9' },
      listed: [],
    });

    const result = await service.getMyMemories('user-1', {
      limit: 20,
      cursor: 'memory-9',
      year: 2026,
      month: 10,
      utcOffsetMinutes: 420,
    });

    expect(result.collections).toBeNull();
    expect(result.highlight).toBeNull();
    expect(result.meta.totalCount).toBeNull();
    expect(prisma.trip.findMany).not.toHaveBeenCalled();
    expect(prisma.tripMedia.count).not.toHaveBeenCalled();
    expect(prisma.tripMedia.findFirst).toHaveBeenCalledTimes(1);
  });
});

describe('TripMemoriesService highlight ties', () => {
  const october = {
    gte: new Date('2026-09-30T17:00:00.000Z'),
    lt: new Date('2026-10-31T17:00:00.000Z'),
  };

  it('breaks a like tie by newer photo, with like count first', async () => {
    const { service, prisma } = viewerSetup({ highlight: null });

    const result = await service.getMyMemories('user-1', {
      limit: 20,
      year: 2026,
      month: 10,
      utcOffsetMinutes: 420,
    });

    expect(result.highlight).toBeNull();
    expect(prisma.tripMedia.findFirst).toHaveBeenCalledWith(
      expect.objectContaining({
        where: { ...ownedPhotoFilter, createdAt: october },
        orderBy: [{ likeCount: 'desc' }, { createdAt: 'desc' }, { id: 'desc' }],
      }),
    );
  });

  it('limits the highlight to the selected trip', async () => {
    const { service, prisma } = viewerSetup({
      highlight: { ...viewerPhoto, likeCount: 4, likes: [{ id: 'like-1' }] },
    });

    const result = await service.getMyMemories('user-1', {
      limit: 20,
      tripId: 'trip-1',
      year: 2026,
      month: 10,
      utcOffsetMinutes: 0,
      q: 'sunset',
    });

    expect(result.highlight).toEqual(
      expect.objectContaining({
        id: 'memory-1',
        tripName: 'Hội An',
        likeCount: 4,
        liked: true,
      }),
    );
    const highlightWhere = prisma.tripMedia.findFirst.mock.calls[0][0].where;
    expect(highlightWhere.tripId).toBe('trip-1');
    expect(highlightWhere).not.toHaveProperty('caption');
    expect(highlightWhere.createdAt).toEqual({
      gte: new Date('2026-10-01T00:00:00.000Z'),
      lt: new Date('2026-11-01T00:00:00.000Z'),
    });
  });
});

describe('TripMemoriesService likes', () => {
  it('likes a photo for an active member and returns the new count', async () => {
    const { service, tx } = viewerSetup({
      likeCount: 1,
      likes: [{ id: 'like-1' }],
    });

    await expect(service.likeMemory('memory-1', 'user-1')).resolves.toEqual({
      likeCount: 1,
      liked: true,
    });
    expect(tx.tripMediaLike.createMany).toHaveBeenCalledWith({
      data: [{ tripMediaId: 'memory-1', userId: 'user-1' }],
      skipDuplicates: true,
    });
    expect(tx.tripMedia.update).toHaveBeenCalledWith({
      where: { id: 'memory-1' },
      data: { likeCount: { increment: 1 } },
    });
  });

  it('does not increment when the viewer already liked the photo', async () => {
    const { service, tx } = viewerSetup({
      createdCount: 0,
      likeCount: 3,
      likes: [{ id: 'like-1' }],
    });

    await expect(service.likeMemory('memory-1', 'user-1')).resolves.toEqual({
      likeCount: 3,
      liked: true,
    });
    expect(tx.tripMedia.update).not.toHaveBeenCalled();
  });

  it('unlikes and does not drop the count below zero', async () => {
    const { service, tx } = viewerSetup({
      deletedCount: 1,
      likeCount: 2,
      likes: [],
    });

    await expect(service.unlikeMemory('memory-1', 'user-1')).resolves.toEqual({
      likeCount: 2,
      liked: false,
    });
    expect(tx.tripMedia.updateMany).toHaveBeenCalledWith({
      where: { id: 'memory-1', likeCount: { gt: 0 } },
      data: { likeCount: { decrement: 1 } },
    });
  });

  it('does nothing when the photo was not liked', async () => {
    const { service, tx } = viewerSetup({
      deletedCount: 0,
      likeCount: 2,
      likes: [],
    });

    await service.unlikeMemory('memory-1', 'user-1');

    expect(tx.tripMedia.updateMany).not.toHaveBeenCalled();
  });

  it('rejects a viewer who is not an active member', async () => {
    const { service, tx } = viewerSetup({ member: null });

    await expect(
      service.likeMemory('memory-1', 'user-1'),
    ).rejects.toBeInstanceOf(NotFoundException);
    expect(tx.tripMediaLike.createMany).not.toHaveBeenCalled();
  });

  it('returns 404 when the photo is missing or its media was deleted', async () => {
    const missing = viewerSetup({ stored: null });
    await expect(
      missing.service.likeMemory('missing', 'user-1'),
    ).rejects.toBeInstanceOf(NotFoundException);

    const deleted = viewerSetup({
      stored: {
        id: 'memory-1',
        tripId: 'trip-1',
        media: { deletedAt: new Date('2026-10-01T00:00:00Z') },
      },
    });
    await expect(
      deleted.service.unlikeMemory('memory-1', 'user-1'),
    ).rejects.toBeInstanceOf(NotFoundException);
    expect(deleted.tx.tripMediaLike.deleteMany).not.toHaveBeenCalled();
  });
});

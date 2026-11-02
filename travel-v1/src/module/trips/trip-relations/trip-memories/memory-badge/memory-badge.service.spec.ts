import { MEMORY_BADGE } from '../../../../../generated/prisma/enums';
import { parseBadge } from './memory-badge.classifier';
import { MemoryBadgeService } from './memory-badge.service';

const image = new Uint8Array([1, 2, 3]);

function pendingMemory(mimeType: string | null = 'image/jpeg') {
  return { media: { objectKey: 'trips/user-1/a.jpg', mimeType } };
}

function setup(
  options: {
    enabled?: boolean;
    stored?: ReturnType<typeof pendingMemory> | null;
    pending?: string[];
  } = {},
) {
  const prisma = {
    tripMedia: {
      findFirst: jest
        .fn()
        .mockResolvedValue(
          options.stored === undefined ? pendingMemory() : options.stored,
        ),
      findMany: jest
        .fn()
        .mockResolvedValue((options.pending ?? []).map((id) => ({ id }))),
      updateMany: jest.fn().mockResolvedValue({ count: 1 }),
    },
  };
  const s3 = { getObjectBytes: jest.fn().mockResolvedValue(image) };
  const classifier = {
    enabled: options.enabled ?? true,
    classify: jest.fn().mockResolvedValue(MEMORY_BADGE.NIGHT),
  };
  const service = new MemoryBadgeService(
    prisma as never,
    s3 as never,
    classifier as never,
  );
  return { service, prisma, s3, classifier };
}

function savedBadge(prisma: ReturnType<typeof setup>['prisma'], call = 0) {
  const [args] = prisma.tripMedia.updateMany.mock.calls[call] as [
    { where: unknown; data: { badge: unknown; badgeCheckedAt: unknown } },
  ];
  return args;
}

describe('MemoryBadgeService.enqueue', () => {
  it('stores the badge suggested for the photo', async () => {
    const { service, prisma, s3, classifier } = setup();

    await service.enqueue(['memory-1']);

    expect(s3.getObjectBytes).toHaveBeenCalledWith(
      'trips/user-1/a.jpg',
      10 * 1024 * 1024,
    );
    expect(classifier.classify).toHaveBeenCalledWith(image);
    const saved = savedBadge(prisma);
    expect(saved.where).toEqual({ id: 'memory-1', badgeCheckedAt: null });
    expect(saved.data.badge).toBe(MEMORY_BADGE.NIGHT);
    expect(saved.data.badgeCheckedAt).toBeInstanceOf(Date);
  });

  it('marks photos without a fitting label as checked', async () => {
    const { service, prisma, classifier } = setup();
    classifier.classify.mockResolvedValue(null);

    await service.enqueue(['memory-1']);

    expect(savedBadge(prisma).data.badge).toBeNull();
  });

  it('does not call the model for a missing or oversized image', async () => {
    const { service, prisma, s3, classifier } = setup();
    s3.getObjectBytes.mockResolvedValue(null);

    await service.enqueue(['memory-1']);

    expect(classifier.classify).not.toHaveBeenCalled();
    expect(savedBadge(prisma).data.badge).toBeNull();
  });

  it('skips non-image media', async () => {
    const { service, prisma, s3 } = setup({
      stored: pendingMemory('video/mp4'),
    });

    await service.enqueue(['memory-1']);

    expect(s3.getObjectBytes).not.toHaveBeenCalled();
    expect(savedBadge(prisma).data.badge).toBeNull();
  });

  it('ignores memories already checked or deleted', async () => {
    const { service, prisma, s3 } = setup({ stored: null });

    await service.enqueue(['memory-1']);

    expect(prisma.tripMedia.findFirst).toHaveBeenCalledWith({
      where: {
        id: 'memory-1',
        badgeCheckedAt: null,
        media: { deletedAt: null },
      },
      select: { media: { select: { objectKey: true, mimeType: true } } },
    });
    expect(s3.getObjectBytes).not.toHaveBeenCalled();
    expect(prisma.tripMedia.updateMany).not.toHaveBeenCalled();
  });

  it('leaves the batch pending when the model is unreachable', async () => {
    const { service, prisma, classifier } = setup();
    classifier.classify.mockRejectedValue(new TypeError('fetch failed'));

    await service.enqueue(['memory-1', 'memory-2']);

    expect(classifier.classify).toHaveBeenCalledTimes(1);
    expect(prisma.tripMedia.updateMany).not.toHaveBeenCalled();
  });

  it('gives up on an image the model cannot read', async () => {
    const { service, prisma, classifier } = setup();
    classifier.classify
      .mockRejectedValueOnce(
        Object.assign(new Error('invalid image'), { status_code: 400 }),
      )
      .mockResolvedValueOnce(MEMORY_BADGE.FOOD);

    await service.enqueue(['memory-1', 'memory-2']);

    expect(savedBadge(prisma, 0).data.badge).toBeNull();
    expect(savedBadge(prisma, 1).data.badge).toBe(MEMORY_BADGE.FOOD);
  });

  it('runs batches one after another', async () => {
    const { service, classifier } = setup();
    const order: string[] = [];
    classifier.classify.mockImplementation(async () => {
      order.push('start');
      await new Promise((resolve) => setImmediate(resolve));
      order.push('end');
      return MEMORY_BADGE.PEOPLE;
    });

    await Promise.all([service.enqueue(['a']), service.enqueue(['b'])]);

    expect(order).toEqual(['start', 'end', 'start', 'end']);
  });

  it('does nothing when the classifier is disabled', async () => {
    const { service, prisma } = setup({ enabled: false });

    await service.enqueue(['memory-1']);

    expect(prisma.tripMedia.findFirst).not.toHaveBeenCalled();
  });
});

describe('MemoryBadgeService.classifyPending', () => {
  it('takes the oldest pending photos past the grace period', async () => {
    const { service, prisma } = setup({ pending: ['memory-1'] });
    const now = new Date('2026-10-13T10:00:00Z');

    await service.classifyPending(now);

    expect(prisma.tripMedia.findMany).toHaveBeenCalledWith({
      where: {
        badgeCheckedAt: null,
        createdAt: { lt: new Date('2026-10-13T09:55:00Z') },
        media: { deletedAt: null },
      },
      orderBy: { createdAt: 'asc' },
      take: 20,
      select: { id: true },
    });
    expect(prisma.tripMedia.updateMany).toHaveBeenCalledTimes(1);
  });

  it('waits while a batch is still running', async () => {
    const { service, prisma, classifier } = setup();
    let release!: () => void;
    classifier.classify.mockReturnValue(
      new Promise((resolve) => {
        release = () => resolve(MEMORY_BADGE.SCENERY);
      }),
    );

    const running = service.enqueue(['memory-1']);
    await service.classifyPending();
    await new Promise((resolve) => setImmediate(resolve));
    release();
    await running;

    expect(prisma.tripMedia.findMany).not.toHaveBeenCalled();
  });
});

describe('parseBadge', () => {
  it.each([
    ['{"category":"NIGHT"}', MEMORY_BADGE.NIGHT],
    ['{"category":"SCENERY"}', MEMORY_BADGE.SCENERY],
    ['{"category":"PEOPLE"}', MEMORY_BADGE.PEOPLE],
    ['{"category":"FOOD"}', MEMORY_BADGE.FOOD],
    ['{"category":"OTHER"}', null],
    ['{"category":"night"}', null],
    ['{}', null],
    ['null', null],
    ['not json', null],
  ])('maps %s', (content, expected) => {
    expect(parseBadge(content)).toBe(expected);
  });
});

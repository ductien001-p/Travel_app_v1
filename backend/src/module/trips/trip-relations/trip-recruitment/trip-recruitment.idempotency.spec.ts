import { UnprocessableEntityException } from '@nestjs/common';

jest.mock('nanoid', () => ({
  customAlphabet: () => () => 'TESTCODE',
}));

import { TripRecruitmentService } from './trip-recruitment.service';

const NOW = new Date();

function resultTrip(state: 'OPEN' | 'CLOSED') {
  return {
    id: 'trip-1',
    visibility: 'PRIVATE',
    recruitment: {
      state,
      publishedAt: NOW,
      expiresAt: new Date('2099-01-01T00:00:00.000Z'),
      previousVisibility: null,
    },
  };
}

describe('publish idempotency', () => {
  it('replays a stored key as the current CLOSED state', async () => {
    const prisma = {
      tripPublishIdempotency: {
        findUnique: jest.fn().mockResolvedValue({
          id: 'key-1',
          tripId: 'trip-1',
          createdAt: NOW,
        }),
      },
      trip: {
        findUniqueOrThrow: jest.fn().mockResolvedValue(resultTrip('CLOSED')),
      },
      $transaction: jest.fn(),
    };
    const service = new TripRecruitmentService(
      prisma as never,
      { getPublicUrl: jest.fn() } as never,
      {} as never,
      {} as never,
    );

    await expect(
      service.publish('owner-1', 'trip-1', 'same-key'),
    ).resolves.toMatchObject({
      tripId: 'trip-1',
      state: 'CLOSED',
      effectiveState: 'CLOSED',
    });
    expect(prisma.$transaction).not.toHaveBeenCalled();
  });

  it('rejects a key that already belongs to another trip', async () => {
    const prisma = {
      tripPublishIdempotency: {
        findUnique: jest.fn().mockResolvedValue({
          id: 'key-1',
          tripId: 'trip-2',
          createdAt: NOW,
        }),
      },
    };
    const service = new TripRecruitmentService(
      prisma as never,
      { getPublicUrl: jest.fn() } as never,
      {} as never,
      {} as never,
    );

    await expect(
      service.publish('owner-1', 'trip-1', 'same-key'),
    ).rejects.toBeInstanceOf(UnprocessableEntityException);
  });

  it('returns 200 when a parallel insert loses the unique key for the same trip', async () => {
    const tx = {
      $queryRaw: jest
        .fn()
        .mockResolvedValueOnce(undefined)
        .mockResolvedValueOnce([{ id: 'trip-1' }])
        .mockResolvedValueOnce([]),
      tripPublishIdempotency: {
        findUnique: jest.fn().mockResolvedValue(null),
        findUniqueOrThrow: jest.fn().mockResolvedValue({
          id: 'key-1',
          tripId: 'trip-1',
          createdAt: NOW,
        }),
      },
      trip: {
        findFirst: jest.fn().mockResolvedValue({
          id: 'trip-1',
          name: 'Da Nang',
          description: 'A long enough description',
          status: 'UPCOMING',
          visibility: 'PRIVATE',
          startDate: new Date('2099-01-01T00:00:00.000Z'),
          endDate: new Date('2099-01-03T00:00:00.000Z'),
          maxMembers: 4,
          ownerId: 'owner-1',
          budgetLevel: 'LOW',
          coverMedia: null,
          destinations: [],
          recruitment: null,
        }),
        findUniqueOrThrow: jest.fn().mockResolvedValue(resultTrip('OPEN')),
      },
    };
    const prisma = {
      tripPublishIdempotency: {
        findUnique: jest.fn().mockResolvedValue(null),
      },
      $transaction: jest.fn((callback: (client: typeof tx) => unknown) =>
        callback(tx),
      ),
    };
    const service = new TripRecruitmentService(
      prisma as never,
      { getPublicUrl: jest.fn() } as never,
      {} as never,
      {} as never,
    );

    await expect(
      service.publish('owner-1', 'trip-1', 'same-key'),
    ).resolves.toMatchObject({
      tripId: 'trip-1',
      effectiveState: 'OPEN',
    });
  });
});

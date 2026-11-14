jest.mock('nanoid', () => ({
  customAlphabet: () => () => 'TESTCODE',
}));

import { NotFoundException } from '@nestjs/common';
import { plainToInstance } from 'class-transformer';
import { validate } from 'class-validator';
import { PatchRecruitmentDto } from './dto/patch-recruitment.dto';
import { TripRecruitmentService } from './trip-recruitment.service';

function ownerMembership() {
  return {
    ownerId: 'owner-1',
    members: [
      {
        id: 'member-1',
        userId: 'owner-1',
        tripId: 'trip-1',
        role: 'OWNER',
        status: 'ACTIVE',
      },
    ],
  };
}

function publishResult() {
  return {
    id: 'trip-1',
    visibility: 'PRIVATE',
    recruitment: {
      state: 'NOT_PUBLISHED',
      publishedAt: null,
      expiresAt: null,
      previousVisibility: null,
    },
  };
}

function serviceWith(tx: {
  $queryRaw: jest.Mock;
  trip: { findUnique: jest.Mock; findUniqueOrThrow: jest.Mock };
  tripRecruitment: { findUnique: jest.Mock; upsert: jest.Mock };
}) {
  const prisma = {
    $transaction: jest.fn(async (run: (client: typeof tx) => unknown) =>
      run(tx),
    ),
  };
  const service = new TripRecruitmentService(
    prisma as never,
    { getPublicUrl: jest.fn() } as never,
    {} as never,
    {} as never,
  );
  return service;
}

describe('recruitment urgent flag', () => {
  it('rejects a non-boolean urgent value', async () => {
    const dto = plainToInstance(PatchRecruitmentDto, { urgent: 'yes' });
    const errors = await validate(dto);
    expect(errors.some((error) => error.property === 'urgent')).toBe(true);
  });

  it('accepts an omitted urgent flag', async () => {
    const dto = plainToInstance(PatchRecruitmentDto, {
      requirements: 'Bring a jacket',
    });
    const errors = await validate(dto);
    expect(errors.some((error) => error.property === 'urgent')).toBe(false);
  });

  it('stores urgent when the owner creates the recruitment row', async () => {
    const tx = {
      $queryRaw: jest.fn().mockResolvedValue([{ id: 'trip-1' }]),
      trip: {
        findUnique: jest.fn().mockResolvedValue(ownerMembership()),
        findUniqueOrThrow: jest
          .fn()
          .mockResolvedValueOnce({
            id: 'trip-1',
            status: 'DRAFT',
            visibility: 'PRIVATE',
          })
          .mockResolvedValueOnce(publishResult()),
      },
      tripRecruitment: {
        findUnique: jest.fn().mockResolvedValue(null),
        upsert: jest.fn().mockResolvedValue({}),
      },
    };
    const service = serviceWith(tx);

    await service.patch('trip-1', 'owner-1', { urgent: true });

    expect(tx.tripRecruitment.upsert).toHaveBeenCalledWith(
      expect.objectContaining({
        create: expect.objectContaining({ tripId: 'trip-1', urgent: true }),
      }),
    );
  });

  it('leaves urgent unchanged when the patch omits it', async () => {
    const tx = {
      $queryRaw: jest.fn().mockResolvedValue([{ id: 'trip-1' }]),
      trip: {
        findUnique: jest.fn().mockResolvedValue(ownerMembership()),
        findUniqueOrThrow: jest
          .fn()
          .mockResolvedValueOnce({
            id: 'trip-1',
            status: 'UPCOMING',
            visibility: 'PUBLIC',
          })
          .mockResolvedValueOnce(publishResult()),
      },
      tripRecruitment: {
        findUnique: jest
          .fn()
          .mockResolvedValueOnce({ origin: 'EXISTING_TRIP' })
          .mockResolvedValueOnce(null),
        upsert: jest.fn().mockResolvedValue({}),
      },
    };
    const service = serviceWith(tx);

    await service.patch('trip-1', 'owner-1', {
      requirements: 'Bring a jacket',
    });

    const update = tx.tripRecruitment.upsert.mock.calls[0][0].update;
    expect(update).toEqual({ requirements: 'Bring a jacket' });
  });

  it('hides the trip from a caller who is not an active member', async () => {
    const tx = {
      $queryRaw: jest.fn().mockResolvedValue([{ id: 'trip-1' }]),
      trip: {
        findUnique: jest.fn().mockResolvedValue({
          ownerId: 'owner-1',
          members: [],
        }),
        findUniqueOrThrow: jest.fn(),
      },
      tripRecruitment: {
        findUnique: jest.fn(),
        upsert: jest.fn(),
      },
    };
    const service = serviceWith(tx);

    await expect(
      service.patch('trip-1', 'stranger', { urgent: true }),
    ).rejects.toBeInstanceOf(NotFoundException);
    expect(tx.tripRecruitment.upsert).not.toHaveBeenCalled();
  });
});

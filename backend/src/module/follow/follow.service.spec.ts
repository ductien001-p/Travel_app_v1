import { NotFoundException } from '@nestjs/common';
import { USER_STATUS } from '../../generated/prisma/enums';
import { FollowService } from './follow.service';

describe('FollowService deleted accounts', () => {
  function setup(user: unknown) {
    const prisma = {
      user: { findUnique: jest.fn().mockResolvedValue(user) },
      userFollow: {
        findFirst: jest.fn().mockResolvedValue(null),
        findMany: jest.fn().mockResolvedValue([]),
        count: jest.fn().mockResolvedValue(0),
        create: jest.fn(),
      },
      $transaction: jest.fn(async (ops: Promise<unknown>[]) =>
        Promise.all(ops),
      ),
    };
    return { service: new FollowService(prisma as never), prisma };
  }

  it('rejects a follow when the target is missing or soft-deleted', async () => {
    const { service } = setup(null);
    await expect(service.createFollow('a', 'b')).rejects.toBeInstanceOf(
      NotFoundException,
    );
  });

  it('looks up the follow target as active and not deleted', async () => {
    const { service, prisma } = setup({ id: 'b' });
    await service.createFollow('a', 'b');
    expect(prisma.user.findUnique).toHaveBeenCalledWith({
      where: {
        id: 'b',
        status: USER_STATUS.ACTIVE,
        deletedAt: null,
      },
    });
  });

  it('lists only followers that are active and not deleted', async () => {
    const { service, prisma } = setup(null);
    await service.getFollowers('user-1', { page: 1, limit: 20 });
    const where = {
      followingId: 'user-1',
      follower: { deletedAt: null, status: USER_STATUS.ACTIVE },
    };
    expect(prisma.userFollow.findMany).toHaveBeenCalledWith(
      expect.objectContaining({ where }),
    );
    expect(prisma.userFollow.count).toHaveBeenCalledWith({ where });
  });
});

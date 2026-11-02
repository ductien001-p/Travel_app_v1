import { ForbiddenException, NotFoundException } from '@nestjs/common';
import { USER_STATUS } from '../../generated/prisma/enums';
import { UsersService } from './users.service';

describe('UsersService public response and avatar ownership', () => {
  const publicUser = {
    id: 'user-1',
    username: 'traveler',
    avatarId: null,
    status: USER_STATUS.ACTIVE,
    _count: { placeVisits: 0 },
  };

  function setup(media: unknown) {
    const prisma = {
      user: {
        findUnique: jest.fn().mockResolvedValue(publicUser),
        findFirst: jest.fn().mockResolvedValue(publicUser),
        update: jest.fn().mockResolvedValue(publicUser),
      },
      uploadedMedia: { findUnique: jest.fn().mockResolvedValue(media) },
    };
    return { service: new UsersService(prisma as never), prisma };
  }

  it('includes a stable id without private contact fields', async () => {
    const user = await setup(null).service.findOneById('user-1');
    expect(user).toEqual(expect.objectContaining({ id: 'user-1' }));
    expect(user).not.toHaveProperty('email');
    expect(user).not.toHaveProperty('phone');
  });

  it('accepts an owned active image in PATCH update', async () => {
    const { service, prisma } = setup({
      userId: 'user-1',
      deletedAt: null,
      mimeType: 'image/jpeg',
    });
    await service.update('user-1', { avatarId: 'media-1' });
    expect(prisma.user.update).toHaveBeenCalled();
  });

  it('rejects another users media', async () => {
    const { service } = setup({
      userId: 'user-2',
      deletedAt: null,
      mimeType: 'image/png',
    });
    await expect(
      service.update('user-1', { avatarId: 'media-1' }),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });

  it.each([
    null,
    { userId: 'user-1', deletedAt: new Date(), mimeType: 'image/png' },
  ])('rejects missing or deleted media', async (media) => {
    await expect(
      setup(media).service.update('user-1', { avatarId: 'media-1' }),
    ).rejects.toBeInstanceOf(NotFoundException);
  });

  it('rejects non-image media', async () => {
    const { service } = setup({
      userId: 'user-1',
      deletedAt: null,
      mimeType: 'application/pdf',
    });
    await expect(
      service.update('user-1', { avatarId: 'media-1' }),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });
});

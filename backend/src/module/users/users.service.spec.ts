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
        findMany: jest.fn().mockResolvedValue([publicUser]),
        count: jest.fn().mockResolvedValue(1),
        update: jest.fn().mockResolvedValue(publicUser),
        create: jest.fn().mockResolvedValue({ id: 'user-2' }),
      },
      uploadedMedia: { findUnique: jest.fn().mockResolvedValue(media) },
      refreshToken: { updateMany: jest.fn().mockResolvedValue({ count: 1 }) },
      deviceToken: { deleteMany: jest.fn().mockResolvedValue({ count: 1 }) },
      $transaction: jest.fn(async (ops: Promise<unknown>[]) =>
        Promise.all(ops),
      ),
    };
    return { service: new UsersService(prisma as never), prisma };
  }

  const privateContactKeys = [
    'email',
    'phone',
    'address',
    'dateofBirth',
    'notificationEnabled',
    'travelStyle',
  ] as const;

  it('selects only public profile fields for findOneById and findAll', async () => {
    const { service, prisma } = setup(null);
    await service.findOneById('user-1');
    await service.findAll(1, 20);
    for (const select of [
      prisma.user.findFirst.mock.calls[0][0].select,
      prisma.user.findMany.mock.calls[0][0].select,
    ]) {
      expect(select).toMatchObject({
        id: true,
        username: true,
        displayname: true,
        bio: true,
      });
      for (const key of privateContactKeys) {
        expect(select).not.toHaveProperty(key);
      }
    }
  });

  it('keeps private contact fields on the authenticated profile select', async () => {
    const { service, prisma } = setup(null);
    await service.findOne('user-1');
    const select = prisma.user.findFirst.mock.calls[0][0].select;
    expect(select).toMatchObject({
      email: true,
      phone: true,
      address: true,
      dateofBirth: true,
      notificationEnabled: true,
      travelStyle: true,
    });
  });

  it('stores a lowercased email and rejects another users avatar on create', async () => {
    const { service, prisma } = setup({
      userId: 'admin-1',
      deletedAt: null,
      mimeType: 'image/jpeg',
    });
    await service.create(
      {
        email: 'New.User@Example.com',
        password: 'secret1',
        displayname: 'New',
        username: 'new-user',
        avatarId: 'media-1',
      },
      'admin-1',
    );
    expect(prisma.user.create).toHaveBeenCalledWith(
      expect.objectContaining({
        data: expect.objectContaining({ email: 'new.user@example.com' }),
      }),
    );

    const foreign = setup({
      userId: 'someone-else',
      deletedAt: null,
      mimeType: 'image/png',
    });
    await expect(
      foreign.service.create(
        {
          email: 'other@example.com',
          password: 'secret1',
          displayname: 'Other',
          username: 'other',
          avatarId: 'media-2',
        },
        'admin-1',
      ),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });

  it('writes only defined profile fields', async () => {
    const { service, prisma } = setup({
      userId: 'user-1',
      deletedAt: null,
      mimeType: 'image/jpeg',
    });
    await service.update('user-1', { bio: 'hello' });
    expect(prisma.user.update).toHaveBeenCalledWith(
      expect.objectContaining({
        data: { bio: 'hello' },
      }),
    );
  });

  it('revokes refresh tokens and deletes device tokens when the account is removed', async () => {
    const { service, prisma } = setup(null);
    await service.remove('user-1');
    expect(prisma.user.update).toHaveBeenCalledWith(
      expect.objectContaining({
        data: expect.objectContaining({ deletedAt: expect.any(Date) }),
      }),
    );
    expect(prisma.refreshToken.updateMany).toHaveBeenCalledWith({
      where: { userId: 'user-1', revoked: false },
      data: { revoked: true },
    });
    expect(prisma.deviceToken.deleteMany).toHaveBeenCalledWith({
      where: { userId: 'user-1' },
    });
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

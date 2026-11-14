import { AUTH_PROVIDER } from '../../generated/prisma/enums';
import { AuthService } from './auth.service';

describe('AuthService public account recovery contract', () => {
  function setup(user: unknown) {
    const prisma = {
      user: { findUnique: jest.fn().mockResolvedValue(user) },
    };
    const redis = { get: jest.fn(), set: jest.fn() };
    const mail = { sendVerificationCode: jest.fn() };
    const service = new AuthService(
      prisma as never,
      {} as never,
      {} as never,
      {} as never,
      redis as never,
      mail as never,
      {} as never,
    );
    return { service, redis, mail };
  }

  it.each([
    ['unknown account', null],
    ['non-local account', { id: 'user-1', provider: AUTH_PROVIDER.GOOGLE }],
  ])('does not enumerate a %s', async (_label, user) => {
    const { service, redis, mail } = setup(user);
    await expect(
      service.sendPasswordResetCode('person@example.com'),
    ).resolves.toBeUndefined();
    expect(redis.set).not.toHaveBeenCalled();
    expect(mail.sendVerificationCode).not.toHaveBeenCalled();
  });
});

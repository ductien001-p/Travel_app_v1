import { UnauthorizedException } from '@nestjs/common';
import * as bcrypt from 'bcrypt';
import {
  AUTH_PROVIDER,
  USER_ROLE,
  USER_STATUS,
} from '../../generated/prisma/enums';
import { AuthService } from './auth.service';

jest.mock('bcrypt', () => ({
  hash: jest.fn(),
  compare: jest.fn(),
}));

describe('AuthService MVP contract', () => {
  const activeUser = {
    id: 'user-1',
    email: 'user@example.com',
    username: 'Traveler',
    password: 'hashed-password',
    avatarId: null,
    role: USER_ROLE.USER,
    status: USER_STATUS.ACTIVE,
    provider: AUTH_PROVIDER.LOCAL,
    deletedAt: null,
  };

  function setup() {
    const prisma: any = {
      user: { findUnique: jest.fn(), create: jest.fn() },
      refreshToken: {
        findFirst: jest.fn(),
        create: jest.fn(),
        delete: jest.fn(),
        updateMany: jest.fn(),
      },
      deviceToken: { deleteMany: jest.fn() },
    };
    prisma.$transaction = jest.fn(async (input: any) => {
      if (typeof input === 'function') return input(prisma);
      return Promise.all(input);
    });
    const jwt: any = {
      sign: jest
        .fn()
        .mockReturnValueOnce('access-token-1')
        .mockReturnValueOnce('refresh-token-1'),
      verify: jest.fn(),
      decode: jest
        .fn()
        .mockReturnValue({ exp: Math.floor(Date.now() / 1000) + 3600 }),
    };
    const config: any = {
      get: jest.fn(
        (key: string) =>
          ({
            SALT_ROUNDS: 10,
            JWT_SECRET_REFRESH: 'test-refresh-secret',
            ACCESS_TOKEN_EXPIRY: '15m',
            REFRESH_TOKEN_EXPIRY: '7d',
          })[key],
      ),
    };
    const service = new AuthService(
      prisma,
      jwt,
      config,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
    );
    return { service, prisma, jwt };
  }

  beforeEach(() => jest.clearAllMocks());

  it('hashes passwords using configured rounds', async () => {
    (bcrypt.hash as jest.Mock).mockResolvedValue('hashed');
    const { service } = setup();
    await expect(service.hashPassword('plain')).resolves.toBe('hashed');
    expect(bcrypt.hash).toHaveBeenCalledWith('plain', 10);
  });

  it('validates only active, non-deleted LOCAL users with a correct password', async () => {
    const { service, prisma } = setup();
    prisma.user.findUnique.mockResolvedValue(activeUser);
    (bcrypt.compare as jest.Mock).mockResolvedValue(true);
    await expect(
      service.validateUser('USER@example.com', 'correct'),
    ).resolves.toEqual({
      id: activeUser.id,
      email: activeUser.email,
      role: activeUser.role,
    });
    expect(prisma.user.findUnique).toHaveBeenCalledWith({
      where: { email: activeUser.email },
    });
  });

  it.each([
    null,
    { ...activeUser, provider: AUTH_PROVIDER.GOOGLE },
    { ...activeUser, status: USER_STATUS.INACTIVE },
    { ...activeUser, deletedAt: new Date() },
    { ...activeUser, password: null },
  ])(
    'rejects an ineligible local login without account detail',
    async (user) => {
      const { service, prisma } = setup();
      prisma.user.findUnique.mockResolvedValue(user);
      await expect(
        service.validateUser(activeUser.email, 'password'),
      ).resolves.toBeNull();
    },
  );

  it('rejects an incorrect password', async () => {
    const { service, prisma } = setup();
    prisma.user.findUnique.mockResolvedValue(activeUser);
    (bcrypt.compare as jest.Mock).mockResolvedValue(false);
    await expect(
      service.validateUser(activeUser.email, 'wrong'),
    ).resolves.toBeNull();
  });

  it('issues the Flutter login shape and stores only a refresh-token hash', async () => {
    const { service, prisma, jwt } = setup();
    const result = await service.login(activeUser);
    expect(result).toEqual({
      id: activeUser.id,
      accessToken: 'access-token-1',
      refreshToken: 'refresh-token-1',
    });
    expect(prisma.refreshToken.create).toHaveBeenCalledWith({
      data: expect.objectContaining({
        userId: activeUser.id,
        hashed: expect.not.stringContaining('refresh-token-1'),
      }),
    });
    const refreshPayload = jwt.sign.mock.calls[1][0];
    expect(refreshPayload).toEqual(
      expect.objectContaining({ type: 'refresh', jti: expect.any(String) }),
    );
  });

  it('rotates a valid refresh token atomically', async () => {
    const { service, prisma, jwt } = setup();
    jwt.verify.mockReturnValue({ sub: activeUser.id, type: 'refresh' });
    prisma.refreshToken.findFirst.mockResolvedValue({
      id: 'stored-1',
      revoked: false,
      expiresAt: new Date(Date.now() + 60_000),
      user: activeUser,
    });
    const result = await service.refresh('old-refresh-token');
    expect(result).toEqual({
      accessToken: 'access-token-1',
      refreshToken: 'refresh-token-1',
    });
    expect(prisma.refreshToken.delete).toHaveBeenCalledWith({
      where: { id: 'stored-1' },
    });
    expect(prisma.refreshToken.create).toHaveBeenCalled();
    expect(prisma.$transaction).toHaveBeenCalledWith(expect.any(Function));
  });

  it.each([
    ['missing', null],
    [
      'revoked',
      {
        id: 'stored-1',
        revoked: true,
        expiresAt: new Date(Date.now() + 60_000),
        user: activeUser,
      },
    ],
    [
      'expired',
      {
        id: 'stored-1',
        revoked: false,
        expiresAt: new Date(0),
        user: activeUser,
      },
    ],
    [
      'inactive',
      {
        id: 'stored-1',
        revoked: false,
        expiresAt: new Date(Date.now() + 60_000),
        user: { ...activeUser, status: USER_STATUS.INACTIVE },
      },
    ],
  ])('rejects a %s refresh session', async (_label, stored) => {
    const { service, prisma, jwt } = setup();
    jwt.verify.mockReturnValue({ sub: activeUser.id, type: 'refresh' });
    prisma.refreshToken.findFirst.mockResolvedValue(stored);
    await expect(service.refresh('old-refresh-token')).rejects.toBeInstanceOf(
      UnauthorizedException,
    );
  });

  it('rejects invalid JWTs and access tokens at the refresh endpoint', async () => {
    const first = setup();
    first.jwt.verify.mockImplementation(() => {
      throw new Error('invalid');
    });
    await expect(first.service.refresh('invalid')).rejects.toBeInstanceOf(
      UnauthorizedException,
    );
    const second = setup();
    second.jwt.verify.mockReturnValue({ sub: activeUser.id, type: 'access' });
    await expect(second.service.refresh('access-token')).rejects.toBeInstanceOf(
      UnauthorizedException,
    );
  });
});

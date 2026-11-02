import {
  ConflictException,
  ForbiddenException,
  HttpException,
  NotFoundException,
  ServiceUnavailableException,
} from '@nestjs/common';
import { createHash } from 'node:crypto';
import { TripShareService } from './trip-share.service';

describe('TripShareService', () => {
  const tripId = 'trip-1';
  const userId = 'user-1';
  const validToken = 'A'.repeat(43);
  const hash = (token: string) =>
    createHash('sha256').update(token).digest('hex');

  type SetupOptions = {
    member?: { role: string; status: string } | null;
    tripStatus?: string;
    link?: Record<string, unknown> | null;
    quotaUsed?: number;
    baseUrl?: string;
  };

  function setup({
    member = { role: 'MEMBER', status: 'ACTIVE' },
    tripStatus = 'UPCOMING',
    link = null,
    quotaUsed = 1,
    baseUrl = 'https://share.example.com/',
  }: SetupOptions = {}) {
    const prisma = {
      trip: {
        findUnique: jest
          .fn()
          .mockResolvedValue({ id: tripId, status: tripStatus }),
      },
      tripMember: { findUnique: jest.fn().mockResolvedValue(member) },
      tripShareLink: {
        create: jest.fn().mockResolvedValue({}),
        updateMany: jest.fn().mockResolvedValue({ count: 2 }),
        findUnique: jest.fn().mockResolvedValue(link),
      },
    };
    const itineraries = {
      loadItineraryDestinations: jest.fn().mockResolvedValue([{ id: 'd-1' }]),
    };
    const redis = { incrementWithTtl: jest.fn().mockResolvedValue(quotaUsed) };
    const s3 = { getPublicUrl: jest.fn((key: string) => `https://cdn/${key}`) };
    const config = {
      get: jest.fn((key: string) =>
        key === 'PUBLIC_SHARE_BASE_URL' ? baseUrl : undefined,
      ),
    };
    const service = new TripShareService(
      prisma as never,
      itineraries as never,
      redis as never,
      s3 as never,
      config as never,
    );
    return { service, prisma, itineraries };
  }

  const liveLink = (overrides: Record<string, unknown> = {}) => ({
    revokedAt: null,
    expiresAt: new Date(Date.now() + 60_000),
    trip: {
      id: tripId,
      name: 'Đà Nẵng',
      startDate: new Date('2026-07-15'),
      endDate: new Date('2026-07-20'),
      status: 'ONGOING',
      coverMedia: { objectKey: 'cover.jpg', deletedAt: null },
    },
    ...overrides,
  });

  describe('createLink', () => {
    it('stores only the token hash and returns a link on the share host', async () => {
      const { service, prisma } = setup();

      const result = await service.createLink(tripId, userId);

      const match =
        /^https:\/\/share\.example\.com\/s\/([A-Za-z0-9_-]{43})$/.exec(
          result.url,
        );
      expect(match).not.toBeNull();
      const stored = prisma.tripShareLink.create.mock.calls[0][0].data;
      expect(stored.tokenHash).toBe(hash(match![1]));
      expect(JSON.stringify(stored)).not.toContain(match![1]);
      expect(result.expiresAt.getTime()).toBeGreaterThan(Date.now());
    });

    it('refuses draft and cancelled trips', async () => {
      const { service, prisma } = setup({ tripStatus: 'DRAFT' });

      await expect(service.createLink(tripId, userId)).rejects.toThrow(
        ConflictException,
      );
      expect(prisma.tripShareLink.create).not.toHaveBeenCalled();
    });

    it('requires an active member', async () => {
      const { service } = setup({ member: { role: 'MEMBER', status: 'LEFT' } });

      await expect(service.createLink(tripId, userId)).rejects.toThrow(
        ForbiddenException,
      );
    });

    it('rate limits link creation per user', async () => {
      const { service } = setup({ quotaUsed: 21 });

      await expect(service.createLink(tripId, userId)).rejects.toThrow(
        HttpException,
      );
    });

    it('fails clearly when the share host is not configured', async () => {
      const { service } = setup({ baseUrl: '' });

      await expect(service.createLink(tripId, userId)).rejects.toThrow(
        ServiceUnavailableException,
      );
    });
  });

  describe('revokeAll', () => {
    it('revokes live links for owners and admins', async () => {
      const { service, prisma } = setup({
        member: { role: 'ADMIN', status: 'ACTIVE' },
      });

      await expect(service.revokeAll(tripId, userId)).resolves.toEqual({
        revokedCount: 2,
      });
      expect(prisma.tripShareLink.updateMany).toHaveBeenCalledWith(
        expect.objectContaining({
          where: expect.objectContaining({ tripId, revokedAt: null }),
        }),
      );
    });

    it('forbids plain members from revoking', async () => {
      const { service, prisma } = setup();

      await expect(service.revokeAll(tripId, userId)).rejects.toThrow(
        ForbiddenException,
      );
      expect(prisma.tripShareLink.updateMany).not.toHaveBeenCalled();
    });
  });

  describe('getSharedItinerary', () => {
    it('returns a read-only itinerary and the viewer membership', async () => {
      const { service, prisma } = setup({ link: liveLink(), member: null });

      const result = await service.getSharedItinerary(validToken, userId);

      expect(prisma.tripShareLink.findUnique).toHaveBeenCalledWith(
        expect.objectContaining({ where: { tokenHash: hash(validToken) } }),
      );
      expect(result.permissions).toEqual({ canManageItinerary: false });
      expect(result.viewer).toEqual({ isMember: false });
      expect(result.trip.coverImageUrl).toBe('https://cdn/cover.jpg');
      expect(result.destinations).toEqual([{ id: 'd-1' }]);
      expect(result.trip).not.toHaveProperty('inviteCode');
    });

    it.each([
      ['malformed', 'short', null],
      ['unknown', validToken, null],
      ['revoked', validToken, liveLink({ revokedAt: new Date() })],
      [
        'expired',
        validToken,
        liveLink({ expiresAt: new Date(Date.now() - 1) }),
      ],
      [
        'cancelled trip',
        validToken,
        liveLink({ trip: { ...liveLink().trip, status: 'CANCELLED' } }),
      ],
    ])('answers the same 404 for a %s link', async (_, token, link) => {
      const { service, itineraries } = setup({ link });

      await expect(service.getSharedItinerary(token, userId)).rejects.toThrow(
        new NotFoundException('Share link not found or expired'),
      );
      expect(itineraries.loadItineraryDestinations).not.toHaveBeenCalled();
    });
  });
});

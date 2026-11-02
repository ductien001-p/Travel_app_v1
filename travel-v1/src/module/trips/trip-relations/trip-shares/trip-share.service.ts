import {
  ConflictException,
  HttpException,
  HttpStatus,
  Injectable,
  NotFoundException,
  ServiceUnavailableException,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { createHash, randomBytes } from 'node:crypto';

import { PrismaService } from '../../../../prisma.service';
import { RedisService } from '../../../../redis/redis.service';
import { S3Service } from '../../../../uploads/s3/s3.service';
import { MEMBER_STATUS, TRIP_STATUS } from '../../../../generated/prisma/enums';
import { TripAccessPolicy } from '../../policies';
import { TripItinerariesService } from '../trip-itineraries/trip-destination.service';

const TOKEN_BYTES = 32;
/** base64url of 32 bytes, without padding. */
const TOKEN_PATTERN = /^[A-Za-z0-9_-]{43}$/;
const DEFAULT_TTL_DAYS = 30;
const MAX_TTL_DAYS = 365;
const CREATE_QUOTA_WINDOW_SECONDS = 60 * 60;
const CREATE_QUOTA_PER_WINDOW = 20;
const UNSHAREABLE_STATUSES: readonly string[] = [
  TRIP_STATUS.DRAFT,
  TRIP_STATUS.CANCELLED,
];
const LINK_NOT_FOUND = 'Share link not found or expired';

@Injectable()
export class TripShareService {
  private readonly baseUrl: string | null;
  private readonly ttlDays: number;

  constructor(
    private readonly prisma: PrismaService,
    private readonly itineraries: TripItinerariesService,
    private readonly redis: RedisService,
    private readonly s3: S3Service,
    config: ConfigService,
  ) {
    const baseUrl = config.get<string>('PUBLIC_SHARE_BASE_URL')?.trim();
    this.baseUrl = baseUrl ? baseUrl.replace(/\/+$/, '') : null;
    const ttl = Number(config.get('SHARE_LINK_TTL_DAYS'));
    this.ttlDays =
      Number.isInteger(ttl) && ttl > 0 && ttl <= MAX_TTL_DAYS
        ? ttl
        : DEFAULT_TTL_DAYS;
  }

  async createLink(tripId: string, userId: string) {
    if (!this.baseUrl) {
      throw new ServiceUnavailableException('Trip sharing is not configured');
    }
    await TripAccessPolicy.authorize(this.prisma, tripId, userId, 'SHARE_TRIP');

    const trip = await this.prisma.trip.findUnique({
      where: { id: tripId },
      select: { status: true },
    });
    if (!trip) throw new NotFoundException('Trip not found');
    if (UNSHAREABLE_STATUSES.includes(trip.status)) {
      throw new ConflictException(
        `Cannot share a trip while it is ${trip.status}`,
      );
    }
    await this.assertCreateQuota(userId);

    const token = randomBytes(TOKEN_BYTES).toString('base64url');
    const expiresAt = new Date(Date.now() + this.ttlDays * 86_400_000);
    await this.prisma.tripShareLink.create({
      data: {
        tripId,
        createdById: userId,
        tokenHash: this.hash(token),
        expiresAt,
      },
    });

    return { url: `${this.baseUrl}/s/${token}`, expiresAt };
  }

  async revokeAll(tripId: string, userId: string) {
    await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'REVOKE_SHARE',
    );

    const now = new Date();
    const { count } = await this.prisma.tripShareLink.updateMany({
      where: { tripId, revokedAt: null, expiresAt: { gt: now } },
      data: { revokedAt: now },
    });
    return { revokedCount: count };
  }

  /** Read-only itinerary for any signed-in user holding a live link. */
  async getSharedItinerary(token: string, userId: string) {
    if (!TOKEN_PATTERN.test(token)) throw new NotFoundException(LINK_NOT_FOUND);

    const link = await this.prisma.tripShareLink.findUnique({
      where: { tokenHash: this.hash(token) },
      select: {
        revokedAt: true,
        expiresAt: true,
        trip: {
          select: {
            id: true,
            name: true,
            startDate: true,
            endDate: true,
            status: true,
            coverMedia: { select: { objectKey: true, deletedAt: true } },
          },
        },
      },
    });
    // Unknown, revoked, expired and unshareable links are indistinguishable.
    if (
      !link ||
      link.revokedAt !== null ||
      link.expiresAt.getTime() <= Date.now() ||
      UNSHAREABLE_STATUSES.includes(link.trip.status)
    ) {
      throw new NotFoundException(LINK_NOT_FOUND);
    }

    const { trip } = link;
    const [destinations, member] = await Promise.all([
      this.itineraries.loadItineraryDestinations(trip.id),
      this.prisma.tripMember.findUnique({
        where: { tripId_userId: { tripId: trip.id, userId } },
        select: { status: true },
      }),
    ]);

    return {
      trip: {
        id: trip.id,
        name: trip.name,
        startDate: trip.startDate,
        endDate: trip.endDate,
        status: trip.status,
        coverImageUrl:
          trip.coverMedia && trip.coverMedia.deletedAt === null
            ? this.s3.getPublicUrl(trip.coverMedia.objectKey)
            : null,
      },
      destinations,
      permissions: { canManageItinerary: false },
      viewer: { isMember: member?.status === MEMBER_STATUS.ACTIVE },
    };
  }

  private hash(token: string): string {
    return createHash('sha256').update(token).digest('hex');
  }

  private async assertCreateQuota(userId: string): Promise<void> {
    let used: number;
    try {
      used = await this.redis.incrementWithTtl(
        `trip-share:create-quota:${userId}`,
        CREATE_QUOTA_WINDOW_SECONDS,
      );
    } catch {
      // A cache outage must not block sharing.
      return;
    }
    if (used > CREATE_QUOTA_PER_WINDOW) {
      throw new HttpException(
        {
          code: 'RATE_LIMITED',
          message: 'Too many share links, please try again later',
        },
        HttpStatus.TOO_MANY_REQUESTS,
      );
    }
  }
}

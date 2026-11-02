import {
  BadRequestException,
  ConflictException,
  Injectable,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { CreateMemoryDto } from './dto/create-memories.dto';
import { UpdateMemoryDto } from './dto/update-memory.dto';
import { PrismaService } from '../../../../prisma.service';
import {
  MEMBER_STATUS,
  TIMELINE_EVENT_TYPE,
  TIMELINE_TARGET_TYPE,
  TRIP_STATUS,
} from '../../../../generated/prisma/enums';
import { Prisma } from '../../../../generated/prisma/client';
import { S3Service } from '../../../../uploads/s3/s3.service';
import { QueryMemoriesDto } from './dto/query-memories.dto';
import { QueryMyMemoriesDto } from './dto/query-my-memories.dto';
import { MediaService } from '../../../media/media.service';
import { TripTimelineService } from '../trip-timeline/tripTimeline.service';
import { TripGateway } from '../../../../websocket/gateway';
import { TripAccessPolicy, TripResourcePolicy } from '../../policies';
import { TimePolicy } from '../../policies/time.policy';
import { EventEmitter2 } from '@nestjs/event-emitter';
import { DateTime, FixedOffsetZone } from 'luxon';
import {
  TRIP_MEMORIES_CREATED,
  TripMemoriesCreatedEvent,
} from '../../../../events/trip-memories-created.event';
import { memoryBadgeLabel } from './memory-badge/memory-badge.constants';

/** Drafts are private planning and cancelled trips never happened. */
const MEMORY_TRIP_STATUSES: readonly TRIP_STATUS[] = [
  TRIP_STATUS.UPCOMING,
  TRIP_STATUS.ONGOING,
  TRIP_STATUS.COMPLETED,
  TRIP_STATUS.NOTCOMPLETED,
];

function memorySelect(viewerId: string) {
  return {
    id: true,
    tripId: true,
    caption: true,
    createdAt: true,
    badge: true,
    likeCount: true,
    likes: {
      where: { userId: viewerId },
      select: { id: true },
      take: 1,
    },
    media: {
      select: {
        id: true,
        objectKey: true,
        mimeType: true,
        width: true,
        height: true,
        user: { select: { id: true, username: true, avatarId: true } },
      },
    },
  } satisfies Prisma.TripMediaSelect;
}

function myMemorySelect(viewerId: string) {
  return {
    ...memorySelect(viewerId),
    trip: { select: { name: true } },
  } satisfies Prisma.TripMediaSelect;
}

type MemoryRecord = Prisma.TripMediaGetPayload<{
  select: ReturnType<typeof memorySelect>;
}>;

type MyMemoryRecord = Prisma.TripMediaGetPayload<{
  select: ReturnType<typeof myMemorySelect>;
}>;

export interface MemoryItem {
  id: string;
  tripId: string;
  caption: string | null;
  createdAt: Date;
  imageUrl: string;
  user: {
    id: string;
    username: string;
    avatarId: string | null;
  } | null;
  media: {
    id: string;
    mimeType: string;
    width: number | null;
    height: number | null;
  };
  /** Label suggested from the photo content; null until classified. */
  badge: string | null;
  likeCount: number;
  /** True when the requesting user has a TripMediaLike on this photo. */
  liked: boolean;
}

export interface MyMemoryItem extends MemoryItem {
  tripName: string;
}

export interface MyMemoryCollection {
  tripId: string;
  name: string;
  status: string;
  memoryCount: number;
}

export interface GetMyMemoriesResult {
  data: MyMemoryItem[];
  /** Null after the first page so the client keeps the chip list. */
  collections: MyMemoryCollection[] | null;
  /** Null after the first page, or when the month has no photo. */
  highlight: MyMemoryItem | null;
  meta: {
    nextCursor: string | null;
    hasMore: boolean;
    /** Photos in the selected set; only on the first page. */
    totalCount: number | null;
  };
}

export interface MemoryLikeResult {
  likeCount: number;
  liked: boolean;
}

export interface MemoryDayCount {
  day: number;
  count: number;
}

export interface GetMemoriesResult {
  data: MemoryItem[];
  meta: {
    nextCursor: string | null;
    hasMore: boolean;
    /** Memories matching every filter; only on the first page. */
    totalCount: number | null;
    /** Memories per trip day, ignoring `day`; only on the first page. */
    dayCounts: MemoryDayCount[] | null;
  };
}

/** Trip dates as UTC calendar days (`yyyy-MM-dd`). */
interface TripDays {
  startDate: string;
  endDate: string;
  dayCount: number;
}

@Injectable()
export class TripMemoriesService {
  private readonly logger = new Logger(TripMemoriesService.name);
  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
    private readonly mediaService: MediaService,
    private readonly tripTimelineService: TripTimelineService,
    private readonly tripTimelineGateway: TripGateway,
    private readonly eventEmitter: EventEmitter2,
  ) {}
  async createMemory(tripId: string, userId: string, dto: CreateMemoryDto) {
    const [memory] = await this.createMemories(tripId, userId, [dto]);
    return memory;
  }

  /**
   * Adds several photos at once. All memories are created in one transaction
   * and announced by a single MEMORY_ADDED event, so the feed shows one card.
   */
  async createMemories(
    tripId: string,
    userId: string,
    items: CreateMemoryDto[],
  ): Promise<MemoryItem[]> {
    const mediaIds = items.map((item) => item.mediaId);
    if (mediaIds.length === 0) {
      throw new BadRequestException('At least one photo is required');
    }
    if (new Set(mediaIds).size !== mediaIds.length) {
      throw new BadRequestException('Each photo can only be added once');
    }

    await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'CREATE_MEMORY',
    );

    const trip = await this.prisma.trip.findUniqueOrThrow({
      where: { id: tripId },
      select: { status: true },
    });
    if (!MEMORY_TRIP_STATUSES.includes(trip.status)) {
      throw new ConflictException(
        `Memories cannot be added while the trip is ${trip.status}`,
      );
    }

    const mediaById = await TripResourcePolicy.assertOwnedImages(
      this.prisma,
      userId,
      mediaIds,
    );
    const existing = await this.prisma.tripMedia.findFirst({
      where: { mediaId: { in: mediaIds } },
      select: { id: true },
    });
    if (existing) {
      throw new BadRequestException('Memory already exists for this media');
    }

    await Promise.all(
      [...mediaById.values()].map((media) =>
        this.mediaService.validateMediaExists(media.objectKey),
      ),
    );

    const result = await this.prisma
      .$transaction(async (tx) => {
        const memories: MemoryRecord[] = [];
        // Sequential on purpose: an interactive transaction runs one query at a time.
        for (const item of items) {
          memories.push(
            await tx.tripMedia.create({
              data: {
                tripId,
                mediaId: item.mediaId,
                caption: item.caption,
              },
              select: memorySelect(userId),
            }),
          );
        }

        const timelineEvent = await this.tripTimelineService.createEvent(
          tx,
          tripId,
          userId,
          {
            type: TIMELINE_EVENT_TYPE.MEMORY_ADDED,
            content:
              memories.length > 1
                ? `Đã thêm ${memories.length} kỷ niệm mới`
                : `Đã thêm một kỷ niệm mới`,
            metadata: {
              memoryIds: memories.map((memory) => memory.id),
              caption:
                items.map((item) => item.caption?.trim()).find(Boolean) ?? null,
            },
            target: { type: TIMELINE_TARGET_TYPE.MEMORY, id: memories[0].id },
          },
        );
        return { memories, timelineEvent };
      })
      .catch((error: unknown) => {
        if (
          error instanceof Prisma.PrismaClientKnownRequestError &&
          error.code === 'P2002'
        ) {
          throw new BadRequestException('Memory already exists for this media');
        }
        throw error;
      });

    this.tripTimelineGateway.emitTimelineEvent(tripId, result.timelineEvent);
    this.eventEmitter.emit(
      TRIP_MEMORIES_CREATED,
      new TripMemoriesCreatedEvent(
        tripId,
        result.memories.map((memory) => memory.id),
      ),
    );
    return result.memories.map((memory) => this.mapMemory(memory));
  }

  //paganition theo kieu feed load lien tuc va lay tu phan tu cursor ko phai bo qua cac phan tu dau roi moi lay nhu offset
  async getMemories(
    tripId: string,
    userId: string,
    getMemoriesDto: QueryMemoriesDto,
  ): Promise<GetMemoriesResult> {
    // 1. Check quyền: user phải là active member của trip
    await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'READ_MEMORIES',
    );

    const { cursor, day, limit, userId: uploaderId } = getMemoriesDto;
    const tripDays = await this.getTripDays(tripId);
    if (day !== undefined && day > tripDays.dayCount) {
      throw new BadRequestException('Day is outside the trip dates');
    }

    const filter: Prisma.TripMediaWhereInput = {
      tripId,
      media: {
        deletedAt: null,
        ...(uploaderId ? { userId: uploaderId } : {}),
      },
      ...(day !== undefined
        ? { createdAt: this.tripDayRange(tripDays, day) }
        : {}),
    };

    // 3. Cursor phải thuộc đúng trip và bộ lọc, nếu không `skip: 1` sẽ bỏ sót
    // một phần tử hợp lệ.
    if (cursor) {
      const cursorExists = await this.prisma.tripMedia.findFirst({
        where: { ...filter, id: cursor },
        select: { id: true },
      });
      if (!cursorExists) {
        throw new BadRequestException('Invalid cursor for this trip');
      }
    }

    // 4. Query danh sách + 1 để biết còn trang tiếp theo không. Tổng chỉ tính ở
    // trang đầu, các trang sau giữ số của trang đầu.
    const [memories, totalCount, dayCounts] = await Promise.all([
      this.prisma.tripMedia.findMany({
        where: filter,
        take: limit + 1,
        ...(cursor ? { cursor: { id: cursor }, skip: 1 } : {}),
        orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
        select: memorySelect(userId),
      }),
      cursor ? null : this.prisma.tripMedia.count({ where: filter }),
      cursor ? null : this.countByTripDay(tripId, tripDays, uploaderId),
    ]);

    const hasMore = memories.length > limit;
    const items = hasMore ? memories.slice(0, limit) : memories;
    const nextCursor = hasMore ? items[items.length - 1].id : null;

    return {
      data: items.map((memory) => this.mapMemory(memory)),
      meta: { nextCursor, hasMore, totalCount, dayCounts },
    };
  }

  private async getTripDays(tripId: string): Promise<TripDays> {
    const trip = await this.prisma.trip.findUniqueOrThrow({
      where: { id: tripId },
      select: { startDate: true, endDate: true },
    });
    const range = {
      startDate: TimePolicy.utcDate(DateTime.fromJSDate(trip.startDate)),
      endDate: TimePolicy.utcDate(DateTime.fromJSDate(trip.endDate)),
    };
    return { ...range, dayCount: TimePolicy.dayCount(range) };
  }

  /** UTC bounds of the 1-based trip [day]. */
  private tripDayRange(trip: TripDays, day: number) {
    const start = TimePolicy.day(trip.startDate).plus({ days: day - 1 });
    return { gte: start.toJSDate(), lt: start.plus({ days: 1 }).toJSDate() };
  }

  /** Days without memories and photos posted outside the trip are left out. */
  private async countByTripDay(
    tripId: string,
    trip: TripDays,
    uploaderId: string | undefined,
  ): Promise<MemoryDayCount[]> {
    // `createdAt` is a UTC timestamp without zone, so `::date` is its UTC day.
    return this.prisma.$queryRaw<MemoryDayCount[]>`
      SELECT (tm."createdAt"::date - ${trip.startDate}::date + 1)::int AS "day",
             COUNT(*)::int AS "count"
      FROM "TripMedia" tm
      JOIN "UploadedMedia" um ON um."id" = tm."mediaId"
      WHERE tm."tripId" = ${tripId}
        AND um."deletedAt" IS NULL
        ${uploaderId ? Prisma.sql`AND um."userId" = ${uploaderId}` : Prisma.empty}
        AND tm."createdAt"::date BETWEEN ${trip.startDate}::date AND ${trip.endDate}::date
      GROUP BY 1
      ORDER BY 1`;
  }

  async updateMemory(memoryId: string, userId: string, dto: UpdateMemoryDto) {
    const memory = await this.prisma.tripMedia.findUnique({
      where: {
        id: memoryId,
      },
      select: {
        id: true,
        tripId: true,
        caption: true,
        media: {
          select: {
            id: true,
            userId: true,
          },
        },
      },
    });

    if (!memory) {
      throw new NotFoundException('Memory not found');
    }

    const member = await this.prisma.tripMember.findUnique({
      where: { tripId_userId: { tripId: memory.tripId, userId } },
      select: { role: true, status: true },
    });
    TripAccessPolicy.assertAllowed(member, 'CREATE_MEMORY');

    TripResourcePolicy.assertOwnedBy(
      memory.media.userId,
      userId,
      'You cannot update this memory',
    );

    const updatedMemory = await this.prisma.tripMedia.update({
      where: { id: memory.id },
      data: { caption: dto.caption },
      select: memorySelect(userId),
    });

    return this.mapMemory(updatedMemory);
  }

  //Sau nay lam them chuc nang backgroud job de xoa cac ban ghi deletedAt cu, de tranh database bi day do cac ban ghi memory da xoa nhung van con trong database
  async deleteMemory(memoryId: string, userId: string) {
    const memory = await this.prisma.tripMedia.findUnique({
      where: {
        id: memoryId,
      },
      select: {
        id: true,
        media: {
          select: {
            id: true,
            user: {
              select: {
                id: true,
              },
            },
          },
        },
        tripId: true,
      },
    });

    if (!memory) {
      throw new NotFoundException('Memory not found');
    }
    const member = await this.prisma.tripMember.findUnique({
      where: { tripId_userId: { tripId: memory.tripId, userId } },
      select: { role: true, status: true },
    });
    TripAccessPolicy.assertAllowed(member, 'CREATE_MEMORY');
    // OWNER/ADMIN moderate, which also covers memories whose uploader
    // deleted their account (media.user is then null).
    if (!TripAccessPolicy.can(member, 'MODERATE_MEMORIES')) {
      TripResourcePolicy.assertOwnedBy(
        memory.media.user?.id,
        userId,
        'You cannot delete this memory',
      );
    }

    const result = await this.prisma.$transaction(async (tx) => {
      await tx.tripMedia.delete({
        where: {
          id: memory.id,
        },
      });
      const timelineEvent = await this.tripTimelineService.createEvent(
        tx,
        memory.tripId,
        userId,
        {
          type: TIMELINE_EVENT_TYPE.MEMORY_DELETED,
          content: `Đã xóa một kỷ niệm`,
          metadata: null,
        },
      );
      return {
        timelineEvent,
      };
    });
    this.tripTimelineGateway.emitTimelineEvent(
      memory.tripId,
      result.timelineEvent,
    );

    return {
      message: 'Memory deleted successfully',
    };
  }

  private mapMemory(memory: MemoryRecord): MemoryItem {
    return {
      id: memory.id,
      tripId: memory.tripId,
      caption: memory.caption,
      createdAt: memory.createdAt,
      imageUrl: this.s3.getPublicUrl(memory.media.objectKey),
      user: memory.media.user,
      media: {
        id: memory.media.id,
        mimeType: memory.media.mimeType ?? 'application/octet-stream',
        width: memory.media.width,
        height: memory.media.height,
      },
      badge: memoryBadgeLabel(memory.badge),
      likeCount: memory.likeCount,
      liked: memory.likes.length > 0,
    };
  }

  async getMyMemories(
    userId: string,
    query: QueryMyMemoriesDto,
  ): Promise<GetMyMemoriesResult> {
    if (query.tripId) {
      await TripAccessPolicy.authorize(
        this.prisma,
        query.tripId,
        userId,
        'READ_MEMORIES',
      );
    }

    const filter = this.myMemoryFilter(userId, query);
    const firstPage = !query.cursor;

    if (query.cursor) {
      const cursorExists = await this.prisma.tripMedia.findFirst({
        where: { ...filter, id: query.cursor },
        select: { id: true },
      });
      if (!cursorExists) {
        throw new BadRequestException('Invalid cursor for this filter');
      }
    }

    const [memories, totalCount, collections, highlight] = await Promise.all([
      this.prisma.tripMedia.findMany({
        where: filter,
        take: query.limit + 1,
        ...(query.cursor ? { cursor: { id: query.cursor }, skip: 1 } : {}),
        orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
        select: myMemorySelect(userId),
      }),
      firstPage
        ? this.prisma.tripMedia.count({ where: filter })
        : Promise.resolve(null),
      firstPage ? this.listMyCollections(userId) : Promise.resolve(null),
      firstPage ? this.findHighlight(userId, query) : Promise.resolve(null),
    ]);

    const hasMore = memories.length > query.limit;
    const items = hasMore ? memories.slice(0, query.limit) : memories;

    return {
      data: items.map((memory) => this.mapMyMemory(memory)),
      collections,
      highlight,
      meta: {
        nextCursor: hasMore ? items[items.length - 1].id : null,
        hasMore,
        totalCount,
      },
    };
  }

  async likeMemory(
    memoryId: string,
    userId: string,
  ): Promise<MemoryLikeResult> {
    const memory = await this.requireLikeableMemory(memoryId, userId);
    await this.prisma.$transaction(async (tx) => {
      const created = await tx.tripMediaLike.createMany({
        data: [{ tripMediaId: memory.id, userId }],
        skipDuplicates: true,
      });
      if (created.count === 1) {
        await tx.tripMedia.update({
          where: { id: memory.id },
          data: { likeCount: { increment: 1 } },
        });
      }
    });
    return this.likeState(memory.id, userId);
  }

  async unlikeMemory(
    memoryId: string,
    userId: string,
  ): Promise<MemoryLikeResult> {
    const memory = await this.requireLikeableMemory(memoryId, userId);
    await this.prisma.$transaction(async (tx) => {
      const deleted = await tx.tripMediaLike.deleteMany({
        where: { tripMediaId: memory.id, userId },
      });
      if (deleted.count === 1) {
        await tx.tripMedia.updateMany({
          where: { id: memory.id, likeCount: { gt: 0 } },
          data: { likeCount: { decrement: 1 } },
        });
      }
    });
    return this.likeState(memory.id, userId);
  }

  private myMemoryFilter(
    userId: string,
    query: Pick<QueryMyMemoriesDto, 'tripId' | 'q'>,
  ): Prisma.TripMediaWhereInput {
    const caption = query.q?.trim();
    return {
      media: { userId, deletedAt: null },
      trip: {
        members: { some: { userId, status: MEMBER_STATUS.ACTIVE } },
      },
      ...(query.tripId ? { tripId: query.tripId } : {}),
      ...(caption
        ? { caption: { contains: caption, mode: 'insensitive' as const } }
        : {}),
    };
  }

  /** Active trips that contain at least one of the viewer's photos. */
  private async listMyCollections(
    userId: string,
  ): Promise<MyMemoryCollection[]> {
    const trips = await this.prisma.trip.findMany({
      where: {
        members: { some: { userId, status: MEMBER_STATUS.ACTIVE } },
        tripMedias: {
          some: { media: { userId, deletedAt: null } },
        },
      },
      select: {
        id: true,
        name: true,
        status: true,
        tripMedias: {
          where: { media: { userId, deletedAt: null } },
          select: { createdAt: true },
          orderBy: { createdAt: 'desc' },
          take: 1,
        },
        _count: {
          select: {
            tripMedias: {
              where: { media: { userId, deletedAt: null } },
            },
          },
        },
      },
    });

    return trips
      .flatMap((trip) => {
        const latest = trip.tripMedias[0];
        if (!latest || trip._count.tripMedias < 1) return [];
        return [
          {
            tripId: trip.id,
            name: trip.name,
            status: trip.status,
            memoryCount: trip._count.tripMedias,
            latestAt: latest.createdAt,
          },
        ];
      })
      .sort((left, right) => {
        const byPhoto = right.latestAt.getTime() - left.latestAt.getTime();
        if (byPhoto !== 0) return byPhoto;
        return left.name.localeCompare(right.name, 'vi');
      })
      .map(({ latestAt: _latestAt, ...collection }) => collection);
  }

  /**
   * Highest like count among the viewer's photos in the device calendar
   * month. A tie keeps the newer photo. Caption search does not apply.
   */
  private async findHighlight(
    userId: string,
    query: QueryMyMemoriesDto,
  ): Promise<MyMemoryItem | null> {
    if (query.year === undefined || query.month === undefined) return null;
    const memory = await this.prisma.tripMedia.findFirst({
      where: {
        media: { userId, deletedAt: null },
        trip: {
          members: { some: { userId, status: MEMBER_STATUS.ACTIVE } },
        },
        createdAt: this.viewerMonthRange(
          query.year,
          query.month,
          query.utcOffsetMinutes,
        ),
        ...(query.tripId ? { tripId: query.tripId } : {}),
      },
      orderBy: [{ likeCount: 'desc' }, { createdAt: 'desc' }, { id: 'desc' }],
      select: myMemorySelect(userId),
    });
    return memory ? this.mapMyMemory(memory) : null;
  }

  /** Inclusive start and exclusive end of the viewer's calendar month, in UTC. */
  private viewerMonthRange(year: number, month: number, offsetMinutes: number) {
    const start = DateTime.fromObject(
      { year, month, day: 1 },
      { zone: FixedOffsetZone.instance(offsetMinutes) },
    );
    if (!start.isValid) {
      throw new BadRequestException('Invalid calendar month');
    }
    return {
      gte: start.toJSDate(),
      lt: start.plus({ months: 1 }).toJSDate(),
    };
  }

  private async requireLikeableMemory(memoryId: string, userId: string) {
    const memory = await this.prisma.tripMedia.findUnique({
      where: { id: memoryId },
      select: {
        id: true,
        tripId: true,
        media: { select: { deletedAt: true } },
      },
    });
    if (!memory || memory.media.deletedAt) {
      throw new NotFoundException('Memory not found');
    }
    await TripAccessPolicy.authorize(
      this.prisma,
      memory.tripId,
      userId,
      'READ_MEMORIES',
    );
    return memory;
  }

  private async likeState(
    memoryId: string,
    userId: string,
  ): Promise<MemoryLikeResult> {
    const memory = await this.prisma.tripMedia.findUniqueOrThrow({
      where: { id: memoryId },
      select: {
        likeCount: true,
        likes: { where: { userId }, select: { id: true }, take: 1 },
      },
    });
    return { likeCount: memory.likeCount, liked: memory.likes.length > 0 };
  }

  private mapMyMemory(memory: MyMemoryRecord): MyMemoryItem {
    return {
      ...this.mapMemory(memory),
      tripName: memory.trip.name,
    };
  }
}

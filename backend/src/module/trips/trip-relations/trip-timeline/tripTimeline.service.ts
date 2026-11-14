import { BadRequestException, Injectable } from '@nestjs/common';

import { PrismaService } from '../../../../prisma.service';

import {
  TIMELINE_EVENT_TYPE,
  TIMELINE_TARGET_TYPE,
  TRIP_STATUS,
} from '../../../../generated/prisma/enums';

import { Prisma } from '../../../../generated/prisma/client';
import { S3Service } from '../../../../uploads/s3/s3.service';
import { TripAccessPolicy } from '../../policies';
import {
  TIMELINE_CATEGORY_TYPES,
  TimelineCategory,
  TimelineCounts,
  toTimelineCounts,
} from './timeline-category';
import {
  readStoredMetadata,
  TimelineEventInput,
  TimelineEventMetadataResponse,
} from './timeline-metadata';

const DEFAULT_PAGE_SIZE = 30;
const MAX_PAGE_SIZE = 100;

const TIMELINE_EVENT_SELECT = {
  id: true,
  tripId: true,
  memberId: true,
  type: true,
  content: true,
  metadata: true,
  targetType: true,
  targetId: true,
  createdAt: true,
  member: {
    select: {
      id: true,
      user: {
        select: {
          id: true,
          username: true,
          displayname: true,
          avatar: { select: { objectKey: true, deletedAt: true } },
        },
      },
    },
  },
} satisfies Prisma.TripTimelineEventSelect;

type TimelineEventRecord = Prisma.TripTimelineEventGetPayload<{
  select: typeof TIMELINE_EVENT_SELECT;
}>;

type TimelineReader = Pick<Prisma.TransactionClient, 'tripMedia'>;

/** Shape shared by GET /trips/timeline/:tripId and the `trip:timeline` socket event. */
export interface TimelineEventResponse {
  id: string;
  tripId: string;
  memberId: string;
  type: TIMELINE_EVENT_TYPE;
  content: string;
  createdAt: Date;
  targetType: TIMELINE_TARGET_TYPE | null;
  targetId: string | null;
  member: {
    id: string;
    user: {
      id: string;
      username: string;
      displayName: string;
      avatarUrl: string | null;
    };
  };
  metadata: TimelineEventMetadataResponse | null;
}

export interface TimelinePageResponse {
  data: TimelineEventResponse[];
  meta: {
    nextCursor: string | null;
    hasMore: boolean;
    /** Totals per filter chip; only sent with the first page. */
    counts: TimelineCounts | null;
  };
}

export interface TimelineQuery {
  limit?: number;
  cursor?: string;
  category?: TimelineCategory;
}

@Injectable()
export class TripTimelineService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
  ) {}

  // =========================================================
  // CREATE EVENT
  // INTERNAL SERVICE METHOD
  // =========================================================

  /**
   * Records an event inside the caller's transaction and returns it in the
   * public response shape, ready to be broadcast over the trip socket room.
   *
   * Returns null without recording anything while the trip is a draft: drafts
   * are private planning and the group's history starts with TRIP_CREATED.
   */
  async createEvent<T extends TIMELINE_EVENT_TYPE>(
    tx: Prisma.TransactionClient,
    tripId: string,
    userId: string,
    input: TimelineEventInput<T>,
  ): Promise<TimelineEventResponse | null> {
    const member = await tx.tripMember.findFirst({
      where: {
        tripId,
        userId,
      },

      select: {
        id: true,
        role: true,
        status: true,
        trip: { select: { status: true } },
      },
    });

    TripAccessPolicy.assertAllowed(member, 'CREATE_TIMELINE_EVENT');

    if (member.trip.status === TRIP_STATUS.DRAFT) return null;

    const event = await tx.tripTimelineEvent.create({
      data: {
        tripId,
        memberId: member.id,
        type: input.type,
        content: input.content,
        metadata:
          input.metadata === null
            ? undefined
            : (input.metadata as Prisma.InputJsonObject),
        targetType: input.target?.type ?? null,
        targetId: input.target?.id ?? null,
      },
      select: TIMELINE_EVENT_SELECT,
    });

    const [response] = await this.toResponses(tx, [event]);
    return response;
  }

  // =========================================================
  // GET TIMELINE
  // =========================================================

  async getTripTimeline(
    tripId: string,
    userId: string,
    query: TimelineQuery = {},
  ): Promise<TimelinePageResponse> {
    await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'READ_TIMELINE',
    );

    const where: Prisma.TripTimelineEventWhereInput = {
      tripId,
      ...(query.category
        ? { type: { in: [...TIMELINE_CATEGORY_TYPES[query.category]] } }
        : {}),
    };

    if (query.cursor) {
      // The cursor must match the same filter, otherwise the page would
      // silently restart from an unrelated position.
      const cursorEvent = await this.prisma.tripTimelineEvent.findFirst({
        where: { ...where, id: query.cursor },
        select: { id: true },
      });
      if (!cursorEvent) {
        throw new BadRequestException('Invalid cursor for this trip');
      }
    }

    const safeLimit = Math.min(
      Math.max(query.limit ?? DEFAULT_PAGE_SIZE, 1),
      MAX_PAGE_SIZE,
    );

    const [events, counts] = await Promise.all([
      this.prisma.tripTimelineEvent.findMany({
        where,
        take: safeLimit + 1,
        ...(query.cursor ? { cursor: { id: query.cursor }, skip: 1 } : {}),
        orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
        select: TIMELINE_EVENT_SELECT,
      }),
      query.cursor ? Promise.resolve(null) : this.countByCategory(tripId),
    ]);

    const hasMore = events.length > safeLimit;
    const page = hasMore ? events.slice(0, safeLimit) : events;
    const nextCursor = hasMore ? page[page.length - 1].id : null;

    return {
      data: await this.toResponses(this.prisma, page),
      meta: { nextCursor, hasMore, counts },
    };
  }

  private async countByCategory(tripId: string): Promise<TimelineCounts> {
    const rows = await this.prisma.tripTimelineEvent.groupBy({
      by: ['type'],
      where: { tripId },
      _count: { _all: true },
    });
    return toTimelineCounts(
      rows.map((row) => ({ type: row.type, count: row._count._all })),
    );
  }

  // =========================================================
  // RESPONSE MAPPING
  // =========================================================

  private async toResponses(
    reader: TimelineReader,
    events: TimelineEventRecord[],
  ): Promise<TimelineEventResponse[]> {
    const stored = events.map((event) => readStoredMetadata(event.metadata));
    const photoUrlsByMemory = await this.loadMemoryPhotoUrls(
      reader,
      events[0]?.tripId,
      stored.flatMap((item) => item?.memoryIds ?? []),
    );

    return events.map((event, index) => ({
      id: event.id,
      tripId: event.tripId,
      memberId: event.memberId,
      type: event.type,
      content: event.content,
      createdAt: event.createdAt,
      targetType: event.targetType,
      targetId: event.targetId,
      member: {
        id: event.member.id,
        user: {
          id: event.member.user.id,
          username: event.member.user.username,
          displayName: event.member.user.displayname,
          avatarUrl: this.toPublicUrl(event.member.user.avatar),
        },
      },
      metadata: this.resolveMetadata(
        event.type,
        stored[index],
        photoUrlsByMemory,
      ),
    }));
  }

  private resolveMetadata(
    type: TIMELINE_EVENT_TYPE,
    stored: ReturnType<typeof readStoredMetadata>,
    photoUrlsByMemory: Map<string, string>,
  ): TimelineEventMetadataResponse | null {
    if (!stored) return null;
    const metadata = { ...stored.metadata };

    if (type === TIMELINE_EVENT_TYPE.ACTIVITY_CHECKIN) {
      metadata.imageUrl = stored.placeMediaKey
        ? this.s3.getPublicUrl(stored.placeMediaKey)
        : null;
    }

    if (type === TIMELINE_EVENT_TYPE.MEMORY_ADDED) {
      const alive = stored.memoryIds.flatMap((id) => {
        const url = photoUrlsByMemory.get(id);
        return url ? [{ id, url }] : [];
      });
      metadata.memoryIds = alive.map((memory) => memory.id);
      metadata.photoUrls = alive.map((memory) => memory.url);
      metadata.photoCount = alive.length;
    }

    return metadata;
  }

  /** One query per page; deleted memories simply drop out of the result. */
  private async loadMemoryPhotoUrls(
    reader: TimelineReader,
    tripId: string | undefined,
    memoryIds: string[],
  ): Promise<Map<string, string>> {
    if (!tripId || memoryIds.length === 0) return new Map();
    const memories = await reader.tripMedia.findMany({
      where: {
        id: { in: [...new Set(memoryIds)] },
        tripId,
        media: { deletedAt: null },
      },
      select: { id: true, media: { select: { objectKey: true } } },
    });
    return new Map(
      memories.map((memory) => [
        memory.id,
        this.s3.getPublicUrl(memory.media.objectKey),
      ]),
    );
  }

  private toPublicUrl(
    media: { objectKey: string; deletedAt: Date | null } | null,
  ): string | null {
    return media && media.deletedAt === null
      ? this.s3.getPublicUrl(media.objectKey)
      : null;
  }
}

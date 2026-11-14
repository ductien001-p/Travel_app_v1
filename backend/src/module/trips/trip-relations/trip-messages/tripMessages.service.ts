import {
  BadRequestException,
  Inject,
  Injectable,
  Logger,
  NotFoundException,
  forwardRef,
} from '@nestjs/common';

import {
  MEMBER_STATUS,
  TRIP_MESSAGE_TYPE,
  TRIP_ROLE,
} from '../../../../generated/prisma/enums';
import { Prisma } from '../../../../generated/prisma/client';
import { PrismaService } from '../../../../prisma.service';
import { S3Service } from '../../../../uploads/s3/s3.service';
import { TripGateway } from '../../../../websocket/gateway';
import { TripAccessPolicy, TripResourcePolicy } from '../../policies';
import {
  aggregateReactions,
  buildMemberSummaryLabel,
  formatDateLabel,
  formatTimeLabel,
  mapMessageTypeToUiKind,
  mapPinnedActivity,
  mapTripRoleToSenderBadge,
  parseMessageMetadata,
  resolveReadStatus,
  TRIP_CHAT_UTILITIES,
  TripChatMessageDto,
  TripChatThreadDto,
} from './trip-chat-thread.mapper';

type DbClient = Prisma.TransactionClient | PrismaService;

const MEDIA_URL_SELECT = {
  objectKey: true,
  deletedAt: true,
} satisfies Prisma.UploadedMediaSelect;

const MESSAGE_INCLUDE = {
  sender: {
    select: {
      id: true,
      role: true,
      user: {
        select: {
          id: true,
          username: true,
          displayname: true,
          avatar: { select: MEDIA_URL_SELECT },
        },
      },
    },
  },
  reactions: {
    select: {
      emoji: true,
      userId: true,
    },
  },
} as const;

export type CreateMessageOptions = {
  messageType?: TRIP_MESSAGE_TYPE;
  metadata?: Prisma.InputJsonValue | null;
  /** When set, skips SEND_MESSAGE auth and uses this TripMember.id as sender. */
  senderMemberId?: string;
};

@Injectable()
export class TripMessageService {
  private readonly logger = new Logger(TripMessageService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
    @Inject(forwardRef(() => TripGateway))
    private readonly tripGateway: TripGateway,
  ) {}

  // =========================================================
  // CREATE MESSAGE
  // =========================================================

  /** For IMAGE messages `content` is the id of an image the sender uploaded. */
  async createMessage(
    tripId: string,
    userId: string,
    content: string,
    messageTypeOrOptions:
      | TRIP_MESSAGE_TYPE
      | CreateMessageOptions = TRIP_MESSAGE_TYPE.TEXT,
  ) {
    const options: CreateMessageOptions =
      typeof messageTypeOrOptions === 'string'
        ? { messageType: messageTypeOrOptions }
        : messageTypeOrOptions;
    const messageType = options.messageType ?? TRIP_MESSAGE_TYPE.TEXT;

    let senderId = options.senderMemberId;
    if (!senderId) {
      const sender = await TripAccessPolicy.authorize(
        this.prisma,
        tripId,
        userId,
        'SEND_MESSAGE',
      );
      senderId = sender.id;
    }

    if (
      messageType !== TRIP_MESSAGE_TYPE.TEXT &&
      messageType !== TRIP_MESSAGE_TYPE.IMAGE &&
      messageType !== TRIP_MESSAGE_TYPE.SYSTEM &&
      messageType !== TRIP_MESSAGE_TYPE.EXPENSE
    ) {
      throw new BadRequestException('Unsupported message type');
    }

    const image =
      messageType === TRIP_MESSAGE_TYPE.IMAGE
        ? await TripResourcePolicy.assertOwnedImage(
            this.prisma,
            userId,
            content,
          )
        : null;

    const metadata =
      messageType === TRIP_MESSAGE_TYPE.IMAGE
        ? this.buildImageMetadata(options.metadata)
        : (options.metadata ?? null);

    const message = await this.prisma.tripMessage.create({
      data: {
        tripId,
        senderId,
        content,
        messageType,
        ...(metadata != null ? { metadata } : {}),
      },
      include: MESSAGE_INCLUDE,
    });

    return {
      ...message,
      imageUrl: image ? this.s3.getPublicUrl(image.objectKey) : null,
    };
  }

  async createMessageAsUi(
    tripId: string,
    userId: string,
    content: string,
    options: {
      messageType?: TRIP_MESSAGE_TYPE;
      caption?: string;
      locationLabel?: string;
    } = {},
  ): Promise<TripChatMessageDto> {
    const messageType = options.messageType ?? TRIP_MESSAGE_TYPE.TEXT;
    if (
      messageType !== TRIP_MESSAGE_TYPE.TEXT &&
      messageType !== TRIP_MESSAGE_TYPE.IMAGE
    ) {
      throw new BadRequestException('Clients may only send TEXT or IMAGE');
    }

    const metadata =
      messageType === TRIP_MESSAGE_TYPE.IMAGE
        ? {
            caption: options.caption?.trim() || null,
            locationLabel: options.locationLabel?.trim() || null,
          }
        : null;

    const created = await this.createMessage(tripId, userId, content, {
      messageType,
      metadata,
    });

    return this.mapStoredMessageToUi(created, userId, []);
  }

  /** Used by expense / itinerary hooks inside an existing transaction. */
  async createAutoMessage(
    tx: DbClient,
    input: {
      tripId: string;
      senderMemberId: string;
      content: string;
      messageType: TRIP_MESSAGE_TYPE;
      metadata: Prisma.InputJsonValue;
    },
  ) {
    return tx.tripMessage.create({
      data: {
        tripId: input.tripId,
        senderId: input.senderMemberId,
        content: input.content,
        messageType: input.messageType,
        metadata: input.metadata,
      },
      include: MESSAGE_INCLUDE,
    });
  }

  // =========================================================
  // CHAT THREAD (UI aggregate)
  // =========================================================

  async getChatThread(
    tripId: string,
    userId: string,
    limit = 50,
  ): Promise<TripChatThreadDto> {
    await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'READ_MESSAGES',
    );

    const trip = await this.prisma.trip.findUnique({
      where: { id: tripId },
      select: {
        id: true,
        name: true,
        members: {
          where: { status: MEMBER_STATUS.ACTIVE },
          select: {
            id: true,
            userId: true,
            role: true,
            user: {
              select: {
                id: true,
                displayname: true,
                username: true,
                avatar: { select: MEDIA_URL_SELECT },
              },
            },
          },
        },
      },
    });
    if (!trip) throw new NotFoundException('Trip not found');

    const safeLimit = Math.min(Math.max(limit, 1), 100);
    const [messagesDesc, nextActivity, reads] = await Promise.all([
      this.prisma.tripMessage.findMany({
        where: { tripId },
        take: safeLimit,
        orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
        include: MESSAGE_INCLUDE,
      }),
      this.prisma.itineraryItem.findFirst({
        where: { tripId, startTime: { gt: new Date() } },
        orderBy: [{ startTime: 'asc' }, { id: 'asc' }],
        select: { id: true, title: true, startTime: true },
      }),
      this.prisma.tripMessageRead.findMany({
        where: { tripId },
        select: { userId: true, lastReadAt: true },
      }),
    ]);

    const messages = [...messagesDesc].reverse();
    const imageUrls = await this.resolveImageUrls(messages);

    const onlineUserIds = await this.loadOnlineUserIds(tripId);
    const onlineNames = trip.members
      .filter((member) => onlineUserIds.has(member.userId))
      .map(
        (member) =>
          member.user.displayname?.trim() ||
          member.user.username ||
          'Thành viên',
      );

    const otherMembers = trip.members.filter(
      (member) => member.userId !== userId,
    );
    const readByUserId = new Map(
      reads.map((row) => [row.userId, row.lastReadAt] as const),
    );
    const otherMembersLastReadAt = otherMembers.map(
      (member) => readByUserId.get(member.userId) ?? null,
    );

    const uiMessages = messages.map((message, index) => {
      const previous = index > 0 ? messages[index - 1] : null;
      const showAvatar =
        message.messageType === TRIP_MESSAGE_TYPE.SYSTEM
          ? false
          : !previous ||
            previous.senderId !== message.senderId ||
            previous.messageType === TRIP_MESSAGE_TYPE.SYSTEM;

      return this.mapStoredMessageToUi(
        {
          ...message,
          imageUrl: imageUrls.get(message.id) ?? null,
        },
        userId,
        otherMembersLastReadAt,
        showAvatar,
      );
    });

    await this.prisma.tripMessageRead.upsert({
      where: { userId_tripId: { userId, tripId } },
      create: { userId, tripId, lastReadAt: new Date() },
      update: { lastReadAt: new Date() },
    });

    const latest = messages.length > 0 ? messages[messages.length - 1] : null;

    return {
      tripId: trip.id,
      title: trip.name,
      memberSummaryLabel: buildMemberSummaryLabel({
        memberCount: trip.members.length,
        onlineNames,
      }),
      isLive: onlineUserIds.size > 0,
      pinnedActivity: mapPinnedActivity(
        nextActivity?.startTime
          ? {
              id: nextActivity.id,
              title: nextActivity.title,
              startTime: nextActivity.startTime,
            }
          : null,
      ),
      dateLabel: formatDateLabel(latest?.createdAt ?? new Date()),
      messages: uiMessages,
      isSomeoneTyping: false,
      typingLabel: null,
      typingAvatarUrl: null,
      utilities: TRIP_CHAT_UTILITIES,
    };
  }

  // =========================================================
  // GET MESSAGE HISTORY (legacy cursor)
  // =========================================================

  async getMessages(
    tripId: string,
    userId: string,
    limit = 50,
    cursor?: string,
  ) {
    await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'READ_MESSAGES',
    );

    if (cursor) {
      const cursorMessage = await this.prisma.tripMessage.findFirst({
        where: { id: cursor, tripId },
        select: { id: true },
      });
      if (!cursorMessage) {
        throw new BadRequestException('Invalid cursor for this trip');
      }
    }

    const safeLimit = Math.min(Math.max(limit, 1), 100);

    const messages = await this.prisma.tripMessage.findMany({
      where: { tripId },
      take: safeLimit + 1,
      ...(cursor
        ? {
            cursor: { id: cursor },
            skip: 1,
          }
        : {}),
      orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
      include: MESSAGE_INCLUDE,
    });

    const hasMore = messages.length > safeLimit;
    if (hasMore) messages.pop();

    const nextCursor =
      hasMore && messages.length > 0 ? messages[messages.length - 1].id : null;

    const imageUrls = await this.resolveImageUrls(messages);

    await this.prisma.tripMessageRead.upsert({
      where: { userId_tripId: { userId, tripId } },
      create: { userId, tripId, lastReadAt: new Date() },
      update: { lastReadAt: new Date() },
    });

    return {
      data: messages.reverse().map((message) => ({
        ...message,
        imageUrl: imageUrls.get(message.id) ?? null,
      })),
      meta: {
        nextCursor,
        hasMore,
      },
    };
  }

  async markTripMessagesRead(tripId: string, userId: string) {
    await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'READ_MESSAGES',
    );

    const lastReadAt = new Date();
    await this.prisma.tripMessageRead.upsert({
      where: { userId_tripId: { userId, tripId } },
      create: { userId, tripId, lastReadAt },
      update: { lastReadAt },
    });

    return { tripId, lastReadAt };
  }

  // =========================================================
  // REACTIONS
  // =========================================================

  async addReaction(
    tripId: string,
    messageId: string,
    userId: string,
    emoji: string,
  ) {
    await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'SEND_MESSAGE',
    );
    const message = await this.requireTripMessage(tripId, messageId);

    await this.prisma.tripMessageReaction.upsert({
      where: {
        messageId_userId_emoji: { messageId, userId, emoji },
      },
      create: { messageId, userId, emoji },
      update: {},
    });

    const reactions = await this.prisma.tripMessageReaction.findMany({
      where: { messageId: message.id },
      select: { emoji: true },
    });

    return {
      messageId,
      reactions: aggregateReactions(reactions),
    };
  }

  async removeReaction(
    tripId: string,
    messageId: string,
    userId: string,
    emoji: string,
  ) {
    await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'SEND_MESSAGE',
    );
    await this.requireTripMessage(tripId, messageId);

    await this.prisma.tripMessageReaction.deleteMany({
      where: { messageId, userId, emoji },
    });

    const reactions = await this.prisma.tripMessageReaction.findMany({
      where: { messageId },
      select: { emoji: true },
    });

    return {
      messageId,
      reactions: aggregateReactions(reactions),
    };
  }

  // =========================================================
  // MAPPERS / HELPERS
  // =========================================================

  mapStoredMessageToUi(
    message: {
      id: string;
      tripId: string;
      senderId: string;
      content: string;
      messageType: TRIP_MESSAGE_TYPE;
      metadata: unknown;
      createdAt: Date;
      imageUrl?: string | null;
      sender?: {
        id: string;
        role: TRIP_ROLE;
        user: {
          id: string;
          username: string;
          displayname: string | null;
          avatar: { objectKey: string; deletedAt: Date | null } | null;
        };
      };
      reactions?: Array<{ emoji: string }>;
    },
    viewerUserId: string,
    otherMembersLastReadAt: Array<Date | null>,
    showAvatar = true,
  ): TripChatMessageDto {
    const kind = mapMessageTypeToUiKind(message.messageType);
    const isMine = message.sender?.user.id === viewerUserId;
    const metadata = parseMessageMetadata(message.metadata);
    const role = message.sender
      ? mapTripRoleToSenderBadge(message.sender.role)
      : null;

    const sender = message.sender
      ? {
          userId: message.sender.user.id,
          displayName:
            message.sender.user.displayname?.trim() ||
            message.sender.user.username,
          avatarUrl: this.toPublicUrl(message.sender.user.avatar),
          roleBadge: role?.roleBadge ?? null,
          roleTone: role?.roleTone ?? 'MEMBER',
          isLeader: role?.isLeader ?? false,
        }
      : null;

    return {
      id: message.id,
      kind,
      isMine,
      text:
        kind === 'TEXT'
          ? message.content
          : kind === 'PHOTO'
            ? null
            : kind === 'SYSTEM'
              ? null
              : null,
      timeLabel: formatTimeLabel(message.createdAt),
      readStatus: resolveReadStatus({
        isMine,
        createdAt: message.createdAt,
        otherMembersLastReadAt,
      }),
      showAvatar: kind === 'SYSTEM' ? false : showAvatar,
      sender: kind === 'SYSTEM' ? null : sender,
      system:
        kind === 'SYSTEM'
          ? {
              icon: metadata?.icon || 'info',
              richText: metadata?.richText || message.content,
            }
          : null,
      photo:
        kind === 'PHOTO'
          ? {
              imageUrl: message.imageUrl || '',
              caption: metadata?.caption ?? null,
              locationLabel: metadata?.locationLabel ?? null,
              reactions: aggregateReactions(message.reactions ?? []),
            }
          : null,
      expense:
        kind === 'EXPENSE'
          ? {
              expenseId: metadata?.expenseId || message.content,
              title: metadata?.title || 'Khoản chi mới được tạo',
              subtitle: metadata?.subtitle || message.content,
              amountLabel: metadata?.amountLabel || '',
              splitLabel: metadata?.splitLabel || '',
              perPersonLabel: metadata?.perPersonLabel || '',
              actionLabel: metadata?.actionLabel || 'Xem chi tiết chi tiêu',
            }
          : null,
    };
  }

  private buildImageMetadata(
    metadata: Prisma.InputJsonValue | null | undefined,
  ): Prisma.InputJsonValue | null {
    if (!metadata || typeof metadata !== 'object' || Array.isArray(metadata)) {
      return null;
    }
    const raw = metadata as Record<string, unknown>;
    return {
      caption: typeof raw.caption === 'string' ? raw.caption : null,
      locationLabel:
        typeof raw.locationLabel === 'string' ? raw.locationLabel : null,
    };
  }

  private async requireTripMessage(tripId: string, messageId: string) {
    const message = await this.prisma.tripMessage.findFirst({
      where: { id: messageId, tripId },
      select: { id: true, tripId: true },
    });
    if (!message) throw new NotFoundException('Message not found');
    return message;
  }

  private async loadOnlineUserIds(tripId: string): Promise<Set<string>> {
    try {
      return await this.tripGateway.getOnlineUserIds(tripId);
    } catch (error) {
      this.logger.warn(
        `Failed to read presence for trip ${tripId}: ${
          error instanceof Error ? error.message : 'unknown error'
        }`,
      );
      return new Set();
    }
  }

  private toPublicUrl(
    media: { objectKey: string; deletedAt: Date | null } | null | undefined,
  ): string | null {
    if (!media || media.deletedAt) return null;
    return this.s3.getPublicUrl(media.objectKey);
  }

  private async resolveImageUrls(
    messages: Array<{
      id: string;
      content: string;
      messageType: TRIP_MESSAGE_TYPE;
    }>,
  ): Promise<Map<string, string>> {
    const imageMessages = messages.filter(
      (message) => message.messageType === TRIP_MESSAGE_TYPE.IMAGE,
    );
    if (imageMessages.length === 0) return new Map();

    const media = await this.prisma.uploadedMedia.findMany({
      where: {
        id: { in: [...new Set(imageMessages.map((m) => m.content))] },
        deletedAt: null,
      },
      select: { id: true, objectKey: true },
    });
    const keyById = new Map(media.map((item) => [item.id, item.objectKey]));

    const urls = new Map<string, string>();
    for (const message of imageMessages) {
      const objectKey = keyById.get(message.content);
      if (objectKey) urls.set(message.id, this.s3.getPublicUrl(objectKey));
    }
    return urls;
  }
}

import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { PrismaService } from '../../prisma.service';
import { S3Service } from '../../uploads/s3/s3.service';
import { TripGateway } from '../../websocket/gateway';
import {
  FRIEND_REQUEST_STATUS,
  MEMBER_STATUS,
  TRIP_ROLE,
  TRIP_STATUS,
} from '../../generated/prisma/enums';
import { Prisma } from '../../generated/prisma/client';
import {
  dnaSimilarity,
  topTravelPersona,
  type TravelDnaScore,
} from '../trips/trip-relations/trip-join-requests/join-request-match';
import { TRAVEL_DNA_CONFIG } from '../travelDNA/travel.constant';
import {
  FriendChatInviteCandidateResponseDto,
  FriendChatMessageUiResponseDto,
  FriendChatPlaceCardResponseDto,
  FriendChatShortcutResponseDto,
  FriendChatThreadResponseDto,
  FriendChatTripInviteCardResponseDto,
} from './dto/friend-chat-thread-response.dto';
import {
  FRIEND_CHAT_MESSAGE_TYPES,
  FriendChatMessageType,
} from './dto/send-messsage.dto';
import type {
  FriendUserResponseDto,
  FriendshipResponseDto,
  ReceivedFriendRequestResponseDto,
  SentFriendRequestResponseDto,
} from '../../common/contracts/extended-response.dto';

const MEDIA_URL_SELECT = {
  objectKey: true,
  deletedAt: true,
} satisfies Prisma.UploadedMediaSelect;

type MediaUrlSource = { objectKey: string; deletedAt: Date | null } | null;

const FRIEND_CHAT_SHORTCUTS: FriendChatShortcutResponseDto[] = [
  { kind: 'INVITE_TRIP', label: 'Mời vào chuyến đi', emphasized: true },
  { kind: 'SEND_LOCATION', label: '📍 Gửi vị trí GPS', emphasized: false },
  { kind: 'SPLIT_BILL', label: '💸 Chia tiền', emphasized: false },
  {
    kind: 'SUGGEST_ITINERARY',
    label: '🗓️ Gợi ý lịch trình',
    emphasized: false,
  },
  { kind: 'SEND_PHOTO', label: '📸 Gửi ảnh HD', emphasized: false },
];

@Injectable()
export class FriendService {
  private readonly logger = new Logger(FriendService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
    private readonly tripGateway: TripGateway,
  ) {}

  // =========================================================
  // USER
  // =========================================================

  private async ensureUserExists(userId: string) {
    const user = await this.prisma.user.findUnique({
      where: {
        id: userId,
      },
    });

    if (!user) {
      throw new NotFoundException('User not found');
    }

    return user;
  }

  // =========================================================
  // FRIENDSHIP CHECK
  // =========================================================

  async areFriends(userId: string, otherUserId: string) {
    const friendship = await this.prisma.friendship.findFirst({
      where: {
        OR: [
          {
            userId,
            friendId: otherUserId,
          },
          {
            userId: otherUserId,
            friendId: userId,
          },
        ],
      },
    });

    return !!friendship;
  }

  // =========================================================
  // SEND FRIEND REQUEST
  // =========================================================

  async sendFriendRequest(fromUserId: string, toUserId: string) {
    if (fromUserId === toUserId) {
      throw new BadRequestException(
        'You cannot send a friend request to yourself',
      );
    }

    await this.ensureUserExists(toUserId);

    // Already friends
    const alreadyFriends = await this.areFriends(fromUserId, toUserId);

    if (alreadyFriends) {
      throw new BadRequestException('You are already friends');
    }

    // Check request sent by current user
    const existingRequest = await this.prisma.friendRequest.findUnique({
      where: {
        fromUserId_toUserId: {
          fromUserId,
          toUserId,
        },
      },
    });

    if (existingRequest) {
      if (existingRequest.status === FRIEND_REQUEST_STATUS.PENDING) {
        throw new BadRequestException('Friend request already sent');
      }

      if (existingRequest.status === FRIEND_REQUEST_STATUS.REJECTED) {
        return this.prisma.friendRequest.update({
          where: {
            id: existingRequest.id,
          },
          data: {
            status: FRIEND_REQUEST_STATUS.PENDING,
          },
        });
      }
    }

    // Check reverse request
    const reverseRequest = await this.prisma.friendRequest.findUnique({
      where: {
        fromUserId_toUserId: {
          fromUserId: toUserId,
          toUserId: fromUserId,
        },
      },
    });

    if (
      reverseRequest &&
      reverseRequest.status === FRIEND_REQUEST_STATUS.PENDING
    ) {
      throw new BadRequestException(
        'This user has already sent you a friend request. Accept it instead.',
      );
    }

    return this.prisma.friendRequest.create({
      data: {
        fromUserId,
        toUserId,
        status: FRIEND_REQUEST_STATUS.PENDING,
      },
    });
  }

  // =========================================================
  // GET RECEIVED REQUESTS
  // =========================================================

  async getReceivedRequests(
    userId: string,
  ): Promise<ReceivedFriendRequestResponseDto[]> {
    const rows = await this.prisma.friendRequest.findMany({
      where: {
        toUserId: userId,
        status: FRIEND_REQUEST_STATUS.PENDING,
      },
      include: {
        fromUser: {
          select: {
            id: true,
            username: true,
            displayname: true,
            isVerified: true,
            avatarId: true,
            avatar: { select: MEDIA_URL_SELECT },
          },
        },
      },
      orderBy: {
        createdAt: 'desc',
      },
    });

    const peerIds = rows.map((row) => row.fromUser.id);
    const enrich = await this.loadHubEnrichment(userId, peerIds);

    return rows.map((row) => {
      const peerId = row.fromUser.id;
      const shared = enrich.sharedTrips.get(peerId) ?? 0;
      const dna = enrich.dnaMatch.get(peerId);
      const { metaIcon, metaLine } = this.buildRequestMeta({
        sharedTripsCount: shared,
        dnaMatchPercent: dna,
      });

      return {
        id: row.id,
        fromUserId: row.fromUserId,
        toUserId: row.toUserId,
        status: row.status,
        createdAt: row.createdAt.toISOString(),
        updatedAt: row.updatedAt.toISOString(),
        fromUser: this.mapHubUser(row.fromUser, {
          isOnline: enrich.online.has(peerId),
          metaIcon,
          metaLine,
          badgeLabel: dna != null && dna >= 70 ? `${dna}% DNA Match` : null,
          badgeTone:
            dna != null && dna >= 70 ? ('SECONDARY' as const) : null,
        }),
      };
    });
  }

  // =========================================================
  // GET SENT REQUESTS
  // =========================================================

  async getSentRequests(
    userId: string,
  ): Promise<SentFriendRequestResponseDto[]> {
    const rows = await this.prisma.friendRequest.findMany({
      where: {
        fromUserId: userId,
        status: FRIEND_REQUEST_STATUS.PENDING,
      },
      include: {
        toUser: {
          select: {
            id: true,
            username: true,
            displayname: true,
            isVerified: true,
            avatarId: true,
            avatar: { select: MEDIA_URL_SELECT },
          },
        },
      },
      orderBy: {
        createdAt: 'desc',
      },
    });

    const peerIds = rows.map((row) => row.toUser.id);
    const enrich = await this.loadHubEnrichment(userId, peerIds);

    return rows.map((row) => {
      const peerId = row.toUser.id;
      const shared = enrich.sharedTrips.get(peerId) ?? 0;
      const dna = enrich.dnaMatch.get(peerId);
      const { metaIcon, metaLine } = this.buildRequestMeta({
        sharedTripsCount: shared,
        dnaMatchPercent: dna,
      });

      return {
        id: row.id,
        fromUserId: row.fromUserId,
        toUserId: row.toUserId,
        status: row.status,
        createdAt: row.createdAt.toISOString(),
        updatedAt: row.updatedAt.toISOString(),
        toUser: this.mapHubUser(row.toUser, {
          isOnline: enrich.online.has(peerId),
          metaIcon,
          metaLine,
          badgeLabel: dna != null && dna >= 70 ? `${dna}% DNA Match` : null,
          badgeTone:
            dna != null && dna >= 70 ? ('SECONDARY' as const) : null,
        }),
      };
    });
  }

  // =========================================================
  // ACCEPT
  // =========================================================

  async acceptFriendRequest(requestId: string, userId: string) {
    const request = await this.prisma.friendRequest.findUnique({
      where: {
        id: requestId,
      },
    });

    if (!request) {
      throw new NotFoundException('Friend request not found');
    }

    if (request.toUserId !== userId) {
      throw new ForbiddenException('You cannot accept this request');
    }

    if (request.status !== FRIEND_REQUEST_STATUS.PENDING) {
      throw new BadRequestException('This request is no longer pending');
    }

    return this.prisma.$transaction(async (tx) => {
      // Update request
      const updatedRequest = await tx.friendRequest.update({
        where: {
          id: requestId,
        },
        data: {
          status: FRIEND_REQUEST_STATUS.ACCEPTED,
        },
      });

      // Create friendship A -> B
      await tx.friendship.create({
        data: {
          userId: request.fromUserId,
          friendId: request.toUserId,
        },
      });

      // Create friendship B -> A
      await tx.friendship.create({
        data: {
          userId: request.toUserId,
          friendId: request.fromUserId,
        },
      });

      return updatedRequest;
    });
  }

  // =========================================================
  // REJECT
  // =========================================================

  async rejectFriendRequest(requestId: string, userId: string) {
    const request = await this.prisma.friendRequest.findUnique({
      where: {
        id: requestId,
      },
    });

    if (!request) {
      throw new NotFoundException('Friend request not found');
    }

    if (request.toUserId !== userId) {
      throw new ForbiddenException('You cannot reject this request');
    }

    if (request.status !== FRIEND_REQUEST_STATUS.PENDING) {
      throw new BadRequestException('This request is no longer pending');
    }

    return this.prisma.friendRequest.update({
      where: {
        id: requestId,
      },
      data: {
        status: FRIEND_REQUEST_STATUS.REJECTED,
      },
    });
  }

  // =========================================================
  // CANCEL
  // =========================================================

  async cancelFriendRequest(requestId: string, userId: string) {
    const request = await this.prisma.friendRequest.findUnique({
      where: {
        id: requestId,
      },
    });

    if (!request) {
      throw new NotFoundException('Friend request not found');
    }

    if (request.fromUserId !== userId) {
      throw new ForbiddenException('You cannot cancel this request');
    }

    if (request.status !== FRIEND_REQUEST_STATUS.PENDING) {
      throw new BadRequestException('This request is no longer pending');
    }

    return this.prisma.friendRequest.delete({
      where: {
        id: requestId,
      },
    });
  }

  // =========================================================
  // GET FRIENDS
  // =========================================================

  async getFriends(userId: string): Promise<FriendshipResponseDto[]> {
    const rows = await this.prisma.friendship.findMany({
      where: {
        userId,
      },
      include: {
        friend: {
          select: {
            id: true,
            username: true,
            displayname: true,
            isVerified: true,
            avatarId: true,
            avatar: { select: MEDIA_URL_SELECT },
          },
        },
      },
      orderBy: {
        createdAt: 'desc',
      },
    });

    const peerIds = rows.map((row) => row.friend.id);
    const enrich = await this.loadHubEnrichment(userId, peerIds);
    const conversations = await this.loadConversationIds(userId, peerIds);

    return rows.map((row) => {
      const peerId = row.friend.id;
      const shared = enrich.sharedTrips.get(peerId) ?? 0;
      const dna = enrich.dnaMatch.get(peerId);
      const persona = enrich.persona.get(peerId);
      const mutual = enrich.mutualFriends.get(peerId) ?? 0;
      const ui = this.buildFriendUi({
        sharedTripsCount: shared,
        dnaMatchPercent: dna,
        travelPersona: persona,
        mutualFriends: mutual,
      });

      return {
        id: row.id,
        userId: row.userId,
        friendId: row.friendId,
        createdAt: row.createdAt.toISOString(),
        conversationId: conversations.get(peerId) ?? null,
        sharedTripsCount: shared > 0 ? shared : null,
        dnaMatchPercent: dna ?? null,
        friend: this.mapHubUser(row.friend, {
          isOnline: enrich.online.has(peerId),
          subtitle: ui.subtitle,
          metaIcon: ui.metaIcon,
          metaLine: ui.metaLine,
          badgeLabel: ui.badgeLabel,
          badgeTone: ui.badgeTone,
        }),
      };
    });
  }

  // =========================================================
  // REMOVE FRIEND
  // =========================================================

  async removeFriend(userId: string, friendId: string) {
    if (userId === friendId) {
      throw new BadRequestException('Invalid friend');
    }

    const friendship = await this.prisma.friendship.findFirst({
      where: {
        userId,
        friendId,
      },
    });

    if (!friendship) {
      throw new NotFoundException('Friendship not found');
    }

    await this.prisma.$transaction([
      this.prisma.friendship.deleteMany({
        where: {
          OR: [
            {
              userId,
              friendId,
            },
            {
              userId: friendId,
              friendId: userId,
            },
          ],
        },
      }),

      this.prisma.friendRequest.deleteMany({
        where: {
          OR: [
            {
              fromUserId: userId,
              toUserId: friendId,
            },
            {
              fromUserId: friendId,
              toUserId: userId,
            },
          ],
        },
      }),
    ]);

    return {
      success: true,
      message: 'Friend removed successfully',
    };
  }

  // =========================================================
  // FRIEND STATUS
  // =========================================================

  async getFriendStatus(userId: string, otherUserId: string) {
    if (userId === otherUserId) {
      return {
        status: 'SELF',
      };
    }

    const friends = await this.areFriends(userId, otherUserId);

    if (friends) {
      return {
        status: 'FRIENDS',
      };
    }

    const sent = await this.prisma.friendRequest.findUnique({
      where: {
        fromUserId_toUserId: {
          fromUserId: userId,
          toUserId: otherUserId,
        },
      },
    });

    if (sent?.status === FRIEND_REQUEST_STATUS.PENDING) {
      return {
        status: 'REQUEST_SENT',
        requestId: sent.id,
      };
    }

    const received = await this.prisma.friendRequest.findUnique({
      where: {
        fromUserId_toUserId: {
          fromUserId: otherUserId,
          toUserId: userId,
        },
      },
    });

    if (received?.status === FRIEND_REQUEST_STATUS.PENDING) {
      return {
        status: 'REQUEST_RECEIVED',
        requestId: received.id,
      };
    }

    return {
      status: 'NOT_FRIENDS',
    };
  }

  // =========================================================
  // GET / CREATE CONVERSATION
  // =========================================================

  async getOrCreateConversation(userId: string, otherUserId: string) {
    if (userId === otherUserId) {
      throw new BadRequestException('Cannot create conversation with yourself');
    }

    const friends = await this.areFriends(userId, otherUserId);

    if (!friends) {
      throw new ForbiddenException('You are not friends with this user');
    }

    // Always normalize order
    const [user1Id, user2Id] =
      userId < otherUserId ? [userId, otherUserId] : [otherUserId, userId];

    return this.prisma.friendConversation.upsert({
      where: {
        user1Id_user2Id: {
          user1Id,
          user2Id,
        },
      },
      create: {
        user1Id,
        user2Id,
      },
      update: {},
      include: {
        user1: {
          select: {
            id: true,
            username: true,
            avatarId: true,
          },
        },
        user2: {
          select: {
            id: true,
            username: true,
            avatarId: true,
          },
        },
      },
    });
  }

  // =========================================================
  // GET CONVERSATIONS
  // =========================================================

  async getConversations(userId: string, limit = 20, cursor?: string) {
    const safeLimit = Math.min(Math.max(limit, 1), 100);

    const conversations = await this.prisma.friendConversation.findMany({
      where: {
        OR: [{ user1Id: userId }, { user2Id: userId }],
      },

      take: safeLimit + 1,

      ...(cursor
        ? {
            cursor: {
              id: cursor,
            },
            skip: 1,
          }
        : {}),

      include: {
        user1: {
          select: {
            id: true,
            username: true,
            avatarId: true,
          },
        },

        user2: {
          select: {
            id: true,
            username: true,
            avatarId: true,
          },
        },

        messages: {
          take: 1,
          orderBy: {
            createdAt: 'desc',
          },
          select: {
            id: true,
            content: true,
            senderId: true,
            createdAt: true,
          },
        },
      },

      orderBy: [
        {
          createdAt: 'desc',
        },
        {
          id: 'desc',
        },
      ],
    });

    const hasMore = conversations.length > safeLimit;

    if (hasMore) {
      conversations.pop();
    }

    const nextCursor =
      hasMore && conversations.length > 0
        ? conversations[conversations.length - 1].id
        : null;

    const data = conversations.map((conversation) => {
      const { messages, ...rest } = conversation;

      return {
        ...rest,
        lastMessage: messages[0] ?? null,
      };
    });

    return {
      data,
      meta: {
        nextCursor,
        hasMore,
      },
    };
  }

  // =========================================================
  // THREAD (UI aggregate for friend-chat screen)
  // =========================================================

  async getThread(
    conversationId: string,
    userId: string,
  ): Promise<FriendChatThreadResponseDto> {
    const conversation = await this.prisma.friendConversation.findUnique({
      where: { id: conversationId },
      include: {
        user1: {
          select: {
            id: true,
            displayname: true,
            avatar: { select: MEDIA_URL_SELECT },
          },
        },
        user2: {
          select: {
            id: true,
            displayname: true,
            avatar: { select: MEDIA_URL_SELECT },
          },
        },
      },
    });

    if (!conversation) {
      throw new NotFoundException('Conversation not found');
    }

    const isMember =
      conversation.user1Id === userId || conversation.user2Id === userId;
    if (!isMember) {
      throw new NotFoundException('Conversation not found');
    }

    const peer =
      conversation.user1Id === userId ? conversation.user2 : conversation.user1;

    const [messages, peerRead, sharedTripStats, isPeerOnline, isPeerOwner, inviteCandidates] =
      await Promise.all([
        this.prisma.friendMessage.findMany({
          where: { conversationId },
          orderBy: [{ createdAt: 'asc' }, { id: 'asc' }],
          take: 100,
        }),
        this.prisma.friendConversationRead.findUnique({
          where: {
            userId_conversationId: {
              userId: peer.id,
              conversationId,
            },
          },
          select: { lastReadAt: true },
        }),
        this.buildSharedTripContext(userId, peer.id),
        this.isUserOnline(peer.id),
        this.isPeerOwnerOnSharedTrip(userId, peer.id),
        this.buildInviteCandidates(userId),
      ]);

    // Opening the thread marks it read for the viewer.
    await this.prisma.friendConversationRead.upsert({
      where: {
        userId_conversationId: {
          userId,
          conversationId,
        },
      },
      create: {
        userId,
        conversationId,
        lastReadAt: new Date(),
      },
      update: {
        lastReadAt: new Date(),
      },
    });

    const uiMessages = this.toUiMessages(
      messages,
      userId,
      peerRead?.lastReadAt ?? null,
    );

    const sharedCount = sharedTripStats.count;
    const presenceLabel = isPeerOnline ? 'Đang hoạt động' : 'Ngoại tuyến';

    return {
      conversationId,
      peer: {
        userId: peer.id,
        displayName: peer.displayname,
        avatarUrl: this.toPublicUrl(peer.avatar),
        roleBadge: isPeerOwner ? 'Trưởng nhóm' : null,
        isOnline: isPeerOnline,
        presenceLabel,
        sharedTripsLabel:
          sharedCount > 0 ? `${sharedCount} chuyến chung` : null,
      },
      sharedTrip: sharedTripStats.sharedTrip,
      dateLabel: this.formatDateLabel(
        messages.length > 0
          ? messages[messages.length - 1].createdAt
          : conversation.createdAt,
      ),
      messages: uiMessages,
      isPeerTyping: false,
      typingLabel: null,
      shortcuts: FRIEND_CHAT_SHORTCUTS,
      inviteCandidates,
    };
  }

  // =========================================================
  // SEND MESSAGE
  // =========================================================

  async sendMessage(
    conversationId: string,
    senderId: string,
    content: string,
    messageType: string = 'TEXT',
    metadata?: Record<string, unknown> | null,
  ) {
    await this.assertConversationMember(conversationId, senderId);

    const kind = this.normalizeMessageType(messageType);
    const normalizedContent = (content ?? '').trim();
    const normalizedMetadata = this.normalizeMetadata(kind, metadata);

    if (kind === 'TEXT' && !normalizedContent) {
      throw new BadRequestException('Message content is required');
    }

    if (
      (kind === 'PLACE_CARD' || kind === 'TRIP_INVITE') &&
      !normalizedMetadata
    ) {
      throw new BadRequestException(
        `metadata is required for messageType ${kind}`,
      );
    }

    return this.prisma.friendMessage.create({
      data: {
        conversationId,
        senderId,
        content: normalizedContent,
        messageType: kind,
        metadata:
          normalizedMetadata === null
            ? Prisma.JsonNull
            : (normalizedMetadata as Prisma.InputJsonValue),
      },
      include: {
        sender: {
          select: {
            id: true,
            username: true,
            avatarId: true,
          },
        },
      },
    });
  }

  async sendMessageAsUi(
    conversationId: string,
    senderId: string,
    content: string,
    messageType: string = 'TEXT',
    metadata?: Record<string, unknown> | null,
  ): Promise<FriendChatMessageUiResponseDto> {
    const created = await this.sendMessage(
      conversationId,
      senderId,
      content,
      messageType,
      metadata,
    );

    const conversation = await this.prisma.friendConversation.findUniqueOrThrow(
      {
        where: { id: conversationId },
        select: { user1Id: true, user2Id: true },
      },
    );
    const peerId =
      conversation.user1Id === senderId
        ? conversation.user2Id
        : conversation.user1Id;

    const peerRead = await this.prisma.friendConversationRead.findUnique({
      where: {
        userId_conversationId: {
          userId: peerId,
          conversationId,
        },
      },
      select: { lastReadAt: true },
    });

    return this.toUiMessage(
      created,
      senderId,
      peerRead?.lastReadAt ?? null,
      true,
    );
  }

  // =========================================================
  // MARK CONVERSATION READ
  // =========================================================

  async markConversationRead(conversationId: string, userId: string) {
    await this.assertConversationMember(conversationId, userId);

    await this.prisma.friendConversationRead.upsert({
      where: {
        userId_conversationId: {
          userId,
          conversationId,
        },
      },
      create: {
        userId,
        conversationId,
        lastReadAt: new Date(),
      },
      update: {
        lastReadAt: new Date(),
      },
    });

    return {
      conversationId,
      lastReadAt: new Date(),
    };
  }

  // =========================================================
  // GET MESSAGES
  // =========================================================

  async getMessages(
    conversationId: string,
    userId: string,
    limit = 50,
    cursor?: string,
  ) {
    await this.assertConversationMember(conversationId, userId);

    const safeLimit = Math.min(Math.max(limit, 1), 100);

    const messages = await this.prisma.friendMessage.findMany({
      where: {
        conversationId,
      },

      take: safeLimit + 1,

      ...(cursor
        ? {
            cursor: {
              id: cursor,
            },
            skip: 1,
          }
        : {}),

      include: {
        sender: {
          select: {
            id: true,
            username: true,
            avatarId: true,
          },
        },
      },

      orderBy: [
        {
          createdAt: 'desc',
        },
        {
          id: 'desc',
        },
      ],
    });

    const hasMore = messages.length > safeLimit;

    if (hasMore) {
      messages.pop();
    }

    const nextCursor =
      hasMore && messages.length > 0 ? messages[messages.length - 1].id : null;

    // Opening the thread marks it read (hub unread can clear).
    await this.prisma.friendConversationRead.upsert({
      where: {
        userId_conversationId: {
          userId,
          conversationId,
        },
      },
      create: {
        userId,
        conversationId,
        lastReadAt: new Date(),
      },
      update: {
        lastReadAt: new Date(),
      },
    });

    return {
      data: messages.reverse(),
      meta: {
        nextCursor,
        hasMore,
      },
    };
  }

  private async assertConversationMember(
    conversationId: string,
    userId: string,
  ) {
    const conversation = await this.prisma.friendConversation.findUnique({
      where: {
        id: conversationId,
      },
    });

    if (!conversation) {
      throw new NotFoundException('Conversation not found');
    }

    const isMember =
      conversation.user1Id === userId || conversation.user2Id === userId;

    if (!isMember) {
      throw new NotFoundException('Conversation not found');
    }

    return conversation;
  }

  private normalizeMessageType(messageType?: string): FriendChatMessageType {
    const value = (messageType ?? 'TEXT').toUpperCase();
    if (
      !(FRIEND_CHAT_MESSAGE_TYPES as readonly string[]).includes(value)
    ) {
      throw new BadRequestException(
        `messageType must be one of ${FRIEND_CHAT_MESSAGE_TYPES.join(', ')}`,
      );
    }
    return value as FriendChatMessageType;
  }

  private normalizeMetadata(
    kind: FriendChatMessageType,
    metadata?: Record<string, unknown> | null,
  ): Record<string, unknown> | null {
    if (kind === 'TEXT') {
      return metadata && Object.keys(metadata).length > 0 ? metadata : null;
    }
    if (!metadata || typeof metadata !== 'object') {
      return null;
    }
    if (kind === 'PLACE_CARD') {
      this.assertPlaceCardMetadata(metadata);
    }
    if (kind === 'TRIP_INVITE') {
      this.assertTripInviteMetadata(metadata);
    }
    return metadata;
  }

  private assertPlaceCardMetadata(metadata: Record<string, unknown>) {
    for (const key of ['placeId', 'name', 'address', 'imageUrl'] as const) {
      if (typeof metadata[key] !== 'string' || !metadata[key]) {
        throw new BadRequestException(
          `metadata.${key} is required for PLACE_CARD`,
        );
      }
    }
    if (typeof metadata.rating !== 'number') {
      throw new BadRequestException('metadata.rating must be a number');
    }
    if (typeof metadata.reviewCount !== 'number') {
      throw new BadRequestException('metadata.reviewCount must be a number');
    }
  }

  private assertTripInviteMetadata(metadata: Record<string, unknown>) {
    for (const key of [
      'tripId',
      'title',
      'imageUrl',
      'dateLabel',
      'priceLabel',
      'seatsLabel',
    ] as const) {
      if (typeof metadata[key] !== 'string' || !metadata[key]) {
        throw new BadRequestException(
          `metadata.${key} is required for TRIP_INVITE`,
        );
      }
    }
  }

  private toUiMessages(
    messages: Array<{
      id: string;
      senderId: string;
      content: string;
      messageType: string;
      metadata: Prisma.JsonValue;
      createdAt: Date;
    }>,
    viewerId: string,
    peerLastReadAt: Date | null,
  ): FriendChatMessageUiResponseDto[] {
    return messages.map((message, index) => {
      const previous = index > 0 ? messages[index - 1] : null;
      const showAvatar =
        !this.isMine(message.senderId, viewerId) &&
        (!previous || previous.senderId !== message.senderId);
      return this.toUiMessage(message, viewerId, peerLastReadAt, showAvatar);
    });
  }

  private toUiMessage(
    message: {
      id: string;
      senderId: string;
      content: string;
      messageType: string;
      metadata: Prisma.JsonValue;
      createdAt: Date;
    },
    viewerId: string,
    peerLastReadAt: Date | null,
    showAvatar: boolean,
  ): FriendChatMessageUiResponseDto {
    const kind = this.normalizeMessageType(message.messageType);
    const isMine = this.isMine(message.senderId, viewerId);
    const meta =
      message.metadata && typeof message.metadata === 'object'
        ? (message.metadata as Record<string, unknown>)
        : null;

    return {
      id: message.id,
      kind,
      isMine,
      text: message.content || null,
      timeLabel: this.formatClockLabel(message.createdAt),
      readStatus: isMine
        ? this.resolveReadStatus(message.createdAt, peerLastReadAt)
        : null,
      showAvatar: isMine ? false : showAvatar,
      placeCard:
        kind === 'PLACE_CARD' && meta ? this.mapPlaceCard(meta) : null,
      tripInvite:
        kind === 'TRIP_INVITE' && meta ? this.mapTripInvite(meta) : null,
    };
  }

  private mapPlaceCard(
    meta: Record<string, unknown>,
  ): FriendChatPlaceCardResponseDto {
    return {
      placeId: String(meta.placeId ?? ''),
      name: String(meta.name ?? ''),
      address: String(meta.address ?? ''),
      imageUrl: String(meta.imageUrl ?? ''),
      rating: Number(meta.rating ?? 0),
      reviewCount: Number(meta.reviewCount ?? 0),
      badgeLabel:
        typeof meta.badgeLabel === 'string' ? meta.badgeLabel : null,
      footerLabel:
        typeof meta.footerLabel === 'string' ? meta.footerLabel : null,
      actionLabel:
        typeof meta.actionLabel === 'string' ? meta.actionLabel : null,
    };
  }

  private mapTripInvite(
    meta: Record<string, unknown>,
  ): FriendChatTripInviteCardResponseDto {
    return {
      tripId: String(meta.tripId ?? ''),
      title: String(meta.title ?? ''),
      imageUrl: String(meta.imageUrl ?? ''),
      dateLabel: String(meta.dateLabel ?? ''),
      priceLabel: String(meta.priceLabel ?? ''),
      seatsLabel: String(meta.seatsLabel ?? ''),
      badgeLabel:
        typeof meta.badgeLabel === 'string' ? meta.badgeLabel : null,
      primaryActionLabel:
        typeof meta.primaryActionLabel === 'string'
          ? meta.primaryActionLabel
          : null,
      secondaryActionLabel:
        typeof meta.secondaryActionLabel === 'string'
          ? meta.secondaryActionLabel
          : null,
    };
  }

  private resolveReadStatus(
    createdAt: Date,
    peerLastReadAt: Date | null,
  ): 'SENT' | 'DELIVERED' | 'READ' {
    if (peerLastReadAt && peerLastReadAt.getTime() >= createdAt.getTime()) {
      return 'READ';
    }
    return 'DELIVERED';
  }

  private isMine(senderId: string, viewerId: string) {
    return senderId === viewerId;
  }

  private async buildSharedTripContext(userId: string, peerId: string) {
    const myTripIds = (
      await this.prisma.tripMember.findMany({
        where: { userId, status: MEMBER_STATUS.ACTIVE },
        select: { tripId: true },
      })
    ).map((m) => m.tripId);

    if (myTripIds.length === 0) {
      return { count: 0, sharedTrip: null };
    }

    const sharedMemberships = await this.prisma.tripMember.findMany({
      where: {
        userId: peerId,
        status: MEMBER_STATUS.ACTIVE,
        tripId: { in: myTripIds },
        trip: {
          status: {
            in: [
              TRIP_STATUS.UPCOMING,
              TRIP_STATUS.ONGOING,
              TRIP_STATUS.COMPLETED,
            ],
          },
        },
      },
      select: {
        trip: {
          select: {
            id: true,
            name: true,
            status: true,
            destinations: {
              orderBy: { order: 'asc' },
              take: 1,
              select: { city: true },
            },
          },
        },
      },
      orderBy: { joinedAt: 'desc' },
    });

    const count = sharedMemberships.length;
    const preferred =
      sharedMemberships.find((m) => m.trip.status === TRIP_STATUS.ONGOING) ??
      sharedMemberships.find((m) => m.trip.status === TRIP_STATUS.UPCOMING) ??
      sharedMemberships[0] ??
      null;

    if (!preferred) {
      return { count, sharedTrip: null };
    }

    const statusLabel =
      preferred.trip.status === TRIP_STATUS.ONGOING
        ? 'Đang diễn ra'
        : preferred.trip.status === TRIP_STATUS.COMPLETED
          ? 'Đã hoàn thành'
          : 'Sắp tới';

    return {
      count,
      sharedTrip: {
        tripId: preferred.trip.id,
        title: preferred.trip.name,
        destinationHint: preferred.trip.destinations[0]?.city ?? null,
        statusLabel,
      },
    };
  }

  private async isPeerOwnerOnSharedTrip(userId: string, peerId: string) {
    const myTripIds = (
      await this.prisma.tripMember.findMany({
        where: { userId, status: MEMBER_STATUS.ACTIVE },
        select: { tripId: true },
      })
    ).map((m) => m.tripId);

    if (myTripIds.length === 0) return false;

    const owner = await this.prisma.tripMember.findFirst({
      where: {
        tripId: { in: myTripIds },
        userId: peerId,
        status: MEMBER_STATUS.ACTIVE,
        role: TRIP_ROLE.OWNER,
      },
      select: { userId: true },
    });

    return !!owner;
  }

  private async buildInviteCandidates(
    userId: string,
  ): Promise<FriendChatInviteCandidateResponseDto[]> {
    const memberships = await this.prisma.tripMember.findMany({
      where: {
        userId,
        status: MEMBER_STATUS.ACTIVE,
        role: { in: [TRIP_ROLE.OWNER, TRIP_ROLE.ADMIN] },
        trip: {
          status: { in: [TRIP_STATUS.UPCOMING, TRIP_STATUS.ONGOING] },
        },
      },
      take: 10,
      orderBy: { joinedAt: 'desc' },
      select: {
        trip: {
          select: {
            id: true,
            name: true,
            status: true,
            startDate: true,
            endDate: true,
            maxMembers: true,
            coverMedia: { select: MEDIA_URL_SELECT },
            _count: {
              select: {
                members: { where: { status: MEMBER_STATUS.ACTIVE } },
              },
            },
          },
        },
      },
    });

    return memberships.map(({ trip }) => {
      const seatsLeft = Math.max(0, trip.maxMembers - trip._count.members);
      const metaLabel =
        trip.status === TRIP_STATUS.ONGOING
          ? `📅 Đang diễn ra • ${trip._count.members} thành viên`
          : `📅 ${this.formatDayMonth(trip.startDate)} - ${this.formatDayMonth(
              trip.endDate,
            )} • Còn ${seatsLeft} chỗ`;

      return {
        tripId: trip.id,
        title: trip.name,
        imageUrl: this.toPublicUrl(trip.coverMedia) ?? '',
        metaLabel,
        badgeLabel:
          trip.status === TRIP_STATUS.ONGOING
            ? 'Đang đi'
            : this.formatDurationBadge(trip.startDate, trip.endDate),
        actionLabel: 'Gửi thẻ',
      };
    });
  }

  private async isUserOnline(userId: string): Promise<boolean> {
    try {
      const online = await this.tripGateway.getConnectedUserIds([userId]);
      return online.has(userId);
    } catch (error) {
      this.logger.warn(
        `Failed to read presence for ${userId}: ${
          error instanceof Error ? error.message : String(error)
        }`,
      );
      return false;
    }
  }

  private formatClockLabel(date: Date): string {
    return `${String(date.getHours()).padStart(2, '0')}:${String(
      date.getMinutes(),
    ).padStart(2, '0')}`;
  }

  private formatDateLabel(date: Date, now = new Date()): string {
    const startOfToday = new Date(now);
    startOfToday.setHours(0, 0, 0, 0);
    const startOfYesterday = new Date(startOfToday);
    startOfYesterday.setDate(startOfYesterday.getDate() - 1);

    const day = date.getDate();
    const month = date.getMonth() + 1;
    const monthLabel = `Tháng ${month}`;

    if (date >= startOfToday) {
      return `Hôm nay, ${day} ${monthLabel}`;
    }
    if (date >= startOfYesterday) {
      return `Hôm qua, ${day} ${monthLabel}`;
    }
    return `${day} ${monthLabel}`;
  }

  private formatDayMonth(date: Date | null | undefined): string {
    if (!date) return '—';
    return `${String(date.getDate()).padStart(2, '0')}/${String(
      date.getMonth() + 1,
    ).padStart(2, '0')}`;
  }

  private formatDurationBadge(
    start: Date | null | undefined,
    end: Date | null | undefined,
  ): string {
    if (!start || !end) return 'Trip';
    const days =
      Math.floor(
        (end.getTime() - start.getTime()) / (24 * 60 * 60 * 1000),
      ) + 1;
    const nights = Math.max(0, days - 1);
    return `${days}N${nights}Đ`;
  }

  private toPublicUrl(media: MediaUrlSource): string | null {
    if (!media || media.deletedAt) return null;
    return this.s3.getPublicUrl(media.objectKey);
  }

  private mapHubUser(
    user: {
      id: string;
      username: string;
      displayname: string | null;
      isVerified: boolean | null;
      avatarId: string | null;
      avatar: MediaUrlSource;
    },
    extra?: {
      isOnline?: boolean;
      subtitle?: string | null;
      metaIcon?: string | null;
      metaLine?: string | null;
      badgeLabel?: string | null;
      badgeTone?: FriendUserResponseDto['badgeTone'];
    },
  ): FriendUserResponseDto {
    const displayName =
      user.displayname?.trim() || user.username || 'Người dùng';
    return {
      id: user.id,
      username: user.username,
      displayName,
      avatarId: user.avatarId,
      avatarUrl: this.toPublicUrl(user.avatar),
      isOnline: extra?.isOnline ?? false,
      verified: user.isVerified === true,
      subtitle: extra?.subtitle ?? null,
      metaIcon: extra?.metaIcon ?? null,
      metaLine: extra?.metaLine ?? null,
      badgeLabel: extra?.badgeLabel ?? null,
      badgeTone: extra?.badgeTone ?? null,
    };
  }

  private async loadHubEnrichment(
    viewerId: string,
    peerIds: string[],
  ): Promise<{
    online: Set<string>;
    sharedTrips: Map<string, number>;
    dnaMatch: Map<string, number>;
    persona: Map<string, string>;
    mutualFriends: Map<string, number>;
  }> {
    if (peerIds.length === 0) {
      return {
        online: new Set(),
        sharedTrips: new Map(),
        dnaMatch: new Map(),
        persona: new Map(),
        mutualFriends: new Map(),
      };
    }

    const [online, sharedTrips, dnaMap, mutualFriends] = await Promise.all([
      this.onlineSet(peerIds),
      this.loadSharedTripCounts(viewerId, peerIds),
      this.loadDnaMap([viewerId, ...peerIds]),
      this.loadMutualFriendCounts(viewerId, peerIds),
    ]);

    const viewerScores = dnaMap.get(viewerId) ?? [];
    const dnaMatch = new Map<string, number>();
    const persona = new Map<string, string>();

    for (const peerId of peerIds) {
      const scores = dnaMap.get(peerId) ?? [];
      const match = dnaSimilarity(viewerScores, scores);
      if (match != null) dnaMatch.set(peerId, match);
      const top = topTravelPersona(scores);
      if (top) {
        persona.set(peerId, TRAVEL_DNA_CONFIG[top.personaType].name);
      }
    }

    return { online, sharedTrips, dnaMatch, persona, mutualFriends };
  }

  private buildFriendUi(input: {
    sharedTripsCount: number;
    dnaMatchPercent?: number;
    travelPersona?: string;
    mutualFriends: number;
  }): {
    subtitle: string | null;
    metaIcon: string | null;
    metaLine: string | null;
    badgeLabel: string | null;
    badgeTone: FriendUserResponseDto['badgeTone'];
  } {
    if (input.sharedTripsCount > 0) {
      return {
        subtitle: input.travelPersona ?? null,
        metaIcon: 'connecting_airports',
        metaLine: null,
        badgeLabel: `Travel Buddy • ${input.sharedTripsCount} chuyến`,
        badgeTone: 'PRIMARY',
      };
    }
    if (input.dnaMatchPercent != null && input.dnaMatchPercent >= 70) {
      return {
        subtitle: input.travelPersona ?? null,
        metaIcon: 'psychology',
        metaLine: null,
        badgeLabel: `${input.dnaMatchPercent}% DNA Match`,
        badgeTone: 'SECONDARY',
      };
    }
    if (input.mutualFriends > 0) {
      return {
        subtitle: input.travelPersona ?? null,
        metaIcon: 'group',
        metaLine: `${input.mutualFriends} bạn chung`,
        badgeLabel: null,
        badgeTone: null,
      };
    }
    return {
      subtitle: input.travelPersona ?? null,
      metaIcon: null,
      metaLine: null,
      badgeLabel: null,
      badgeTone: null,
    };
  }

  private buildRequestMeta(input: {
    sharedTripsCount: number;
    dnaMatchPercent?: number;
  }): { metaIcon: string | null; metaLine: string | null } {
    if (input.sharedTripsCount > 0) {
      return {
        metaIcon: 'groups',
        metaLine: `Đã đi chung ${input.sharedTripsCount} chuyến`,
      };
    }
    if (input.dnaMatchPercent != null && input.dnaMatchPercent >= 70) {
      return {
        metaIcon: 'hiking',
        metaLine: `Độ hợp DNA ${input.dnaMatchPercent}%`,
      };
    }
    return { metaIcon: null, metaLine: null };
  }

  private async loadDnaMap(
    userIds: string[],
  ): Promise<Map<string, TravelDnaScore[]>> {
    if (userIds.length === 0) return new Map();
    const rows = await this.prisma.userTravelDNA.findMany({
      where: { userId: { in: userIds } },
      select: { userId: true, type: true, score: true },
    });
    const map = new Map<string, TravelDnaScore[]>();
    for (const row of rows) {
      const list = map.get(row.userId) ?? [];
      list.push({ type: row.type, score: row.score });
      map.set(row.userId, list);
    }
    return map;
  }

  private async loadSharedTripCounts(
    viewerId: string,
    userIds: string[],
  ): Promise<Map<string, number>> {
    const map = new Map<string, number>();
    if (userIds.length === 0) return map;

    const myTripIds = (
      await this.prisma.tripMember.findMany({
        where: { userId: viewerId, status: MEMBER_STATUS.ACTIVE },
        select: { tripId: true },
      })
    ).map((m) => m.tripId);

    if (myTripIds.length === 0) return map;

    const shared = await this.prisma.tripMember.findMany({
      where: {
        userId: { in: userIds },
        status: MEMBER_STATUS.ACTIVE,
        tripId: { in: myTripIds },
        trip: {
          status: {
            in: [
              TRIP_STATUS.UPCOMING,
              TRIP_STATUS.ONGOING,
              TRIP_STATUS.COMPLETED,
            ],
          },
        },
      },
      select: { userId: true },
    });

    for (const row of shared) {
      map.set(row.userId, (map.get(row.userId) ?? 0) + 1);
    }
    return map;
  }

  private async loadConversationIds(
    viewerId: string,
    friendIds: string[],
  ): Promise<Map<string, string>> {
    const map = new Map<string, string>();
    if (friendIds.length === 0) return map;

    const pairs = friendIds.map((friendId) => {
      const [user1Id, user2Id] =
        viewerId < friendId ? [viewerId, friendId] : [friendId, viewerId];
      return { user1Id, user2Id };
    });

    const conversations = await this.prisma.friendConversation.findMany({
      where: {
        OR: pairs.map((p) => ({
          user1Id: p.user1Id,
          user2Id: p.user2Id,
        })),
      },
      select: { id: true, user1Id: true, user2Id: true },
    });

    for (const conv of conversations) {
      const peerId =
        conv.user1Id === viewerId ? conv.user2Id : conv.user1Id;
      map.set(peerId, conv.id);
    }
    return map;
  }

  private async loadMutualFriendCounts(
    viewerId: string,
    userIds: string[],
  ): Promise<Map<string, number>> {
    const map = new Map<string, number>();
    if (userIds.length === 0) return map;

    const myFriends = await this.prisma.friendship.findMany({
      where: { userId: viewerId },
      select: { friendId: true },
    });
    const myFriendIds = myFriends.map((f) => f.friendId);
    if (myFriendIds.length === 0) return map;

    const theirFriendships = await this.prisma.friendship.findMany({
      where: {
        userId: { in: userIds },
        friendId: { in: myFriendIds },
      },
      select: { userId: true },
    });

    for (const row of theirFriendships) {
      map.set(row.userId, (map.get(row.userId) ?? 0) + 1);
    }
    return map;
  }

  private async onlineSet(userIds: string[]): Promise<Set<string>> {
    if (userIds.length === 0) return new Set();
    try {
      return await this.tripGateway.getConnectedUserIds(userIds);
    } catch (error) {
      this.logger.warn(
        `Failed to read presence batch: ${
          error instanceof Error ? error.message : String(error)
        }`,
      );
      return new Set();
    }
  }
}


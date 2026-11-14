import { Injectable, Logger } from '@nestjs/common';

import { PrismaService } from '../../prisma.service';
import { S3Service } from '../../uploads/s3/s3.service';
import { TripGateway } from '../../websocket/gateway';
import {
  MEMBER_STATUS,
  TRIP_MESSAGE_TYPE,
  TRIP_ROLE,
  TRIP_STATUS,
  TRIP_TYPE,
} from '../../generated/prisma/enums';
import { Prisma } from '../../generated/prisma/client';

const MEDIA_URL_SELECT = {
  objectKey: true,
  deletedAt: true,
} satisfies Prisma.UploadedMediaSelect;

const PLACEHOLDER_COVER = '';

type MediaUrlSource = { objectKey: string; deletedAt: Date | null } | null;

@Injectable()
export class ChatsHubService {
  private readonly logger = new Logger(ChatsHubService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
    private readonly tripGateway: TripGateway,
  ) {}

  async getHub(userId: string) {
    const [viewer, tripThreads, friendThreads] = await Promise.all([
      this.buildViewer(userId),
      this.buildTripThreads(userId),
      this.buildFriendThreads(userId),
    ]);

    const activeTripPulse = await this.buildActiveTripPulse(
      userId,
      tripThreads,
    );

    const totalThreadCount = tripThreads.length + friendThreads.length;
    const hasUnread =
      tripThreads.some((t) => t.unreadCount > 0) ||
      friendThreads.some((t) => t.unreadCount > 0) ||
      (activeTripPulse?.newExchangeCount ?? 0) > 0;

    return {
      viewer,
      totalThreadCount,
      hasUnread,
      activeTripPulse,
      tripThreads,
      friendThreads,
    };
  }

  private async buildViewer(userId: string) {
    const user = await this.prisma.user.findUniqueOrThrow({
      where: { id: userId },
      select: {
        displayname: true,
        avatar: { select: MEDIA_URL_SELECT },
      },
    });

    return {
      displayName: user.displayname,
      avatarUrl: this.toPublicUrl(user.avatar),
      isOnline: true,
    };
  }

  private async buildTripThreads(userId: string) {
    const memberships = await this.prisma.tripMember.findMany({
      where: {
        userId,
        status: MEMBER_STATUS.ACTIVE,
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
        id: true,
        trip: {
          select: {
            id: true,
            name: true,
            status: true,
            tripType: true,
            maxMembers: true,
            coverMedia: { select: MEDIA_URL_SELECT },
            _count: {
              select: {
                members: { where: { status: MEMBER_STATUS.ACTIVE } },
              },
            },
            tripMessages: {
              take: 1,
              orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
              select: {
                id: true,
                content: true,
                messageType: true,
                createdAt: true,
                senderId: true,
                sender: {
                  select: {
                    id: true,
                    userId: true,
                    user: { select: { displayname: true } },
                  },
                },
              },
            },
          },
        },
      },
    });

    if (memberships.length === 0) return [];

    const tripIds = memberships.map((m) => m.trip.id);
    const myMemberIds = new Set(memberships.map((m) => m.id));

    const [reads, otherReads] = await Promise.all([
      this.prisma.tripMessageRead.findMany({
        where: { userId, tripId: { in: tripIds } },
        select: { tripId: true, lastReadAt: true },
      }),
      this.prisma.tripMessageRead.findMany({
        where: {
          tripId: { in: tripIds },
          userId: { not: userId },
        },
        select: { tripId: true, lastReadAt: true },
      }),
    ]);

    const readByTrip = new Map(reads.map((r) => [r.tripId, r.lastReadAt]));
    const otherReadsByTrip = new Map<string, Date[]>();
    for (const row of otherReads) {
      const list = otherReadsByTrip.get(row.tripId) ?? [];
      list.push(row.lastReadAt);
      otherReadsByTrip.set(row.tripId, list);
    }

    const unreadCounts = await Promise.all(
      memberships.map(async (membership) => {
        const lastReadAt = readByTrip.get(membership.trip.id);
        return {
          tripId: membership.trip.id,
          count: await this.prisma.tripMessage.count({
            where: {
              tripId: membership.trip.id,
              ...(lastReadAt ? { createdAt: { gt: lastReadAt } } : {}),
              sender: { userId: { not: userId } },
            },
          }),
        };
      }),
    );
    const unreadByTrip = new Map(unreadCounts.map((u) => [u.tripId, u.count]));

    const threads = memberships.map((membership) => {
      const trip = membership.trip;
      const last = trip.tripMessages[0] ?? null;
      const unreadCount = unreadByTrip.get(trip.id) ?? 0;
      const lastFromMe = last != null && myMemberIds.has(last.senderId);
      const peerReadAts = otherReadsByTrip.get(trip.id) ?? [];
      const isReadReceipt =
        unreadCount === 0 &&
        lastFromMe &&
        last != null &&
        peerReadAts.some((at) => at.getTime() >= last.createdAt.getTime());

      const status = this.toHubTripStatus(trip.status);
      const memberCount = trip._count.members;

      return {
        id: trip.id,
        tripId: trip.id,
        title: trip.name,
        coverUrl: this.toPublicUrl(trip.coverMedia) ?? PLACEHOLDER_COVER,
        badgeIcon: this.badgeIconFor(trip.status, trip.tripType),
        status,
        memberCount,
        memberLabel:
          trip.status === TRIP_STATUS.COMPLETED
            ? 'Kỷ niệm trip'
            : `${memberCount} thành viên`,
        lastSenderName: last?.sender.user.displayname ?? '',
        lastMessage: last ? this.previewMessage(last) : '',
        timeLabel: last ? this.formatTimeLabel(last.createdAt) : '',
        unreadCount,
        isReadReceipt,
        emphasize: unreadCount > 0,
        _sortAt: last?.createdAt?.getTime() ?? 0,
        _status: trip.status,
      };
    });

    threads.sort((a, b) => b._sortAt - a._sortAt);

    return threads.map(
      ({ _sortAt: _a, _status: _b, ...thread }) => thread,
    );
  }

  private async buildFriendThreads(userId: string) {
    const conversations = await this.prisma.friendConversation.findMany({
      where: {
        OR: [{ user1Id: userId }, { user2Id: userId }],
      },
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
        messages: {
          take: 1,
          orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
          select: {
            id: true,
            content: true,
            messageType: true,
            senderId: true,
            createdAt: true,
          },
        },
      },
    });

    if (conversations.length === 0) return [];

    const conversationIds = conversations.map((c) => c.id);
    const peerIds = conversations.map((c) =>
      c.user1Id === userId ? c.user2Id : c.user1Id,
    );

    const [reads, onlinePeerIds, ownerPeerIds] = await Promise.all([
      this.prisma.friendConversationRead.findMany({
        where: { userId, conversationId: { in: conversationIds } },
        select: { conversationId: true, lastReadAt: true },
      }),
      this.safeConnectedUserIds(peerIds),
      this.findOwnerPeersOnSharedTrips(userId, peerIds),
    ]);

    const readByConv = new Map(reads.map((r) => [r.conversationId, r.lastReadAt]));

    const unreadCounts = await Promise.all(
      conversations.map(async (conversation) => {
        const lastReadAt = readByConv.get(conversation.id);
        return {
          conversationId: conversation.id,
          count: await this.prisma.friendMessage.count({
            where: {
              conversationId: conversation.id,
              senderId: { not: userId },
              ...(lastReadAt ? { createdAt: { gt: lastReadAt } } : {}),
            },
          }),
        };
      }),
    );
    const unreadByConv = new Map(
      unreadCounts.map((u) => [u.conversationId, u.count]),
    );

    const now = Date.now();
    const oneHourMs = 60 * 60 * 1000;

    const threads = conversations.map((conversation) => {
      const peer =
        conversation.user1Id === userId
          ? conversation.user2
          : conversation.user1;
      const last = conversation.messages[0] ?? null;
      const unreadCount = unreadByConv.get(conversation.id) ?? 0;
      const isOwnerPeer = ownerPeerIds.has(peer.id);
      const timeEmphasized =
        unreadCount > 0 ||
        (last != null && now - last.createdAt.getTime() < oneHourMs);

      return {
        id: `dm-${peer.id}`,
        conversationId: conversation.id,
        peerUserId: peer.id,
        displayName: peer.displayname,
        avatarUrl: this.toPublicUrl(peer.avatar),
        roleBadge: isOwnerPeer ? 'Trưởng nhóm' : null,
        roleTone: isOwnerPeer ? ('PRIMARY' as const) : null,
        isOnline: onlinePeerIds.has(peer.id),
        lastMessage: last?.content ?? '',
        timeLabel: last ? this.formatTimeLabel(last.createdAt) : '',
        unreadCount,
        timeEmphasized,
        _sortAt: last?.createdAt?.getTime() ?? conversation.createdAt.getTime(),
      };
    });

    threads.sort((a, b) => b._sortAt - a._sortAt);

    return threads.map(({ _sortAt: _, ...thread }) => thread);
  }

  private async buildActiveTripPulse(
    userId: string,
    tripThreads: Array<{
      tripId: string;
      unreadCount: number;
    }>,
  ) {
    const ongoing = await this.prisma.tripMember.findMany({
      where: {
        userId,
        status: MEMBER_STATUS.ACTIVE,
        trip: { status: TRIP_STATUS.ONGOING },
      },
      select: {
        trip: {
          select: {
            id: true,
            name: true,
            maxMembers: true,
            destinations: {
              orderBy: { order: 'asc' },
              select: { city: true },
            },
            members: {
              where: { status: MEMBER_STATUS.ACTIVE },
              orderBy: { joinedAt: 'asc' },
              select: {
                userId: true,
                user: {
                  select: {
                    avatar: { select: MEDIA_URL_SELECT },
                  },
                },
              },
            },
            tripMessages: {
              take: 1,
              orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
              select: {
                content: true,
                messageType: true,
                createdAt: true,
                sender: {
                  select: {
                    user: { select: { displayname: true } },
                  },
                },
              },
            },
          },
        },
      },
    });

    if (ongoing.length === 0) return null;

    const ranked = ongoing
      .map((row) => {
        const last = row.trip.tripMessages[0] ?? null;
        return {
          trip: row.trip,
          last,
          sortAt: last?.createdAt.getTime() ?? 0,
        };
      })
      .sort((a, b) => b.sortAt - a.sortAt);

    const selected = ranked[0];
    if (!selected) return null;

    const trip = selected.trip;
    const last = selected.last;
    const memberAvatars = trip.members
      .map((m) => this.toPublicUrl(m.user.avatar))
      .filter((url): url is string => !!url)
      .slice(0, 3);
    const extraMemberCount = Math.max(
      0,
      trip.members.length - memberAvatars.length,
    );

    let onlineMemberCount = 0;
    try {
      const online = await this.tripGateway.getOnlineUserIds(trip.id);
      onlineMemberCount = trip.members.filter((m) =>
        online.has(m.userId),
      ).length;
    } catch (error) {
      this.logger.warn(
        `Failed to read presence for trip ${trip.id}: ${
          error instanceof Error ? error.message : String(error)
        }`,
      );
    }

    const city = trip.destinations[0]?.city;
    const statusLabel = city
      ? `Đang diễn ra • Chặng ${city}`
      : 'Đang diễn ra';

    const unreadFromThreads =
      tripThreads.find((t) => t.tripId === trip.id)?.unreadCount ?? 0;

    return {
      tripId: trip.id,
      title: trip.name,
      statusLabel,
      onlineMemberCount,
      memberCapacity: trip.maxMembers,
      memberAvatars,
      extraMemberCount,
      pinnedSenderName: last?.sender.user.displayname ?? '',
      pinnedMessage: last ? this.previewMessage(last) : '',
      pinnedTimeLabel: last ? this.formatTimeLabel(last.createdAt) : '',
      newExchangeCount: unreadFromThreads,
    };
  }

  private async findOwnerPeersOnSharedTrips(
    userId: string,
    peerIds: string[],
  ): Promise<Set<string>> {
    if (peerIds.length === 0) return new Set();

    const myTripIds = (
      await this.prisma.tripMember.findMany({
        where: { userId, status: MEMBER_STATUS.ACTIVE },
        select: { tripId: true },
      })
    ).map((m) => m.tripId);

    if (myTripIds.length === 0) return new Set();

    const owners = await this.prisma.tripMember.findMany({
      where: {
        tripId: { in: myTripIds },
        userId: { in: peerIds },
        status: MEMBER_STATUS.ACTIVE,
        role: TRIP_ROLE.OWNER,
      },
      select: { userId: true },
    });

    return new Set(owners.map((o) => o.userId));
  }

  private async safeConnectedUserIds(userIds: string[]): Promise<Set<string>> {
    try {
      return await this.tripGateway.getConnectedUserIds(userIds);
    } catch (error) {
      this.logger.warn(
        `Failed to read connected users: ${
          error instanceof Error ? error.message : String(error)
        }`,
      );
      return new Set();
    }
  }

  private previewMessage(message: {
    content: string;
    messageType: string;
  }): string {
    if (message.messageType === TRIP_MESSAGE_TYPE.IMAGE) return '[Ảnh]';
    return message.content;
  }

  private toHubTripStatus(
    status: TRIP_STATUS,
  ): 'UPCOMING' | 'ONGOING' | 'COMPLETED' {
    if (status === TRIP_STATUS.ONGOING) return 'ONGOING';
    if (status === TRIP_STATUS.COMPLETED) return 'COMPLETED';
    return 'UPCOMING';
  }

  private badgeIconFor(status: TRIP_STATUS, tripType: TRIP_TYPE): string {
    if (status === TRIP_STATUS.COMPLETED) return 'task_alt';
    if (tripType === TRIP_TYPE.BACKPACKER) return 'hiking';
    if (tripType === TRIP_TYPE.COUPLE || tripType === TRIP_TYPE.SOLO) {
      return 'sailing';
    }
    return 'landscape';
  }

  private formatTimeLabel(date: Date, now = new Date()): string {
    const diffMs = now.getTime() - date.getTime();
    const diffMinutes = Math.floor(diffMs / 60_000);
    const diffHours = Math.floor(diffMs / 3_600_000);

    if (diffMinutes < 1) return 'vừa xong';
    if (diffMinutes < 60) return `${diffMinutes}p`;
    if (diffHours < 24) {
      if (diffHours < 12) {
        return `${String(date.getHours()).padStart(2, '0')}:${String(
          date.getMinutes(),
        ).padStart(2, '0')}`;
      }
      return `${diffHours} giờ`;
    }

    const startOfToday = new Date(now);
    startOfToday.setHours(0, 0, 0, 0);
    const startOfYesterday = new Date(startOfToday);
    startOfYesterday.setDate(startOfYesterday.getDate() - 1);

    if (date >= startOfYesterday && date < startOfToday) return 'Hôm qua';

    const day = String(date.getDate()).padStart(2, '0');
    const month = String(date.getMonth() + 1).padStart(2, '0');
    return `${day}/${month}`;
  }

  private toPublicUrl(media: MediaUrlSource): string | null {
    if (!media || media.deletedAt) return null;
    return this.s3.getPublicUrl(media.objectKey);
  }
}

import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { PrismaService } from '../../prisma.service';
import { FRIEND_REQUEST_STATUS } from '../../generated/prisma/enums';

@Injectable()
export class FriendService {
  constructor(private readonly prisma: PrismaService) {}

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

  getReceivedRequests(userId: string) {
    return this.prisma.friendRequest.findMany({
      where: {
        toUserId: userId,
        status: FRIEND_REQUEST_STATUS.PENDING,
      },
      include: {
        fromUser: {
          select: {
            id: true,
            username: true,
            avatarId: true,
          },
        },
      },
      orderBy: {
        createdAt: 'desc',
      },
    });
  }

  // =========================================================
  // GET SENT REQUESTS
  // =========================================================

  getSentRequests(userId: string) {
    return this.prisma.friendRequest.findMany({
      where: {
        fromUserId: userId,
        status: FRIEND_REQUEST_STATUS.PENDING,
      },
      include: {
        toUser: {
          select: {
            id: true,
            username: true,
            avatarId: true,
          },
        },
      },
      orderBy: {
        createdAt: 'desc',
      },
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

  getFriends(userId: string) {
    return this.prisma.friendship.findMany({
      where: {
        userId,
      },
      include: {
        friend: {
          select: {
            id: true,
            username: true,
            avatarId: true,
          },
        },
      },
      orderBy: {
        createdAt: 'desc',
      },
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
  // SEND MESSAGE
  // =========================================================

  async sendMessage(
    conversationId: string,
    senderId: string,
    content: string,
    messageType = 'TEXT',
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
      conversation.user1Id === senderId || conversation.user2Id === senderId;

    if (!isMember) {
      throw new ForbiddenException('You are not a member of this conversation');
    }

    return this.prisma.friendMessage.create({
      data: {
        conversationId,
        senderId,
        content,
        messageType,
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

  // =========================================================
  // GET MESSAGES
  // =========================================================

  async getMessages(
    conversationId: string,
    userId: string,
    limit = 50,
    cursor?: string,
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
      throw new ForbiddenException('You are not a member of this conversation');
    }

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

    return {
      data: messages.reverse(),
      meta: {
        nextCursor,
        hasMore,
      },
    };
  }
}

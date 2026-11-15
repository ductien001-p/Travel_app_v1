import {
  ConnectedSocket,
  MessageBody,
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
  OnGatewayConnection,
  OnGatewayDisconnect,
  OnGatewayInit,
} from '@nestjs/websockets';

import { HttpException, Inject, Logger, forwardRef } from '@nestjs/common';
import { plainToInstance } from 'class-transformer';
import { validate } from 'class-validator';
import { Server, Socket } from 'socket.io';
import { MEMBER_STATUS } from '../generated/prisma/browser';
import { PrismaService } from '../prisma.service';
import { SendTripMessageDto } from '../module/trips/trip-relations/trip-messages/dto/message.dto';
import { TripMessageService } from '../module/trips/trip-relations/trip-messages/tripMessages.service';
import { WsJwtMiddleware } from './ws-jwt-middleware';
import type { TimelineEventResponse } from '../module/trips/trip-relations/trip-timeline/tripTimeline.service';
//fix orifin khi len production
@WebSocketGateway(3002, {
  cors: {
    origin: '*',
  },
})
export class TripGateway
  implements OnGatewayConnection, OnGatewayDisconnect, OnGatewayInit
{
  @WebSocketServer() server!: Server;
  private readonly logger = new Logger(TripGateway.name);

  constructor(
    private readonly prisma: PrismaService,
    @Inject(forwardRef(() => TripMessageService))
    private readonly tripMessageService: TripMessageService,
    private readonly wsJwtMiddleware: WsJwtMiddleware,
  ) {}

  afterInit(server: Server) {
    server.use(this.wsJwtMiddleware.use.bind(this.wsJwtMiddleware));
    console.log('[WS] Initialized');
  }
  async handleConnection(client: Socket) {
    console.log('[WS] Connected:', client.id);
    const userId: unknown = client.data?.userId;
    // Presence of users outside any trip room, e.g. people asking to join.
    if (typeof userId === 'string') await client.join(this.userRoom(userId));
  }

  handleDisconnect(client: Socket) {
    console.log('[WS] Disconnected:', client.id);
  }
  /**
   * User join vào room của Trip
   */
  @SubscribeMessage('trip:join')
  async handleJoinTrip(
    @ConnectedSocket() socket: Socket,
    @MessageBody() data: { tripId: string } | string,
  ) {
    // ========================================
    // 1. Parse data nếu Socket.IO gửi string
    // ========================================
    let payload: { tripId: string };

    try {
      if (typeof data === 'string') {
        payload = JSON.parse(data);
      } else {
        payload = data;
      }
    } catch (error) {
      console.log(`[WS] Invalid JSON payload ${error}`);

      socket.emit('trip:error', {
        message: 'Invalid JSON payload',
      });

      return;
    }

    // ========================================
    // 2. Validate tripId
    // ========================================
    if (!payload || typeof payload.tripId !== 'string') {
      console.log('[WS] Invalid tripId');

      socket.emit('trip:error', {
        message: 'tripId is required',
      });

      return;
    }

    const tripId = payload.tripId;

    // ========================================
    // 3. Lấy userId từ socket
    // ========================================
    const userId = socket.data.userId;

    if (!userId) {
      socket.emit('trip:error', {
        message: 'User is not authenticated',
      });

      return;
    }

    // ========================================
    // 4. Kiểm tra member
    // ========================================
    const member = await this.prisma.tripMember.findFirst({
      where: {
        tripId,
        userId,
        status: MEMBER_STATUS.ACTIVE,
      },
    });

    if (!member) {
      socket.emit('trip:error', {
        message: 'You are not an active member of this trip',
      });

      return;
    }

    // ========================================
    // 5. Join room
    // ========================================
    const room = `trip:${tripId}`;

    await socket.join(room);

    const sockets = await this.server.in(room).fetchSockets();

    console.log(
      '[WS] Users:',
      sockets.map((socket) => socket.data.userId),
    );

    // ========================================
    // 6. Thông báo join thành công
    // ========================================
    socket.emit('trip:joined', {
      tripId,
      room,
    });
  }

  /**
   * User rời room Trip
   */
  @SubscribeMessage('trip:leave')
  async handleLeaveTrip(
    @ConnectedSocket() socket: Socket,
    @MessageBody() data: { tripId: string },
  ) {
    let payload: { tripId: string };

    try {
      if (typeof data === 'string') {
        payload = JSON.parse(data);
      } else {
        payload = data;
      }
    } catch (error) {
      console.log(`[WS] Invalid JSON payload ${error}`);

      socket.emit('trip:error', {
        message: 'Invalid JSON payload',
      });

      return;
    }

    if (!payload || typeof payload.tripId !== 'string') {
      socket.emit('trip:error', {
        message: 'tripId is required',
      });

      return;
    }

    await socket.leave(this.tripRoom(payload.tripId));
  }

  /**
   * Backend gọi hàm này khi có TimelineEvent mới. `event` has the same shape
   * as the items of GET /trips/timeline/:tripId; null means nothing was
   * recorded (draft trip) and is ignored.
   */
  emitTimelineEvent(tripId: string, event: TimelineEventResponse | null) {
    if (!event) return;
    const room = `trip:${tripId}`;

    this.server.to(room).emit('trip:timeline', event);
  }

  /** Broadcast a chat message created via HTTP or auto-post hooks. */
  emitChatMessage(tripId: string, message: unknown) {
    this.server
      .to(this.tripRoom(tripId))
      .emit('trip:message', { tripId, message });
  }

  /** Broadcast reaction aggregate updates for a message. */
  emitChatReaction(tripId: string, payload: unknown) {
    this.server.to(this.tripRoom(tripId)).emit('trip:message:reaction', {
      tripId,
      ...(payload && typeof payload === 'object' ? payload : {}),
    });
  }

  /**
   * Removes every socket of a user from the trip room (kick / leave).
   */
  async removeUserFromTripRoom(tripId: string, userId: string) {
    const room = this.tripRoom(tripId);
    const sockets = await this.server.in(room).fetchSockets();

    for (const socket of sockets) {
      if (socket.data?.userId === userId) {
        socket.leave(room);
      }
    }
  }

  /** Users that currently have a socket joined to the trip room. */
  async getOnlineUserIds(tripId: string): Promise<Set<string>> {
    const sockets = await this.server.in(this.tripRoom(tripId)).fetchSockets();
    const userIds = sockets
      .map((socket) => socket.data?.userId as unknown)
      .filter((userId): userId is string => typeof userId === 'string');
    return new Set(userIds);
  }

  /** Which of [userIds] have at least one connected socket. */
  async getConnectedUserIds(userIds: string[]): Promise<Set<string>> {
    if (userIds.length === 0) return new Set();
    const sockets = await this.server
      .in(userIds.map((userId) => this.userRoom(userId)))
      .fetchSockets();
    const connected = sockets
      .map((socket) => socket.data?.userId as unknown)
      .filter((userId): userId is string => typeof userId === 'string');
    return new Set(connected);
  }

  /**
   * Disconnects every socket from the trip room (trip deleted).
   */
  closeTripRoom(tripId: string) {
    this.server.in(this.tripRoom(tripId)).socketsLeave(this.tripRoom(tripId));
  }

  @SubscribeMessage('trip:typing')
  async handleTyping(
    @ConnectedSocket() socket: Socket,
    @MessageBody() data: unknown,
  ) {
    const userId = socket.data.userId;
    if (typeof userId !== 'string') {
      socket.emit('trip:error', { message: 'Unauthorized' });
      return;
    }

    let raw: unknown = data;
    if (typeof data === 'string') {
      try {
        raw = JSON.parse(data);
      } catch {
        socket.emit('trip:error', { message: 'Invalid typing payload' });
        return;
      }
    }

    if (!raw || typeof raw !== 'object' || Array.isArray(raw)) {
      socket.emit('trip:error', { message: 'Invalid typing payload' });
      return;
    }

    const payload = raw as { tripId?: unknown; isTyping?: unknown };
    if (typeof payload.tripId !== 'string' || payload.tripId.length === 0) {
      socket.emit('trip:error', { message: 'tripId is required' });
      return;
    }

    const member = await this.prisma.tripMember.findUnique({
      where: {
        tripId_userId: { tripId: payload.tripId, userId },
      },
      select: {
        status: true,
        user: {
          select: {
            displayname: true,
            username: true,
          },
        },
      },
    });

    if (!member || member.status !== MEMBER_STATUS.ACTIVE) {
      socket.emit('trip:error', { message: 'Not a trip member' });
      return;
    }

    const displayName =
      member.user.displayname?.trim() || member.user.username || 'Thành viên';

    socket.to(this.tripRoom(payload.tripId)).emit('trip:typing', {
      tripId: payload.tripId,
      userId,
      isTyping: payload.isTyping !== false,
      typingLabel: `${displayName} đang nhập`,
      // Avatar URL resolution needs S3; clients can fall back to local cache.
      typingAvatarUrl: null,
    });
  }

  @SubscribeMessage('trip:message:send')
  async handleSendMessage(
    @ConnectedSocket() socket: Socket,
    @MessageBody() data: unknown,
  ) {
    const userId = socket.data.userId;

    if (!userId) {
      socket.emit('trip:error', {
        message: 'Unauthorized',
      });

      return;
    }

    const payload = await this.parseSendMessagePayload(data);

    if (!payload) {
      socket.emit('trip:error', {
        message: 'Invalid message payload',
      });

      return;
    }

    try {
      const message = await this.tripMessageService.createMessageAsUi(
        payload.tripId,
        userId,
        payload.content,
        { messageType: payload.messageType },
      );

      this.emitChatMessage(payload.tripId, message);

      return {
        success: true,
        message,
      };
    } catch (error) {
      if (error instanceof HttpException) {
        socket.emit('trip:error', {
          message: error.message,
        });

        return;
      }

      this.logger.error(
        `Failed to create message for trip ${payload.tripId}`,
        error instanceof Error ? error.stack : undefined,
      );

      socket.emit('trip:error', {
        message: 'Internal server error',
      });
    }
  }

  private async parseSendMessagePayload(
    data: unknown,
  ): Promise<SendTripMessageDto | null> {
    let raw: unknown = data;

    if (typeof data === 'string') {
      try {
        raw = JSON.parse(data);
      } catch {
        return null;
      }
    }

    if (!raw || typeof raw !== 'object' || Array.isArray(raw)) {
      return null;
    }

    const dto = plainToInstance(SendTripMessageDto, raw);
    const errors = await validate(dto, {
      whitelist: true,
      forbidNonWhitelisted: true,
    });

    return errors.length === 0 ? dto : null;
  }

  private tripRoom(tripId: string) {
    return `trip:${tripId}`;
  }

  private userRoom(userId: string) {
    return `user:${userId}`;
  }
}

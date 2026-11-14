import {
  ConnectedSocket,
  MessageBody,
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
  OnGatewayInit,
} from '@nestjs/websockets';

import { Server, Socket } from 'socket.io';
import { FriendService } from './friends.service';
import { WsJwtMiddleware } from '../../websocket/ws-jwt-middleware';

//fix cors khi len production
@WebSocketGateway(3002, {
  namespace: '/friends',
  cors: {
    origin: '*',
  },
})
export class FriendGateway implements OnGatewayInit {
  @WebSocketServer()
  server!: Server;

  constructor(
    private readonly friendService: FriendService,
    private readonly middleware: WsJwtMiddleware,
  ) {}

  afterInit(server: Server) {
    server.use(this.middleware.use.bind(this.middleware));
    console.log('[WS] Initialized');
  }
  // =========================================================
  // JOIN CONVERSATION
  // =========================================================

  @SubscribeMessage('friend:conversation:join')
  async joinConversation(
    @ConnectedSocket() socket: Socket,
    @MessageBody()
    data: {
      conversationId: string;
    },
  ) {
    let payload: { conversationId: string };

    try {
      if (typeof data === 'string') {
        payload = JSON.parse(data);
      } else {
        payload = data;
      }
    } catch (error) {
      console.log(`[WS] Invalid JSON payload ${error}`);

      socket.emit('friend:error', {
        message: 'Invalid JSON payload',
      });

      return;
    }

    console.log('[WS] parsed payload:', payload);

    if (!payload || typeof payload.conversationId !== 'string') {
      console.log('[WS] Invalid conversationId payload:', payload);

      socket.emit('friend:error', {
        message: 'conversationId is required',
      });

      return;
    }
    const userId = socket.data.userId;

    // getMessages also upserts FriendConversationRead.lastReadAt.
    const messages = await this.friendService.getMessages(
      payload.conversationId,
      userId,
      50,
    );

    await socket.join(`friend-conversation:${payload.conversationId}`);

    socket.emit('friend:conversation:joined', {
      conversationId: payload.conversationId,
      messages,
    });

    return {
      success: true,
    };
  }

  // =========================================================
  // SEND MESSAGE
  // =========================================================

  emitMessageNew(conversationId: string, message: unknown) {
    if (!this.server) return;
    this.server
      .to(`friend-conversation:${conversationId}`)
      .emit('friend:message:new', message);
  }

  @SubscribeMessage('friend:message:send')
  async sendMessage(
    @ConnectedSocket() socket: Socket,
    @MessageBody()
    data: {
      conversationId: string;
      content: string;
      messageType?: string;
      metadata?: Record<string, unknown>;
    },
  ) {
    let payload: {
      conversationId: string;
      content: string;
      messageType?: string;
      metadata?: Record<string, unknown>;
    };

    try {
      if (typeof data === 'string') {
        payload = JSON.parse(data);
      } else {
        payload = data;
      }
    } catch (error) {
      console.log(`[WS] Invalid JSON payload ${error}`);

      socket.emit('friend:error', {
        message: 'Invalid JSON payload',
      });

      return;
    }

    console.log('[WS] parsed payload:', payload);

    // ========================================
    // 2. Validate conversationId
    // ========================================
    if (!payload || typeof payload.conversationId !== 'string') {
      console.log('[WS] Invalid conversationId payload:', payload);

      socket.emit('friend:error', {
        message: 'conversationId is required',
      });

      return;
    }
    const userId = socket.data.userId;

    const message = await this.friendService.sendMessage(
      payload.conversationId,
      userId,
      payload.content ?? '',
      payload.messageType ?? 'TEXT',
      payload.metadata,
    );

    this.emitMessageNew(payload.conversationId, message);

    return {
      success: true,
      message,
    };
  }

  // =========================================================
  // LEAVE
  // =========================================================

  @SubscribeMessage('friend:conversation:leave')
  async leaveConversation(
    @ConnectedSocket() socket: Socket,
    @MessageBody()
    data: {
      conversationId: string;
    },
  ) {
    let payload: {
      conversationId: string;
    };

    try {
      if (typeof data === 'string') {
        payload = JSON.parse(data);
      } else {
        payload = data;
      }
    } catch (error) {
      console.log(`[WS] Invalid JSON payload ${error}`);

      socket.emit('friend:error', {
        message: 'Invalid JSON payload',
      });

      return;
    }

    console.log('[WS] parsed payload:', payload);

    // ========================================
    // 2. Validate conversationId
    // ========================================
    if (!payload || typeof payload.conversationId !== 'string') {
      console.log('[WS] Invalid conversationId payload:', payload);

      socket.emit('friend:error', {
        message: 'conversationId is required',
      });

      return;
    }
    await socket.leave(`friend-conversation:${payload.conversationId}`);

    return {
      success: true,
    };
  }
}

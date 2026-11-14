import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
  Query,
} from '@nestjs/common';

import { ApiCreatedResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';

import { FriendService } from './friends.service';
import { FindFriendsService } from './find-friends.service';
import { FriendGateway } from './friend-gateway';
import { CurrentUser } from '../../decoration/currentUser.decoration';
import { SendFriendRequestDto } from './dto/send-friendRequest.dto';
import { SendFriendMessageDto } from './dto/send-messsage.dto';
import {
  FriendChatMessageUiEnvelopeResponseDto,
  FriendChatThreadEnvelopeResponseDto,
} from './dto/friend-chat-thread-response.dto';
import {
  FindFriendsEnvelopeResponseDto,
  FindFriendsQueryDto,
} from './dto/find-friends.dto';
import {
  DiscoveryLocationEnvelopeResponseDto,
  UpdateDiscoveryLocationDto,
} from './dto/discovery-location.dto';

import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';

import {
  FriendRequestEnvelopeResponseDto,
  ReceivedFriendRequestsResponseDto,
  SentFriendRequestsResponseDto,
  FriendshipsResponseDto,
  RemoveFriendResponseDto,
  FriendStatusEnvelopeResponseDto,
  FriendConversationEnvelopeResponseDto,
  FriendConversationReadEnvelopeResponseDto,
  FriendMessagesPageResponseDto,
  FriendConversationsPageResponseDto,
} from '../../common/contracts/extended-response.dto';

import { GetFriendConversationsQueryDto } from './dto/get-conversations.dto';
import { GetFriendMessagesQueryDto } from './dto/get-messages.dto';

@ApiTags('Friends')
@ApiStandardErrors()
@Controller('friends')
export class FriendController {
  constructor(
    private readonly friendService: FriendService,
    private readonly findFriendsService: FindFriendsService,
    private readonly friendGateway: FriendGateway,
  ) {}

  // =========================================================
  // FIND FRIENDS (composite screen)
  // =========================================================

  @Get('find')
  @ApiOkResponse({ type: FindFriendsEnvelopeResponseDto })
  async findFriends(
    @CurrentUser('id') userId: string,
    @Query() query: FindFriendsQueryDto,
  ) {
    const data = await this.findFriendsService.find(userId, query);
    return {
      data,
      message: 'Find friends retrieved successfully',
    };
  }

  @Put('discovery-location')
  @ApiOkResponse({ type: DiscoveryLocationEnvelopeResponseDto })
  async updateDiscoveryLocation(
    @CurrentUser('id') userId: string,
    @Body() dto: UpdateDiscoveryLocationDto,
  ) {
    const data = await this.findFriendsService.updateDiscoveryLocation(
      userId,
      dto,
    );
    return {
      data,
      message: 'Discovery location updated successfully',
    };
  }

  // =========================================================
  // FRIEND REQUEST
  // =========================================================

  @Post('requests')
  @ApiCreatedResponse({
    type: FriendRequestEnvelopeResponseDto,
  })
  async sendRequest(
    @CurrentUser('id') userId: string,
    @Body() dto: SendFriendRequestDto,
  ) {
    const data = await this.friendService.sendFriendRequest(
      userId,
      dto.toUserId,
    );

    return {
      data,
      message: 'Friend request sent successfully',
    };
  }

  @Get('requests/received')
  @ApiOkResponse({
    type: ReceivedFriendRequestsResponseDto,
  })
  async getReceivedRequests(@CurrentUser('id') userId: string) {
    const data = await this.friendService.getReceivedRequests(userId);

    return {
      data,
      message: 'Received friend requests retrieved successfully',
    };
  }

  @Get('requests/sent')
  @ApiOkResponse({
    type: SentFriendRequestsResponseDto,
  })
  async getSentRequests(@CurrentUser('id') userId: string) {
    const data = await this.friendService.getSentRequests(userId);

    return {
      data,
      message: 'Sent friend requests retrieved successfully',
    };
  }

  @Post('requests/:requestId/accept')
  @ApiCreatedResponse({
    type: FriendRequestEnvelopeResponseDto,
  })
  async acceptRequest(
    @Param('requestId') requestId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.friendService.acceptFriendRequest(
      requestId,
      userId,
    );

    return {
      data,
      message: 'Friend request accepted successfully',
    };
  }

  @Post('requests/:requestId/reject')
  @ApiCreatedResponse({
    type: FriendRequestEnvelopeResponseDto,
  })
  async rejectRequest(
    @Param('requestId') requestId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.friendService.rejectFriendRequest(
      requestId,
      userId,
    );

    return {
      data,
      message: 'Friend request rejected successfully',
    };
  }

  @Delete('requests/:requestId')
  @ApiOkResponse({
    type: FriendRequestEnvelopeResponseDto,
  })
  async cancelRequest(
    @Param('requestId') requestId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.friendService.cancelFriendRequest(
      requestId,
      userId,
    );

    return {
      data,
      message: 'Friend request cancelled successfully',
    };
  }

  // =========================================================
  // CONVERSATIONS
  // Fixed routes before dynamic :friendId routes
  // =========================================================

  @Get('conversations')
  @ApiOkResponse({
    type: FriendConversationsPageResponseDto,
  })
  getConversations(
    @CurrentUser('id') userId: string,
    @Query() query: GetFriendConversationsQueryDto,
  ) {
    // Service already returns:
    // {
    //   data: [],
    //   meta: { nextCursor, hasMore }
    // }

    return this.friendService.getConversations(
      userId,
      query.limit,
      query.cursor,
    );
  }

  @Get('conversations/:conversationId/thread')
  @ApiOkResponse({
    type: FriendChatThreadEnvelopeResponseDto,
  })
  async getThread(
    @Param('conversationId') conversationId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.friendService.getThread(conversationId, userId);

    return {
      data,
      message: 'Friend chat thread retrieved successfully',
    };
  }

  @Get('conversations/:conversationId/messages')
  @ApiOkResponse({
    type: FriendMessagesPageResponseDto,
  })
  getMessages(
    @Param('conversationId') conversationId: string,
    @CurrentUser('id') userId: string,
    @Query() query: GetFriendMessagesQueryDto,
  ) {
    // Service already returns:
    // {
    //   data: [],
    //   meta: { nextCursor, hasMore }
    // }

    return this.friendService.getMessages(
      conversationId,
      userId,
      query.limit,
      query.cursor,
    );
  }

  @Post('conversations/:conversationId/messages')
  @ApiCreatedResponse({
    type: FriendChatMessageUiEnvelopeResponseDto,
  })
  async sendMessage(
    @Param('conversationId') conversationId: string,
    @CurrentUser('id') userId: string,
    @Body() body: SendFriendMessageDto,
  ) {
    const data = await this.friendService.sendMessageAsUi(
      conversationId,
      userId,
      body.content ?? '',
      body.messageType ?? 'TEXT',
      body.metadata,
    );

    this.friendGateway.emitMessageNew(conversationId, data);

    return {
      data,
      message: 'Message sent successfully',
    };
  }

  @Post('conversations/:conversationId/read')
  @ApiOkResponse({
    type: FriendConversationReadEnvelopeResponseDto,
  })
  async markConversationRead(
    @Param('conversationId') conversationId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.friendService.markConversationRead(
      conversationId,
      userId,
    );

    return {
      data,
      message: 'Conversation marked as read',
    };
  }

  // =========================================================
  // FRIENDS
  // =========================================================

  @Get()
  @ApiOkResponse({
    type: FriendshipsResponseDto,
  })
  async getFriends(@CurrentUser('id') userId: string) {
    const data = await this.friendService.getFriends(userId);

    return {
      data,
      message: 'Friends retrieved successfully',
    };
  }

  @Delete(':friendId')
  @ApiOkResponse({
    type: RemoveFriendResponseDto,
  })
  removeFriend(
    @Param('friendId') friendId: string,
    @CurrentUser('id') userId: string,
  ) {
    // Service already returns:
    // {
    //   success: true,
    //   message: 'Friend removed successfully'
    // }

    return this.friendService.removeFriend(userId, friendId);
  }

  @Get(':friendId/status')
  @ApiOkResponse({
    type: FriendStatusEnvelopeResponseDto,
  })
  async getFriendStatus(
    @Param('friendId') friendId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.friendService.getFriendStatus(userId, friendId);

    return {
      data,
      message: 'Friend status retrieved successfully',
    };
  }

  @Post(':friendId/conversation')
  @ApiCreatedResponse({
    type: FriendConversationEnvelopeResponseDto,
  })
  async getOrCreateConversation(
    @Param('friendId') friendId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.friendService.getOrCreateConversation(
      userId,
      friendId,
    );

    return {
      data,
      message: 'Conversation retrieved successfully',
    };
  }
}

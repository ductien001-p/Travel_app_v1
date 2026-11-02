import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Query,
} from '@nestjs/common';

import { ApiCreatedResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';

import { FriendService } from './friends.service';
import { CurrentUser } from '../../decoration/currentUser.decoration';
import { SendFriendRequestDto } from './dto/send-friendRequest.dto';

import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';

import {
  FriendRequestEnvelopeResponseDto,
  ReceivedFriendRequestsResponseDto,
  SentFriendRequestsResponseDto,
  FriendshipsResponseDto,
  RemoveFriendResponseDto,
  FriendStatusEnvelopeResponseDto,
  FriendConversationEnvelopeResponseDto,
  FriendMessagesPageResponseDto,
  FriendConversationsPageResponseDto,
} from '../../common/contracts/extended-response.dto';

import { GetFriendConversationsQueryDto } from './dto/get-conversations.dto';
import { GetFriendMessagesQueryDto } from './dto/get-messages.dto';

@ApiTags('Friends')
@ApiStandardErrors()
@Controller('friends')
export class FriendController {
  constructor(private readonly friendService: FriendService) {}

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

import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Query,
} from '@nestjs/common';

import { ApiBearerAuth, ApiOkResponse, ApiTags } from '@nestjs/swagger';

import { TripMessageService } from './tripMessages.service';

import { CurrentUser } from '../../../../decoration/currentUser.decoration';

import { QueryTripMessagesDto } from './dto/query-trip-messages.dto';
import {
  CreateTripMessageDto,
  TripMessageReactionDto,
} from './dto/create-trip-message.dto';
import {
  TripChatMessageEnvelopeResponseDto,
  TripChatThreadEnvelopeResponseDto,
  TripMessageReactionEnvelopeResponseDto,
} from './dto/trip-chat-thread-response.dto';

import {
  TripMessageReadEnvelopeResponseDto,
  TripMessagesCursorResponseDto,
} from '../../../../common/contracts/extended-response.dto';

import { ApiStandardErrors } from '../../../../common/contracts/api-standard-errors.decorator';
import { TripGateway } from '../../../../websocket/gateway';
import { TRIP_MESSAGE_TYPE } from '../../../../generated/prisma/enums';

@ApiTags('Trip Messages')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('trips')
export class TripMessageController {
  constructor(
    private readonly tripMessageService: TripMessageService,
    private readonly tripGateway: TripGateway,
  ) {}

  @Get(':tripId/chat/thread')
  @ApiOkResponse({ type: TripChatThreadEnvelopeResponseDto })
  async getChatThread(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.tripMessageService.getChatThread(tripId, userId);
    return { data };
  }

  @Get(':tripId/messages')
  @ApiOkResponse({
    type: TripMessagesCursorResponseDto,
  })
  getMessages(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
    @Query() query: QueryTripMessagesDto,
  ) {
    return this.tripMessageService.getMessages(
      tripId,
      userId,
      query.limit,
      query.cursor,
    );
  }

  @Post(':tripId/messages')
  @ApiOkResponse({ type: TripChatMessageEnvelopeResponseDto })
  async createMessage(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
    @Body() body: CreateTripMessageDto,
  ) {
    const data = await this.tripMessageService.createMessageAsUi(
      tripId,
      userId,
      body.content,
      {
        messageType: body.messageType ?? TRIP_MESSAGE_TYPE.TEXT,
        caption: body.caption,
        locationLabel: body.locationLabel,
      },
    );
    this.tripGateway.emitChatMessage(tripId, data);
    return { data };
  }

  @Post(':tripId/messages/read')
  @ApiOkResponse({
    type: TripMessageReadEnvelopeResponseDto,
  })
  async markTripMessagesRead(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.tripMessageService.markTripMessagesRead(
      tripId,
      userId,
    );

    return {
      data,
      message: 'Trip messages marked as read',
    };
  }

  @Post(':tripId/messages/:messageId/reactions')
  @ApiOkResponse({ type: TripMessageReactionEnvelopeResponseDto })
  async addReaction(
    @Param('tripId') tripId: string,
    @Param('messageId') messageId: string,
    @CurrentUser('id') userId: string,
    @Body() body: TripMessageReactionDto,
  ) {
    const data = await this.tripMessageService.addReaction(
      tripId,
      messageId,
      userId,
      body.emoji,
    );
    this.tripGateway.emitChatReaction(tripId, data);
    return { data };
  }

  @Delete(':tripId/messages/:messageId/reactions')
  @ApiOkResponse({ type: TripMessageReactionEnvelopeResponseDto })
  async removeReaction(
    @Param('tripId') tripId: string,
    @Param('messageId') messageId: string,
    @CurrentUser('id') userId: string,
    @Body() body: TripMessageReactionDto,
  ) {
    const data = await this.tripMessageService.removeReaction(
      tripId,
      messageId,
      userId,
      body.emoji,
    );
    this.tripGateway.emitChatReaction(tripId, data);
    return { data };
  }
}

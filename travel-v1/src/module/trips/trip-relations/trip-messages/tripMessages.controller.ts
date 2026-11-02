import { Controller, Get, Param, Query } from '@nestjs/common';

import { ApiBearerAuth, ApiOkResponse, ApiTags } from '@nestjs/swagger';

import { TripMessageService } from './tripMessages.service';

import { CurrentUser } from '../../../../decoration/currentUser.decoration';

import { QueryTripMessagesDto } from './dto/query-trip-messages.dto';

import { TripMessagesCursorResponseDto } from '../../../../common/contracts/extended-response.dto';

import { ApiStandardErrors } from '../../../../common/contracts/api-standard-errors.decorator';

@ApiTags('Trip Messages')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('trips')
export class TripMessageController {
  constructor(private readonly tripMessageService: TripMessageService) {}

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
}

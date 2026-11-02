import {
  Body,
  Controller,
  Get,
  HttpCode,
  HttpStatus,
  Param,
  Patch,
  Post,
  Query,
} from '@nestjs/common';
import { ApiBearerAuth, ApiOkResponse, ApiTags } from '@nestjs/swagger';

import { CurrentUser } from '../../../../decoration/currentUser.decoration';
import { ApiStandardErrors } from '../../../../common/contracts/api-standard-errors.decorator';
import {
  TripJoinRequestEnvelopeResponseDto,
  TripJoinRequestSettingsEnvelopeResponseDto,
  TripJoinRequestsCursorResponseDto,
} from '../../../../common/contracts/extended-response.dto';
import { UpdateJoinRequestSettingsDto } from './dto/join-request-settings.dto';
import { QueryJoinRequestsDto } from './dto/query-join-requests.dto';
import { TripJoinRequestsService } from './trip-join-requests.service';

/** Owner and admins review the people asking to join with the invite code. */
@ApiTags('Trip join requests')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('trips/:tripId/join-requests')
export class TripJoinRequestsController {
  constructor(private readonly joinRequests: TripJoinRequestsService) {}

  @Get()
  @ApiOkResponse({ type: TripJoinRequestsCursorResponseDto })
  getJoinRequests(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
    @Query() query: QueryJoinRequestsDto,
  ) {
    return this.joinRequests.getJoinRequests(tripId, userId, query);
  }

  @Get('settings')
  @ApiOkResponse({ type: TripJoinRequestSettingsEnvelopeResponseDto })
  async getJoinRequestSettings(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.joinRequests.getSettings(tripId, userId);
    return { data, message: 'Join request settings retrieved successfully' };
  }

  @Patch('settings')
  @ApiOkResponse({ type: TripJoinRequestSettingsEnvelopeResponseDto })
  async updateJoinRequestSettings(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
    @Body() dto: UpdateJoinRequestSettingsDto,
  ) {
    const data = await this.joinRequests.updateSettings(tripId, userId, dto);
    return { data, message: 'Join request settings updated successfully' };
  }

  @Post(':requestId/approve')
  @HttpCode(HttpStatus.OK)
  @ApiOkResponse({ type: TripJoinRequestEnvelopeResponseDto })
  async approveJoinRequest(
    @Param('tripId') tripId: string,
    @Param('requestId') requestId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.joinRequests.approve(tripId, requestId, userId);
    return { data, message: 'Join request approved successfully' };
  }

  @Post(':requestId/reject')
  @HttpCode(HttpStatus.OK)
  @ApiOkResponse({ type: TripJoinRequestEnvelopeResponseDto })
  async rejectJoinRequest(
    @Param('tripId') tripId: string,
    @Param('requestId') requestId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.joinRequests.reject(tripId, requestId, userId);
    return { data, message: 'Join request rejected successfully' };
  }
}

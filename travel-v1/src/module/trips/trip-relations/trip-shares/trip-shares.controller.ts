import { Controller, Delete, Get, Param, Post } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';

import { CurrentUser } from '../../../../decoration/currentUser.decoration';
import { ApiStandardErrors } from '../../../../common/contracts/api-standard-errors.decorator';
import {
  SharedItineraryEnvelopeResponseDto,
  TripShareLinkEnvelopeResponseDto,
  TripShareRevokeEnvelopeResponseDto,
} from '../../../../common/contracts/extended-response.dto';
import { TripShareService } from './trip-share.service';

@ApiTags('Trip shares')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller()
export class TripSharesController {
  constructor(private readonly shares: TripShareService) {}

  @Post('trips/:tripId/share-links')
  @ApiCreatedResponse({ type: TripShareLinkEnvelopeResponseDto })
  async createLink(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.shares.createLink(tripId, userId);
    return { data, message: 'Share link created successfully' };
  }

  @Delete('trips/:tripId/share-links')
  @ApiOkResponse({ type: TripShareRevokeEnvelopeResponseDto })
  async revokeAll(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.shares.revokeAll(tripId, userId);
    return { data, message: 'Share links revoked successfully' };
  }

  @Get('trip-shares/:token')
  @ApiOkResponse({ type: SharedItineraryEnvelopeResponseDto })
  async getSharedItinerary(
    @Param('token') token: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.shares.getSharedItinerary(token, userId);
    return { data, message: 'Shared itinerary retrieved successfully' };
  }
}

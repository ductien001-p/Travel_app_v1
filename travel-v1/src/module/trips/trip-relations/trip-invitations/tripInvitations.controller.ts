import { Body, Controller, Get, Param, Post, Query } from '@nestjs/common';

import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';

import { TripInvitationsService } from './tripInvitations.service';

import { CreateTripInvitationDto } from '../../dto/trip-invitation.dto';

import { CurrentUser } from '../../../../decoration/currentUser.decoration';

import { ApiStandardErrors } from '../../../../common/contracts/api-standard-errors.decorator';

import {
  TripInvitationEnvelopeResponseDto,
  TripInvitationsPageResponseDto,
} from '../../../../common/contracts/extended-response.dto';
import { GetTripInvitationsDto } from './dto/get-invitation.sto';
import { GetReceivedInvitationsDto } from './dto/get-received-invitations.dto';

@ApiTags('Trip Invitations')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('trip-invitations')
export class TripInvitationsController {
  constructor(
    private readonly tripInvitationsService: TripInvitationsService,
  ) {}

  // =========================================================
  // INVITE USER
  // =========================================================

  @Post('invite')
  @ApiCreatedResponse({
    type: TripInvitationEnvelopeResponseDto,
  })
  async inviteUserToTrip(
    @CurrentUser('id') inviterId: string,
    @Body() dto: CreateTripInvitationDto,
  ) {
    const data = await this.tripInvitationsService.createInvitation(
      dto,
      inviterId,
    );

    return {
      data,
      message: 'Trip invitation sent successfully',
    };
  }

  // =========================================================
  // ACCEPT
  // =========================================================

  @Post('accept/:invitationId')
  @ApiCreatedResponse({
    type: TripInvitationEnvelopeResponseDto,
  })
  async acceptInvitation(
    @CurrentUser('id') userId: string,
    @Param('invitationId') invitationId: string,
  ) {
    const data = await this.tripInvitationsService.acceptInvitation(
      invitationId,
      userId,
    );

    return {
      data,
      message: 'Trip invitation accepted successfully',
    };
  }

  // =========================================================
  // REJECT
  // =========================================================

  @Post('reject/:invitationId')
  @ApiCreatedResponse({
    type: TripInvitationEnvelopeResponseDto,
  })
  async rejectInvitation(
    @CurrentUser('id') userId: string,
    @Param('invitationId') invitationId: string,
  ) {
    const data = await this.tripInvitationsService.rejectInvitation(
      invitationId,
      userId,
    );

    return {
      data,
      message: 'Trip invitation rejected successfully',
    };
  }

  // =========================================================
  // PENDING INVITATIONS
  // =========================================================

  @Get('invitations')
  @ApiOkResponse({
    type: TripInvitationsPageResponseDto,
  })
  getPendingInvitations(
    @CurrentUser('id') userId: string,
    @Query() dto: GetTripInvitationsDto,
  ) {
    return this.tripInvitationsService.getSendingInvitationsForTrip(
      userId,
      dto,
    );
  }

  // =========================================================
  // RECEIVED INVITATIONS (current user is the invitee)
  // =========================================================

  @Get('received')
  @ApiOkResponse({
    type: TripInvitationsPageResponseDto,
  })
  getReceivedInvitations(
    @CurrentUser('id') userId: string,
    @Query() dto: GetReceivedInvitationsDto,
  ) {
    return this.tripInvitationsService.getReceivedInvitations(userId, dto);
  }

  // =========================================================
  // CANCEL INVITATION
  // =========================================================

  @Post('cancel/:tripId/:invitationId')
  @ApiCreatedResponse({
    type: TripInvitationEnvelopeResponseDto,
  })
  async cancelInvitation(
    @CurrentUser('id') userId: string,
    @Param('tripId') tripId: string,
    @Param('invitationId') invitationId: string,
  ) {
    const data = await this.tripInvitationsService.cancelInvitation(
      tripId,
      invitationId,
      userId,
    );

    return {
      data,
      message: 'Trip invitation cancelled successfully',
    };
  }
}

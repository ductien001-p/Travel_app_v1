import { Controller, Get, Param } from '@nestjs/common';
import { ApiBearerAuth, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { CurrentUser } from '../../../../decoration/currentUser.decoration';
import { ApiStandardErrors } from '../../../../common/contracts/api-standard-errors.decorator';
import { TripMissionsService } from './trip-missions.service';
import { TripMissionsEnvelopeResponseDto } from './dto/trip-mission-response.dto';

@ApiTags('Trip Missions')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('trips/:tripId/missions')
export class TripMissionsController {
  constructor(private readonly tripMissionsService: TripMissionsService) {}

  @Get()
  @ApiOkResponse({ type: TripMissionsEnvelopeResponseDto })
  async list(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.tripMissionsService.listForViewer(tripId, userId);
    return {
      data,
      message: 'Trip missions retrieved successfully',
    };
  }
}

import { Controller, Param, Post } from '@nestjs/common';

import { ApiBearerAuth, ApiCreatedResponse, ApiTags } from '@nestjs/swagger';

import { TripCompletionService } from './tripCompletetion.service';

import { CurrentUser } from '../../../../decoration/currentUser.decoration';

import { ApiStandardErrors } from '../../../../common/contracts/api-standard-errors.decorator';

import { TripCompletionEnvelopeResponseDto } from '../../../../common/contracts/extended-response.dto';

@ApiTags('Trip Completion')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('trips/:tripId/completion')
export class TripCompletionController {
  constructor(private readonly tripCompletionService: TripCompletionService) {}

  @Post()
  @ApiCreatedResponse({
    type: TripCompletionEnvelopeResponseDto,
  })
  async completeTrip(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.tripCompletionService.completeTrip(tripId, userId);

    return {
      data,
      message: 'Trip completed successfully',
    };
  }
}

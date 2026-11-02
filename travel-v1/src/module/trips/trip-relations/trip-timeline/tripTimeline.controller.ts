import { Controller, Get, Param, Query } from '@nestjs/common';

import { ApiBearerAuth, ApiOkResponse, ApiTags } from '@nestjs/swagger';

import { TripTimelineService } from './tripTimeline.service';

import { CurrentUser } from '../../../../decoration/currentUser.decoration';

import { ApiStandardErrors } from '../../../../common/contracts/api-standard-errors.decorator';

import { TripTimelinePageResponseDto } from '../../../../common/contracts/extended-response.dto';
import { QueryTripTimelineDto } from './dto/query-timeline.dto';

@ApiTags('Trip Timeline')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('trips/timeline')
export class TripTimelineController {
  constructor(private readonly tripTimelineService: TripTimelineService) {}

  @Get(':tripId')
  @ApiOkResponse({
    type: TripTimelinePageResponseDto,
  })
  getTripTimeline(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
    @Query() query: QueryTripTimelineDto,
  ) {
    return this.tripTimelineService.getTripTimeline(tripId, userId, {
      limit: query.limit,
      cursor: query.cursor,
      category: query.category,
    });
  }
}

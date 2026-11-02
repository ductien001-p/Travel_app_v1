import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Query,
} from '@nestjs/common';

import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';

import { CurrentUser } from '../../../../decoration/currentUser.decoration';

import { CreateActivityDto } from './dto/create-activity.dto';
import { UpdateActivityDto } from './dto/update-activity.dto';
import { CheckinDto } from './dto/checkin-activity.dto';

import { TripItinerariesService } from './trip-destination.service';
import { TripItinerariesActivitiesService } from './trip-itineraries-activities.service';

import { ApiStandardErrors } from '../../../../common/contracts/api-standard-errors.decorator';

import {
  ActivityEnvelopeResponseDto,
  ActivityResponseDto,
  ItineraryItemsBatchResponseDto,
  DestinationItineraryEnvelopeResponseDto,
  TripItineraryEnvelopeResponseDto,
  ItineraryActionResponseDto,
  TripCheckinEnvelopeResponseDto,
  TripCompletionStatusEnvelopeResponseDto,
  ViewerCheckinsEnvelopeResponseDto,
  DayRouteEnvelopeResponseDto,
} from '../../../../common/contracts/extended-response.dto';
import { CreateItineraryItemsBatchDto } from './dto/create-itinerary-items-batch.dto';
import { ReorderItineraryItemsDto } from './dto/reorder-itinerary-items.dto';
import { TripItineraryViewerService } from './trip-itinerary-viewer.service';

@ApiTags('Itinerary')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('trips/:tripId/itineraries')
export class TripItinerariesController {
  constructor(
    private readonly tripItineraryService: TripItinerariesService,
    private readonly tripItineraryActivitiesService: TripItinerariesActivitiesService,
    private readonly tripItineraryViewerService: TripItineraryViewerService,
  ) {}

  // =========================================================
  // GET FULL ITINERARY
  // =========================================================

  @Get()
  @ApiOkResponse({
    type: TripItineraryEnvelopeResponseDto,
  })
  async getItinerary(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
  ) {
    const itinerary = await this.tripItineraryService.getTripItinerary(
      tripId,
      userId,
    );

    return {
      data: itinerary.destinations,
      permissions: {
        canManageItinerary: itinerary.canManageItinerary,
      },
      message: 'Itinerary retrieved successfully',
    };
  }

  // =========================================================
  // MY CHECK-INS
  // =========================================================

  @Get('checkins/me')
  @ApiOkResponse({ type: ViewerCheckinsEnvelopeResponseDto })
  async getMyCheckins(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.tripItineraryViewerService.listMyCheckins(
      tripId,
      userId,
    );

    return {
      data,
      message: 'Check-ins retrieved successfully',
    };
  }

  // =========================================================
  // DAY ROUTE
  // =========================================================

  @Get('days/:dayId/route')
  @ApiOkResponse({ type: DayRouteEnvelopeResponseDto })
  async getDayRoute(
    @Param('tripId') tripId: string,
    @Param('dayId') dayId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.tripItineraryViewerService.getDayRoute(
      tripId,
      dayId,
      userId,
    );

    return {
      data,
      message: 'Day route retrieved successfully',
    };
  }

  // =========================================================
  // GET DESTINATION ITINERARY
  // =========================================================

  @Get('destinations/:destinationId')
  @ApiOkResponse({
    type: DestinationItineraryEnvelopeResponseDto,
  })
  async getDestinationItinerary(
    @Param('tripId') tripId: string,
    @Param('destinationId') destinationId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.tripItineraryService.getDestinationItinerary(
      tripId,
      destinationId,
      userId,
    );

    return {
      data,
      message: 'Destination itinerary retrieved successfully',
    };
  }

  // =========================================================
  // DELETE DESTINATION
  // =========================================================

  @Delete('destinations/:destinationId')
  @ApiOkResponse({
    type: ItineraryActionResponseDto,
  })
  async deleteDestination(
    @Param('tripId') tripId: string,
    @Param('destinationId') destinationId: string,
    @CurrentUser('id') userId: string,
    @Query('acknowledgeRecruitmentImpact') acknowledge?: string,
  ) {
    await this.tripItineraryService.deleteDestination(
      tripId,
      destinationId,
      userId,
      acknowledge === 'true',
    );

    return {
      success: true,
      message: 'Destination deleted successfully',
    };
  }

  // =========================================================
  // CREATE ACTIVITY
  // =========================================================

  @Post('days/:dayId/activities')
  @ApiCreatedResponse({
    type: ActivityEnvelopeResponseDto,
  })
  async createActivity(
    @Param('tripId') tripId: string,
    @Param('dayId') dayId: string,
    @Body() dto: CreateActivityDto,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.tripItineraryActivitiesService.createActivity(
      tripId,
      dayId,
      userId,
      dto,
    );

    return {
      data,
      message: 'Activity created successfully',
    };
  }

  // =========================================================
  // UPDATE ACTIVITY
  // =========================================================

  @Patch('activities/:activityId')
  @ApiOkResponse({
    type: ActivityEnvelopeResponseDto,
  })
  async updateActivity(
    @Param('tripId') tripId: string,
    @Param('activityId') activityId: string,
    @Body() dto: UpdateActivityDto,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.tripItineraryActivitiesService.updateActivity(
      tripId,
      activityId,
      dto,
      userId,
    );

    return {
      data,
      message: 'Activity updated successfully',
    };
  }

  // =========================================================
  // DELETE ACTIVITY
  // =========================================================

  @Delete('activities/:activityId')
  @ApiOkResponse({
    type: ItineraryActionResponseDto,
  })
  async deleteActivity(
    @Param('tripId') tripId: string,
    @Param('activityId') activityId: string,
    @CurrentUser('id') userId: string,
  ) {
    await this.tripItineraryActivitiesService.deleteActivity(
      tripId,
      activityId,
      userId,
    );

    return {
      success: true,
      message: 'Activity deleted successfully',
    };
  }

  // =========================================================
  // CHECK-IN
  // =========================================================

  @Post('activities/:activityId/checkin')
  @ApiCreatedResponse({
    type: TripCheckinEnvelopeResponseDto,
  })
  async checkin(
    @Param('tripId') tripId: string,
    @Param('activityId') activityId: string,
    @Body() dto: CheckinDto,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.tripItineraryActivitiesService.checkin(
      tripId,
      activityId,
      dto,
      userId,
    );

    return {
      data,
      message: 'Check-in successful',
    };
  }

  // =========================================================
  // UNCHECK-IN
  // =========================================================

  @Delete('activities/:activityId/checkin')
  @ApiOkResponse({
    type: ItineraryActionResponseDto,
  })
  async uncheckin(
    @Param('tripId') tripId: string,
    @Param('activityId') activityId: string,
    @CurrentUser('id') userId: string,
  ) {
    await this.tripItineraryActivitiesService.uncheckin(
      tripId,
      activityId,
      userId,
    );

    return {
      success: true,
      message: 'Check-in removed successfully',
    };
  }

  // =========================================================
  // COMPLETION STATUS
  // =========================================================

  @Get('completion-status')
  @ApiOkResponse({
    type: TripCompletionStatusEnvelopeResponseDto,
  })
  async getCompletionStatus(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data =
      await this.tripItineraryActivitiesService.getTripCompletionStatus(
        tripId,
        userId,
      );

    return {
      data,
      message: 'Trip completion status retrieved successfully',
    };
  }
  @Post('items/batch')
  @ApiCreatedResponse({ type: ItineraryItemsBatchResponseDto })
  createItemsBatch(
    @Param('tripId')
    tripId: string,

    @Body()
    dto: CreateItineraryItemsBatchDto,

    @CurrentUser('id')
    userId: string,
  ) {
    return this.tripItineraryActivitiesService.createItemsBatch(
      tripId,
      dto,
      userId,
    );
  }
}

@ApiTags('Itinerary')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('trips/:tripId/itinerary-days')
export class ItineraryDayItemsController {
  constructor(
    private readonly activitiesService: TripItinerariesActivitiesService,
  ) {}

  @Patch(':dayId/items/reorder')
  @ApiOkResponse({ type: ActivityResponseDto, isArray: true })
  reorderItems(
    @Param('tripId') tripId: string,
    @Param('dayId') dayId: string,
    @Body() dto: ReorderItineraryItemsDto,
    @CurrentUser('id') userId: string,
  ) {
    return this.activitiesService.reorderItems(tripId, dayId, dto, userId);
  }
}

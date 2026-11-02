import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  HttpCode,
  HttpStatus,
} from '@nestjs/common';

import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';

import { CreateTripDto } from './dto/create-trip.dto';
import { UpdateTripDto } from './dto/update-trip.dto';
import { QueryTripDto } from './dto/query-trip.dto';
import { QueryDiscoverTripDto } from './dto/query-discover-trip.dto';
import { DiscoverTripListResponseDto } from './dto/discover-trip-response.dto';

import { CurrentUser } from '../../decoration/currentUser.decoration';

import { TripsService } from './trips.service';

import { TripMemoriesService } from './trip-relations/trip-memories/trip-memories.service';

import { CreateMemoryDto } from './trip-relations/trip-memories/dto/create-memories.dto';
import { CreateMemoriesBatchDto } from './trip-relations/trip-memories/dto/create-memories-batch.dto';
import { UpdateMemoryDto } from './trip-relations/trip-memories/dto/update-memory.dto';

import { QueryMemoriesDto } from './trip-relations/trip-memories/dto/query-memories.dto';
import { QueryMyMemoriesDto } from './trip-relations/trip-memories/dto/query-my-memories.dto';

import {
  TripEnvelopeResponseDto,
  TripDetailEnvelopeResponseDto,
  TripActionResponseDto,
  TripMemberEnvelopeResponseDto,
  MemoryEnvelopeResponseDto,
  MemoriesBatchEnvelopeResponseDto,
  MemoriesCursorResponseDto,
  MyMemoriesResponseDto,
  MemoryLikeResponseDto,
  InviteCodeEnvelopeResponseDto,
  TripJoinRequestEnvelopeResponseDto,
  TripJoinInvitePreviewEnvelopeResponseDto,
} from '../../common/contracts/extended-response.dto';
import { JOIN_REQUEST_STATUS } from '../../generated/prisma/enums';

import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';
import { TripListResponseDto } from './dto/trip-list-response.dto';
import { CompanionRecommendationsResponseDto } from './trip-relations/trip-recommend-friend/companion-recommendation.dto';
import { RecommendFriendsToTripService } from './trip-relations/trip-recommend-friend/recommend-friends-to-trip.service';
import { CreateTripDraftDto } from './dto/create-trip-draft.dto';
import { TripExploreService } from './trip-relations/trip-explore/trip-explore.service';
import { RouteService } from './route/route.service';
import { TripMembersService } from './trip-relations/trip-members/trip-member.service';
import { TripDetailService } from './trip-detail/trip-detail.service';
import { TripJoinRequestsService } from './trip-relations/trip-join-requests/trip-join-requests.service';
import { TripRecruitmentService } from './trip-relations/trip-recruitment/trip-recruitment.service';
import { TripDiscoverService } from './trip-discover/trip-discover.service';
import { RequestToJoinDto } from './trip-relations/trip-join-requests/dto/request-to-join.dto';
import {
  RecruitmentMineEnvelopeDto,
  RecruitmentSummaryEnvelopeDto,
} from './trip-relations/trip-recruitment/dto/recruitment-response.dto';
import {
  CatalogPlacesQueryDto,
  CatalogPlacesResponseDto,
  DestinationCatalogResponseDto,
  RoutePreviewDto,
  RoutePreviewResponseDto,
} from './dto/destination-planning.dto';

@ApiTags('Trips')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('trips')
export class TripsController {
  constructor(
    private readonly tripsService: TripsService,
    private readonly tripMemoriesService: TripMemoriesService,
    private readonly recommendFriendsToTripService: RecommendFriendsToTripService,
    private readonly tripExploreService: TripExploreService,
    private readonly routeService: RouteService,
    private readonly tripMembersService: TripMembersService,
    private readonly tripDetailService: TripDetailService,
    private readonly tripJoinRequestsService: TripJoinRequestsService,
    private readonly tripRecruitmentService: TripRecruitmentService,
    private readonly tripDiscoverService: TripDiscoverService,
  ) {}

  // =========================================================
  // CREATE
  // =========================================================

  @Post()
  @ApiCreatedResponse({
    type: TripEnvelopeResponseDto,
  })
  async create(@CurrentUser('id') ownerId: string, @Body() dto: CreateTripDto) {
    const data = await this.tripsService.createTrip(ownerId, dto);

    return {
      data,
      message: 'Trip created successfully',
    };
  }

  @Post('drafts')
  @ApiCreatedResponse({ type: TripEnvelopeResponseDto })
  async createDraft(
    @CurrentUser('id') ownerId: string,
    @Body() dto: CreateTripDraftDto,
  ) {
    const data = await this.tripsService.createDraft(ownerId, dto);
    return { data, message: 'Trip draft created successfully' };
  }

  @Post(':tripId/finalize')
  @HttpCode(HttpStatus.OK)
  @ApiOkResponse({ type: TripEnvelopeResponseDto })
  async finalize(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.tripsService.finalizeTrip(tripId, userId);
    return { data, message: 'Trip finalized successfully' };
  }
  // =========================================================
  // GET MY DRAFTS
  // =========================================================

  @Get('my-drafts')
  @ApiOkResponse({
    type: TripListResponseDto,
  })
  async getMyDrafts(@CurrentUser('id') userId: string) {
    const data = await this.tripsService.getMyDrafts(userId);
    return {
      data,
      message: 'Trip retrieved successfully',
    };
  }

  @Get('destinations/catalog')
  @ApiOkResponse({ type: DestinationCatalogResponseDto })
  async getDestinationCatalog(@Query('q') query?: string) {
    const data = await this.tripsService.getDestinationCatalog(query);
    return { data, message: 'Destination catalog retrieved successfully' };
  }

  @Get('destinations/catalog/:catalogId/places')
  @ApiOkResponse({ type: CatalogPlacesResponseDto })
  async getCatalogPlaces(
    @Param('catalogId') catalogId: string,
    @Query() query: CatalogPlacesQueryDto,
  ) {
    const data = await this.tripExploreService.getCatalogPlaces(
      catalogId,
      query.category,
      query.limit,
      query.sort,
    );
    return { data, message: 'Destination places retrieved successfully' };
  }

  @Post('routes/preview')
  @HttpCode(HttpStatus.OK)
  @ApiOkResponse({ type: RoutePreviewResponseDto })
  async previewRoute(
    @CurrentUser('id') userId: string,
    @Body() dto: RoutePreviewDto,
  ) {
    const data = await this.routeService.previewRoute(
      userId,
      { latitude: dto.origin.lat, longitude: dto.origin.lng },
      { latitude: dto.destination.lat, longitude: dto.destination.lng },
    );
    return { data, message: 'Route preview retrieved successfully' };
  }

  @Get(':tripId/explore')
  @ApiOkResponse({
    schema: {
      type: 'object',
      required: ['data', 'message'],
      properties: {
        data: { type: 'object', additionalProperties: true },
        message: { type: 'string' },
      },
    },
  })
  async getExplore(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.tripExploreService.getExplore(tripId, userId);
    return { data, message: 'Trip explore data retrieved successfully' };
  }

  @Get(':tripId/destinations/:destinationId/places')
  @ApiOkResponse({
    schema: {
      type: 'object',
      required: ['data', 'message'],
      properties: {
        data: {
          type: 'array',
          items: { type: 'object', additionalProperties: true },
        },
        message: { type: 'string' },
      },
    },
  })
  async getDestinationPlaces(
    @Param('tripId') tripId: string,
    @Param('destinationId') destinationId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.tripExploreService.getDestinationPlaces(
      tripId,
      destinationId,
      userId,
    );
    return { data, message: 'Destination places retrieved successfully' };
  }

  // =========================================================
  // LIST
  // =========================================================

  @Get('discover')
  @ApiOkResponse({ type: DiscoverTripListResponseDto })
  discover(
    @Query() query: QueryDiscoverTripDto,
    @CurrentUser('id') userId: string,
  ) {
    return this.tripDiscoverService.discover(query, userId);
  }

  @Get()
  @ApiOkResponse({
    type: TripListResponseDto,
  })
  findAll(
    @Query()
    query: QueryTripDto,

    @CurrentUser('id')
    userId: string,
  ) {
    return this.tripsService.queryTrip(query, userId);
  }

  @Get('mine/summary')
  @ApiOkResponse({ type: RecruitmentSummaryEnvelopeDto })
  async recruitmentSummary(@CurrentUser('id') userId: string) {
    const data = await this.tripRecruitmentService.summary(userId);
    return { data, message: 'Recruitment summary retrieved successfully' };
  }

  @Get('mine')
  @ApiOkResponse({ type: RecruitmentMineEnvelopeDto })
  async recruitmentMine(@CurrentUser('id') userId: string) {
    const data = await this.tripRecruitmentService.mine(userId);
    return { data, message: 'Recruitment trips retrieved successfully' };
  }

  // =========================================================
  // DETAIL
  // =========================================================

  @Get(':id')
  @ApiOkResponse({
    type: TripDetailEnvelopeResponseDto,
  })
  async findOne(@Param('id') id: string, @CurrentUser('id') userId: string) {
    const data = await this.tripDetailService.getTripDetail(id, userId);

    return {
      data,
      message: 'Trip retrieved successfully',
    };
  }

  // =========================================================
  // UPDATE
  // =========================================================

  @Patch(':id')
  @ApiOkResponse({
    type: TripEnvelopeResponseDto,
  })
  async update(
    @CurrentUser('id') userId: string,
    @Param('id') id: string,
    @Body() dto: UpdateTripDto,
  ) {
    const data = await this.tripsService.updateTrip(id, userId, dto);

    return {
      data,
      message: 'Trip updated successfully',
    };
  }

  // =========================================================
  // DELETE
  // =========================================================

  @Delete(':id')
  @ApiOkResponse({
    type: TripActionResponseDto,
  })
  async deleteTrip(@CurrentUser('id') userId: string, @Param('id') id: string) {
    await this.tripsService.deleteTrip(id, userId);

    return {
      success: true,
      message: 'Trip deleted successfully',
    };
  }

  // =========================================================
  // JOIN
  // =========================================================

  @Get('join/:inviteCode')
  @ApiOkResponse({
    type: TripJoinInvitePreviewEnvelopeResponseDto,
    description:
      'Looks up a trip by invite code so the viewer can preview it before sending a join request.',
  })
  async previewJoinByInviteCode(
    @CurrentUser('id') userId: string,
    @Param('inviteCode') inviteCode: string,
  ) {
    const data = await this.tripJoinRequestsService.previewByInviteCode(
      inviteCode,
      userId,
    );

    return {
      data,
      message: 'Invite preview retrieved successfully',
    };
  }

  @Post('join/:inviteCode')
  @ApiCreatedResponse({
    type: TripJoinRequestEnvelopeResponseDto,
    description:
      'Creates a PENDING join request for the owner and admins to review. Friends of the owner are APPROVED and become members right away when the trip auto-approves them.',
  })
  async joinByInviteCode(
    @CurrentUser('id') userId: string,
    @Param('inviteCode') inviteCode: string,
    @Body() dto: RequestToJoinDto,
  ) {
    const data = await this.tripJoinRequestsService.requestToJoin(
      inviteCode,
      userId,
      dto,
    );

    return {
      data,
      message:
        data.status === JOIN_REQUEST_STATUS.APPROVED
          ? 'Joined trip successfully'
          : 'Join request sent successfully',
    };
  }

  @Get(':tripId/join/preview')
  @ApiOkResponse({
    type: TripJoinInvitePreviewEnvelopeResponseDto,
    description:
      'Preview a PUBLIC trip before sending a join request by trip id (Community Explore).',
  })
  async previewJoinByTripId(
    @CurrentUser('id') userId: string,
    @Param('tripId') tripId: string,
  ) {
    const data = await this.tripJoinRequestsService.previewByTripId(
      tripId,
      userId,
    );

    return {
      data,
      message: 'Join preview retrieved successfully',
    };
  }

  @Post(':tripId/join')
  @ApiCreatedResponse({
    type: TripJoinRequestEnvelopeResponseDto,
    description:
      'Request to join a PUBLIC trip by id. PRIVATE trips must use an invite code.',
  })
  async joinByTripId(
    @CurrentUser('id') userId: string,
    @Param('tripId') tripId: string,
    @Body() dto: RequestToJoinDto,
  ) {
    const data = await this.tripJoinRequestsService.requestToJoinByTripId(
      tripId,
      userId,
      dto,
    );

    return {
      data,
      message:
        data.status === JOIN_REQUEST_STATUS.APPROVED
          ? 'Joined trip successfully'
          : 'Join request sent successfully',
    };
  }

  // =========================================================
  // ROTATE INVITE CODE
  // =========================================================

  @Post(':tripId/invite-code/rotate')
  @HttpCode(HttpStatus.OK)
  @ApiOkResponse({ type: InviteCodeEnvelopeResponseDto })
  async rotateInviteCode(
    @CurrentUser('id') userId: string,
    @Param('tripId') tripId: string,
  ) {
    const data = await this.tripMembersService.rotateInviteCode(tripId, userId);
    return { data, message: 'Invite code rotated successfully' };
  }

  // =========================================================
  // LEAVE
  // =========================================================

  @Post('leave/:tripId')
  @ApiCreatedResponse({
    type: TripMemberEnvelopeResponseDto,
  })
  async leaveTrip(
    @CurrentUser('id') userId: string,
    @Param('tripId') tripId: string,
  ) {
    const data = await this.tripMembersService.leaveTrip(tripId, userId);

    return {
      data,
      message: 'Left trip successfully',
    };
  }

  // =========================================================
  // KICK MEMBER
  // =========================================================

  @Post('kick/:tripId/:targetUserId')
  @ApiCreatedResponse({
    type: TripMemberEnvelopeResponseDto,
  })
  async kickMember(
    @CurrentUser('id') requesterId: string,
    @Param('tripId') tripId: string,
    @Param('targetUserId') targetUserId: string,
  ) {
    const data = await this.tripMembersService.kickMember(
      tripId,
      targetUserId,
      requesterId,
    );

    return {
      data,
      message: 'Member removed from trip successfully',
    };
  }

  // =========================================================
  // CREATE MEMORY
  // =========================================================

  @Post('memories/:tripId')
  @ApiCreatedResponse({
    type: MemoryEnvelopeResponseDto,
  })
  async createTripMemory(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
    @Body() dto: CreateMemoryDto,
  ) {
    const data = await this.tripMemoriesService.createMemory(
      tripId,
      userId,
      dto,
    );

    return {
      data,
      message: 'Memory created successfully',
    };
  }

  @Post('memories/:tripId/batch')
  @ApiCreatedResponse({
    type: MemoriesBatchEnvelopeResponseDto,
    description:
      'Adds up to 20 photos in one transaction and records a single MEMORY_ADDED timeline event.',
  })
  async createTripMemories(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
    @Body() dto: CreateMemoriesBatchDto,
  ) {
    const data = await this.tripMemoriesService.createMemories(
      tripId,
      userId,
      dto.items,
    );

    return {
      data,
      message: 'Memories created successfully',
    };
  }

  // =========================================================
  // VIEWER MEMORIES — register before memories/:tripId
  // =========================================================

  @Get('memories/mine')
  @ApiOkResponse({ type: MyMemoriesResponseDto })
  getMyMemories(
    @CurrentUser('id') userId: string,
    @Query() query: QueryMyMemoriesDto,
  ) {
    return this.tripMemoriesService.getMyMemories(userId, query);
  }

  @Post('memories/:memoryId/like')
  @HttpCode(HttpStatus.OK)
  @ApiOkResponse({ type: MemoryLikeResponseDto })
  likeMemory(
    @Param('memoryId') memoryId: string,
    @CurrentUser('id') userId: string,
  ) {
    return this.tripMemoriesService.likeMemory(memoryId, userId);
  }

  @Delete('memories/:memoryId/like')
  @ApiOkResponse({ type: MemoryLikeResponseDto })
  unlikeMemory(
    @Param('memoryId') memoryId: string,
    @CurrentUser('id') userId: string,
  ) {
    return this.tripMemoriesService.unlikeMemory(memoryId, userId);
  }

  // =========================================================
  // MEMORIES CURSOR PAGINATION
  // =========================================================

  @Get('memories/:tripId')
  @ApiOkResponse({
    type: MemoriesCursorResponseDto,
  })
  getMemories(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
    @Query() query: QueryMemoriesDto,
  ) {
    return this.tripMemoriesService.getMemories(tripId, userId, query);
  }
  // =========================================================
  // UPDATE MEMORY
  // =========================================================
  @Patch('memories/:memoryId')
  @ApiOkResponse({
    type: MemoryEnvelopeResponseDto,
  })
  async updateMemory(
    @Param('memoryId') memoryId: string,
    @CurrentUser('id') userId: string,
    @Body() dto: UpdateMemoryDto,
  ) {
    const data = await this.tripMemoriesService.updateMemory(
      memoryId,
      userId,
      dto,
    );

    return {
      data,
      message: 'Memory updated successfully',
    };
  }

  // =========================================================
  // DELETE MEMORY
  // =========================================================

  @Delete('memories/:memoryId')
  @ApiOkResponse({
    type: TripActionResponseDto,
  })
  async deleteMemory(
    @Param('memoryId') memoryId: string,
    @CurrentUser('id') userId: string,
  ) {
    await this.tripMemoriesService.deleteMemory(memoryId, userId);

    return {
      success: true,
      message: 'Memory deleted successfully',
    };
  }
  // ===================================================
  // Recommend Friends to Trip
  // =========================================================

  @Get('recommend-friends/:tripId')
  @ApiOkResponse({
    type: CompanionRecommendationsResponseDto,
  })
  async recommendFriendsToTrip(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
  ) {
    const result =
      await this.recommendFriendsToTripService.getCompanionRecommendations(
        tripId,
        userId,
      );
    return {
      data: result.recommendations,
      tripTravelPersona: result.tripTravelPersona,
      message: 'Recommended friends retrieved successfully',
    };
  }
}

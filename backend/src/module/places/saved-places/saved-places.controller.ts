import { Controller, Delete, Get, Param, Post, Query } from '@nestjs/common';

import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';

import { CurrentUser } from '../../../decoration/currentUser.decoration';

import { SavedPlacesService } from './saved-places.service';

import { PaginationDto } from '../../users/dto/pagination.dto';

import {
  RemoveSavedPlaceResponseDto,
  SavedPlaceEnvelopeResponseDto,
  SavedPlacesCountEnvelopeResponseDto,
  SavedPlacesPageResponseDto,
  SavedPlaceStatusEnvelopeResponseDto,
} from '../../../common/contracts/extended-response.dto';

import { ApiStandardErrors } from '../../../common/contracts/api-standard-errors.decorator';

@ApiTags('Saved Places')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('places')
export class SavedPlacesController {
  constructor(private readonly savedPlacesService: SavedPlacesService) {}

  // =========================================================
  // SAVE
  // POST /places/:placeId/save
  // =========================================================

  @Post(':placeId/save')
  @ApiCreatedResponse({
    type: SavedPlaceEnvelopeResponseDto,
  })
  async save(
    @CurrentUser('id') userId: string,
    @Param('placeId') placeId: string,
  ) {
    const data = await this.savedPlacesService.save(userId, placeId);

    return {
      data,
      message: 'Place saved successfully',
    };
  }

  // =========================================================
  // UNSAVE
  // DELETE /places/:placeId/save
  // =========================================================

  @Delete(':placeId/save')
  @ApiOkResponse({
    type: RemoveSavedPlaceResponseDto,
  })
  async remove(
    @CurrentUser('id') userId: string,
    @Param('placeId') placeId: string,
  ) {
    await this.savedPlacesService.remove(userId, placeId);

    return {
      success: true,
      message: 'Place unsaved successfully',
    };
  }

  // =========================================================
  // STATUS
  // GET /places/:placeId/save/status
  // =========================================================

  @Get(':placeId/save/status')
  @ApiOkResponse({
    type: SavedPlaceStatusEnvelopeResponseDto,
  })
  async getStatus(
    @CurrentUser('id') userId: string,
    @Param('placeId') placeId: string,
  ) {
    const data = await this.savedPlacesService.getStatus(userId, placeId);

    return {
      data,
      message: 'Saved place status retrieved successfully',
    };
  }

  // =========================================================
  // MY SAVED PLACES
  // =========================================================

  @Get('saved/me')
  @ApiOkResponse({
    type: SavedPlacesPageResponseDto,
  })
  findMySavedPlaces(
    @CurrentUser('id') userId: string,
    @Query() page: PaginationDto,
  ) {
    return this.savedPlacesService.findMySavedPlaces(userId, page);
  }

  // =========================================================
  // COUNT
  // =========================================================

  @Get('saved/count')
  @ApiOkResponse({
    type: SavedPlacesCountEnvelopeResponseDto,
  })
  async countMySavedPlaces(@CurrentUser('id') userId: string) {
    const data = await this.savedPlacesService.countMySavedPlaces(userId);

    return {
      data,
      message: 'Saved places count retrieved successfully',
    };
  }
}

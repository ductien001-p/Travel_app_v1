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

import { PlacesService } from './places.service';
import { SearchPlaceService } from './search-place.service';
import { PlaceGalaryService } from './place-gallary/place-galary.service';
import { FeaturedPlacesService } from './featured-places.service';
import { NearbyPlacesService } from './nearby-places.service';
import {
  FeaturedPlacesQueryDto,
  NearbyPlacesQueryDto,
} from './dto/explore-places-query.dto';
import {
  FeaturedPlacesResponseDto,
  NearbyPlacesResponseDto,
} from './dto/explore-places.response.dto';

import { CreatePlaceDto } from './dto/create-place.dto';
import { UpdatePlaceDto } from './dto/update-place.dto';
import { PaginationDto } from '../users/dto/pagination.dto';
import { CreateSearchDto } from './dto/create-search.dto';
import { DeleteGalleryDto } from './place-gallary/dto/delete-gallary.dto';

import { Roles } from '../../decoration/role.decoriation';
import { CurrentUser } from '../../decoration/currentUser.decoration';

import { USER_ROLE } from '../../generated/prisma/browser';

import {
  PlaceEnvelopeResponseDto,
  PlacesPageResponseDto,
  PendingPlacesPageResponseDto,
  PlaceSearchResponseDto,
  PlaceDeleteResponseDto,
  GalleryDeleteEnvelopeResponseDto,
} from '../../common/contracts/extended-response.dto';

import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';

@ApiTags('Places')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('places')
export class PlacesController {
  constructor(
    private readonly placesService: PlacesService,
    private readonly searchPlaceService: SearchPlaceService,
    private readonly placeGalaryService: PlaceGalaryService,
    private readonly featuredPlacesService: FeaturedPlacesService,
    private readonly nearbyPlacesService: NearbyPlacesService,
  ) {}
  // =========================================================
  // SEMANTIC SEARCH
  // =========================================================

  @Post('search-embeddings')
  @ApiCreatedResponse({
    type: PlaceSearchResponseDto,
  })
  async searchPlaceEmbeddings(
    @Body() searchDto: CreateSearchDto,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.searchPlaceService.semanticSearch(
      searchDto.query,
      searchDto.destinationId,
      searchDto.radiusKm,
      userId,
      searchDto.categories,
    );

    return {
      data,
      message: 'Places searched successfully',
    };
  }

  // =========================================================
  // ADMIN
  // =========================================================

  @Post('admin/create')
  @Roles(USER_ROLE.ADMIN)
  @ApiCreatedResponse({
    type: PlaceEnvelopeResponseDto,
  })
  async createByAdmin(
    @Body() dto: CreatePlaceDto,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.placesService.createByAdmin(dto, userId);

    return {
      data,
      message: 'Place created successfully',
    };
  }

  @Get('admin/pending')
  @Roles(USER_ROLE.ADMIN)
  @ApiOkResponse({
    type: PendingPlacesPageResponseDto,
  })
  findPending(@Query() paginationDto: PaginationDto) {
    return this.placesService.findPending(paginationDto);
  }

  @Patch(':id/approve')
  @Roles(USER_ROLE.ADMIN)
  @ApiOkResponse({
    type: PlaceEnvelopeResponseDto,
  })
  async approve(@Param('id') id: string, @CurrentUser('id') userId: string) {
    const data = await this.placesService.approve(id, userId);

    return {
      data,
      message: 'Place approved successfully',
    };
  }

  @Patch(':id/reject')
  @Roles(USER_ROLE.ADMIN)
  @ApiOkResponse({
    type: PlaceEnvelopeResponseDto,
  })
  async reject(@Param('id') id: string, @CurrentUser('id') userId: string) {
    const data = await this.placesService.reject(id, userId);

    return {
      data,
      message: 'Place rejected successfully',
    };
  }

  @Delete(':id')
  @Roles(USER_ROLE.ADMIN)
  @ApiOkResponse({
    type: PlaceDeleteResponseDto,
  })
  async softDelete(@Param('id') id: string, @CurrentUser('id') userId: string) {
    await this.placesService.softDelete(id, userId);

    return {
      success: true,
      message: 'Place deleted successfully',
    };
  }

  // =========================================================
  // USER
  // =========================================================

  @Post()
  @ApiCreatedResponse({
    type: PlaceEnvelopeResponseDto,
  })
  async create(@Body() dto: CreatePlaceDto, @CurrentUser('id') userId: string) {
    const data = await this.placesService.createByUser(dto, userId);

    return {
      data,
      message: 'Place submitted successfully',
    };
  }

  @Patch(':id')
  @ApiOkResponse({
    type: PlaceEnvelopeResponseDto,
  })
  async update(
    @Param('id') id: string,
    @Body() dto: UpdatePlaceDto,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.placesService.update(id, dto, userId);

    return {
      data,
      message: 'Place updated successfully',
    };
  }

  @Get('featured')
  @ApiOkResponse({ type: FeaturedPlacesResponseDto })
  async findFeatured(
    @CurrentUser('id') userId: string,
    @Query() query: FeaturedPlacesQueryDto,
  ) {
    const data = await this.featuredPlacesService.findForUser(
      userId,
      query.utcOffsetMinutes,
    );
    return { data, message: 'Featured places retrieved successfully' };
  }

  @Get('nearby')
  @ApiOkResponse({ type: NearbyPlacesResponseDto })
  async findNearby(@Query() query: NearbyPlacesQueryDto) {
    const data = await this.nearbyPlacesService.findNearby(
      query.latitude,
      query.longitude,
      query.radiusKm,
    );
    return { data, message: 'Nearby places retrieved successfully' };
  }

  @Get()
  @ApiOkResponse({
    type: PlacesPageResponseDto,
  })
  findMany(@Query() paginationDto: PaginationDto) {
    return this.placesService.findPublicMany(paginationDto);
  }

  @Get(':id')
  @ApiOkResponse({
    type: PlaceEnvelopeResponseDto,
  })
  async findOne(@Param('id') id: string) {
    const data = await this.placesService.findPublicById(id);

    return {
      data,
      message: 'Place retrieved successfully',
    };
  }

  // =========================================================
  // GALLERY
  // =========================================================

  @Delete(':placeId/gallery')
  @ApiOkResponse({
    type: GalleryDeleteEnvelopeResponseDto,
  })
  async deleteGalleryMedia(
    @Param('placeId') placeId: string,
    @Body() dto: DeleteGalleryDto,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.placeGalaryService.deleteGalleryMedia(
      userId,
      placeId,
      dto.mediaIds,
    );

    return {
      data,
      message: 'Gallery media deleted successfully',
    };
  }
}

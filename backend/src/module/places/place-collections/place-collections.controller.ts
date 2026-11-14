import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Put,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
} from '@nestjs/swagger';
import { CurrentUser } from '../../../decoration/currentUser.decoration';
import { ApiStandardErrors } from '../../../common/contracts/api-standard-errors.decorator';
import { PlaceCollectionsService } from './place-collections.service';
import {
  CreatePlaceCollectionDto,
  PlaceMembershipDto,
  RatePlaceCollectionDto,
  UpdatePlaceCollectionDto,
} from './dto/place-collection.dto';
import {
  FeaturedCollectionsResponseDto,
  OwnedPlaceCollectionResponseDto,
  OwnedPlaceCollectionsResponseDto,
  PlaceCollectionDeleteResponseDto,
  PlaceCollectionDetailResponseDto,
  PlaceCollectionRatingResponseDto,
  PlaceMembershipResponseDto,
} from './dto/place-collection.response.dto';

@ApiTags('Place Collections')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('place-collections')
export class PlaceCollectionsController {
  constructor(private readonly collections: PlaceCollectionsService) {}

  @Post()
  @ApiCreatedResponse({ type: OwnedPlaceCollectionResponseDto })
  async create(
    @CurrentUser('id') userId: string,
    @Body() dto: CreatePlaceCollectionDto,
  ) {
    const data = await this.collections.create(userId, dto.title);
    return { data, message: 'Collection created successfully' };
  }

  @Get('mine')
  @ApiOkResponse({ type: OwnedPlaceCollectionsResponseDto })
  async findMine(@CurrentUser('id') userId: string) {
    const data = await this.collections.findMine(userId);
    return { data, message: 'Collections retrieved successfully' };
  }

  @Get('featured')
  @ApiOkResponse({ type: FeaturedCollectionsResponseDto })
  async findFeatured() {
    const data = await this.collections.findFeatured();
    return { data, message: 'Featured collections retrieved successfully' };
  }

  @Put('places/:placeId/membership')
  @ApiOperation({
    summary:
      'Update which of the caller collections contain a place. Returns 403 when a collection is not owned by the caller.',
  })
  @ApiOkResponse({ type: PlaceMembershipResponseDto })
  async setMembership(
    @CurrentUser('id') userId: string,
    @Param('placeId') placeId: string,
    @Body() dto: PlaceMembershipDto,
  ) {
    const data = await this.collections.setMembership(
      userId,
      placeId,
      dto.collectionIds,
    );
    return { data, message: 'Collection membership updated successfully' };
  }

  @Get(':id')
  @ApiOperation({
    summary:
      'Read a collection. Returns 403 when the collection is private and the caller is not the owner.',
  })
  @ApiOkResponse({ type: PlaceCollectionDetailResponseDto })
  async findOne(@CurrentUser('id') userId: string, @Param('id') id: string) {
    const data = await this.collections.findOne(userId, id);
    return { data, message: 'Collection retrieved successfully' };
  }

  @Patch(':id')
  @ApiOperation({
    summary:
      'Update a collection. Returns 403 when the caller does not own it.',
  })
  @ApiOkResponse({ type: OwnedPlaceCollectionResponseDto })
  async update(
    @CurrentUser('id') userId: string,
    @Param('id') id: string,
    @Body() dto: UpdatePlaceCollectionDto,
  ) {
    const data = await this.collections.update(userId, id, dto);
    return { data, message: 'Collection updated successfully' };
  }

  @Delete(':id')
  @ApiOperation({
    summary:
      'Delete a collection. Returns 403 when the caller does not own it.',
  })
  @ApiOkResponse({ type: PlaceCollectionDeleteResponseDto })
  async remove(@CurrentUser('id') userId: string, @Param('id') id: string) {
    await this.collections.remove(userId, id);
    return { success: true, message: 'Collection deleted successfully' };
  }

  @Post(':id/copy')
  @ApiOperation({
    summary:
      'Copy a public collection. Returns 403 when the collection is not public.',
  })
  @ApiCreatedResponse({ type: OwnedPlaceCollectionResponseDto })
  async copy(@CurrentUser('id') userId: string, @Param('id') id: string) {
    const data = await this.collections.copy(userId, id);
    return { data, message: 'Collection copied successfully' };
  }

  @Put(':id/rating')
  @ApiOperation({
    summary:
      'Rate a public collection. Returns 403 when the collection is not public.',
  })
  @ApiOkResponse({ type: PlaceCollectionRatingResponseDto })
  async rate(
    @CurrentUser('id') userId: string,
    @Param('id') id: string,
    @Body() dto: RatePlaceCollectionDto,
  ) {
    const data = await this.collections.rate(userId, id, dto.rating);
    return { data, message: 'Collection rated successfully' };
  }
}

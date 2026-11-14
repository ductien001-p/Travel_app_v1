import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Query,
} from '@nestjs/common';

import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';

import { CurrentUser } from '../../../decoration/currentUser.decoration';

import { CreatePlaceReviewDto } from './dto/create-review-place.dto';
import { PlaceReviewsService } from './review-places.service';
import { PaginationDto } from '../../users/dto/pagination.dto';

import {
  DeletePlaceReviewResponseDto,
  MyPlaceReviewResponseDto,
  PlaceRatingSummaryEnvelopeResponseDto,
  PlaceReviewEnvelopeResponseDto,
  PlaceReviewsPageResponseDto,
} from '../../../common/contracts/extended-response.dto';

import { ApiStandardErrors } from '../../../common/contracts/api-standard-errors.decorator';

@ApiTags('Place Reviews')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('places')
export class PlaceReviewsController {
  constructor(private readonly placeReviewsService: PlaceReviewsService) {}

  // =========================================================
  // CREATE
  // POST /places/:placeId/reviews
  // =========================================================

  @Post(':placeId/reviews')
  @ApiCreatedResponse({
    type: PlaceReviewEnvelopeResponseDto,
  })
  async create(
    @CurrentUser('id') userId: string,
    @Param('placeId') placeId: string,
    @Body() dto: CreatePlaceReviewDto,
  ) {
    const data = await this.placeReviewsService.create(userId, placeId, dto);

    return {
      data,
      message: 'Review created successfully',
    };
  }

  // =========================================================
  // GET REVIEWS
  // =========================================================

  @Get(':placeId/reviews')
  @ApiOkResponse({
    type: PlaceReviewsPageResponseDto,
  })
  findByPlace(@Param('placeId') placeId: string, @Query() page: PaginationDto) {
    return this.placeReviewsService.findByPlace(placeId, page);
  }

  // =========================================================
  // MY REVIEW
  // =========================================================

  @Get(':placeId/reviews/me')
  @ApiOkResponse({
    type: MyPlaceReviewResponseDto,
  })
  async findMyReview(
    @CurrentUser('id') userId: string,
    @Param('placeId') placeId: string,
  ) {
    const data = await this.placeReviewsService.findMyReview(userId, placeId);

    return {
      data,
      message: 'My review retrieved successfully',
    };
  }

  // =========================================================
  // RATING SUMMARY
  // =========================================================

  @Get(':placeId/reviews/summary')
  @ApiOkResponse({
    type: PlaceRatingSummaryEnvelopeResponseDto,
  })
  async getRatingSummary(@Param('placeId') placeId: string) {
    const data = await this.placeReviewsService.getRatingSummary(placeId);

    return {
      data,
      message: 'Rating summary retrieved successfully',
    };
  }

  // =========================================================
  // GET ONE REVIEW
  // =========================================================

  @Get('reviews/:reviewId')
  @ApiOkResponse({
    type: PlaceReviewEnvelopeResponseDto,
  })
  async findById(@Param('reviewId') reviewId: string) {
    const data = await this.placeReviewsService.findById(reviewId);

    return {
      data,
      message: 'Review retrieved successfully',
    };
  }

  // =========================================================
  // DELETE
  // =========================================================

  @Delete('reviews/:reviewId')
  @ApiOkResponse({
    type: DeletePlaceReviewResponseDto,
  })
  async remove(
    @CurrentUser('id') userId: string,
    @Param('reviewId') reviewId: string,
  ) {
    await this.placeReviewsService.remove(userId, reviewId);

    return {
      success: true,
      message: 'Review deleted successfully',
    };
  }
}

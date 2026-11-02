import { Controller, Get, Post, Body, Delete, Query } from '@nestjs/common';

import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';

import { CreateFollowDto } from './dto/create-follow.dto';
import { FollowService } from './follow.service';
import { CurrentUser } from '../../decoration/currentUser.decoration';
import { PaginationDto } from '../users/dto/pagination.dto';

import {
  FollowersPageResponseDto,
  FollowEnvelopeResponseDto,
} from '../../common/contracts/extended-response.dto';

import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';

@ApiTags('Follow')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('follow')
export class FollowController {
  constructor(private readonly followService: FollowService) {}

  @Post()
  @ApiCreatedResponse({
    type: FollowEnvelopeResponseDto,
  })
  async create(
    @Body() createFollowDto: CreateFollowDto,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.followService.createFollow(
      userId,
      createFollowDto.followingId,
    );

    return {
      data,
      message: 'Followed user successfully',
    };
  }

  @Delete()
  @ApiOkResponse({
    type: FollowEnvelopeResponseDto,
  })
  async remove(
    @Body() createFollowDto: CreateFollowDto,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.followService.removeFollow(
      userId,
      createFollowDto.followingId,
    );

    return {
      data,
      message: 'Unfollowed user successfully',
    };
  }

  @Get('followers')
  @ApiOkResponse({
    type: FollowersPageResponseDto,
  })
  getFollowers(
    @Query() page: PaginationDto,
    @CurrentUser('id') userId: string,
  ) {
    return this.followService.getFollowers(userId, page);
  }
}

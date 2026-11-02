import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Query,
  Post,
} from '@nestjs/common';

import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';

import { CreatePostDto } from './dto/create-post.dto';
import { UpdatePostDto } from './dto/update-post.dto';
import { CurrentUser } from '../../decoration/currentUser.decoration';
import { PostsService } from './post.service';
import { PaginationDto } from '../users/dto/pagination.dto';

import {
  PostEnvelopeResponseDto,
  PostsPageResponseDto,
  DeletePostResponseDto,
} from '../../common/contracts/extended-response.dto';

import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';

@ApiTags('Posts')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('social/posts')
export class PostsController {
  constructor(private readonly postsService: PostsService) {}

  // =========================================================
  // CREATE
  // =========================================================

  @Post()
  @ApiCreatedResponse({
    type: PostEnvelopeResponseDto,
  })
  async create(@CurrentUser('id') userId: string, @Body() dto: CreatePostDto) {
    const data = await this.postsService.create(userId, dto);

    return {
      data,
      message: 'Post created successfully',
    };
  }

  // =========================================================
  // FEED
  // =========================================================

  @Get('feed')
  @ApiOkResponse({
    type: PostsPageResponseDto,
  })
  findFeed(
    @CurrentUser('id') userId: string,
    @Query() pagination: PaginationDto,
  ) {
    return this.postsService.findFeed(userId, pagination);
  }

  // =========================================================
  // MY POSTS
  // =========================================================

  @Get('me')
  @ApiOkResponse({
    type: PostsPageResponseDto,
  })
  findMyPosts(
    @CurrentUser('id') userId: string,
    @Query() pagination: PaginationDto,
  ) {
    return this.postsService.findMyPosts(userId, pagination);
  }

  // =========================================================
  // POSTS BY PLACE
  // =========================================================

  @Get('place/:placeId')
  @ApiOkResponse({
    type: PostsPageResponseDto,
  })
  findByPlace(
    @Param('placeId') placeId: string,
    @CurrentUser('id') userId: string,
    @Query() pagination: PaginationDto,
  ) {
    return this.postsService.findByPlace(placeId, userId, pagination);
  }

  // =========================================================
  // DETAIL
  // =========================================================

  @Get(':postId')
  @ApiOkResponse({
    type: PostEnvelopeResponseDto,
  })
  async findById(
    @Param('postId') postId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.postsService.findById(postId, userId);

    return {
      data,
      message: 'Post retrieved successfully',
    };
  }

  // =========================================================
  // UPDATE
  // =========================================================

  @Patch(':postId')
  @ApiOkResponse({
    type: PostEnvelopeResponseDto,
  })
  async update(
    @CurrentUser('id') userId: string,
    @Param('postId') postId: string,
    @Body() dto: UpdatePostDto,
  ) {
    const data = await this.postsService.update(userId, postId, dto);

    return {
      data,
      message: 'Post updated successfully',
    };
  }

  // =========================================================
  // DELETE
  // =========================================================

  @Delete(':postId')
  @ApiOkResponse({
    type: DeletePostResponseDto,
  })
  async remove(
    @CurrentUser('id') userId: string,
    @Param('postId') postId: string,
  ) {
    await this.postsService.remove(userId, postId);

    return {
      success: true,
      message: 'Post deleted successfully',
    };
  }
}

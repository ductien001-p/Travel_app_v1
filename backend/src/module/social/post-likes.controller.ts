import { Controller, Delete, Param, Post } from '@nestjs/common';

import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';

import { PostLikesService } from './post-likes.service';

import { CurrentUser } from '../../decoration/currentUser.decoration';

import { InteractionActionResponseDto } from '../../common/contracts/extended-response.dto';

import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';

@ApiTags('Post Likes')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('social/posts')
export class PostLikesController {
  constructor(private readonly postLikesService: PostLikesService) {}

  // =========================================================
  // LIKE
  // =========================================================

  @Post(':postId/like')
  @ApiCreatedResponse({
    type: InteractionActionResponseDto,
  })
  async like(
    @CurrentUser('id') userId: string,
    @Param('postId') postId: string,
  ) {
    await this.postLikesService.like(userId, postId);

    return {
      success: true,
      message: 'Post liked successfully',
    };
  }

  // =========================================================
  // UNLIKE
  // =========================================================

  @Delete(':postId/like')
  @ApiOkResponse({
    type: InteractionActionResponseDto,
  })
  async unlike(
    @CurrentUser('id') userId: string,
    @Param('postId') postId: string,
  ) {
    await this.postLikesService.unlike(userId, postId);

    return {
      success: true,
      message: 'Post unliked successfully',
    };
  }

}

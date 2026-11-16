import { Controller, Delete, Param, Post } from '@nestjs/common';

import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';

import { PostSharesService } from './post-shares.service';

import { CurrentUser } from '../../decoration/currentUser.decoration';

import { InteractionActionResponseDto } from '../../common/contracts/extended-response.dto';

import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';

@ApiTags('Post Shares')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('social/posts')
export class PostSharesController {
  constructor(private readonly postSharesService: PostSharesService) {}

  // =========================================================
  // SHARE
  // =========================================================

  @Post(':postId/share')
  @ApiCreatedResponse({
    type: InteractionActionResponseDto,
  })
  async share(
    @CurrentUser('id') userId: string,
    @Param('postId') postId: string,
  ) {
    await this.postSharesService.share(userId, postId);

    return {
      success: true,
      message: 'Post shared successfully',
    };
  }

  // =========================================================
  // UNSHARE
  // =========================================================

  @Delete(':postId/share')
  @ApiOkResponse({
    type: InteractionActionResponseDto,
  })
  async unshare(
    @CurrentUser('id') userId: string,
    @Param('postId') postId: string,
  ) {
    await this.postSharesService.unshare(userId, postId);

    return {
      success: true,
      message: 'Post unshared successfully',
    };
  }

}

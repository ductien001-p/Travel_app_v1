import { Controller, Delete, Param, Post } from '@nestjs/common';

import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';

import { PostSavesService } from './post-saves.service';
import { CurrentUser } from '../../decoration/currentUser.decoration';
import { InteractionActionResponseDto } from '../../common/contracts/extended-response.dto';
import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';

@ApiTags('Post Saves')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('social/posts')
export class PostSavesController {
  constructor(private readonly postSavesService: PostSavesService) {}

  @Post(':postId/save')
  @ApiCreatedResponse({ type: InteractionActionResponseDto })
  async save(
    @CurrentUser('id') userId: string,
    @Param('postId') postId: string,
  ) {
    await this.postSavesService.save(userId, postId);
    return {
      success: true,
      message: 'Post saved successfully',
    };
  }

  @Delete(':postId/save')
  @ApiOkResponse({ type: InteractionActionResponseDto })
  async unsave(
    @CurrentUser('id') userId: string,
    @Param('postId') postId: string,
  ) {
    await this.postSavesService.unsave(userId, postId);
    return {
      success: true,
      message: 'Post unsaved successfully',
    };
  }

}

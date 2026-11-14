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

import { CreatePostCommentDto } from './dto/create-post-comment.dto';
import { PostCommentsService } from './post-comments.service';
import { CurrentUser } from '../../decoration/currentUser.decoration';
import { PaginationDto } from '../users/dto/pagination.dto';

import {
  PostCommentEnvelopeResponseDto,
  PostCommentsPageResponseDto,
  DeletePostCommentResponseDto,
} from '../../common/contracts/extended-response.dto';

import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';

@ApiTags('Post Comments')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('social/posts')
export class PostCommentsController {
  constructor(private readonly postCommentsService: PostCommentsService) {}

  // =========================================================
  // CREATE COMMENT
  // =========================================================

  @Post(':postId/comments')
  @ApiCreatedResponse({
    type: PostCommentEnvelopeResponseDto,
  })
  async create(
    @CurrentUser('id') userId: string,
    @Param('postId') postId: string,
    @Body() dto: CreatePostCommentDto,
  ) {
    const data = await this.postCommentsService.create(userId, postId, dto);

    return {
      data,
      message: 'Comment created successfully',
    };
  }

  // =========================================================
  // GET COMMENTS
  // =========================================================

  @Get(':postId/comments')
  @ApiOkResponse({
    type: PostCommentsPageResponseDto,
  })
  findByPost(
    @Param('postId') postId: string,
    @CurrentUser('id') userId: string,
    @Query() pageDto: PaginationDto,
  ) {
    return this.postCommentsService.findByPost(postId, userId, pageDto);
  }

  // =========================================================
  // DELETE COMMENT
  // =========================================================

  @Delete('comments/:commentId')
  @ApiOkResponse({
    type: DeletePostCommentResponseDto,
  })
  async remove(
    @CurrentUser('id') userId: string,
    @Param('commentId') commentId: string,
  ) {
    await this.postCommentsService.remove(userId, commentId);

    return {
      success: true,
      message: 'Comment deleted successfully',
    };
  }
}

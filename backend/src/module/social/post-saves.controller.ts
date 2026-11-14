import { Controller, Delete, Get, Param, Post } from '@nestjs/common';

import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';

import { PostSavesService } from './post-saves.service';
import { CurrentUser } from '../../decoration/currentUser.decoration';
import {
  InteractionActionResponseDto,
  InteractionStatusEnvelopeResponseDto,
} from '../../common/contracts/extended-response.dto';
import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

class SaveStatusResponseDto {
  @ApiProperty()
  saved!: boolean;

  @ApiPropertyOptional({ nullable: true, format: 'date-time', type: String })
  savedAt!: string | null;
}

class SaveStatusEnvelopeResponseDto {
  @ApiProperty({ type: SaveStatusResponseDto })
  data!: SaveStatusResponseDto;

  @ApiProperty()
  message!: string;
}

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

  @Get(':postId/save/status')
  @ApiOkResponse({ type: SaveStatusEnvelopeResponseDto })
  async getStatus(
    @CurrentUser('id') userId: string,
    @Param('postId') postId: string,
  ) {
    const data = await this.postSavesService.getStatus(userId, postId);
    return {
      data,
      message: 'Save status retrieved successfully',
    };
  }
}

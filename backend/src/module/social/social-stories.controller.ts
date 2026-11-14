import { Body, Controller, Post } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiProperty,
  ApiPropertyOptional,
  ApiTags,
} from '@nestjs/swagger';
import { CurrentUser } from '../../decoration/currentUser.decoration';
import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';
import { CreateSocialStoryDto } from './dto/create-social-story.dto';
import { SocialStoriesService } from './social-stories.service';

class SocialStoryResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  label!: string;

  @ApiPropertyOptional({ nullable: true, type: String })
  imageUrl!: string | null;

  @ApiProperty()
  isSelf!: boolean;

  @ApiProperty()
  isActive!: boolean;

  @ApiProperty({ enum: ['NONE', 'LIVE', 'NEW'] })
  badge!: string;
}

class SocialStoryEnvelopeResponseDto {
  @ApiProperty({ type: SocialStoryResponseDto })
  data!: SocialStoryResponseDto;

  @ApiProperty()
  message!: string;
}

@ApiTags('Social Stories')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('social/stories')
export class SocialStoriesController {
  constructor(private readonly storiesService: SocialStoriesService) {}

  @Post()
  @ApiCreatedResponse({ type: SocialStoryEnvelopeResponseDto })
  async create(
    @CurrentUser('id') userId: string,
    @Body() dto: CreateSocialStoryDto,
  ) {
    const data = await this.storiesService.create(userId, dto);
    return {
      data,
      message: 'Story created successfully',
    };
  }
}

import { Controller, Get, Query } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiOkResponse,
  ApiProperty,
  ApiTags,
} from '@nestjs/swagger';
import { CurrentUser } from '../../decoration/currentUser.decoration';
import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';
import { PaginationMetaDto } from '../../common/contracts/pagination-meta.dto';
import { QuerySocialFeedDto } from './dto/query-social-feed.dto';
import { SocialFeedService } from './social-feed.service';

class SocialFeedEnvelopeResponseDto {
  @ApiProperty({ description: 'Composite Social Feed payload' })
  data!: Record<string, unknown>;

  @ApiProperty({ example: 'Social feed retrieved successfully' })
  message!: string;
}

@ApiTags('Social Feed')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('social')
export class SocialFeedController {
  constructor(private readonly socialFeedService: SocialFeedService) {}

  @Get('feed')
  @ApiOkResponse({ type: SocialFeedEnvelopeResponseDto })
  async getFeed(
    @CurrentUser('id') userId: string,
    @Query() query: QuerySocialFeedDto,
  ) {
    const data = await this.socialFeedService.getFeed(userId, query);
    return {
      data,
      message: 'Social feed retrieved successfully',
    };
  }
}

// Keep PaginationMetaDto referenced for OpenAPI extra models consumers.
void PaginationMetaDto;

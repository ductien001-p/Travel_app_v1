import { Controller, Get, Param, NotFoundException } from '@nestjs/common';

import { ApiBearerAuth, ApiOkResponse, ApiTags } from '@nestjs/swagger';

import { MediaService } from './media.service';
import { S3Service } from '../../uploads/s3/s3.service';
import { CurrentUser } from '../../decoration/currentUser.decoration';

import { MediaUrlEnvelopeResponseDto } from '../../common/contracts/extended-response.dto';

import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';

@ApiTags('Media')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('media')
export class MediaController {
  constructor(
    private readonly mediaService: MediaService,
    private readonly s3: S3Service,
  ) {}

  @Get(':id')
  @ApiOkResponse({
    type: MediaUrlEnvelopeResponseDto,
  })
  async getImage(@Param('id') mediaId: string) {
    const media = await this.mediaService.findOne(mediaId);

    if (!media) {
      throw new NotFoundException('Media not found');
    }

    const url = this.s3.getPublicUrl(media.objectKey);

    return {
      data: {
        url,
      },
      message: 'Media URL retrieved successfully',
    };
  }

  @Get('own/:id')
  @ApiOkResponse({
    type: MediaUrlEnvelopeResponseDto,
  })
  async getOwnImage(
    @Param('id') mediaId: string,
    @CurrentUser('id') userId: string,
  ) {
    const media = await this.mediaService.findOwnMedia(userId, mediaId);

    if (!media) {
      throw new NotFoundException('Media not found');
    }

    const url = this.s3.getPublicUrl(media.objectKey);

    return {
      data: {
        url,
      },
      message: 'Media URL retrieved successfully',
    };
  }
}

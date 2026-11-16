import { Controller, Get, Param } from '@nestjs/common';
import { ApiBearerAuth, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';
import { CurrentUser } from '../../decoration/currentUser.decoration';
import { PublicImageAlbumEnvelopeResponseDto } from './dto/public-image-album-response.dto';
import { PublicImagesService } from './public-images.service';

@ApiTags('Public images')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('public-images')
export class PublicImagesController {
  constructor(private readonly publicImages: PublicImagesService) {}

  @Get('albums/:albumId')
  @ApiOkResponse({ type: PublicImageAlbumEnvelopeResponseDto })
  async getAlbum(
    @Param('albumId') albumId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.publicImages.getAlbum(albumId, userId);
    return {
      data,
      message: 'Public image album retrieved successfully',
    };
  }
}

import { BadRequestException, Body, Controller, Post } from '@nestjs/common';
import { S3Service } from '../s3/s3.service';
import { PresignUploadDto } from './presign-upload.dto';
import { CurrentUser } from '../../decoration/currentUser.decoration';
import { MediaService } from '../../module/media/media.service';
import { CompleteUploadMultipleDto } from '../../module/media/dto/complete-media.dto';
import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';
import {
  PresignedUploadsResponseDto,
  UploadedMediaResponseDto,
} from '../../common/contracts/extended-response.dto';
import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';

@ApiTags('Uploads')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('uploads')
export class UploadsController {
  constructor(
    private readonly s3: S3Service,
    private readonly mediaService: MediaService,
  ) {}
  @Post('presigns')
  @ApiCreatedResponse({ type: PresignedUploadsResponseDto })
  async presigns(
    @CurrentUser('id') userId: string,
    @Body() dto: PresignUploadDto,
  ) {
    if (!this.s3.isUploadConfigured()) {
      throw new BadRequestException(
        'S3 presign is not configured (set AWS_S3_BUCKET and credentials)',
      );
    }
    return this.s3.createImagePresignedPutMultiple({
      userId,
      files: dto.files,
      folder: dto.folder,
      expiresInSeconds: dto.expiresInSeconds,
    });
  }

  @Post('complete')
  @ApiOkResponse({ type: [UploadedMediaResponseDto] })
  async completeUpload(
    @CurrentUser('id') userId: string,
    @Body() dto: CompleteUploadMultipleDto,
  ) {
    return this.mediaService.completeUploadMultiple(userId, dto);
  }
}

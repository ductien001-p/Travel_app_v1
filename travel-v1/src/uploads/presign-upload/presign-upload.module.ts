import { Module } from '@nestjs/common';
import { S3Module } from '../s3/s3.module';
import { UploadsController } from './presign-upload.controller';
import { MediaModule } from '../../module/media/media.module';

@Module({
  imports: [S3Module, MediaModule],
  controllers: [UploadsController],
})
export class PresignUploadModule {}

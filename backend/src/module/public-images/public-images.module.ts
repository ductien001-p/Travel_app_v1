import { Module } from '@nestjs/common';
import { PrismaModule } from '../../prisma.module';
import { S3Module } from '../../uploads/s3/s3.module';
import { PublicImagesController } from './public-images.controller';
import { PublicImagesService } from './public-images.service';

@Module({
  imports: [PrismaModule, S3Module],
  controllers: [PublicImagesController],
  providers: [PublicImagesService],
})
export class PublicImagesModule {}

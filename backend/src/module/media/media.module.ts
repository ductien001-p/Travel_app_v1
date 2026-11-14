import { Module } from '@nestjs/common';
import { MediaService } from './media.service';
import { MediaController } from './media.controller';
import { PrismaModule } from '../../prisma.module';
import { S3Module } from '../../uploads/s3/s3.module';

@Module({
  imports: [PrismaModule, S3Module],
  controllers: [MediaController],
  providers: [MediaService],
  exports: [MediaService],
})
export class MediaModule {}

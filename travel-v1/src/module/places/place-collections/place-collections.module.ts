import { Module } from '@nestjs/common';
import { PrismaModule } from '../../../prisma.module';
import { S3Module } from '../../../uploads/s3/s3.module';
import { PlaceCollectionsController } from './place-collections.controller';
import { PlaceCollectionsService } from './place-collections.service';

@Module({
  imports: [PrismaModule, S3Module],
  controllers: [PlaceCollectionsController],
  providers: [PlaceCollectionsService],
  exports: [PlaceCollectionsService],
})
export class PlaceCollectionsModule {}

import { Module } from '@nestjs/common';
import { TripMessageController } from './tripMessages.controller';
import { TripMessageService } from './tripMessages.service';
import { PrismaModule } from '../../../../prisma.module';
import { S3Module } from '../../../../uploads/s3/s3.module';

@Module({
  imports: [PrismaModule, S3Module],
  controllers: [TripMessageController],
  providers: [TripMessageService],
  exports: [TripMessageService],
})
export class TripMessageModule {}

import { Module } from '@nestjs/common';
import { PrismaModule } from '../../prisma.module';
import { S3Module } from '../../uploads/s3/s3.module';
import { TravelDnaController } from './travel-dna.controller';
import { TravelDNAListener } from './travel-dna.listener';
import { TravelDnaService } from './travel-dna.service';

@Module({
  imports: [PrismaModule, S3Module],
  controllers: [TravelDnaController],
  providers: [TravelDnaService, TravelDNAListener],
  exports: [TravelDnaService],
})
export class TravelDnaModule {}

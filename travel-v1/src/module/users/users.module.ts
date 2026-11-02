import { Module } from '@nestjs/common';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { PrismaModule } from '../../prisma.module';
import { TravelDnaModule } from '../travelDNA/travel-dna.module';
import { S3Module } from '../../uploads/s3/s3.module';
import { ProfileShowcaseService } from './profile-showcase.service';

@Module({
  imports: [PrismaModule, TravelDnaModule, S3Module],
  controllers: [UsersController],
  providers: [UsersService, ProfileShowcaseService],
  exports: [UsersService],
})
export class UsersModule {}

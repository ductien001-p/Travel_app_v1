import { Module } from '@nestjs/common';
import { FriendController } from './friends.controller';
import { PrismaModule } from '../../prisma.module';
import { AuthModule } from '../auth/auth.module';
import { FriendService } from './friends.service';
import { FriendGateway } from './friend-gateway';

@Module({
  imports: [PrismaModule, AuthModule],
  controllers: [FriendController],

  providers: [FriendService, FriendGateway],

  exports: [FriendService],
})
export class FriendModule {}

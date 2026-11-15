import { Module } from '@nestjs/common';
import { NotificationsService } from './notification.service';
import { NotificationsController } from './notification.controller';
import { PushNotificationsService } from './push-notification.service';
import { DeviceTokensModule } from '../module/auth/device-token/device-token.module';
import { PrismaModule } from '../prisma.module';

@Module({
  imports: [DeviceTokensModule, PrismaModule],
  controllers: [NotificationsController],
  providers: [NotificationsService, PushNotificationsService],
  exports: [NotificationsService, PushNotificationsService],
})
export class NotificationModule {}

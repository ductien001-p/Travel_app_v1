import { Module } from '@nestjs/common';
import { NotificationsService } from './notification.service';
import { PushNotificationsService } from './push-notification.service';
import { DeviceTokensModule } from '../module/auth/device-token/device-token.module';
import { PrismaModule } from '../prisma.module';

@Module({
  imports: [DeviceTokensModule, PrismaModule],
  providers: [NotificationsService, PushNotificationsService],
  exports: [NotificationsService, PushNotificationsService],
})
export class NotificationModule {}

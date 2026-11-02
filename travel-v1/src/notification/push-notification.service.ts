// src/modules/notifications/push-notifications.service.ts
import { Injectable, Logger, OnModuleInit } from '@nestjs/common';
import { getMessaging, MulticastMessage } from 'firebase-admin/messaging';
import { initFirebaseAdmin } from '../config/firebase.config';
import { DeviceTokenService } from '../module/auth/device-token/device-token.service';

@Injectable()
export class PushNotificationsService implements OnModuleInit {
  private readonly logger = new Logger(PushNotificationsService.name);

  constructor(private readonly deviceTokensService: DeviceTokenService) {}

  onModuleInit() {
    initFirebaseAdmin();
  }

  async sendToUser(
    userId: string,
    payload: { title: string; body: string; data?: Record<string, string> },
  ) {
    const tokens = await this.deviceTokensService.getTokensByUserId(userId);

    if (tokens.length === 0) {
      this.logger.debug(`User ${userId} has no registered device tokens`);
      return;
    }

    const message: MulticastMessage = {
      tokens,
      notification: {
        title: payload.title,
        body: payload.body,
      },
      data: payload.data ?? {},
      android: {
        priority: 'high',
      },
      apns: {
        payload: {
          aps: { sound: 'default', badge: 1 },
        },
      },
    };

    try {
      const response = await getMessaging().sendEachForMulticast(message);

      const invalidTokens: string[] = [];
      response.responses.forEach((res, idx) => {
        if (
          !res.success &&
          (res.error?.code === 'messaging/registration-token-not-registered' ||
            res.error?.code === 'messaging/invalid-registration-token')
        ) {
          invalidTokens.push(tokens[idx]);
        }
      });

      if (invalidTokens.length > 0) {
        await this.deviceTokensService.removeInvalidTokens(invalidTokens);
        this.logger.debug(`Removed ${invalidTokens.length} invalid tokens`);
      }

      return response;
    } catch (error) {
      this.logger.error('Error sending push notification', error);
      throw error;
    }
  }
}

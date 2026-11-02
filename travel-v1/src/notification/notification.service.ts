// notifications.service.ts
import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { PushNotificationsService } from './push-notification.service';
import { Prisma } from '../generated/prisma/client';
import { CreateNotificationParams } from './type/create-notification.type';

type NotificationWriter = Pick<Prisma.TransactionClient, 'notification'>;

@Injectable()
export class NotificationsService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly pushNotificationsService: PushNotificationsService,
  ) {}

  async create(
    tx: NotificationWriter,
    createNotification: CreateNotificationParams,
  ) {
    const notification = await tx.notification.create({
      data: {
        userId: createNotification.userId,
        actorId: createNotification.actorId,
        tripId: createNotification.tripId,
        type: createNotification.type,
        title: createNotification.title,
        message: createNotification.message,
      },
    });

    // Gửi push SAU khi transaction commit thành công, không phải trong transaction
    // vì gọi network trong transaction có thể giữ lock DB lâu nếu FCM chậm/timeout
    // → xử lý ở bước 7 bên dưới bằng cách trả kèm 1 hàm callback

    return notification;
  }
}

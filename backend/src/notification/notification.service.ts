// notifications.service.ts
import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { PushNotificationsService } from './push-notification.service';
import { Prisma } from '../generated/prisma/client';
import { CreateNotificationParams } from './type/create-notification.type';
import { NotificationItemResponseDto } from './dto/notification-response.dto';

type NotificationWriter = Pick<Prisma.TransactionClient, 'notification'>;

type NotificationRow = {
  id: string;
  type: NotificationItemResponseDto['type'];
  title: string;
  message: string;
  isRead: boolean;
  createdAt: Date;
  tripId: string | null;
  actorId: string | null;
};

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

  async listForUser(userId: string, limit = 30, cursor?: string) {
    const safeLimit = Math.min(Math.max(limit, 1), 50);
    const rows = await this.prisma.notification.findMany({
      where: { userId },
      orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
      take: safeLimit + 1,
      ...(cursor ? { cursor: { id: cursor }, skip: 1 } : {}),
      select: {
        id: true,
        type: true,
        title: true,
        message: true,
        isRead: true,
        createdAt: true,
        tripId: true,
        actorId: true,
      },
    });

    const hasMore = rows.length > safeLimit;
    if (hasMore) rows.pop();

    const unreadCount = await this.prisma.notification.count({
      where: { userId, isRead: false },
    });

    return {
      data: rows.map((row) => this.toItem(row)),
      meta: {
        nextCursor: hasMore && rows.length > 0 ? rows[rows.length - 1].id : null,
        hasMore,
        unreadCount,
      },
    };
  }

  async markRead(userId: string, notificationId: string) {
    const existing = await this.prisma.notification.findFirst({
      where: { id: notificationId, userId },
      select: {
        id: true,
        type: true,
        title: true,
        message: true,
        isRead: true,
        createdAt: true,
        tripId: true,
        actorId: true,
      },
    });
    if (!existing) throw new NotFoundException('Notification not found');

    if (existing.isRead) return this.toItem(existing);

    const updated = await this.prisma.notification.update({
      where: { id: existing.id },
      data: { isRead: true, readAt: new Date() },
      select: {
        id: true,
        type: true,
        title: true,
        message: true,
        isRead: true,
        createdAt: true,
        tripId: true,
        actorId: true,
      },
    });
    return this.toItem(updated);
  }

  async markAllRead(userId: string) {
    const result = await this.prisma.notification.updateMany({
      where: { userId, isRead: false },
      data: { isRead: true, readAt: new Date() },
    });
    return { updated: result.count };
  }

  private toItem(row: NotificationRow): NotificationItemResponseDto {
    return {
      id: row.id,
      type: row.type,
      title: row.title,
      message: row.message,
      isRead: row.isRead,
      createdAt: row.createdAt.toISOString(),
      tripId: row.tripId,
      actorId: row.actorId,
    };
  }
}

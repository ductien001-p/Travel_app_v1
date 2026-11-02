import { BadRequestException, Injectable } from '@nestjs/common';

import { TRIP_MESSAGE_TYPE } from '../../../../generated/prisma/enums';
import { PrismaService } from '../../../../prisma.service';
import { S3Service } from '../../../../uploads/s3/s3.service';
import { TripAccessPolicy, TripResourcePolicy } from '../../policies';

const MESSAGE_INCLUDE = {
  sender: {
    select: {
      id: true,
      user: {
        select: {
          id: true,
          username: true,
          avatarId: true,
        },
      },
    },
  },
} as const;

@Injectable()
export class TripMessageService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
  ) {}

  // =========================================================
  // CREATE MESSAGE
  // Internal / WebSocket
  // =========================================================

  /** For IMAGE messages `content` is the id of an image the sender uploaded. */
  async createMessage(
    tripId: string,
    userId: string,
    content: string,
    messageType: TRIP_MESSAGE_TYPE = TRIP_MESSAGE_TYPE.TEXT,
  ) {
    // TripMessage.senderId references TripMember.id, not User.id.
    const sender = await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'SEND_MESSAGE',
    );

    const image =
      messageType === TRIP_MESSAGE_TYPE.IMAGE
        ? await TripResourcePolicy.assertOwnedImage(
            this.prisma,
            userId,
            content,
          )
        : null;

    const message = await this.prisma.tripMessage.create({
      data: {
        tripId,
        senderId: sender.id,
        content,
        messageType,
      },
      include: MESSAGE_INCLUDE,
    });

    return {
      ...message,
      imageUrl: image ? this.s3.getPublicUrl(image.objectKey) : null,
    };
  }

  // =========================================================
  // GET MESSAGE HISTORY
  // =========================================================

  async getMessages(
    tripId: string,
    userId: string,
    limit = 50,
    cursor?: string,
  ) {
    await TripAccessPolicy.authorize(
      this.prisma,
      tripId,
      userId,
      'READ_MESSAGES',
    );

    if (cursor) {
      const cursorMessage = await this.prisma.tripMessage.findFirst({
        where: { id: cursor, tripId },
        select: { id: true },
      });
      if (!cursorMessage) {
        throw new BadRequestException('Invalid cursor for this trip');
      }
    }

    const safeLimit = Math.min(Math.max(limit, 1), 100);

    const messages = await this.prisma.tripMessage.findMany({
      where: {
        tripId,
      },

      take: safeLimit + 1,

      ...(cursor
        ? {
            cursor: {
              id: cursor,
            },

            skip: 1,
          }
        : {}),

      orderBy: [
        {
          createdAt: 'desc',
        },
        {
          id: 'desc',
        },
      ],

      include: MESSAGE_INCLUDE,
    });

    const hasMore = messages.length > safeLimit;

    if (hasMore) {
      messages.pop();
    }

    const nextCursor =
      hasMore && messages.length > 0 ? messages[messages.length - 1].id : null;

    const imageUrls = await this.resolveImageUrls(messages);

    return {
      // reverse để UI chat nhận thứ tự cũ → mới
      data: messages.reverse().map((message) => ({
        ...message,
        imageUrl: imageUrls.get(message.id) ?? null,
      })),

      meta: {
        nextCursor,
        hasMore,
      },
    };
  }

  /** Message id → URL; images deleted since sending resolve to nothing. */
  private async resolveImageUrls(
    messages: Array<{
      id: string;
      content: string;
      messageType: TRIP_MESSAGE_TYPE;
    }>,
  ): Promise<Map<string, string>> {
    const imageMessages = messages.filter(
      (message) => message.messageType === TRIP_MESSAGE_TYPE.IMAGE,
    );
    if (imageMessages.length === 0) return new Map();

    const media = await this.prisma.uploadedMedia.findMany({
      where: {
        id: { in: [...new Set(imageMessages.map((m) => m.content))] },
        deletedAt: null,
      },
      select: { id: true, objectKey: true },
    });
    const keyById = new Map(media.map((item) => [item.id, item.objectKey]));

    const urls = new Map<string, string>();
    for (const message of imageMessages) {
      const objectKey = keyById.get(message.content);
      if (objectKey) urls.set(message.id, this.s3.getPublicUrl(objectKey));
    }
    return urls;
  }
}

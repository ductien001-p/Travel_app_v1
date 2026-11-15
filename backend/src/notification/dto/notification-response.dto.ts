import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { NOTIFICATION_TYPE } from '../../generated/prisma/enums';

export class NotificationItemResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty({ enum: NOTIFICATION_TYPE })
  type!: NOTIFICATION_TYPE;

  @ApiProperty()
  title!: string;

  @ApiProperty()
  message!: string;

  @ApiProperty()
  isRead!: boolean;

  @ApiProperty()
  createdAt!: string;

  @ApiPropertyOptional({ nullable: true, type: String })
  tripId!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  actorId!: string | null;
}

export class NotificationListMetaDto {
  @ApiPropertyOptional({ nullable: true, type: String })
  nextCursor!: string | null;

  @ApiProperty()
  hasMore!: boolean;

  @ApiProperty()
  unreadCount!: number;
}

export class NotificationListResponseDto {
  @ApiProperty({ type: [NotificationItemResponseDto] })
  data!: NotificationItemResponseDto[];

  @ApiProperty({ type: NotificationListMetaDto })
  meta!: NotificationListMetaDto;
}

export class NotificationReadEnvelopeDto {
  @ApiProperty({ type: NotificationItemResponseDto })
  data!: NotificationItemResponseDto;
}

export class NotificationReadAllDto {
  @ApiProperty()
  updated!: number;
}

export class NotificationReadAllEnvelopeDto {
  @ApiProperty({ type: NotificationReadAllDto })
  data!: NotificationReadAllDto;
}

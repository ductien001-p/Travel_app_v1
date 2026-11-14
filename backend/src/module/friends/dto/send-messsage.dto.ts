import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsIn,
  IsNotEmpty,
  IsObject,
  IsOptional,
  IsString,
  MaxLength,
  ValidateIf,
} from 'class-validator';

export const FRIEND_CHAT_MESSAGE_TYPES = [
  'TEXT',
  'PLACE_CARD',
  'TRIP_INVITE',
] as const;

export type FriendChatMessageType = (typeof FRIEND_CHAT_MESSAGE_TYPES)[number];

export class SendFriendMessageDto {
  @ApiProperty({
    description:
      'Plain text body. Required for TEXT; optional caption for rich cards.',
    maxLength: 5000,
    default: '',
  })
  @IsString()
  @MaxLength(5000)
  @ValidateIf(
    (o: SendFriendMessageDto) => !o.messageType || o.messageType === 'TEXT',
  )
  @IsNotEmpty()
  content: string = '';

  @ApiPropertyOptional({
    enum: FRIEND_CHAT_MESSAGE_TYPES,
    default: 'TEXT',
  })
  @IsOptional()
  @IsIn(FRIEND_CHAT_MESSAGE_TYPES)
  messageType?: FriendChatMessageType;

  @ApiPropertyOptional({
    description:
      'Required for PLACE_CARD / TRIP_INVITE. Shape matches Flutter FriendChatPlaceCard / FriendChatTripInviteCard.',
    type: Object,
  })
  @ValidateIf(
    (o: SendFriendMessageDto) =>
      o.messageType === 'PLACE_CARD' || o.messageType === 'TRIP_INVITE',
  )
  @IsNotEmpty()
  @IsObject()
  metadata?: Record<string, unknown>;
}

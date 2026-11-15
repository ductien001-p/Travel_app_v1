import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class TripChatReactionResponseDto {
  @ApiProperty()
  emoji!: string;

  @ApiProperty()
  count!: number;
}

export class TripChatSenderResponseDto {
  @ApiProperty()
  userId!: string;

  @ApiProperty()
  displayName!: string;

  @ApiPropertyOptional({ nullable: true, type: String })
  avatarUrl!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  roleBadge!: string | null;

  @ApiProperty({
    enum: ['LEADER', 'PHOTOGRAPHER', 'TREASURER', 'MEMBER'],
  })
  roleTone!: string;

  @ApiProperty()
  isLeader!: boolean;
}

export class TripChatSystemPayloadResponseDto {
  @ApiProperty()
  icon!: string;

  @ApiProperty()
  richText!: string;
}

export class TripChatPhotoPayloadResponseDto {
  @ApiProperty()
  imageUrl!: string;

  @ApiPropertyOptional({ nullable: true, type: String })
  caption!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  locationLabel!: string | null;

  @ApiProperty({ type: [TripChatReactionResponseDto] })
  reactions!: TripChatReactionResponseDto[];
}

export class TripChatExpensePayloadResponseDto {
  @ApiProperty()
  expenseId!: string;

  @ApiProperty()
  title!: string;

  @ApiProperty()
  subtitle!: string;

  @ApiProperty()
  amountLabel!: string;

  @ApiProperty()
  splitLabel!: string;

  @ApiProperty()
  perPersonLabel!: string;

  @ApiPropertyOptional({ nullable: true, type: String })
  actionLabel!: string | null;
}

export class TripChatMessageResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty({ enum: ['SYSTEM', 'TEXT', 'PHOTO', 'EXPENSE'] })
  kind!: string;

  @ApiProperty()
  isMine!: boolean;

  @ApiPropertyOptional({ nullable: true, type: String })
  text!: string | null;

  @ApiProperty()
  timeLabel!: string;

  @ApiPropertyOptional({
    nullable: true,
    enum: ['SENT', 'DELIVERED', 'READ'],
  })
  readStatus!: string | null;

  @ApiProperty()
  showAvatar!: boolean;

  @ApiPropertyOptional({ nullable: true, type: TripChatSenderResponseDto })
  sender!: TripChatSenderResponseDto | null;

  @ApiPropertyOptional({
    nullable: true,
    type: TripChatSystemPayloadResponseDto,
  })
  system!: TripChatSystemPayloadResponseDto | null;

  @ApiPropertyOptional({ nullable: true, type: TripChatPhotoPayloadResponseDto })
  photo!: TripChatPhotoPayloadResponseDto | null;

  @ApiProperty({ type: [TripChatReactionResponseDto] })
  reactions!: TripChatReactionResponseDto[];

  @ApiPropertyOptional({
    nullable: true,
    type: TripChatExpensePayloadResponseDto,
  })
  expense!: TripChatExpensePayloadResponseDto | null;
}

export class TripChatPinnedActivityResponseDto {
  @ApiProperty()
  badgeLabel!: string;

  @ApiPropertyOptional({ nullable: true, type: String })
  dayChipLabel!: string | null;

  @ApiProperty()
  title!: string;

  @ApiPropertyOptional({ nullable: true, type: String })
  checkInLabel!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  itineraryDayId!: string | null;
}

export class TripChatUtilityResponseDto {
  @ApiProperty({
    enum: ['LIVE_LOCATION', 'SPLIT_BILL', 'ALBUM', 'ADD_STOP'],
  })
  kind!: string;

  @ApiProperty()
  label!: string;
}

export class TripChatThreadResponseDto {
  @ApiProperty()
  tripId!: string;

  @ApiProperty()
  title!: string;

  @ApiProperty()
  memberSummaryLabel!: string;

  @ApiProperty()
  isLive!: boolean;

  @ApiPropertyOptional({
    nullable: true,
    type: TripChatPinnedActivityResponseDto,
  })
  pinnedActivity!: TripChatPinnedActivityResponseDto | null;

  @ApiProperty()
  dateLabel!: string;

  @ApiProperty({ type: [TripChatMessageResponseDto] })
  messages!: TripChatMessageResponseDto[];

  @ApiProperty()
  isSomeoneTyping!: boolean;

  @ApiPropertyOptional({ nullable: true, type: String })
  typingLabel!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  typingAvatarUrl!: string | null;

  @ApiProperty({ type: [TripChatUtilityResponseDto] })
  utilities!: TripChatUtilityResponseDto[];
}

export class TripChatThreadEnvelopeResponseDto {
  @ApiProperty({ type: TripChatThreadResponseDto })
  data!: TripChatThreadResponseDto;
}

export class TripChatMessageEnvelopeResponseDto {
  @ApiProperty({ type: TripChatMessageResponseDto })
  data!: TripChatMessageResponseDto;
}

export class TripMessageReactionEnvelopeResponseDto {
  @ApiProperty({
    type: 'object',
    properties: {
      messageId: { type: 'string' },
      reactions: {
        type: 'array',
        items: { $ref: '#/components/schemas/TripChatReactionResponseDto' },
      },
    },
  })
  data!: {
    messageId: string;
    reactions: TripChatReactionResponseDto[];
  };
}

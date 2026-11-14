import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class FriendChatPeerResponseDto {
  @ApiProperty()
  userId!: string;

  @ApiProperty()
  displayName!: string;

  @ApiPropertyOptional({ nullable: true, type: String })
  avatarUrl!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  roleBadge!: string | null;

  @ApiProperty()
  isOnline!: boolean;

  @ApiPropertyOptional({ nullable: true, type: String })
  presenceLabel!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  sharedTripsLabel!: string | null;
}

export class FriendChatSharedTripResponseDto {
  @ApiProperty()
  tripId!: string;

  @ApiProperty()
  title!: string;

  @ApiPropertyOptional({ nullable: true, type: String })
  destinationHint!: string | null;

  @ApiProperty()
  statusLabel!: string;
}

export class FriendChatPlaceCardResponseDto {
  @ApiProperty()
  placeId!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty()
  address!: string;

  @ApiProperty()
  imageUrl!: string;

  @ApiProperty()
  rating!: number;

  @ApiProperty()
  reviewCount!: number;

  @ApiPropertyOptional({ nullable: true, type: String })
  badgeLabel!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  footerLabel!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  actionLabel!: string | null;
}

export class FriendChatTripInviteCardResponseDto {
  @ApiProperty()
  tripId!: string;

  @ApiProperty()
  title!: string;

  @ApiProperty()
  imageUrl!: string;

  @ApiProperty()
  dateLabel!: string;

  @ApiProperty()
  priceLabel!: string;

  @ApiProperty()
  seatsLabel!: string;

  @ApiPropertyOptional({ nullable: true, type: String })
  badgeLabel!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  primaryActionLabel!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  secondaryActionLabel!: string | null;
}

export class FriendChatMessageUiResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty({ enum: ['TEXT', 'PLACE_CARD', 'TRIP_INVITE'] })
  kind!: 'TEXT' | 'PLACE_CARD' | 'TRIP_INVITE';

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
  readStatus!: 'SENT' | 'DELIVERED' | 'READ' | null;

  @ApiProperty()
  showAvatar!: boolean;

  @ApiPropertyOptional({
    nullable: true,
    type: FriendChatPlaceCardResponseDto,
  })
  placeCard!: FriendChatPlaceCardResponseDto | null;

  @ApiPropertyOptional({
    nullable: true,
    type: FriendChatTripInviteCardResponseDto,
  })
  tripInvite!: FriendChatTripInviteCardResponseDto | null;
}

export class FriendChatShortcutResponseDto {
  @ApiProperty({
    enum: [
      'INVITE_TRIP',
      'SEND_LOCATION',
      'SPLIT_BILL',
      'SUGGEST_ITINERARY',
      'SEND_PHOTO',
    ],
  })
  kind!:
    | 'INVITE_TRIP'
    | 'SEND_LOCATION'
    | 'SPLIT_BILL'
    | 'SUGGEST_ITINERARY'
    | 'SEND_PHOTO';

  @ApiProperty()
  label!: string;

  @ApiProperty()
  emphasized!: boolean;
}

export class FriendChatInviteCandidateResponseDto {
  @ApiProperty()
  tripId!: string;

  @ApiProperty()
  title!: string;

  @ApiProperty()
  imageUrl!: string;

  @ApiProperty()
  metaLabel!: string;

  @ApiProperty()
  badgeLabel!: string;

  @ApiProperty()
  actionLabel!: string;
}

export class FriendChatThreadResponseDto {
  @ApiProperty()
  conversationId!: string;

  @ApiProperty({ type: FriendChatPeerResponseDto })
  peer!: FriendChatPeerResponseDto;

  @ApiPropertyOptional({
    nullable: true,
    type: FriendChatSharedTripResponseDto,
  })
  sharedTrip!: FriendChatSharedTripResponseDto | null;

  @ApiProperty()
  dateLabel!: string;

  @ApiProperty({ type: [FriendChatMessageUiResponseDto] })
  messages!: FriendChatMessageUiResponseDto[];

  @ApiProperty()
  isPeerTyping!: boolean;

  @ApiPropertyOptional({ nullable: true, type: String })
  typingLabel!: string | null;

  @ApiProperty({ type: [FriendChatShortcutResponseDto] })
  shortcuts!: FriendChatShortcutResponseDto[];

  @ApiProperty({ type: [FriendChatInviteCandidateResponseDto] })
  inviteCandidates!: FriendChatInviteCandidateResponseDto[];
}

export class FriendChatThreadEnvelopeResponseDto {
  @ApiProperty({ type: FriendChatThreadResponseDto })
  data!: FriendChatThreadResponseDto;

  @ApiProperty({ example: 'Friend chat thread retrieved successfully' })
  message!: string;
}

export class FriendChatMessageUiEnvelopeResponseDto {
  @ApiProperty({ type: FriendChatMessageUiResponseDto })
  data!: FriendChatMessageUiResponseDto;

  @ApiProperty({ example: 'Message sent successfully' })
  message!: string;
}

import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class ChatsHubViewerResponseDto {
  @ApiProperty()
  displayName!: string;

  @ApiPropertyOptional({ nullable: true, type: String })
  avatarUrl!: string | null;

  @ApiProperty()
  isOnline!: boolean;
}

export class ChatsActiveTripPulseResponseDto {
  @ApiProperty()
  tripId!: string;

  @ApiProperty()
  title!: string;

  @ApiProperty()
  statusLabel!: string;

  @ApiProperty()
  onlineMemberCount!: number;

  @ApiProperty()
  memberCapacity!: number;

  @ApiProperty({ type: [String] })
  memberAvatars!: string[];

  @ApiProperty()
  extraMemberCount!: number;

  @ApiProperty()
  pinnedSenderName!: string;

  @ApiProperty()
  pinnedMessage!: string;

  @ApiProperty()
  pinnedTimeLabel!: string;

  @ApiProperty()
  newExchangeCount!: number;
}

export class ChatsTripThreadResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  tripId!: string;

  @ApiProperty()
  title!: string;

  @ApiProperty()
  coverUrl!: string;

  @ApiProperty({
    description: 'UI badge key: landscape | sailing | hiking | task_alt',
  })
  badgeIcon!: string;

  @ApiProperty({ enum: ['UPCOMING', 'ONGOING', 'COMPLETED'] })
  status!: 'UPCOMING' | 'ONGOING' | 'COMPLETED';

  @ApiProperty()
  memberCount!: number;

  @ApiProperty()
  memberLabel!: string;

  @ApiProperty()
  lastSenderName!: string;

  @ApiProperty()
  lastMessage!: string;

  @ApiProperty()
  timeLabel!: string;

  @ApiProperty()
  unreadCount!: number;

  @ApiProperty()
  isReadReceipt!: boolean;

  @ApiProperty()
  emphasize!: boolean;
}

export class ChatsFriendThreadResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  conversationId!: string;

  @ApiProperty()
  peerUserId!: string;

  @ApiProperty()
  displayName!: string;

  @ApiPropertyOptional({ nullable: true, type: String })
  avatarUrl!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  roleBadge!: string | null;

  @ApiPropertyOptional({
    nullable: true,
    enum: ['PRIMARY', 'SECONDARY'],
  })
  roleTone!: 'PRIMARY' | 'SECONDARY' | null;

  @ApiProperty()
  isOnline!: boolean;

  @ApiProperty()
  lastMessage!: string;

  @ApiProperty()
  timeLabel!: string;

  @ApiProperty()
  unreadCount!: number;

  @ApiProperty()
  timeEmphasized!: boolean;
}

export class ChatsHubResponseDto {
  @ApiProperty({ type: ChatsHubViewerResponseDto })
  viewer!: ChatsHubViewerResponseDto;

  @ApiProperty()
  totalThreadCount!: number;

  @ApiProperty()
  hasUnread!: boolean;

  @ApiPropertyOptional({
    nullable: true,
    type: ChatsActiveTripPulseResponseDto,
  })
  activeTripPulse!: ChatsActiveTripPulseResponseDto | null;

  @ApiProperty({ type: [ChatsTripThreadResponseDto] })
  tripThreads!: ChatsTripThreadResponseDto[];

  @ApiProperty({ type: [ChatsFriendThreadResponseDto] })
  friendThreads!: ChatsFriendThreadResponseDto[];
}

export class ChatsHubEnvelopeResponseDto {
  @ApiProperty({ type: ChatsHubResponseDto })
  data!: ChatsHubResponseDto;

  @ApiProperty({ example: 'Chat hub retrieved successfully' })
  message!: string;
}

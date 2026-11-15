import {
  TRIP_MESSAGE_TYPE,
  TRIP_ROLE,
} from '../../../../generated/prisma/enums';

export type TripChatUiKind = 'SYSTEM' | 'TEXT' | 'PHOTO' | 'EXPENSE';
export type TripChatReadStatus = 'SENT' | 'DELIVERED' | 'READ';
export type TripChatRoleTone = 'LEADER' | 'PHOTOGRAPHER' | 'TREASURER' | 'MEMBER';

export type TripChatReactionDto = {
  emoji: string;
  count: number;
};

export type TripChatSenderDto = {
  userId: string;
  displayName: string;
  avatarUrl: string | null;
  roleBadge: string | null;
  roleTone: TripChatRoleTone;
  isLeader: boolean;
};

export type TripChatMessageDto = {
  id: string;
  kind: TripChatUiKind;
  isMine: boolean;
  text: string | null;
  timeLabel: string;
  readStatus: TripChatReadStatus | null;
  showAvatar: boolean;
  sender: TripChatSenderDto | null;
  system: { icon: string; richText: string } | null;
  photo: {
    imageUrl: string;
    caption: string | null;
    locationLabel: string | null;
    reactions: TripChatReactionDto[];
  } | null;
  expense: {
    expenseId: string;
    title: string;
    subtitle: string;
    amountLabel: string;
    splitLabel: string;
    perPersonLabel: string;
    actionLabel: string | null;
  } | null;
  reactions: TripChatReactionDto[];
};

export type TripChatPinnedActivityDto = {
  badgeLabel: string;
  dayChipLabel: string | null;
  title: string;
  checkInLabel: string | null;
  itineraryDayId: string | null;
};

export type TripChatUtilityDto = {
  kind: 'LIVE_LOCATION' | 'SPLIT_BILL' | 'ALBUM' | 'ADD_STOP';
  label: string;
};

export type TripChatThreadDto = {
  tripId: string;
  title: string;
  memberSummaryLabel: string;
  isLive: boolean;
  pinnedActivity: TripChatPinnedActivityDto | null;
  dateLabel: string;
  messages: TripChatMessageDto[];
  isSomeoneTyping: boolean;
  typingLabel: string | null;
  typingAvatarUrl: string | null;
  utilities: TripChatUtilityDto[];
};

type MessageMetadata = {
  caption?: string | null;
  locationLabel?: string | null;
  icon?: string | null;
  richText?: string | null;
  expenseId?: string | null;
  title?: string | null;
  subtitle?: string | null;
  amountLabel?: string | null;
  splitLabel?: string | null;
  perPersonLabel?: string | null;
  actionLabel?: string | null;
};

const VI_MONTHS = [
  'Tháng 1',
  'Tháng 2',
  'Tháng 3',
  'Tháng 4',
  'Tháng 5',
  'Tháng 6',
  'Tháng 7',
  'Tháng 8',
  'Tháng 9',
  'Tháng 10',
  'Tháng 11',
  'Tháng 12',
] as const;

export const TRIP_CHAT_UTILITIES: TripChatUtilityDto[] = [
  { kind: 'LIVE_LOCATION', label: 'Vị trí live' },
  { kind: 'SPLIT_BILL', label: 'Chia tiền' },
  { kind: 'ALBUM', label: 'Album trip' },
  { kind: 'ADD_STOP', label: 'Thêm chặng' },
];

export function mapTripRoleToSenderBadge(role: TRIP_ROLE): {
  roleBadge: string | null;
  roleTone: TripChatRoleTone;
  isLeader: boolean;
} {
  switch (role) {
    case TRIP_ROLE.OWNER:
      return {
        roleBadge: 'Trưởng nhóm',
        roleTone: 'LEADER',
        isLeader: true,
      };
    case TRIP_ROLE.ADMIN:
      return {
        roleBadge: 'Admin',
        roleTone: 'MEMBER',
        isLeader: false,
      };
    default:
      return {
        roleBadge: null,
        roleTone: 'MEMBER',
        isLeader: false,
      };
  }
}

export function mapMessageTypeToUiKind(
  messageType: TRIP_MESSAGE_TYPE,
): TripChatUiKind {
  switch (messageType) {
    case TRIP_MESSAGE_TYPE.SYSTEM:
      return 'SYSTEM';
    case TRIP_MESSAGE_TYPE.IMAGE:
      return 'PHOTO';
    case TRIP_MESSAGE_TYPE.EXPENSE:
      return 'EXPENSE';
    default:
      return 'TEXT';
  }
}

export function formatTimeLabel(date: Date): string {
  const hour = date.getHours().toString().padStart(2, '0');
  const minute = date.getMinutes().toString().padStart(2, '0');
  return `${hour}:${minute}`;
}

export function formatDateLabel(date: Date, now = new Date()): string {
  const sameDay =
    date.getFullYear() === now.getFullYear() &&
    date.getMonth() === now.getMonth() &&
    date.getDate() === now.getDate();
  const day = date.getDate();
  const month = VI_MONTHS[date.getMonth()];
  if (sameDay) return `Hôm nay, ${day} ${month}`;
  return `${day} ${month}`;
}

export function buildMemberSummaryLabel(input: {
  memberCount: number;
  onlineNames: string[];
}): string {
  const { memberCount, onlineNames } = input;
  if (onlineNames.length === 0) {
    return `${memberCount} thành viên`;
  }
  const shown = onlineNames.slice(0, 3).join(', ');
  return `${memberCount} thành viên • ${onlineNames.length} đang online (${shown})`;
}

export function mapPinnedActivity(input: {
  id: string;
  title: string;
  startTime: Date;
} | null): TripChatPinnedActivityDto | null {
  if (!input) return null;
  const now = new Date();
  const sameDay =
    input.startTime.getFullYear() === now.getFullYear() &&
    input.startTime.getMonth() === now.getMonth() &&
    input.startTime.getDate() === now.getDate();
  const time = formatTimeLabel(input.startTime);
  return {
    badgeLabel: 'Hoạt động tiếp theo',
    dayChipLabel: sameDay ? 'Hôm nay' : null,
    title: `${time}: ${input.title}`,
    checkInLabel: 'Check-in',
    itineraryDayId: input.id,
  };
}

export function resolveReadStatus(input: {
  isMine: boolean;
  createdAt: Date;
  otherMembersLastReadAt: Array<Date | null>;
}): TripChatReadStatus | null {
  if (!input.isMine) return null;
  if (input.otherMembersLastReadAt.length === 0) return 'SENT';
  const allRead = input.otherMembersLastReadAt.every(
    (lastReadAt) => lastReadAt != null && lastReadAt >= input.createdAt,
  );
  return allRead ? 'READ' : 'DELIVERED';
}

export function parseMessageMetadata(
  metadata: unknown,
): MessageMetadata | null {
  if (!metadata || typeof metadata !== 'object' || Array.isArray(metadata)) {
    return null;
  }
  return metadata as MessageMetadata;
}

export function aggregateReactions(
  reactions: Array<{ emoji: string }>,
): TripChatReactionDto[] {
  const counts = new Map<string, number>();
  for (const reaction of reactions) {
    counts.set(reaction.emoji, (counts.get(reaction.emoji) ?? 0) + 1);
  }
  return [...counts.entries()].map(([emoji, count]) => ({ emoji, count }));
}

import { TRAVEL_DNA_TYPE } from '../../generated/prisma/enums';

const INTEREST_BADGES: Array<{
  match: RegExp;
  label: string;
  icon: string;
}> = [
  { match: /ẩm thực|food|cafe|ăn/i, label: 'Foodie', icon: 'ramen_dining' },
  {
    match: /ảnh|photo|check-?in|camera/i,
    label: 'Photo Master',
    icon: 'photo_camera',
  },
  {
    match: /núi|trekking|phiêu lưu|adventure|backpack|phượt/i,
    label: 'Backpacker',
    icon: 'backpack',
  },
  {
    match: /biển|đảo|island|beach/i,
    label: 'Island Hopper',
    icon: 'waves',
  },
  {
    match: /văn hóa|lịch sử|culture|heritage/i,
    label: 'Culture Fan',
    icon: 'account_balance',
  },
  { match: /thuyền|sail|voyage/i, label: 'Sailor', icon: 'sailing' },
];

const DNA_BADGES: Partial<
  Record<TRAVEL_DNA_TYPE, { label: string; icon: string }>
> = {
  [TRAVEL_DNA_TYPE.FOODIE_TRAVELER]: {
    label: 'Foodie',
    icon: 'ramen_dining',
  },
  [TRAVEL_DNA_TYPE.PHOTOGRAPHY_LOVER]: {
    label: 'Photo Master',
    icon: 'photo_camera',
  },
  [TRAVEL_DNA_TYPE.BACKPACKER]: { label: 'Backpacker', icon: 'backpack' },
  [TRAVEL_DNA_TYPE.ADVENTURE_TRAVELER]: {
    label: 'Master Explorer',
    icon: 'terrain',
  },
  [TRAVEL_DNA_TYPE.BEACH_LOVER]: { label: 'Island Hopper', icon: 'waves' },
  [TRAVEL_DNA_TYPE.CULTURE_TRAVELER]: {
    label: 'Culture Fan',
    icon: 'account_balance',
  },
  [TRAVEL_DNA_TYPE.MOUNTAIN_LOVER]: {
    label: 'Master Explorer',
    icon: 'terrain',
  },
};

export function resolveTravelStyleBadge(input: {
  profileBadge?: string | null;
  interests?: string[];
  dominantDna?: TRAVEL_DNA_TYPE | null;
}): { badgeLabel: string | null; badgeIcon: string | null } {
  const profile = input.profileBadge?.trim();
  if (profile) {
    return { badgeLabel: profile, badgeIcon: 'military_tech' };
  }

  for (const interest of input.interests ?? []) {
    for (const rule of INTEREST_BADGES) {
      if (rule.match.test(interest)) {
        return { badgeLabel: rule.label, badgeIcon: rule.icon };
      }
    }
  }

  if (input.dominantDna && DNA_BADGES[input.dominantDna]) {
    const badge = DNA_BADGES[input.dominantDna]!;
    return { badgeLabel: badge.label, badgeIcon: badge.icon };
  }

  return { badgeLabel: 'Explorer', badgeIcon: 'explore' };
}

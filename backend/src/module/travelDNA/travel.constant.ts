import {
  PLACE_CATEGORY,
  TRIP_TYPE,
  TRAVEL_DNA_TYPE,
} from '../../generated/prisma/enums';

export const TRAVEL_DNA_POTENTIAL_BADGE = 'Trục tiềm năng mở rộng';

const TRAVEL_DNA_BADGE_MIN_SCORE = 60;

export const TRAVEL_DNA_CONFIG: Record<
  TRAVEL_DNA_TYPE,
  {
    name: string;
    icon: string;
    description: string;
    shortLabel: string;
    badgeTitle: string;
    tripTypes: TRIP_TYPE[];
    activities: PLACE_CATEGORY[];
  }
> = {
  SOLO_TRAVELER: {
    name: 'Solo Traveler',
    icon: '🧳',
    description: 'You enjoy exploring the world on your own.',
    shortLabel: 'Một mình',
    badgeTitle: 'Người đi riêng',
    tripTypes: [TRIP_TYPE.SOLO],
    activities: [],
  },

  BACKPACKER: {
    name: 'Backpacker',
    icon: '🎒',
    description: 'You love independent and adventurous travel.',
    shortLabel: 'Phượt Bụi',
    badgeTitle: 'Balo gọn nhẹ',
    tripTypes: [TRIP_TYPE.BACKPACKER],
    activities: [],
  },

  MOUNTAIN_LOVER: {
    name: 'Mountain Lover',
    icon: '🏔️',
    description: 'You are drawn to mountains and highland destinations.',
    shortLabel: 'Núi',
    badgeTitle: 'Người của cao nguyên',
    tripTypes: [],
    activities: [PLACE_CATEGORY.MOUNTAIN],
  },

  BEACH_LOVER: {
    name: 'Beach Lover',
    icon: '🏖️',
    description: 'You love relaxing and exploring by the sea.',
    shortLabel: 'Biển Đảo',
    badgeTitle: 'Tín đồ hoàng hôn biển',
    tripTypes: [],
    activities: [PLACE_CATEGORY.BEACH],
  },

  ADVENTURE_TRAVELER: {
    name: 'Adventure Traveler',
    icon: '🧗',
    description: 'You seek exciting and challenging travel experiences.',
    shortLabel: 'Dã Ngoại',
    badgeTitle: 'Người mở đường',
    tripTypes: [],
    activities: [
      PLACE_CATEGORY.CAMPING,
      PLACE_CATEGORY.CAVE,
      PLACE_CATEGORY.LAKE,
      PLACE_CATEGORY.WATERFALL,
    ],
  },

  FOODIE_TRAVELER: {
    name: 'Foodie Traveler',
    icon: '🍜',
    description: 'You love discovering local food and cuisine.',
    shortLabel: 'Ẩm Thực',
    badgeTitle: 'Bậc thầy vị giác',
    tripTypes: [],
    activities: [PLACE_CATEGORY.FOOD],
  },

  PHOTOGRAPHY_LOVER: {
    name: 'Photography Lover',
    icon: '📸',
    description: 'You love capturing beautiful travel moments.',
    shortLabel: 'Săn Ảnh',
    badgeTitle: 'Ống kính nghệ thuật',
    tripTypes: [],
    activities: [],
  },

  CULTURE_TRAVELER: {
    name: 'Culture Traveler',
    icon: '🏛️',
    description: 'You enjoy discovering history, culture and traditions.',
    shortLabel: 'Văn Hóa',
    badgeTitle: 'Người kể chuyện di sản',
    tripTypes: [],
    activities: [
      PLACE_CATEGORY.MUSEUM,
      PLACE_CATEGORY.TEMPLES,
      PLACE_CATEGORY.HISTORICAL_SITE,
      PLACE_CATEGORY.MONUMENT,
      PLACE_CATEGORY.PALACE,
      PLACE_CATEGORY.CASTLE,
      PLACE_CATEGORY.OLD_TOWN,
    ],
  },

  ENTERTAINMENT_TRAVELLER: {
    name: 'Fun Seeker',
    icon: '🎢',
    description: 'You love discovering fun, exciting and entertaining places.',
    shortLabel: 'Giải trí',
    badgeTitle: 'Người săn không khí',
    tripTypes: [],
    activities: [
      PLACE_CATEGORY.ZOO,
      PLACE_CATEGORY.WATER_PARK,
      PLACE_CATEGORY.PARK,
      PLACE_CATEGORY.CINEMA,
      PLACE_CATEGORY.THEATER,
      PLACE_CATEGORY.NIGHT_MARKET,
      PLACE_CATEGORY.SHOPPING_MALL,
      PLACE_CATEGORY.MARKET,
      PLACE_CATEGORY.ZIPLINE,
      PLACE_CATEGORY.WALKING_STREET,
    ],
  },

  FAMILY_TRAVELER: {
    name: 'Family Traveler',
    icon: '👨‍👩‍👧',
    description: 'You enjoy traveling and creating memories with family.',
    shortLabel: 'Gia đình',
    badgeTitle: 'Nhịp chung nhà',
    tripTypes: [TRIP_TYPE.FAMILY],
    activities: [],
  },

  COUPLE_TRAVELLER: {
    name: 'Couple Traveler',
    icon: '❤️',
    description: 'You enjoy discovering new places with your partner.',
    shortLabel: 'Cặp đôi',
    badgeTitle: 'Nhịp hai người',
    tripTypes: [TRIP_TYPE.COUPLE],
    activities: [],
  },

  GROUP_TRAVELER: {
    name: 'Group Traveler',
    icon: '👥',
    description: 'You enjoy traveling and sharing experiences with friends.',
    shortLabel: 'Nhóm bạn',
    badgeTitle: 'Người giữ nhịp nhóm',
    tripTypes: [TRIP_TYPE.FRIENDS],
    activities: [],
  },
};

/** Badge sentence for a score. Below 60 the axis is still potential, not a badge. */
export function travelDnaBadgeTitle(
  type: TRAVEL_DNA_TYPE,
  score: number,
): string {
  if (score < TRAVEL_DNA_BADGE_MIN_SCORE) return TRAVEL_DNA_POTENTIAL_BADGE;
  return TRAVEL_DNA_CONFIG[type].badgeTitle;
}

import { PrismaPg } from '@prisma/adapter-pg';
import { Pool } from 'pg';
import 'dotenv/config';
import { PrismaClient } from '../src/generated/prisma/client';
import {
  ACHIEVEMENT_RARITY,
  PLACE_CATEGORY,
  TRIP_MISSION_GROUP,
  TRIP_MISSION_SCOPE,
  TRIP_MISSION_VERIFY,
} from '../src/generated/prisma/enums';

const connectionString = process.env.DATABASE_URL;
if (!connectionString) {
  throw new Error('DATABASE_URL is not configured');
}

const pool = new Pool({ connectionString });
const prisma = new PrismaClient({ adapter: new PrismaPg(pool) });

const FOOD_CATEGORIES = [
  PLACE_CATEGORY.FOOD,
  PLACE_CATEGORY.CAFE,
  PLACE_CATEGORY.MARKET,
  PLACE_CATEGORY.NIGHT_MARKET,
] as const;

const CULTURE_CATEGORIES = [
  PLACE_CATEGORY.MUSEUM,
  PLACE_CATEGORY.TEMPLES,
  PLACE_CATEGORY.CHURCH,
  PLACE_CATEGORY.HISTORICAL_SITE,
  PLACE_CATEGORY.MONUMENT,
  PLACE_CATEGORY.PALACE,
  PLACE_CATEGORY.CASTLE,
  PLACE_CATEGORY.OLD_TOWN,
] as const;

const NATURE_CATEGORIES = [
  PLACE_CATEGORY.BEACH,
  PLACE_CATEGORY.MOUNTAIN,
  PLACE_CATEGORY.WATERFALL,
  PLACE_CATEGORY.PARK,
  PLACE_CATEGORY.LAKE,
  PLACE_CATEGORY.CAVE,
  PLACE_CATEGORY.CAMPING,
] as const;

async function main() {
  const templates = [
    {
      code: 'CHECKIN_PLACES',
      group: TRIP_MISSION_GROUP.EXPLORATION,
      title: 'Ghé thăm địa điểm trong lịch trình',
      subtitle: 'Check-in đủ số điểm dừng mục tiêu',
      icon: 'pin_drop',
      verifyType: TRIP_MISSION_VERIFY.CHECKIN_COUNT,
      verifyPayload: {},
      pointsReward: 30,
      targetCountDefault: 3,
      scope: TRIP_MISSION_SCOPE.PERSONAL,
      sortOrder: 1,
      seed: {
        placeCategories: [] as PLACE_CATEGORY[],
        requireNewCity: false,
        priority: 10,
      },
    },
    {
      code: 'TRIP_MEMORIES',
      group: TRIP_MISSION_GROUP.EXPERIENCE,
      title: 'Lưu 3 kỷ niệm',
      subtitle: 'Đăng ít nhất 3 ảnh trong chuyến đi',
      icon: 'photo_camera',
      verifyType: TRIP_MISSION_VERIFY.MEMORY_COUNT,
      verifyPayload: {},
      pointsReward: 25,
      targetCountDefault: 3,
      scope: TRIP_MISSION_SCOPE.PERSONAL,
      sortOrder: 2,
      seed: {
        placeCategories: [] as PLACE_CATEGORY[],
        requireNewCity: false,
        priority: 20,
      },
    },
    {
      code: 'NEW_CITY',
      group: TRIP_MISSION_GROUP.EXPLORATION,
      title: 'Khám phá tỉnh/thành mới',
      subtitle: 'Check-in tại một thành phố chưa từng ghé',
      icon: 'explore',
      verifyType: TRIP_MISSION_VERIFY.CHECKIN_NEW_CITY,
      verifyPayload: {},
      pointsReward: 40,
      targetCountDefault: 1,
      scope: TRIP_MISSION_SCOPE.PERSONAL,
      sortOrder: 3,
      seed: {
        placeCategories: [] as PLACE_CATEGORY[],
        requireNewCity: true,
        priority: 30,
      },
    },
    {
      code: 'LOCAL_FOOD',
      group: TRIP_MISSION_GROUP.FOOD,
      title: 'Thử ẩm thực địa phương',
      subtitle: 'Check-in tại quán ăn, cafe hoặc chợ',
      icon: 'restaurant',
      verifyType: TRIP_MISSION_VERIFY.CHECKIN_PLACE_CATEGORY,
      verifyPayload: { categories: [...FOOD_CATEGORIES] },
      pointsReward: 30,
      targetCountDefault: 1,
      scope: TRIP_MISSION_SCOPE.PERSONAL,
      sortOrder: 4,
      seed: {
        placeCategories: [...FOOD_CATEGORIES] as PLACE_CATEGORY[],
        requireNewCity: false,
        priority: 40,
      },
    },
    {
      code: 'CULTURE_SITE',
      group: TRIP_MISSION_GROUP.CULTURE,
      title: 'Khám phá văn hóa',
      subtitle: 'Check-in bảo tàng, di tích hoặc phố cổ',
      icon: 'museum',
      verifyType: TRIP_MISSION_VERIFY.CHECKIN_PLACE_CATEGORY,
      verifyPayload: { categories: [...CULTURE_CATEGORIES] },
      pointsReward: 30,
      targetCountDefault: 1,
      scope: TRIP_MISSION_SCOPE.PERSONAL,
      sortOrder: 5,
      seed: {
        placeCategories: [...CULTURE_CATEGORIES] as PLACE_CATEGORY[],
        requireNewCity: false,
        priority: 50,
      },
    },
    {
      code: 'NATURE_SPOT',
      group: TRIP_MISSION_GROUP.NATURE,
      title: 'Gần gũi thiên nhiên',
      subtitle: 'Check-in biển, núi, thác hoặc công viên',
      icon: 'park',
      verifyType: TRIP_MISSION_VERIFY.CHECKIN_PLACE_CATEGORY,
      verifyPayload: { categories: [...NATURE_CATEGORIES] },
      pointsReward: 30,
      targetCountDefault: 1,
      scope: TRIP_MISSION_SCOPE.PERSONAL,
      sortOrder: 6,
      seed: {
        placeCategories: [...NATURE_CATEGORIES] as PLACE_CATEGORY[],
        requireNewCity: false,
        priority: 60,
      },
    },
  ];

  for (const template of templates) {
    const { seed, ...data } = template;
    const row = await prisma.tripMissionTemplate.upsert({
      where: { code: data.code },
      create: { ...data, isActive: true },
      update: { ...data, isActive: true },
    });

    const existingRule = await prisma.tripMissionSeedRule.findFirst({
      where: { templateId: row.id },
      select: { id: true },
    });
    if (existingRule) {
      await prisma.tripMissionSeedRule.update({
        where: { id: existingRule.id },
        data: {
          placeCategories: seed.placeCategories,
          requireNewCity: seed.requireNewCity,
          priority: seed.priority,
        },
      });
    } else {
      await prisma.tripMissionSeedRule.create({
        data: {
          templateId: row.id,
          placeCategories: seed.placeCategories,
          requireNewCity: seed.requireNewCity,
          priority: seed.priority,
        },
      });
    }
  }

  const achievements = [
    {
      code: 'FOOD_HUNTER',
      title: 'Food Hunter',
      description: 'Check-in tại 10 địa điểm ẩm thực',
      rarity: ACHIEVEMENT_RARITY.BRONZE,
      metric: 'FOOD_CHECKINS',
      targetCount: 10,
      sortOrder: 1,
    },
    {
      code: 'VIETNAM_CIRCLE',
      title: 'Vòng quanh Việt Nam',
      description: 'Đến 10 tỉnh/thành khác nhau',
      rarity: ACHIEVEMENT_RARITY.SILVER,
      metric: 'DISTINCT_CITIES',
      targetCount: 10,
      sortOrder: 2,
    },
    {
      code: 'CULTURE_COLLECTOR',
      title: 'Nhà sưu tầm văn hóa',
      description: 'Check-in 5 di tích hoặc bảo tàng',
      rarity: ACHIEVEMENT_RARITY.BRONZE,
      metric: 'CULTURE_CHECKINS',
      targetCount: 5,
      sortOrder: 3,
    },
    {
      code: 'NATURE_LOVER',
      title: 'Người yêu thiên nhiên',
      description: 'Check-in 5 điểm thiên nhiên',
      rarity: ACHIEVEMENT_RARITY.BRONZE,
      metric: 'NATURE_CHECKINS',
      targetCount: 5,
      sortOrder: 4,
    },
    {
      code: 'PHOTO_MOMENTS',
      title: 'Kẻ săn khoảnh khắc',
      description: 'Đăng 10 kỷ niệm trong các chuyến đi',
      rarity: ACHIEVEMENT_RARITY.BRONZE,
      metric: 'MEMORIES',
      targetCount: 10,
      sortOrder: 5,
    },
  ] as const;

  for (const achievement of achievements) {
    await prisma.achievementDefinition.upsert({
      where: { code: achievement.code },
      create: { ...achievement, isActive: true },
      update: { ...achievement, isActive: true },
    });
  }

  console.log('Trip missions seed completed', {
    templates: templates.map((t) => t.code),
    achievements: achievements.map((a) => a.code),
  });
}

main()
  .catch((error) => {
    console.error('Trip missions seed failed', error);
    process.exitCode = 1;
  })
  .finally(async () => {
    await prisma.$disconnect();
    await pool.end();
  });

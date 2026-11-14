import { PrismaPg } from '@prisma/adapter-pg';
import { Pool } from 'pg';
import 'dotenv/config';
import { PrismaClient } from '../src/generated/prisma/client';
import {
  RANKING_QUEST_ACTION,
  RANKING_QUEST_TONE,
} from '../src/generated/prisma/enums';

const connectionString = process.env.DATABASE_URL;
if (!connectionString) {
  throw new Error('DATABASE_URL is not configured');
}

const pool = new Pool({ connectionString });
const prisma = new PrismaClient({ adapter: new PrismaPg(pool) });

async function main() {
  const season = await prisma.rankingSeason.upsert({
    where: { code: 'SUMMER_2025' },
    create: {
      code: 'SUMMER_2025',
      label: 'Mùa Hè 2025',
      startsAt: new Date('2025-06-01T00:00:00.000Z'),
      endsAt: new Date('2025-08-31T23:59:59.999Z'),
      isActive: true,
    },
    update: {
      label: 'Mùa Hè 2025',
      startsAt: new Date('2025-06-01T00:00:00.000Z'),
      endsAt: new Date('2025-08-31T23:59:59.999Z'),
      isActive: true,
    },
  });

  await prisma.rankingSeason.updateMany({
    where: { id: { not: season.id }, isActive: true },
    data: { isActive: false },
  });

  const quests = [
    {
      code: 'COMPLETE_TRIP',
      title: 'Hoàn thành 1 chuyến đi mới',
      subtitle: 'Đặt & check-in trọn vẹn lịch trình bất kỳ',
      icon: 'luggage',
      pointsReward: 100,
      action: RANKING_QUEST_ACTION.START,
      tone: RANKING_QUEST_TONE.PRIMARY,
      targetCount: 1,
      sortOrder: 1,
    },
    {
      code: 'HERITAGE_CHECKIN',
      title: 'Check-in 5 điểm đến di sản',
      subtitle: 'Tiến độ hiện tại theo địa danh di sản',
      icon: 'pin_drop',
      pointsReward: 50,
      action: RANKING_QUEST_ACTION.CONTINUE,
      tone: RANKING_QUEST_TONE.SECONDARY,
      targetCount: 5,
      sortOrder: 2,
    },
    {
      code: 'PHOTO_REVIEW',
      title: 'Viết review có ảnh chất lượng',
      subtitle: 'Chia sẻ trải nghiệm thực tế với cộng đồng',
      icon: 'photo_camera',
      pointsReward: 30,
      action: RANKING_QUEST_ACTION.WRITE,
      tone: RANKING_QUEST_TONE.TERTIARY,
      targetCount: 1,
      sortOrder: 3,
    },
  ] as const;

  for (const quest of quests) {
    await prisma.rankingQuestDefinition.upsert({
      where: { code: quest.code },
      create: { ...quest, isActive: true },
      update: { ...quest, isActive: true },
    });
  }

  console.log('Ranking seed completed', {
    season: season.code,
    quests: quests.map((q) => q.code),
  });
}

main()
  .catch((error) => {
    console.error('Ranking seed failed', error);
    process.exitCode = 1;
  })
  .finally(async () => {
    await prisma.$disconnect();
    await pool.end();
  });

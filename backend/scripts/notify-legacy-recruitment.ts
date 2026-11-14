import 'dotenv/config';
import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from '../src/generated/prisma/client';
import { notifyLegacyRecruitmentGaps } from '../src/module/trips/trip-relations/trip-recruitment/notify-legacy-recruitment';

async function main(): Promise<void> {
  const connectionString = process.env.DATABASE_URL;
  if (!connectionString) {
    throw new Error('DATABASE_URL is not configured');
  }
  const prisma = new PrismaClient({
    adapter: new PrismaPg({ connectionString }),
  });
  try {
    const sent = await notifyLegacyRecruitmentGaps(prisma);
    console.log(`Legacy recruitment notices sent: ${sent}`);
  } finally {
    await prisma.$disconnect();
  }
}

void main();

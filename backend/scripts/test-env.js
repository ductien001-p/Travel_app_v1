require('dotenv').config();
const { PrismaPg } = require('@prisma/adapter-pg');
const { PrismaClient } = require('../dist/src/generated/prisma/client');
const Redis = require('ioredis');

async function testConnections() {
  console.log('Testing DB connection...');
  try {
    const adapter = new PrismaPg({ connectionString: process.env.DATABASE_URL });
    const prisma = new PrismaClient({ adapter });
    await prisma.$connect();
    console.log('PostgreSQL Connected successfully!');
    const userCount = await prisma.user.count();
    console.log('Current User count in DB:', userCount);
    
    // Check pgvector extension
    const vectorCheck = await prisma.$queryRawUnsafe("SELECT 1 FROM pg_extension WHERE extname = 'vector';");
    console.log('pgvector extension check:', vectorCheck);

    await prisma.$disconnect();
  } catch (err) {
    console.error('PostgreSQL Connection Error:', err);
    process.exit(1);
  }

  console.log('Testing Redis connection...');
  try {
    const redis = new Redis({ host: 'localhost', port: parseInt(process.env.REDIS_PORT || '6379') });
    const pong = await redis.ping();
    console.log('Redis Connected successfully:', pong);
    redis.disconnect();
  } catch (err) {
    console.error('Redis Connection Error:', err);
    process.exit(1);
  }

  console.log('All Environment connections PASSED!');
}

testConnections();

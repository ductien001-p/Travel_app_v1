import { Injectable } from '@nestjs/common';
import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from '../src/generated/prisma/client';

@Injectable()
export class PrismaService extends PrismaClient {
  constructor() {
    const adapter = new PrismaPg({
      connectionString: process.env.DATABASE_URL!,
      // Pins every session to UTC so now()/CURRENT_DATE match the app clock.
      options: '-c TimeZone=UTC',
    });

    super({ adapter });
  }
}

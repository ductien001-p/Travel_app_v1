import { PrismaPg } from '@prisma/adapter-pg';
import * as bcrypt from 'bcrypt';
import { readFileSync } from 'node:fs';
import { resolve } from 'node:path';
import request from 'supertest';
import {
  AUTH_PROVIDER,
  USER_STATUS,
} from '../../src/generated/prisma/enums';
import { PrismaClient } from '../../src/generated/prisma/client';

export const API_BASE = process.env.JOURNEY_API_BASE ?? 'http://127.0.0.1:3001';
export const PASSWORD = 'Journey-E2e-Pass!';

let prisma: PrismaClient | undefined;

function envValue(name: string): string {
  if (process.env[name]?.trim()) return process.env[name]!.trim();
  const text = readFileSync(resolve(__dirname, '../../.env'), 'utf8');
  for (const row of text.split(/\r?\n/)) {
    const trimmed = row.trim();
    if (!trimmed || trimmed.startsWith('#')) continue;
    const eq = trimmed.indexOf('=');
    if (eq === -1) continue;
    if (trimmed.slice(0, eq).trim() !== name) continue;
    return trimmed
      .slice(eq + 1)
      .trim()
      .replace(/^"|"$/g, '');
  }
  throw new Error(`missing ${name}`);
}

export function db(): PrismaClient {
  if (!prisma) {
    process.env.DATABASE_URL = envValue('DATABASE_URL');
    prisma = new PrismaClient({
      adapter: new PrismaPg({
        connectionString: process.env.DATABASE_URL,
        options: '-c TimeZone=UTC',
      }),
    });
  }
  return prisma;
}

export async function disconnectDb(): Promise<void> {
  await prisma?.$disconnect();
  prisma = undefined;
}

export async function assertApiUp(): Promise<void> {
  try {
    const response = await request(API_BASE).get('/api/docs');
    if (response.status >= 500) {
      throw new Error(`API HTTP ${response.status}`);
    }
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    throw new Error(
      `Journey e2e needs the API at ${API_BASE}. Start it with npm run start:dev. ${message}`,
    );
  }
}

export interface JourneyUser {
  id: string;
  email: string;
  accessToken: string;
  refreshToken: string;
}

export async function createActiveUser(label: string): Promise<JourneyUser> {
  const stamp = `${Date.now().toString(36)}${label}`;
  const email = `j3${stamp}@example.invalid`;
  const username = `j3${stamp}`.slice(0, 30);
  const password = await bcrypt.hash(PASSWORD, 4);
  const user = await db().user.create({
    data: {
      email,
      username,
      displayname: username,
      password,
      provider: AUTH_PROVIDER.LOCAL,
      status: USER_STATUS.ACTIVE,
    },
    select: { id: true, email: true },
  });
  const session = await login(email);
  return { id: user.id, email, ...session };
}

export async function login(email: string, password = PASSWORD) {
  const response = await request(API_BASE)
    .post('/auth/login')
    .send({ email, password });
  if (response.status !== 201) {
    throw new Error(
      `login HTTP ${response.status}: ${JSON.stringify(response.body)}`,
    );
  }
  return {
    accessToken: response.body.accessToken as string,
    refreshToken: response.body.refreshToken as string,
  };
}

export function auth(token: string) {
  return { Authorization: `Bearer ${token}` };
}

export function todayUtc(): string {
  return new Date().toISOString().slice(0, 10);
}

export async function createUpcomingTrip(owner: JourneyUser) {
  const draft = await request(API_BASE)
    .post('/trips/drafts')
    .set(auth(owner.accessToken))
    .send({
      name: `Journey e2e ${owner.id.slice(-6)}`,
      maxMembers: 4,
      budgetLevel: 'MEDIUM',
      destinations: [
        {
          country: 'Vietnam',
          city: 'Da Nang',
          lat: 16.0544,
          lng: 108.2022,
          order: 0,
          startDate: todayUtc(),
          endDate: todayUtc(),
        },
      ],
    });
  if (draft.status !== 201) {
    throw new Error(
      `draft HTTP ${draft.status}: ${JSON.stringify(draft.body)}`,
    );
  }
  const tripId = draft.body.data.id as string;
  const finalized = await request(API_BASE)
    .post(`/trips/${tripId}/finalize`)
    .set(auth(owner.accessToken));
  if (finalized.status !== 200 && finalized.status !== 201) {
    throw new Error(
      `finalize HTTP ${finalized.status}: ${JSON.stringify(finalized.body)}`,
    );
  }
  const detail = await request(API_BASE)
    .get(`/trips/${tripId}`)
    .set(auth(owner.accessToken));
  return {
    tripId,
    inviteCode: detail.body.data.inviteCode as string,
  };
}

export async function cleanupUsers(userIds: string[]): Promise<void> {
  if (userIds.length === 0) return;
  const client = db();
  await client.trip.deleteMany({ where: { ownerId: { in: userIds } } });
  await client.friendRequest.deleteMany({
    where: {
      OR: [{ fromUserId: { in: userIds } }, { toUserId: { in: userIds } }],
    },
  });
  await client.user.deleteMany({ where: { id: { in: userIds } } });
}

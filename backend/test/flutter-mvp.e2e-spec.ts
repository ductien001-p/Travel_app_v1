import {
  ConflictException,
  Controller,
  ForbiddenException,
  Get,
  INestApplication,
  InternalServerErrorException,
  ValidationPipe,
} from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { APP_FILTER, APP_GUARD } from '@nestjs/core';
import { JwtModule, JwtService } from '@nestjs/jwt';
import { PassportModule } from '@nestjs/passport';
import { Test } from '@nestjs/testing';
import * as bcrypt from 'bcrypt';
import * as crypto from 'node:crypto';
import request from 'supertest';
import { App } from 'supertest/types';
import { Public } from '../src/decoration/isPublic.decoration';
import {
  AUTH_PROVIDER,
  MEMBER_STATUS,
  TRIP_ROLE,
  TRIP_STATUS,
  TRIP_TYPE,
  TRIP_VISIBILITY,
  USER_ROLE,
  USER_STATUS,
} from '../src/generated/prisma/enums';
import { ApiExceptionFilter } from '../src/common/filters/api-exception.filter';
import { AuthController } from '../src/module/auth/auth.controller';
import { AuthService } from '../src/module/auth/auth.service';
import { LocalAuthGuard } from '../src/module/auth/strategies/local-auth.guard';
import { LocalStrategy } from '../src/module/auth/strategies/local.strategy';
import { JwtAuthGuard } from '../src/module/auth/strategies/jwt-auth.guard';
import { JwtStrategy } from '../src/module/auth/strategies/jwt.strategy';
import { UsersController } from '../src/module/users/users.controller';
import { UsersService } from '../src/module/users/users.service';
import { TripsController } from '../src/module/trips/trips.controller';
import { TripsService } from '../src/module/trips/trips.service';
import { TripMemoriesService } from '../src/module/trips/trip-relations/trip-memories/trip-memories.service';
import { TripItinerariesActivitiesService } from '../src/module/trips/trip-relations/trip-itineraries/trip-itineraries-activities.service';
import { TripTimelineService } from '../src/module/trips/trip-relations/trip-timeline/tripTimeline.service';
import { TripItinerariesService } from '../src/module/trips/trip-relations/trip-itineraries/trip-destination.service';
import { TripGateway } from '../src/websocket/gateway';
import { TripRoomWS } from '../src/module/trips/trip-gateway.service';
import { RedisService } from '../src/redis/redis.service';
import { MailService } from '../src/mail/mail.service';
import { MediaService } from '../src/module/media/media.service';
import { PrismaService } from '../src/prisma.service';
import {
  expectErrorSchema,
  expectOpenApiResponse,
} from './openapi-response-validator';

jest.mock('nanoid', () => ({
  customAlphabet: () => () => 'MVPTEST1',
}));

@Public()
@Controller('__readiness_probe')
class ReadinessProbeController {
  @Get('forbidden') forbidden(): never {
    throw new ForbiddenException('Forbidden probe');
  }
  @Get('conflict') conflict(): never {
    throw new ConflictException('Conflict probe');
  }
  @Get('internal') internal(): never {
    throw new InternalServerErrorException('sensitive-internal-probe');
  }
}

describe('Flutter MVP runtime readiness', () => {
  let app: INestApplication<App>;
  let prisma: PrismaService;
  let jwt: JwtService;
  const marker = 'flutter-mvp-20260915';
  const password = 'Mvp-Test-Password-42!';
  const ids = {
    owner: `${marker}-owner`,
    member: `${marker}-member`,
    outsider: `${marker}-outsider`,
    inactive: `${marker}-inactive`,
    publicTrip: `${marker}-public-trip`,
    privateTrip: `${marker}-private-trip`,
  };
  const tokens: Record<string, string> = {};

  beforeAll(async () => {
    if (!process.env.DATABASE_URL?.includes('travel_mvp_test_')) {
      throw new Error(
        'Refusing to run: DATABASE_URL is not an isolated MVP test database',
      );
    }
    const moduleRef = await Test.createTestingModule({
      imports: [
        ConfigModule.forRoot({ isGlobal: true }),
        PassportModule,
        JwtModule.registerAsync({
          inject: [ConfigService],
          useFactory: (config: ConfigService) => ({
            secret: config.getOrThrow<string>('JWT_SECRET'),
          }),
        }),
      ],
      controllers: [
        AuthController,
        UsersController,
        TripsController,
        ReadinessProbeController,
      ],
      providers: [
        PrismaService,
        UsersService,
        AuthService,
        LocalStrategy,
        JwtStrategy,
        LocalAuthGuard,
        TripsService,
        { provide: TripMemoriesService, useValue: {} },
        { provide: TripItinerariesActivitiesService, useValue: {} },
        { provide: TripTimelineService, useValue: {} },
        { provide: TripItinerariesService, useValue: {} },
        { provide: TripGateway, useValue: {} },
        { provide: TripRoomWS, useValue: {} },
        { provide: RedisService, useValue: {} },
        { provide: MailService, useValue: {} },
        { provide: MediaService, useValue: {} },
        { provide: APP_GUARD, useClass: JwtAuthGuard },
        { provide: APP_FILTER, useClass: ApiExceptionFilter },
      ],
    }).compile();

    app = moduleRef.createNestApplication();
    app.useGlobalPipes(
      new ValidationPipe({
        whitelist: true,
        forbidNonWhitelisted: true,
        transform: true,
      }),
    );
    await app.init();
    prisma = moduleRef.get(PrismaService);
    jwt = moduleRef.get(JwtService);
    await cleanup();

    const hashedPassword = await bcrypt.hash(password, 4);
    await prisma.user.createMany({
      data: [
        {
          id: ids.owner,
          email: `${marker}-owner@example.invalid`,
          username: 'MVP Owner',
          password: hashedPassword,
          provider: AUTH_PROVIDER.LOCAL,
          status: USER_STATUS.ACTIVE,
          role: USER_ROLE.USER,
        },
        {
          id: ids.member,
          email: `${marker}-member@example.invalid`,
          username: 'MVP Member',
          password: hashedPassword,
          provider: AUTH_PROVIDER.LOCAL,
          status: USER_STATUS.ACTIVE,
          role: USER_ROLE.USER,
        },
        {
          id: ids.outsider,
          email: `${marker}-outsider@example.invalid`,
          username: 'MVP Outsider',
          password: hashedPassword,
          provider: AUTH_PROVIDER.LOCAL,
          status: USER_STATUS.ACTIVE,
          role: USER_ROLE.USER,
        },
        {
          id: ids.inactive,
          email: `${marker}-inactive@example.invalid`,
          username: 'MVP Inactive',
          password: hashedPassword,
          provider: AUTH_PROVIDER.LOCAL,
          status: USER_STATUS.INACTIVE,
          role: USER_ROLE.USER,
        },
      ],
    });
    const baseTrip = {
      ownerId: ids.owner,
      description: null,
      startDate: new Date('2026-10-01T00:00:00.000Z'),
      endDate: new Date('2026-10-03T00:00:00.000Z'),
      maxMembers: 4,
      tripType: TRIP_TYPE.FRIENDS,
      status: TRIP_STATUS.UPCOMING,
    };
    await prisma.trip.create({
      data: {
        ...baseTrip,
        id: ids.publicTrip,
        name: 'MVP Public Trip',
        inviteCode: 'MVPPUB26',
        visibility: TRIP_VISIBILITY.PUBLIC,
        destinations: {
          create: {
            city: 'Da Nang',
            country: 'Vietnam',
            lat: 16.0544,
            lng: 108.2022,
            order: 1,
            startDate: baseTrip.startDate,
            endDate: baseTrip.endDate,
          },
        },
      },
    });
    await prisma.trip.create({
      data: {
        ...baseTrip,
        id: ids.privateTrip,
        name: 'MVP Private Trip',
        inviteCode: 'MVPPRI26',
        visibility: TRIP_VISIBILITY.PRIVATE,
        destinations: {
          create: {
            city: 'Hue',
            country: 'Vietnam',
            lat: 16.4637,
            lng: 107.5909,
            order: 1,
            startDate: baseTrip.startDate,
            endDate: baseTrip.endDate,
          },
        },
        members: {
          create: [
            {
              userId: ids.owner,
              role: TRIP_ROLE.OWNER,
              status: MEMBER_STATUS.ACTIVE,
            },
            {
              userId: ids.member,
              role: TRIP_ROLE.MEMBER,
              status: MEMBER_STATUS.ACTIVE,
            },
          ],
        },
      },
    });
  });

  afterAll(async () => {
    if (prisma) await cleanup();
    if (app) await app.close();
    if (prisma) await prisma.$disconnect();
  });

  async function cleanup() {
    await prisma.refreshToken.deleteMany({
      where: { userId: { in: Object.values(ids).slice(0, 4) } },
    });
    await prisma.trip.deleteMany({
      where: { id: { in: [ids.publicTrip, ids.privateTrip] } },
    });
    await prisma.user.deleteMany({
      where: { id: { in: Object.values(ids).slice(0, 4) } },
    });
  }

  async function login(user: 'owner' | 'member' | 'outsider') {
    const response = await request(app.getHttpServer())
      .post('/auth/login')
      .send({ email: `${marker}-${user}@example.invalid`, password })
      .expect(201);
    expectOpenApiResponse('post', '/auth/login', 201, response.body);
    tokens[user] = response.body.accessToken as string;
    return response.body as {
      id: string;
      accessToken: string;
      refreshToken: string;
    };
  }

  it('logs in without exposing private account fields and matches OpenAPI', async () => {
    const body = await login('owner');
    expect(Object.keys(body).sort()).toEqual([
      'accessToken',
      'id',
      'refreshToken',
    ]);
    expect(body.id).toBe(ids.owner);
  });

  it('returns the same generic 401 for bad password and inactive account', async () => {
    const wrong = await request(app.getHttpServer())
      .post('/auth/login')
      .send({
        email: `${marker}-owner@example.invalid`,
        password: 'wrong-password',
      })
      .expect(401);
    const inactive = await request(app.getHttpServer())
      .post('/auth/login')
      .send({ email: `${marker}-inactive@example.invalid`, password })
      .expect(401);
    expect(wrong.body.message).toBe(inactive.body.message);
    expectErrorSchema(wrong.body);
    expectErrorSchema(inactive.body);
  });

  it('validates login payload through the runtime error contract', async () => {
    const response = await request(app.getHttpServer())
      .post('/auth/login')
      .send({ email: 'not-an-email' })
      .expect(400);
    expect(response.body.code).toBe('VALIDATION_ERROR');
    expectErrorSchema(response.body);
    expectOpenApiResponse('post', '/auth/login', 400, response.body);
  });

  it('rotates refresh tokens and rejects the replaced token', async () => {
    const session = await login('owner');
    const rotated = await request(app.getHttpServer())
      .post('/auth/refresh')
      .send({ refreshToken: session.refreshToken })
      .expect(201);
    expectOpenApiResponse('post', '/auth/refresh', 201, rotated.body);
    expect(rotated.body.refreshToken).not.toBe(session.refreshToken);
    const reused = await request(app.getHttpServer())
      .post('/auth/refresh')
      .send({ refreshToken: session.refreshToken })
      .expect(401);
    expectErrorSchema(reused.body);
  });

  it('rejects invalid and inactive-user refresh tokens', async () => {
    const invalid = await request(app.getHttpServer())
      .post('/auth/refresh')
      .send({ refreshToken: 'invalid' })
      .expect(401);
    expectErrorSchema(invalid.body);
    const refreshToken = jwt.sign(
      {
        sub: ids.inactive,
        email: `${marker}-inactive@example.invalid`,
        role: USER_ROLE.USER,
        type: 'refresh',
      },
      { secret: process.env.JWT_SECRET_REFRESH!, expiresIn: '1h' },
    );
    await prisma.refreshToken.create({
      data: {
        userId: ids.inactive,
        hashed: crypto.createHash('sha256').update(refreshToken).digest('hex'),
        expiresAt: new Date(Date.now() + 60 * 60 * 1000),
      },
    });
    const inactive = await request(app.getHttpServer())
      .post('/auth/refresh')
      .send({ refreshToken })
      .expect(401);
    expectErrorSchema(inactive.body);
  });

  it('protects /users/me and returns only the public current-user contract', async () => {
    const unauthenticated = await request(app.getHttpServer())
      .get('/users/me')
      .expect(401);
    expectErrorSchema(unauthenticated.body);
    await login('owner');
    const response = await request(app.getHttpServer())
      .get('/users/me')
      .set('Authorization', `Bearer ${tokens.owner}`)
      .expect(200);
    expectOpenApiResponse('get', '/users/me', 200, response.body);
    expect(response.body.data.id).toBe(ids.owner);
    expect(response.body.data.visitedCount).toBe(0);
    for (const key of [
      'password',
      'passwordHash',
      'hashedPassword',
      'refreshToken',
      'refreshTokenHash',
      'resetToken',
      'googleAccessToken',
    ]) {
      expect(JSON.stringify(response.body)).not.toContain(`"${key}"`);
    }
  });

  it('transforms valid trip pagination and rejects invalid values', async () => {
    await login('outsider');
    const response = await request(app.getHttpServer())
      .get('/trips?page=1&limit=1')
      .set('Authorization', `Bearer ${tokens.outsider}`)
      .expect(200);
    expectOpenApiResponse('get', '/trips', 200, response.body);
    expect(response.body.meta).toEqual(
      expect.objectContaining({
        page: 1,
        limit: 1,
        hasNextPage: false,
        hasPreviousPage: false,
      }),
    );
    for (const query of [
      'page=0',
      'page=-1',
      'page=NaN',
      'limit=0',
      'limit=101',
      'limit=NaN',
    ]) {
      const invalid = await request(app.getHttpServer())
        .get(`/trips?${query}`)
        .set('Authorization', `Bearer ${tokens.outsider}`)
        .expect(400);
      expectErrorSchema(invalid.body);
    }
  });

  it('does not leak a private trip or inviteCode through list filters', async () => {
    const response = await request(app.getHttpServer())
      .get(`/trips?ownerId=${ids.owner}&visibility=PRIVATE`)
      .set('Authorization', `Bearer ${tokens.outsider}`)
      .expect(200);
    expect(response.body.data).toEqual([]);
    expect(response.body.meta).toEqual(
      expect.objectContaining({ page: 1, limit: 20 }),
    );
    expect(JSON.stringify(response.body)).not.toContain('inviteCode');

    for (const actor of ['owner', 'member'] as const) {
      if (!tokens[actor]) await login(actor);
      const visible = await request(app.getHttpServer())
        .get(`/trips?visibility=PRIVATE`)
        .set('Authorization', `Bearer ${tokens[actor]}`)
        .expect(200);
      expect(
        visible.body.data.map((trip: { id: string }) => trip.id),
      ).toContain(ids.privateTrip);
      expect(JSON.stringify(visible.body)).not.toContain('inviteCode');
    }
  });

  it('allows owner and active member to read private detail', async () => {
    await login('member');
    for (const actor of ['owner', 'member'] as const) {
      const response = await request(app.getHttpServer())
        .get(`/trips/${ids.privateTrip}`)
        .set('Authorization', `Bearer ${tokens[actor]}`)
        .expect(200);
      expectOpenApiResponse('get', '/trips/{id}', 200, response.body);
      expect(response.body.data.id).toBe(ids.privateTrip);
      expect(JSON.stringify(response.body)).not.toContain('inviteCode');
    }
  });

  it('allows authenticated public detail but hides inaccessible private existence', async () => {
    const publicResponse = await request(app.getHttpServer())
      .get(`/trips/${ids.publicTrip}`)
      .set('Authorization', `Bearer ${tokens.outsider}`)
      .expect(200);
    expectOpenApiResponse('get', '/trips/{id}', 200, publicResponse.body);
    const privateResponse = await request(app.getHttpServer())
      .get(`/trips/${ids.privateTrip}`)
      .set('Authorization', `Bearer ${tokens.outsider}`)
      .expect(404);
    expectErrorSchema(privateResponse.body);
    const missing = await request(app.getHttpServer())
      .get('/trips/flutter-mvp-missing')
      .set('Authorization', `Bearer ${tokens.outsider}`)
      .expect(404);
    expectErrorSchema(missing.body);
    await request(app.getHttpServer())
      .get(`/trips/${ids.publicTrip}`)
      .expect(401);
  });

  it('normalizes forbidden, conflict, internal and unknown-route errors safely', async () => {
    const forbidden = await request(app.getHttpServer())
      .get('/__readiness_probe/forbidden')
      .expect(403);
    expectErrorSchema(forbidden.body);
    const conflict = await request(app.getHttpServer())
      .get('/__readiness_probe/conflict')
      .expect(409);
    expectErrorSchema(conflict.body);
    const internal = await request(app.getHttpServer())
      .get('/__readiness_probe/internal')
      .expect(500);
    expectErrorSchema(internal.body);
    expect(internal.body.message).toBe('Internal server error');
    expect(JSON.stringify(internal.body)).not.toContain(
      'sensitive-internal-probe',
    );
    const unknown = await request(app.getHttpServer())
      .get('/__missing_route')
      .expect(404);
    expectErrorSchema(unknown.body);
  });
});

import request from 'supertest';
import {
  API_BASE,
  PASSWORD,
  assertApiUp,
  auth,
  cleanupUsers,
  createActiveUser,
  disconnectDb,
  login,
  type JourneyUser,
} from './support';

describe('Journey auth session', () => {
  const users: string[] = [];
  let owner: JourneyUser;

  beforeAll(async () => {
    await assertApiUp();
    owner = await createActiveUser('auth');
    users.push(owner.id);
  }, 30_000);

  afterAll(async () => {
    await cleanupUsers(users);
    await disconnectDb();
  });

  it('rotates refresh tokens and rejects the replaced token', async () => {
    const rotated = await request(API_BASE)
      .post('/auth/refresh')
      .send({ refreshToken: owner.refreshToken })
      .expect(201);
    expect(rotated.body.refreshToken).not.toBe(owner.refreshToken);
    await request(API_BASE)
      .post('/auth/refresh')
      .send({ refreshToken: owner.refreshToken })
      .expect(401);
    owner = {
      ...owner,
      accessToken: rotated.body.accessToken,
      refreshToken: rotated.body.refreshToken,
    };
    await request(API_BASE)
      .get('/users/me')
      .set(auth(owner.accessToken))
      .expect(200);
  });

  it('revokes the access token when that device logs out', async () => {
    const session = await login(owner.email);
    await request(API_BASE)
      .post('/auth/logout-one')
      .set(auth(session.accessToken))
      .send({
        refreshToken: session.refreshToken,
        installationId: 'journey-e2e',
      })
      .expect(201);
    await request(API_BASE)
      .get('/users/me')
      .set(auth(session.accessToken))
      .expect(401);
    await request(API_BASE)
      .post('/auth/refresh')
      .send({ refreshToken: session.refreshToken })
      .expect(401);
  });

  it('revokes outstanding access tokens when the password changes', async () => {
    const session = await login(owner.email);
    const next = 'Journey-E2e-Pass2!';
    await request(API_BASE)
      .post('/auth/change-password')
      .set(auth(session.accessToken))
      .send({ oldPassword: PASSWORD, newPassword: next })
      .expect(201);
    await request(API_BASE)
      .get('/users/me')
      .set(auth(session.accessToken))
      .expect(401);
    await request(API_BASE)
      .post('/auth/refresh')
      .send({ refreshToken: session.refreshToken })
      .expect(401);
    await request(API_BASE)
      .post('/auth/login')
      .send({ email: owner.email, password: PASSWORD })
      .expect(401);
    const fresh = await login(owner.email, next);
    await request(API_BASE)
      .get('/users/me')
      .set(auth(fresh.accessToken))
      .expect(200);
  });
});

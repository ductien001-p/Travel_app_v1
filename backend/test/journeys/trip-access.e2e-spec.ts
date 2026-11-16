import request from 'supertest';
import {
  API_BASE,
  assertApiUp,
  auth,
  cleanupUsers,
  createActiveUser,
  createUpcomingTrip,
  disconnectDb,
  type JourneyUser,
} from './support';

describe('Journey trip access', () => {
  const users: string[] = [];
  let owner: JourneyUser;
  let member: JourneyUser;
  let outsider: JourneyUser;
  let tripId = '';
  let inviteCode = '';

  beforeAll(async () => {
    await assertApiUp();
    owner = await createActiveUser('own');
    member = await createActiveUser('mem');
    outsider = await createActiveUser('out');
    users.push(owner.id, member.id, outsider.id);
    const trip = await createUpcomingTrip(owner);
    tripId = trip.tripId;
    inviteCode = trip.inviteCode;
  }, 60_000);

  afterAll(async () => {
    await cleanupUsers(users);
    await disconnectDb();
  });

  it('hides trip writes and member resources from an outsider', async () => {
    const expenses = await request(API_BASE)
      .get(`/trips/${tripId}/expenses`)
      .set(auth(outsider.accessToken))
      .expect(404);
    const postExpense = await request(API_BASE)
      .post(`/trips/${tripId}/expenses`)
      .set(auth(outsider.accessToken))
      .send({
        amount: 1000,
        currency: 'VND',
        category: 'OTHER',
        splitType: 'EQUAL',
      })
      .expect(404);
    const invite = await request(API_BASE)
      .post('/trip-invitations/invite')
      .set(auth(outsider.accessToken))
      .send({ tripId, inviteeId: owner.id })
      .expect(404);
    const missing = await request(API_BASE)
      .get('/trips/trip-does-not-exist/expenses')
      .set(auth(outsider.accessToken))
      .expect(404);

    expect(expenses.body.message).toBe('Trip not found');
    expect(postExpense.body.message).toBe(missing.body.message);
    expect(invite.body.message).toBe('Trip not found');
    expect(expenses.body.code).toBe('NOT_FOUND');
  });

  it('lets the owner invite and a member read expenses after joining by code', async () => {
    await request(API_BASE)
      .post('/trip-invitations/invite')
      .set(auth(owner.accessToken))
      .send({ tripId, inviteeId: member.id })
      .expect(201);

    const joined = await request(API_BASE)
      .post(`/trips/join/${encodeURIComponent(inviteCode)}`)
      .set(auth(member.accessToken))
      .send({ message: 'journey e2e' })
      .expect(201);
    if (joined.body.data.status !== 'APPROVED') {
      await request(API_BASE)
        .post(`/trips/${tripId}/join-requests/${joined.body.data.id}/approve`)
        .set(auth(owner.accessToken))
        .expect(200);
    }

    await request(API_BASE)
      .get(`/trips/${tripId}/expenses`)
      .set(auth(member.accessToken))
      .expect(200);
    await request(API_BASE)
      .get(`/trips/${tripId}/itineraries`)
      .set(auth(outsider.accessToken))
      .expect(404);
  });
});

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

describe('Journey chat and notifications', () => {
  const users: string[] = [];
  let owner: JourneyUser;
  let friend: JourneyUser;
  let outsider: JourneyUser;
  let tripId = '';
  let conversationId = '';

  beforeAll(async () => {
    await assertApiUp();
    owner = await createActiveUser('cht');
    friend = await createActiveUser('frd');
    outsider = await createActiveUser('str');
    users.push(owner.id, friend.id, outsider.id);
    tripId = (await createUpcomingTrip(owner)).tripId;

    const requestId = (
      await request(API_BASE)
        .post('/friends/requests')
        .set(auth(owner.accessToken))
        .send({ toUserId: friend.id })
        .expect(201)
    ).body.data.id as string;
    await request(API_BASE)
      .post(`/friends/requests/${requestId}/accept`)
      .set(auth(friend.accessToken))
      .expect(201);
    conversationId = (
      await request(API_BASE)
        .post(`/friends/${friend.id}/conversation`)
        .set(auth(owner.accessToken))
        .expect(201)
    ).body.data.id as string;
  }, 60_000);

  afterAll(async () => {
    await cleanupUsers(users);
    await disconnectDb();
  });

  it('delivers a TEXT message to a friend and hides the thread from everyone else', async () => {
    const text = `hello ${conversationId.slice(-6)}`;
    await request(API_BASE)
      .post(`/friends/conversations/${conversationId}/messages`)
      .set(auth(owner.accessToken))
      .send({ content: text, messageType: 'TEXT' })
      .expect(201);

    const thread = await request(API_BASE)
      .get(`/friends/conversations/${conversationId}/thread`)
      .set(auth(friend.accessToken))
      .expect(200);
    expect(JSON.stringify(thread.body)).toContain(text);

    const hidden = await request(API_BASE)
      .get(`/friends/conversations/${conversationId}/thread`)
      .set(auth(outsider.accessToken))
      .expect(404);
    const missing = await request(API_BASE)
      .get('/friends/conversations/missing-conversation/thread')
      .set(auth(outsider.accessToken))
      .expect(404);
    expect(hidden.body.message).toBe('Conversation not found');
    expect(missing.body.message).toBe(hidden.body.message);

    await request(API_BASE)
      .post(`/friends/conversations/${conversationId}/messages`)
      .set(auth(outsider.accessToken))
      .send({ content: 'nope', messageType: 'TEXT' })
      .expect(404);
  });

  it('lets the invitee read a trip notification and hides it from an outsider', async () => {
    await request(API_BASE)
      .post('/trip-invitations/invite')
      .set(auth(owner.accessToken))
      .send({ tripId, inviteeId: friend.id })
      .expect(201);

    const inbox = await request(API_BASE)
      .get('/notifications?limit=20')
      .set(auth(friend.accessToken))
      .expect(200);
    const item = (inbox.body.data as Array<{ id: string; tripId: string | null }>).find(
      (row) => row.tripId === tripId,
    );
    expect(item).toBeDefined();

    await request(API_BASE)
      .post(`/notifications/${item!.id}/read`)
      .set(auth(outsider.accessToken))
      .expect(404);
    const read = await request(API_BASE)
      .post(`/notifications/${item!.id}/read`)
      .set(auth(friend.accessToken))
      .expect(201);
    expect(read.body.data.isRead).toBe(true);
  });
});

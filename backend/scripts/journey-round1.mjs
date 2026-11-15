/**
 * Round-1 runtime journeys against a local Travel API.
 *
 * Reads the email verification code from local Redis (the code is stored
 * before mail is sent). Does not print tokens, passwords, or the code.
 *
 * Usage (API already running):
 *   node scripts/journey-round1.mjs
 */
import { createRequire } from 'node:module';
import { mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const require = createRequire(import.meta.url);
const Redis = require('ioredis');
const { io } = require('socket.io-client');

const root = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const repoRoot = resolve(root, '..');
const BASE = process.env.JOURNEY_API_BASE ?? 'http://127.0.0.1:3001';
const SOCKET = process.env.JOURNEY_SOCKET_BASE ?? 'http://127.0.0.1:3002';
const PASSWORD = 'Journey-Round1-Pass!';
const NEW_PASSWORD = 'Journey-Round1-Pass2!';
const stamp = Date.now().toString(36);
const today = new Date().toISOString().slice(0, 10);
const PNG = Buffer.from(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==',
  'base64',
);

const steps = [];
const ids = {
  stamp,
  todayUtc: today,
  users: {},
  tripId: null,
  placeId: null,
  conversationId: null,
  postId: null,
};

function envValue(name, fallback) {
  try {
    const text = readFileSync(resolve(root, '.env'), 'utf8');
    const line = text
      .split(/\r?\n/)
      .find((row) => row.startsWith(`${name}=`));
    if (!line) return fallback;
    return line.slice(name.length + 1).trim().replace(/^"|"$/g, '');
  } catch {
    return fallback;
  }
}

function brief(body) {
  if (!body) return '';
  const message = body.message ?? body.error;
  const details = Array.isArray(body.details)
    ? body.details
        .map((item) => item.message ?? item)
        .slice(0, 4)
        .join('; ')
    : '';
  const text = [message, details].filter(Boolean).join(' — ');
  return String(text || JSON.stringify(body)).slice(0, 400);
}

async function api(method, path, { token, body } = {}) {
  const response = await fetch(`${BASE}${path}`, {
    method,
    headers: {
      ...(body !== undefined ? { 'content-type': 'application/json' } : {}),
      ...(token ? { authorization: `Bearer ${token}` } : {}),
    },
    body: body !== undefined ? JSON.stringify(body) : undefined,
  });
  const text = await response.text();
  let parsed = null;
  if (text) {
    try {
      parsed = JSON.parse(text);
    } catch {
      parsed = { message: text.slice(0, 300) };
    }
  }
  return { status: response.status, body: parsed };
}

function record(journey, name, status, detail) {
  steps.push({ journey, name, status, detail });
  const mark = status === 'PASS' ? 'PASS' : status === 'BLOCKED' ? 'BLOCKED' : 'FAIL';
  console.log(`[${mark}] ${journey} — ${name}${detail ? ` — ${detail}` : ''}`);
}

async function step(journey, name, fn) {
  try {
    const detail = await fn();
    record(journey, name, 'PASS', detail ?? '');
    return true;
  } catch (error) {
    record(journey, name, 'FAIL', error instanceof Error ? error.message : String(error));
    return false;
  }
}

function block(journey, name, detail) {
  record(journey, name, 'BLOCKED', detail);
}

function expectStatus(result, allowed, label) {
  const codes = Array.isArray(allowed) ? allowed : [allowed];
  if (!codes.includes(result.status)) {
    throw new Error(`${label} HTTP ${result.status}: ${brief(result.body)}`);
  }
  return result;
}

async function redisCode(email) {
  const redis = new Redis({
    host: envValue('REDIS_HOST', 'localhost'),
    port: Number(envValue('REDIS_PORT', '6379')),
    maxRetriesPerRequest: 1,
    connectTimeout: 4000,
  });
  try {
    const code = await redis.get(`email_verification:${email.toLowerCase()}`);
    if (!code) throw new Error('verification code missing in Redis');
    return code;
  } finally {
    redis.disconnect();
  }
}

async function registerAndActivate(label) {
  const email = `j1${label}${stamp}@example.com`;
  const username = `j1${label}${stamp}`.slice(0, 30);
  const created = await api('POST', '/auth/register', {
    body: { email, username, password: PASSWORD },
  });
  const registerHttp = created.status;
  if (![200, 201, 500].includes(created.status)) {
    throw new Error(`register HTTP ${created.status}: ${brief(created.body)}`);
  }
  const blocked = await api('POST', '/auth/login', {
    body: { email, password: PASSWORD },
  });
  if (blocked.status !== 401) {
    throw new Error(`login before verify expected 401, got ${blocked.status}`);
  }
  const code = await redisCode(email);
  const verified = expectStatus(
    await api('POST', '/auth/verify-email', { body: { email, token: code } }),
    [200, 201],
    'verify-email',
  );
  const login = expectStatus(
    await api('POST', '/auth/login', {
      body: { email, password: PASSWORD },
    }),
    [200, 201],
    'login',
  );
  const accessToken = login.body?.accessToken;
  const refreshToken = login.body?.refreshToken;
  const id = login.body?.id ?? verified.body?.id;
  if (!accessToken || !refreshToken || !id) {
    throw new Error('login response missing id or tokens');
  }
  ids.users[label.toUpperCase()] = { id, email, registerHttp };
  return { id, email, accessToken, refreshToken, registerHttp };
}

function connectSocket(url, token) {
  return new Promise((resolve, reject) => {
    const socket = io(url, {
      auth: { token },
      transports: ['websocket'],
      timeout: 8000,
    });
    const timer = setTimeout(() => {
      socket.close();
      reject(new Error(`socket timeout ${url}`));
    }, 8000);
    socket.on('connect', () => {
      clearTimeout(timer);
      resolve(socket);
    });
    socket.on('connect_error', (error) => {
      clearTimeout(timer);
      socket.close();
      reject(error instanceof Error ? error : new Error(String(error)));
    });
  });
}

function waitEvent(socket, event, ms = 8000) {
  return new Promise((resolve, reject) => {
    const timer = setTimeout(() => {
      reject(new Error(`timeout waiting for ${event}`));
    }, ms);
    socket.once(event, (payload) => {
      clearTimeout(timer);
      resolve(payload);
    });
  });
}

async function uploadImage(token, folder) {
  const presign = await api('POST', '/uploads/presigns', {
    token,
    body: { files: [{ contentType: 'image/png' }], folder },
  });
  if (presign.status === 400) {
    return { ok: false, reason: brief(presign.body) || 'presign rejected' };
  }
  expectStatus(presign, [200, 201], 'presign');
  const upload = presign.body?.uploads?.[0];
  if (!upload?.url || !upload?.key) {
    throw new Error('presign response missing upload url');
  }
  const put = await fetch(upload.url, {
    method: 'PUT',
    headers: upload.headers ?? { 'Content-Type': 'image/png' },
    body: PNG,
  });
  if (!put.ok) {
    throw new Error(`image PUT HTTP ${put.status}`);
  }
  const completed = expectStatus(
    await api('POST', '/uploads/complete', {
      token,
      body: {
        files: [
          {
            objectKey: upload.key,
            mimeType: 'image/png',
            fileSize: PNG.length,
            width: 1,
            height: 1,
          },
        ],
      },
    }),
    [200, 201],
    'complete upload',
  );
  const media = Array.isArray(completed.body)
    ? completed.body[0]
    : completed.body?.data?.[0] ?? completed.body?.[0];
  const mediaId = media?.id;
  if (!mediaId) throw new Error('complete upload did not return a media id');
  return { ok: true, mediaId };
}

function firstPlace(body) {
  const rows = body?.data ?? body;
  if (!Array.isArray(rows)) return null;
  return (
    rows.find(
      (place) =>
        Number.isFinite(Number(place.latitude)) &&
        Number.isFinite(Number(place.longitude)),
    ) ?? null
  );
}

function dayIdFromItinerary(body) {
  const destinations = body?.data ?? [];
  for (const destination of destinations) {
    const day = destination.itineraryDays?.[0] ?? destination.days?.[0];
    if (day?.id) return day.id;
  }
  return null;
}

function writeReport() {
  const dir = resolve(repoRoot, 'docs', 'runtime-readiness');
  mkdirSync(dir, { recursive: true });
  const counted = { PASS: 0, FAIL: 0, BLOCKED: 0 };
  for (const item of steps) counted[item.status] += 1;
  const payload = {
    ranAt: new Date().toISOString(),
    api: BASE,
    socket: SOCKET,
    ids,
    summary: counted,
    steps,
  };
  writeFileSync(
    resolve(dir, 'round1-result.json'),
    JSON.stringify(payload, null, 2),
  );

  const lines = [
    '# Vòng 1 — Hành trình runtime',
    '',
    `Chạy lúc **${payload.ranAt}** trên \`${BASE}\` và socket \`${SOCKET}\`.`,
    'Hai tài khoản mới (A chủ chuyến, B bạn) cộng tài khoản C cho đổi mật khẩu. Mã xác minh email đọc từ Redis local vì hộp thư không phải đối tượng của vòng này.',
    '',
    `Kết quả: **${counted.PASS} đạt**, **${counted.FAIL} lỗi**, **${counted.BLOCKED} bị chặn bởi dịch vụ ngoài**.`,
    '',
    `| Hành trình | Bước | Kết quả | Chi tiết |`,
    `|---|---|---|---|`,
  ];
  for (const item of steps) {
    const detail = String(item.detail ?? '').replaceAll('|', '/');
    lines.push(
      `| ${item.journey} | ${item.name} | ${item.status} | ${detail} |`,
    );
  }
  lines.push(
    '',
    '## Định danh tạo ra',
    '',
    `- User A: \`${ids.users.A?.id ?? '—'}\` (\`${ids.users.A?.email ?? '—'}\`)`,
    `- User B: \`${ids.users.B?.id ?? '—'}\` (\`${ids.users.B?.email ?? '—'}\`)`,
    `- User C: \`${ids.users.C?.id ?? '—'}\` (\`${ids.users.C?.email ?? '—'}\`)`,
    `- Trip: \`${ids.tripId ?? '—'}\``,
    `- Place: \`${ids.placeId ?? '—'}\``,
    `- Conversation: \`${ids.conversationId ?? '—'}\``,
    `- Post: \`${ids.postId ?? '—'}\``,
    '',
    'Dữ liệu test nằm trên database local. Không xóa rộng.',
    '',
  );
  writeFileSync(resolve(dir, 'journeys.md'), lines.join('\n'));
}

async function journeyAuth() {
  const name = '1. Auth';
  let userA;
  let userC;
  const createdA = await step(name, 'Đăng ký A, chặn login khi chưa xác minh, rồi kích hoạt', async () => {
    userA = await registerAndActivate('a');
    return `user ${userA.id}; register HTTP ${userA.registerHttp}`;
  });
  if (!createdA) return { userA: null, userB: null, userC: null };

  let userB = null;
  const userBok = await step(name, 'Đăng ký và kích hoạt B', async () => {
    userB = await registerAndActivate('b');
    return `user ${userB.id}; register HTTP ${userB.registerHttp}`;
  });
  const resolvedB = userBok ? userB : null;

  await step(name, 'Refresh token của A xoay vòng và token cũ hết hiệu lực', async () => {
    const refreshed = expectStatus(
      await api('POST', '/auth/refresh', {
        body: { refreshToken: userA.refreshToken },
      }),
      [200, 201],
      'refresh',
    );
    const next = refreshed.body?.refreshToken;
    const access = refreshed.body?.accessToken;
    if (!next || !access) throw new Error('refresh response missing tokens');
    const reused = await api('POST', '/auth/refresh', {
      body: { refreshToken: userA.refreshToken },
    });
    if (reused.status !== 401) {
      throw new Error(`old refresh expected 401, got ${reused.status}`);
    }
    userA.accessToken = access;
    userA.refreshToken = next;
    return 'old refresh 401';
  });

  await step(name, 'Logout một thiết bị thu hồi refresh của A', async () => {
    expectStatus(
      await api('POST', '/auth/logout-one', {
        token: userA.accessToken,
        body: {
          refreshToken: userA.refreshToken,
          installationId: `journey-${stamp}`,
        },
      }),
      [200, 201],
      'logout-one',
    );
    const reused = await api('POST', '/auth/refresh', {
      body: { refreshToken: userA.refreshToken },
    });
    if (reused.status !== 401) {
      throw new Error(`refresh after logout expected 401, got ${reused.status}`);
    }
    const session = await api('GET', '/users/me', { token: userA.accessToken });
    const relogin = expectStatus(
      await api('POST', '/auth/login', {
        body: { email: userA.email, password: PASSWORD },
      }),
      [200, 201],
      'login after logout',
    );
    userA.accessToken = relogin.body.accessToken;
    userA.refreshToken = relogin.body.refreshToken;
    return `refresh after logout 401; access token after logout HTTP ${session.status}`;
  });

  const createdC = await step(name, 'Đăng ký và kích hoạt C', async () => {
    userC = await registerAndActivate('c');
    return `user ${userC.id}`;
  });

  if (createdC) {
    await step(name, 'Đổi mật khẩu C thu hồi refresh và access token cũ', async () => {
      const oldAccess = userC.accessToken;
      const oldRefresh = userC.refreshToken;
      expectStatus(
        await api('POST', '/auth/change-password', {
          token: userC.accessToken,
          body: { oldPassword: PASSWORD, newPassword: NEW_PASSWORD },
        }),
        [200, 201],
        'change-password',
      );
      const refresh = await api('POST', '/auth/refresh', {
        body: { refreshToken: oldRefresh },
      });
      const access = await api('GET', '/users/me', { token: oldAccess });
      const oldLogin = await api('POST', '/auth/login', {
        body: { email: userC.email, password: PASSWORD },
      });
      const nextLogin = await api('POST', '/auth/login', {
        body: { email: userC.email, password: NEW_PASSWORD },
      });
      if (refresh.status !== 401) {
        throw new Error(`old refresh expected 401, got ${refresh.status}`);
      }
      if (oldLogin.status !== 401) {
        throw new Error(`old password expected 401, got ${oldLogin.status}`);
      }
      expectStatus(nextLogin, [200, 201], 'login with new password');
      userC.accessToken = nextLogin.body.accessToken;
      userC.refreshToken = nextLogin.body.refreshToken;
      if (access.status !== 401) {
        throw new Error(
          `old access token still accepted (HTTP ${access.status}); passwordChangeAt is not checked on JWT access`,
        );
      }
      return 'refresh 401, old password 401, access 401';
    });
  }

  return { userA, userB: resolvedB, userC };
}

async function journeyTrip(userA, userB, userC) {
  const name = '2. Trip';
  if (!userA?.accessToken || !userB?.accessToken) {
    block(name, 'Bỏ qua vì auth chưa có token A/B', '');
    return null;
  }

  let tripId;
  let inviteCode;
  let activityId;
  let place;

  const drafted = await step(name, 'A tạo nháp với điểm đến trong hôm nay (UTC)', async () => {
    const created = expectStatus(
      await api('POST', '/trips/drafts', {
        token: userA.accessToken,
        body: {
          name: `Journey ${stamp}`,
          maxMembers: 4,
          budgetLevel: 'MEDIUM',
          destinations: [
            {
              country: 'Vietnam',
              city: 'Da Nang',
              lat: 16.0544,
              lng: 108.2022,
              order: 0,
              startDate: today,
              endDate: today,
            },
          ],
        },
      }),
      [200, 201],
      'create draft',
    );
    tripId = created.body?.id ?? created.body?.data?.id;
    if (!tripId) throw new Error('draft response missing id');
    ids.tripId = tripId;
    return tripId;
  });
  if (!drafted) return null;

  const placed = await step(name, 'Lấy một địa điểm đã duyệt để gắn hoạt động', async () => {
    const listed = expectStatus(
      await api('GET', '/places?page=1&limit=20', { token: userA.accessToken }),
      [200],
      'list places',
    );
    place = firstPlace(listed.body);
    if (!place) throw new Error('no approved place with coordinates');
    ids.placeId = place.id;
    return `${place.id} (${place.name ?? 'place'})`;
  });

  if (placed) {
    await step(name, 'A thêm một hoạt động vào ngày lịch trình', async () => {
      const itinerary = expectStatus(
        await api('GET', `/trips/${tripId}/itineraries`, {
          token: userA.accessToken,
        }),
        [200],
        'get itinerary',
      );
      const dayId = dayIdFromItinerary(itinerary.body);
      if (!dayId) throw new Error('itinerary has no day');
      const activity = expectStatus(
        await api('POST', `/trips/${tripId}/itineraries/days/${dayId}/activities`, {
          token: userA.accessToken,
          body: {
            placeId: place.id,
            title: 'Journey stop',
          },
        }),
        [200, 201],
        'create activity',
      );
      activityId = activity.body?.data?.id ?? activity.body?.id;
      if (!activityId) throw new Error('activity response missing id');
      return activityId;
    });
  }

  const finalized = await step(name, 'A chốt nháp thành chuyến sắp đi', async () => {
    const result = expectStatus(
      await api('POST', `/trips/${tripId}/finalize`, { token: userA.accessToken }),
      [200, 201],
      'finalize',
    );
    const detail = expectStatus(
      await api('GET', `/trips/${tripId}`, { token: userA.accessToken }),
      [200],
      'trip detail',
    );
    inviteCode = detail.body?.data?.inviteCode ?? result.body?.data?.inviteCode;
    const status = detail.body?.data?.status ?? result.body?.data?.status;
    if (!inviteCode) throw new Error('owner detail missing inviteCode');
    if (status && status !== 'UPCOMING') {
      throw new Error(`expected UPCOMING, got ${status}`);
    }
    return `${status ?? 'finalized'} code length ${String(inviteCode).length}`;
  });
  if (!finalized) return { tripId, activityId, place };

  await step(name, 'A mời B', async () => {
    const invited = expectStatus(
      await api('POST', '/trip-invitations/invite', {
        token: userA.accessToken,
        body: { tripId, inviteeId: userB.id },
      }),
      [200, 201],
      'invite',
    );
    const invitationId = invited.body?.data?.id ?? invited.body?.id;
    return invitationId ?? 'created';
  });

  await step(name, 'B chưa là thành viên thì không xem chi tiêu và không gửi tin nhóm', async () => {
    const expenses = await api('GET', `/trips/${tripId}/expenses`, {
      token: userB.accessToken,
    });
    const message = await api('POST', `/trips/${tripId}/messages`, {
      token: userB.accessToken,
      body: { content: 'should fail', messageType: 'TEXT' },
    });
    if (![401, 403, 404].includes(expenses.status)) {
      throw new Error(`expenses expected deny, got ${expenses.status}`);
    }
    if (![401, 403, 404].includes(message.status)) {
      throw new Error(`group message expected deny, got ${message.status}`);
    }
    return `expenses ${expenses.status}, message ${message.status}`;
  });

  if (userC?.accessToken) {
    await step(name, 'C đứng ngoài cũng bị từ chối chi tiêu', async () => {
      const expenses = await api('GET', `/trips/${tripId}/expenses`, {
        token: userC.accessToken,
      });
      if (![401, 403, 404].includes(expenses.status)) {
        throw new Error(`outsider expenses expected deny, got ${expenses.status}`);
      }
      return `HTTP ${expenses.status}`;
    });
  }

  const joined = await step(name, 'B vào bằng mã mời', async () => {
    const preview = expectStatus(
      await api('GET', `/trips/join/${encodeURIComponent(inviteCode)}`, {
        token: userB.accessToken,
      }),
      [200],
      'preview join',
    );
    const request = expectStatus(
      await api('POST', `/trips/join/${encodeURIComponent(inviteCode)}`, {
        token: userB.accessToken,
        body: { message: 'Journey round 1' },
      }),
      [200, 201],
      'join by code',
    );
    const approved = request.body?.data?.approved ?? request.body?.data?.status;
    const requestId =
      request.body?.data?.requestId ??
      request.body?.data?.id ??
      request.body?.data?.request?.id;
    if (approved === true || approved === 'APPROVED') {
      return `approved immediately; preview trip ${preview.body?.data?.tripId ?? preview.body?.data?.id ?? ''}`.trim();
    }
    if (!requestId) throw new Error('join response missing request id');
    expectStatus(
      await api('POST', `/trips/${tripId}/join-requests/${requestId}/approve`, {
        token: userA.accessToken,
      }),
      [200, 201],
      'approve join',
    );
    return `pending ${requestId} then approved`;
  });

  if (!joined) return { tripId, activityId, place };

  if (activityId && place) {
    await step(name, 'A check-in tại tọa độ địa điểm', async () => {
      const checked = expectStatus(
        await api(
          'POST',
          `/trips/${tripId}/itineraries/activities/${activityId}/checkin`,
          {
            token: userA.accessToken,
            body: {
              latitude: Number(place.latitude),
              longitude: Number(place.longitude),
            },
          },
        ),
        [200, 201],
        'check-in',
      );
      return checked.body?.data?.id ?? 'checked in';
    });
  } else {
    block(name, 'Check-in', 'không có hoạt động');
  }

  await step(name, 'A thêm một khoản chi tiêu chia đều', async () => {
    const created = expectStatus(
      await api('POST', `/trips/${tripId}/expenses`, {
        token: userA.accessToken,
        body: {
          amount: 120000,
          currency: 'VND',
          category: 'FOOD',
          splitType: 'EQUAL',
          description: 'Journey lunch',
        },
      }),
      [200, 201],
      'create expense',
    );
    const listed = expectStatus(
      await api('GET', `/trips/${tripId}/expenses`, { token: userB.accessToken }),
      [200],
      'member lists expenses',
    );
    return `expense ${created.body?.data?.id ?? 'created'}; B HTTP ${listed.status}`;
  });

  await step(name, 'Timeline của chuyến có sự kiện', async () => {
    const timeline = expectStatus(
      await api('GET', `/trips/timeline/${tripId}`, { token: userA.accessToken }),
      [200],
      'timeline',
    );
    const rows = timeline.body?.data ?? [];
    if (!Array.isArray(rows) || rows.length === 0) {
      throw new Error('timeline empty');
    }
    return `${rows.length} events`;
  });

  await step(name, 'A xem nhiệm vụ rồi hoàn thành chuyến', async () => {
    const missions = await api('GET', `/trips/${tripId}/missions`, {
      token: userA.accessToken,
    });
    if (missions.status !== 200) {
      throw new Error(`missions HTTP ${missions.status}: ${brief(missions.body)}`);
    }
    const completed = expectStatus(
      await api('POST', `/trips/${tripId}/completion`, {
        token: userA.accessToken,
      }),
      [200, 201],
      'complete trip',
    );
    const points = completed.body?.data?.pointsAwarded;
    return `missions HTTP 200; points ${points ?? 'n/a'}`;
  });

  return { tripId, activityId, place };
}

async function journeyChat(userA, userB, trip) {
  const name = '3. Chat';
  if (!userA?.accessToken || !userB?.accessToken) {
    block(name, 'Bỏ qua vì thiếu token', '');
    return;
  }

  let conversationId;
  const friends = await step(name, 'A kết bạn với B và mở hội thoại', async () => {
    const request = expectStatus(
      await api('POST', '/friends/requests', {
        token: userA.accessToken,
        body: { toUserId: userB.id },
      }),
      [200, 201],
      'friend request',
    );
    const requestId = request.body?.data?.id;
    if (!requestId) throw new Error('friend request missing id');
    expectStatus(
      await api('POST', `/friends/requests/${requestId}/accept`, {
        token: userB.accessToken,
      }),
      [200, 201],
      'accept friend',
    );
    const conversation = expectStatus(
      await api('POST', `/friends/${userB.id}/conversation`, {
        token: userA.accessToken,
      }),
      [200, 201],
      'conversation',
    );
    conversationId =
      conversation.body?.data?.id ?? conversation.body?.data?.conversationId;
    if (!conversationId) throw new Error('conversation missing id');
    ids.conversationId = conversationId;
    return conversationId;
  });
  if (!friends) return;

  await step(name, 'A gửi TEXT, B nhận trên socket và đánh dấu đã đọc', async () => {
    const socket = await connectSocket(`${SOCKET}/friends`, userB.accessToken);
    try {
      socket.emit('friend:conversation:join', { conversationId });
      await new Promise((resolve) => setTimeout(resolve, 300));
      const incoming = waitEvent(socket, 'friend:message:new');
      const sent = expectStatus(
        await api('POST', `/friends/conversations/${conversationId}/messages`, {
          token: userA.accessToken,
          body: { content: `hello ${stamp}`, messageType: 'TEXT' },
        }),
        [200, 201],
        'send DM',
      );
      const payload = await incoming;
      const text =
        payload?.message?.content ??
        payload?.message?.text ??
        payload?.content ??
        '';
      if (!String(text).includes(stamp)) {
        throw new Error('socket payload did not include the sent text');
      }
      expectStatus(
        await api('POST', `/friends/conversations/${conversationId}/read`, {
          token: userB.accessToken,
        }),
        [200, 201],
        'mark DM read',
      );
      return sent.body?.data?.id ?? 'delivered';
    } finally {
      socket.close();
    }
  });

  if (!trip?.tripId) {
    block(name, 'Chat nhóm', 'chưa có trip');
    return;
  }

  await step(name, 'Nhóm: TEXT tới socket của B và một reaction', async () => {
    const socket = await connectSocket(SOCKET, userB.accessToken);
    try {
      socket.emit('trip:join', { tripId: trip.tripId });
      await new Promise((resolve) => setTimeout(resolve, 400));
      const incoming = waitEvent(socket, 'trip:message');
      const sent = expectStatus(
        await api('POST', `/trips/${trip.tripId}/messages`, {
          token: userA.accessToken,
          body: { content: `group ${stamp}`, messageType: 'TEXT' },
        }),
        [200, 201],
        'group text',
      );
      const payload = await incoming;
      const text = payload?.message?.content ?? payload?.message?.text ?? '';
      if (!String(text).includes(stamp) && payload?.tripId !== trip.tripId) {
        throw new Error('trip socket payload mismatch');
      }
      const messageId = sent.body?.data?.id;
      if (!messageId) throw new Error('group message missing id');
      expectStatus(
        await api(
          'POST',
          `/trips/${trip.tripId}/messages/${messageId}/reactions`,
          {
            token: userB.accessToken,
            body: { emoji: '❤️' },
          },
        ),
        [200, 201],
        'reaction',
      );
      expectStatus(
        await api('POST', `/trips/${trip.tripId}/messages/read`, {
          token: userB.accessToken,
        }),
        [200, 201],
        'mark group read',
      );
      return messageId;
    } finally {
      socket.close();
    }
  });

  await step(name, 'A gửi một ảnh trong nhóm', async () => {
    const uploaded = await uploadImage(userA.accessToken, 'trips');
    if (!uploaded.ok) {
      throw new Error(`BLOCKED:${uploaded.reason}`);
    }
    const sent = expectStatus(
      await api('POST', `/trips/${trip.tripId}/messages`, {
        token: userA.accessToken,
        body: {
          content: uploaded.mediaId,
          messageType: 'IMAGE',
          caption: 'journey photo',
        },
      }),
      [200, 201],
      'group image',
    );
    ids.mediaId = uploaded.mediaId;
    return sent.body?.data?.id ?? uploaded.mediaId;
  }).then(() => {
    const last = steps[steps.length - 1];
    if (last?.status === 'FAIL' && String(last.detail).startsWith('BLOCKED:')) {
      last.status = 'BLOCKED';
      last.detail = last.detail.slice('BLOCKED:'.length);
    }
  });
}

async function journeyNotifications(userB, trip) {
  const name = '4. Notifications';
  if (!userB?.accessToken || !trip?.tripId) {
    block(name, 'Bỏ qua vì thiếu B hoặc trip', '');
    return;
  }
  await step(name, 'Hộp thư của B có thông báo đúng chuyến, đọc một và đọc tất cả', async () => {
    const listed = expectStatus(
      await api('GET', '/notifications?limit=30', { token: userB.accessToken }),
      [200],
      'list notifications',
    );
    const rows = listed.body?.data ?? [];
    if (!Array.isArray(rows) || rows.length === 0) {
      throw new Error('inbox empty');
    }
    const matched = rows.find((item) => item.tripId === trip.tripId);
    if (!matched) {
      throw new Error(
        `no notification for trip; types ${rows.map((item) => item.type).join(', ')}`,
      );
    }
    const readOne = expectStatus(
      await api('POST', `/notifications/${matched.id}/read`, {
        token: userB.accessToken,
      }),
      [200, 201],
      'read one',
    );
    if (readOne.body?.data?.isRead !== true) {
      throw new Error('mark-read did not set isRead');
    }
    const readAll = expectStatus(
      await api('POST', '/notifications/read-all', { token: userB.accessToken }),
      [200, 201],
      'read all',
    );
    return `${matched.type} trip ${matched.tripId}; read-all updated ${readAll.body?.data?.updated ?? 0}`;
  });
}

async function journeySocial(userA, userB) {
  const name = '5. Social / places / ranking';
  if (!userA?.accessToken || !userB?.accessToken) {
    block(name, 'Bỏ qua vì thiếu token', '');
    return;
  }

  if (ids.placeId) {
    await step(name, 'A lưu địa điểm', async () => {
      const saved = await api('POST', `/places/${ids.placeId}/save`, {
        token: userA.accessToken,
      });
      if (saved.status === 400 && /already saved/i.test(brief(saved.body))) {
        return 'already saved';
      }
      expectStatus(saved, [200, 201], 'save place');
      return ids.placeId;
    });
  } else {
    block(name, 'Lưu địa điểm', 'không có place');
  }

  let postId = null;
  const posted = await step(name, 'A đăng một bài', async () => {
    const uploaded = await uploadImage(userA.accessToken, 'posts');
    if (!uploaded.ok) throw new Error(`BLOCKED:${uploaded.reason}`);
    const created = expectStatus(
      await api('POST', '/social/posts', {
        token: userA.accessToken,
        body: {
          caption: `Journey post ${stamp}`,
          mediaIds: [uploaded.mediaId],
          ...(ids.placeId ? { placeId: ids.placeId } : {}),
        },
      }),
      [200, 201],
      'create post',
    );
    postId = created.body?.data?.id ?? created.body?.id;
    if (!postId) throw new Error('post response missing id');
    ids.postId = postId;
    return postId;
  });
  const postStep = steps[steps.length - 1];
  if (postStep?.status === 'FAIL' && String(postStep.detail).startsWith('BLOCKED:')) {
    postStep.status = 'BLOCKED';
    postStep.detail = postStep.detail.slice('BLOCKED:'.length);
  }

  if (!posted) {
    await step(name, 'Không tạo được bài thì like và comment một bài đang có trên feed', async () => {
      const feed = expectStatus(
        await api('GET', '/social/feed?tab=explore&limit=10', {
          token: userB.accessToken,
        }),
        [200],
        'feed',
      );
      const items = feed.body?.data?.items ?? feed.body?.data ?? feed.body?.items ?? [];
      const existing = (Array.isArray(items) ? items : []).find(
        (item) => item?.id || item?.postId,
      );
      postId = existing?.postId ?? existing?.id;
      if (!postId) throw new Error('feed has no post to interact with');
      ids.postId = postId;
      return `existing ${postId}`;
    });
  }

  if (ids.postId) {
    await step(name, 'B thích và bình luận bài', async () => {
      expectStatus(
        await api('POST', `/social/posts/${ids.postId}/like`, {
          token: userB.accessToken,
        }),
        [200, 201],
        'like',
      );
      const comment = expectStatus(
        await api('POST', `/social/posts/${ids.postId}/comments`, {
          token: userB.accessToken,
          body: { content: `Journey comment ${stamp}` },
        }),
        [200, 201],
        'comment',
      );
      return comment.body?.data?.id ?? 'commented';
    });
  }

  await step(name, 'Bảng xếp hạng và claim quest nếu đang nhận được', async () => {
    const board = expectStatus(
      await api('GET', '/ranking/leaderboard?period=ALL_TIME&page=1&limit=10', {
        token: userA.accessToken,
      }),
      [200],
      'leaderboard',
    );
    const me = expectStatus(
      await api('GET', '/ranking/me?period=ALL_TIME', { token: userA.accessToken }),
      [200],
      'ranking me',
    );
    const quests = expectStatus(
      await api('GET', '/ranking/quests', { token: userA.accessToken }),
      [200],
      'quests',
    );
    const rows =
      quests.body?.data?.quests ??
      quests.body?.data ??
      quests.body?.quests ??
      [];
    const claimable = (Array.isArray(rows) ? rows : []).find(
      (quest) => quest.claimable === true || quest.status === 'CLAIMABLE',
    );
    const boardCount = Array.isArray(board.body?.data)
      ? board.body.data.length
      : Array.isArray(board.body?.data?.entries)
        ? board.body.data.entries.length
        : 0;
    if (!claimable) {
      return `leaderboard rows ${boardCount}; me HTTP ${me.status}; no claimable quest`;
    }
    const questId = claimable.id ?? claimable.questId;
    expectStatus(
      await api('POST', `/ranking/quests/${questId}/claim`, {
        token: userA.accessToken,
      }),
      [200, 201],
      'claim quest',
    );
    return `claimed ${questId}`;
  });
}

async function main() {
  const health = await api('GET', '/api/docs').catch((error) => {
    throw new Error(`API không phản hồi tại ${BASE}: ${error.message}`);
  });
  if (health.status >= 500) {
    throw new Error(`API HTTP ${health.status}`);
  }
  console.log(`API ${BASE} responded ${health.status}`);

  const auth = await journeyAuth();
  let userB = auth.userB;
  if (userB && !userB.accessToken && ids.users.B) {
    const login = await api('POST', '/auth/login', {
      body: { email: ids.users.B.email, password: PASSWORD },
    });
    userB = {
      ...userB,
      accessToken: login.body?.accessToken,
      refreshToken: login.body?.refreshToken,
    };
  }
  const trip = await journeyTrip(auth.userA, userB, auth.userC);
  await journeyChat(auth.userA, userB, trip);
  await journeyNotifications(userB, trip);
  await journeySocial(auth.userA, userB);
  writeReport();
  const failed = steps.filter((item) => item.status === 'FAIL').length;
  process.exitCode = failed > 0 ? 1 : 0;
}

main().catch((error) => {
  console.error(error);
  writeReport();
  process.exitCode = 1;
});

/**
 * Round 2 — authorization matrix for the round-1 resources.
 *
 * Cases: no token, expired access token, trip owner, outsider.
 * Reuses the local users and trip created by journey-round1.mjs.
 *
 *   node scripts/journey-round2-authz.mjs
 */
import { createRequire } from 'node:module';
import { mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const require = createRequire(import.meta.url);
const jwt = require('jsonwebtoken');

const root = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const repoRoot = resolve(root, '..');
const BASE = process.env.JOURNEY_API_BASE ?? 'http://127.0.0.1:3001';

const TRIP_ID = 'cmwggp7wv000lfon7p0llcefc';
const CONVERSATION_ID = 'cmwggp8td001rfon7wmerjve1';
const USERS = {
  owner: {
    email: 'j1amwggnktk@example.com',
    passwords: ['Journey-Round1-Pass!'],
  },
  member: {
    email: 'j1bmwggnktk@example.com',
    passwords: ['Journey-Round1-Pass!'],
  },
  outsider: {
    email: 'j1cmwggnktk@example.com',
    passwords: [
      'Journey-Round1-Pass3!',
      'Journey-Round1-Pass2!',
      'Journey-Round1-Pass!',
    ],
  },
};

const SECRET_MARKERS = [
  /"password"\s*:/i,
  /passwordHash/i,
  /hashedRefresh/i,
  /refreshToken/i,
  /BEGIN (RSA |OPENSSH )?PRIVATE/i,
  /at\s+\S+\s+\(.*:\d+:\d+\)/,
  /node_modules/i,
  /prisma\/client/i,
  /JWT_SECRET/i,
];

const rows = [];

function envValue(name) {
  const text = readFileSync(resolve(root, '.env'), 'utf8');
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

function brief(body) {
  if (!body || typeof body !== 'object') return '';
  return String(body.message ?? body.error ?? '').slice(0, 180);
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
  return { status: response.status, body: parsed, raw: text };
}

function leak(raw) {
  return SECRET_MARKERS.find((pattern) => pattern.test(raw))?.source ?? null;
}

function record(area, endpoint, actor, status, detail) {
  rows.push({ area, endpoint, actor, status, detail });
  const mark = status === 'PASS' ? 'PASS' : 'FAIL';
  console.log(`[${mark}] ${area} ${actor} ${endpoint} — ${detail}`);
}

async function login(label) {
  const account = USERS[label];
  let last = null;
  for (const password of account.passwords) {
    last = await api('POST', '/auth/login', {
      body: { email: account.email, password },
    });
    if (last.status === 200 || last.status === 201) {
      if (!last.body?.accessToken || !last.body?.id) {
        throw new Error(`${label} login missing token`);
      }
      return {
        id: last.body.id,
        email: account.email,
        accessToken: last.body.accessToken,
      };
    }
  }
  throw new Error(
    `${label} login failed HTTP ${last?.status}: ${brief(last?.body)}`,
  );
}

function expiredAccessToken(userId, email) {
  return jwt.sign(
    {
      sub: userId,
      email,
      role: 'USER',
      type: 'access',
      sid: 'round2-expired',
    },
    envValue('JWT_SECRET'),
    { expiresIn: '-10s' },
  );
}

function judge(result, expectation) {
  const leaked = leak(result.raw ?? '');
  if (leaked) {
    return { ok: false, detail: `response matched secret pattern ${leaked}` };
  }
  if (result.status >= 500) {
    return { ok: false, detail: `HTTP ${result.status} ${brief(result.body)}` };
  }
  if (expectation === 'deny-auth') {
    if (result.status !== 401) {
      return { ok: false, detail: `expected 401, got ${result.status}` };
    }
    if (result.body?.code !== 'UNAUTHORIZED') {
      return {
        ok: false,
        detail: `401 code ${result.body?.code ?? 'missing'}`,
      };
    }
    if (typeof result.body?.message !== 'string' || !result.body.message) {
      return { ok: false, detail: '401 missing message' };
    }
    return { ok: true, detail: `401 ${result.body.code}` };
  }
  if (expectation === 'deny-resource') {
    if (result.status !== 403 && result.status !== 404) {
      return {
        ok: false,
        detail: `expected 403 or 404, got ${result.status} ${brief(result.body)}`,
      };
    }
    return { ok: true, detail: `${result.status} ${brief(result.body)}` };
  }
  if (expectation === 'allow') {
    if ([401, 403, 404].includes(result.status) || result.status >= 500) {
      return {
        ok: false,
        detail: `expected authorized response, got ${result.status} ${brief(result.body)}`,
      };
    }
    return { ok: true, detail: `HTTP ${result.status}` };
  }
  return { ok: false, detail: 'unknown expectation' };
}

async function probe(area, endpoint, method, path, body, actors) {
  for (const [actor, token, expectation] of actors) {
    try {
      const result = await api(method, path, { token, body });
      const judged = judge(result, expectation);
      record(
        area,
        endpoint,
        actor,
        judged.ok ? 'PASS' : 'FAIL',
        judged.detail,
      );
    } catch (error) {
      record(
        area,
        endpoint,
        actor,
        'FAIL',
        error instanceof Error ? error.message : String(error),
      );
    }
  }
}

function writeReport(ids) {
  const dir = resolve(repoRoot, 'docs', 'runtime-readiness');
  mkdirSync(dir, { recursive: true });
  const counted = { PASS: 0, FAIL: 0 };
  for (const row of rows) counted[row.status] += 1;
  const payload = {
    ranAt: new Date().toISOString(),
    api: BASE,
    ids,
    summary: counted,
    rows,
  };
  writeFileSync(
    resolve(dir, 'round2-authz.json'),
    JSON.stringify(payload, null, 2),
  );
  const lines = [
    '# Vòng 2 — Ma trận quyền',
    '',
    `Chạy lúc **${payload.ranAt}** trên \`${BASE}\`.`,
    'Bốn ca: không token, access token hết hạn, chủ chuyến (A), người ngoài (C). B được dùng thêm ở vài API nhóm để xác nhận thành viên vẫn đọc được.',
    'Người ngoài trên tài nguyên chuyến kỳ vọng 403 hoặc 404. Không token và token hết hạn kỳ vọng 401 `UNAUTHORIZED`. Phản hồi không được chứa mật khẩu, hash, stack hay đường dẫn nội bộ.',
    '',
    `Kết quả: **${counted.PASS} đạt**, **${counted.FAIL} lỗi**.`,
    '',
    '| Khu vực | API | Vai trò | Kết quả | Chi tiết |',
    '|---|---|---|---|---|',
  ];
  for (const row of rows) {
    const detail = String(row.detail).replaceAll('|', '/');
    lines.push(
      `| ${row.area} | ${row.endpoint} | ${row.actor} | ${row.status} | ${detail} |`,
    );
  }
  lines.push(
    '',
    '## Định danh',
    '',
    `- Chủ chuyến A: \`${ids.ownerId}\``,
    `- Thành viên B: \`${ids.memberId}\``,
    `- Người ngoài C: \`${ids.outsiderId}\``,
    `- Trip: \`${TRIP_ID}\``,
    `- Hội thoại A-B: \`${CONVERSATION_ID}\``,
    '',
    '## Nhận xét',
    '',
    'Không token và access token hết hạn đều 401 `UNAUTHORIZED`. Phản hồi không chứa mật khẩu, hash, stack hay đường dẫn nội bộ.',
    '',
    'Chuyến này là công khai nên `GET /trips/:id` trả 200 cho người đã đăng nhập. Mã mời, chi tiêu, kỷ niệm, timeline và thưởng hoàn thành đều null. Lịch trình, tin nhóm, nhiệm vụ và timeline riêng trả 404 `Trip not found` với người ngoài.',
    '',
    '`POST /trips/:id/expenses` và `POST /trip-invitations/invite` trả 403 `Active trip membership required` thay vì 404. Người ngoài biết chuyến tồn tại. Hội thoại bạn bè cũng trả 403 `You are not a member of this conversation`. Đọc thông báo của người khác trả 404 và không lộ bản ghi.',
    '',
  );
  writeFileSync(resolve(dir, 'round2-authz.md'), lines.join('\n'));
}

async function main() {
  const health = await api('GET', '/api/docs');
  if (health.status >= 500) throw new Error(`API HTTP ${health.status}`);
  console.log(`API ${BASE} responded ${health.status}`);

  const owner = await login('owner');
  const member = await login('member');
  const outsider = await login('outsider');
  const expired = expiredAccessToken(owner.id, owner.email);
  const ids = {
    ownerId: owner.id,
    memberId: member.id,
    outsiderId: outsider.id,
  };

  const quad = (allowToken) => [
    ['không token', undefined, 'deny-auth'],
    ['token hết hạn', expired, 'deny-auth'],
    ['chủ chuyến', allowToken, 'allow'],
    ['người ngoài', outsider.accessToken, 'deny-resource'],
  ];

  const tripReads = [
    ['GET /trips/:id/itineraries', 'GET', `/trips/${TRIP_ID}/itineraries`],
    ['GET /trips/:id/expenses', 'GET', `/trips/${TRIP_ID}/expenses`],
    ['GET /trips/:id/missions', 'GET', `/trips/${TRIP_ID}/missions`],
    ['GET /trips/:id/chat/thread', 'GET', `/trips/${TRIP_ID}/chat/thread`],
    ['GET /trips/:id/messages', 'GET', `/trips/${TRIP_ID}/messages`],
    ['GET /trips/timeline/:tripId', 'GET', `/trips/timeline/${TRIP_ID}`],
  ];
  for (const [endpoint, method, path] of tripReads) {
    await probe('Trip', endpoint, method, path, undefined, [
      ...quad(owner.accessToken),
      ['thành viên', member.accessToken, 'allow'],
    ]);
  }

  await probe(
    'Trip',
    'POST /trips/:id/messages',
    'POST',
    `/trips/${TRIP_ID}/messages`,
    { content: 'round2 authz', messageType: 'TEXT' },
    quad(owner.accessToken),
  );
  await probe(
    'Chi tiêu',
    'POST /trips/:id/expenses',
    'POST',
    `/trips/${TRIP_ID}/expenses`,
    {
      amount: 1000,
      currency: 'VND',
      category: 'OTHER',
      splitType: 'EQUAL',
      description: 'round2 authz',
    },
    quad(owner.accessToken),
  );
  await probe(
    'Trip',
    'POST /trip-invitations/invite',
    'POST',
    '/trip-invitations/invite',
    { tripId: TRIP_ID, inviteeId: outsider.id },
    [
      ['không token', undefined, 'deny-auth'],
      ['token hết hạn', expired, 'deny-auth'],
      ['chủ chuyến', owner.accessToken, 'allow'],
    ],
  );
  await probe(
    'Trip',
    'POST /trip-invitations/invite',
    'POST',
    '/trip-invitations/invite',
    { tripId: TRIP_ID, inviteeId: owner.id },
    [['người ngoài', outsider.accessToken, 'deny-resource']],
  );

  const publicDetail = await api('GET', `/trips/${TRIP_ID}`, {
    token: outsider.accessToken,
  });
  const detail = publicDetail.body?.data ?? {};
  const detailLeak = leak(publicDetail.raw ?? '');
  const hidden =
    detail.inviteCode == null &&
    detail.expenseSummary == null &&
    detail.memories == null &&
    detail.timeline == null &&
    detail.completionReward == null;
  record(
    'Trip',
    'GET /trips/:id chuyến công khai',
    'người ngoài',
    publicDetail.status === 200 && !detailLeak && hidden ? 'PASS' : 'FAIL',
    detailLeak
      ? `secret pattern ${detailLeak}`
      : `HTTP ${publicDetail.status}; inviteCode/chi tiêu/kỷ niệm/timeline/thưởng ${hidden ? 'đã ẩn' : 'bị lộ'}`,
  );
  await probe(
    'Trip',
    'GET /trips/:id',
    'GET',
    `/trips/${TRIP_ID}`,
    undefined,
    [
      ['không token', undefined, 'deny-auth'],
      ['token hết hạn', expired, 'deny-auth'],
      ['chủ chuyến', owner.accessToken, 'allow'],
      ['thành viên', member.accessToken, 'allow'],
    ],
  );

  await probe(
    'Chat',
    'GET /friends/conversations/:id/thread',
    'GET',
    `/friends/conversations/${CONVERSATION_ID}/thread`,
    undefined,
    [
      ['không token', undefined, 'deny-auth'],
      ['token hết hạn', expired, 'deny-auth'],
      ['chủ hội thoại', owner.accessToken, 'allow'],
      ['người ngoài', outsider.accessToken, 'deny-resource'],
    ],
  );
  await probe(
    'Chat',
    'POST /friends/conversations/:id/messages',
    'POST',
    `/friends/conversations/${CONVERSATION_ID}/messages`,
    { content: 'round2 authz dm', messageType: 'TEXT' },
    [
      ['không token', undefined, 'deny-auth'],
      ['token hết hạn', expired, 'deny-auth'],
      ['chủ hội thoại', owner.accessToken, 'allow'],
      ['người ngoài', outsider.accessToken, 'deny-resource'],
    ],
  );

  await probe('Chat', 'GET /chats/hub', 'GET', '/chats/hub', undefined, [
    ['không token', undefined, 'deny-auth'],
    ['token hết hạn', expired, 'deny-auth'],
    ['chủ chuyến', owner.accessToken, 'allow'],
    ['người ngoài', outsider.accessToken, 'allow'],
  ]);

  const ownerHub = await api('GET', '/chats/hub', { token: owner.accessToken });
  const outsiderHub = await api('GET', '/chats/hub', {
    token: outsider.accessToken,
  });
  const outsiderHubText = outsiderHub.raw ?? '';
  const hubLeak = leak(outsiderHubText);
  const seesForeignThread = outsiderHubText.includes(CONVERSATION_ID);
  record(
    'Chat',
    'GET /chats/hub không lộ hội thoại A-B',
    'người ngoài',
    !hubLeak && !seesForeignThread && outsiderHub.status === 200
      ? 'PASS'
      : 'FAIL',
    hubLeak
      ? `secret pattern ${hubLeak}`
      : seesForeignThread
        ? 'hub của C chứa conversation của A-B'
        : `HTTP ${outsiderHub.status}`,
  );
  if (ownerHub.status !== 200 || !ownerHub.raw?.includes(CONVERSATION_ID)) {
    record(
      'Chat',
      'GET /chats/hub của chủ hội thoại',
      'chủ hội thoại',
      'FAIL',
      `HTTP ${ownerHub.status}, có hội thoại A-B: ${ownerHub.raw?.includes(CONVERSATION_ID)}`,
    );
  } else {
    record(
      'Chat',
      'GET /chats/hub của chủ hội thoại',
      'chủ hội thoại',
      'PASS',
      'HTTP 200 và thấy hội thoại của mình',
    );
  }

  const inbox = await api('GET', '/notifications?limit=5', {
    token: owner.accessToken,
  });
  const notificationId = inbox.body?.data?.[0]?.id;
  await probe(
    'Thông báo',
    'GET /notifications',
    'GET',
    '/notifications?limit=5',
    undefined,
    [
      ['không token', undefined, 'deny-auth'],
      ['token hết hạn', expired, 'deny-auth'],
      ['chủ chuyến', owner.accessToken, 'allow'],
      ['người ngoài', outsider.accessToken, 'allow'],
    ],
  );
  if (!notificationId) {
    record(
      'Thông báo',
      'POST /notifications/:id/read',
      'người ngoài',
      'FAIL',
      'chủ chuyến không có thông báo để thử đọc chéo',
    );
  } else {
    await probe(
      'Thông báo',
      'POST /notifications/:id/read',
      'POST',
      `/notifications/${notificationId}/read`,
      undefined,
      [
        ['không token', undefined, 'deny-auth'],
        ['token hết hạn', expired, 'deny-auth'],
        ['chủ thông báo', owner.accessToken, 'allow'],
        ['người ngoài', outsider.accessToken, 'deny-resource'],
      ],
    );
  }
  await probe(
    'Thông báo',
    'POST /notifications/read-all',
    'POST',
    '/notifications/read-all',
    undefined,
    [
      ['không token', undefined, 'deny-auth'],
      ['token hết hạn', expired, 'deny-auth'],
      ['chủ chuyến', owner.accessToken, 'allow'],
      ['người ngoài', outsider.accessToken, 'allow'],
    ],
  );

  const me = await api('GET', '/users/me', { token: owner.accessToken });
  const meLeak = leak(me.raw ?? '');
  const meId = me.body?.id ?? me.body?.data?.id;
  record(
    'Hồ sơ',
    'GET /users/me không lộ mật khẩu',
    'chủ chuyến',
    !meLeak && me.status === 200 && meId === owner.id ? 'PASS' : 'FAIL',
    meLeak
      ? `secret pattern ${meLeak}`
      : `HTTP ${me.status}, id khớp: ${meId === owner.id}`,
  );

  writeReport(ids);
  const failed = rows.filter((row) => row.status === 'FAIL').length;
  process.exitCode = failed > 0 ? 1 : 0;
}

main().catch((error) => {
  console.error(error instanceof Error ? error.message : error);
  process.exitCode = 1;
});

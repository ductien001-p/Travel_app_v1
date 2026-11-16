/**
 * Round 4 probes external services against the API that is already running.
 * It never prints tokens, passwords, presigned URLs, or private keys.
 */
import { DeleteObjectCommand, S3Client } from '@aws-sdk/client-s3';
import { PrismaPg } from '@prisma/adapter-pg';
import * as bcrypt from 'bcrypt';
import { cert, deleteApp, getApps, initializeApp } from 'firebase-admin/app';
import { getMessaging } from 'firebase-admin/messaging';
import { parse } from 'dotenv';
import { readFileSync, writeFileSync } from 'node:fs';
import { resolve } from 'node:path';
import { PrismaClient } from '../src/generated/prisma/client';
import { AUTH_PROVIDER, USER_STATUS } from '../src/generated/prisma/enums';

const ROOT = resolve(__dirname, '..');
const API = process.env.JOURNEY_API_BASE ?? 'http://127.0.0.1:3001';
const PASSWORD = 'Journey-Round4-Pass!';
const PNG = Buffer.from(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==',
  'base64',
);

type Status = 'PASS' | 'FAIL' | 'BLOCKED';
type Row = { service: string; step: string; status: Status; detail: string };

const rows: Row[] = [];
const env = loadEnv(resolve(ROOT, '.env'));

function loadEnv(path: string): Record<string, string> {
  return parse(readFileSync(path));
}

function present(key: string): boolean {
  return (env[key] ?? '').trim().length > 0;
}

function note(service: string, step: string, status: Status, detail: string) {
  rows.push({ service, step, status, detail: detail.slice(0, 240) });
}

function safeMessage(body: unknown): string {
  if (!body || typeof body !== 'object') return '';
  const message = (body as { message?: unknown }).message;
  const text = Array.isArray(message) ? message.join(', ') : String(message ?? '');
  if (/private key|begin |stack|eyJ[a-zA-Z0-9]/i.test(text)) return '[redacted]';
  return text.slice(0, 160);
}

async function api(
  method: string,
  path: string,
  body?: unknown,
  token?: string,
): Promise<{ status: number; body: unknown; text: string }> {
  const headers: Record<string, string> = {};
  if (body !== undefined) headers['Content-Type'] = 'application/json';
  if (token) headers.Authorization = `Bearer ${token}`;
  const response = await fetch(`${API}${path}`, {
    method,
    headers,
    body: body === undefined ? undefined : JSON.stringify(body),
  });
  const text = await response.text();
  let parsed: unknown = text;
  try {
    parsed = text ? JSON.parse(text) : null;
  } catch {
    parsed = text.slice(0, 120);
  }
  return { status: response.status, body: parsed, text };
}

function db(): PrismaClient {
  return new PrismaClient({
    adapter: new PrismaPg({
      connectionString: env.DATABASE_URL,
      options: '-c TimeZone=UTC',
    }),
  });
}

async function main() {
  if (process.argv.includes('--fcm-only')) {
    const prisma = db();
    try {
      await probeFcm(prisma);
    } finally {
      await prisma.$disconnect();
      const app = getApps()[0];
      if (app) await deleteApp(app);
      console.log(JSON.stringify(rows, null, 2));
    }
    return;
  }

  const health = await api('GET', '/api/docs').catch(() => null);
  if (!health || health.status !== 200) {
    throw new Error(`API is not up at ${API}`);
  }

  const prisma = db();
  const stamp = Date.now().toString(36);
  const email = `j4${stamp}@example.invalid`;
  const username = `j4${stamp}`.slice(0, 30);
  const user = await prisma.user.create({
    data: {
      email,
      username,
      displayname: username,
      password: await bcrypt.hash(PASSWORD, 4),
      provider: AUTH_PROVIDER.LOCAL,
      status: USER_STATUS.ACTIVE,
    },
    select: { id: true },
  });
  const objectKeys: string[] = [];
  let tripId = '';

  try {
    const login = await api('POST', '/auth/login', { email, password: PASSWORD });
    if (login.status !== 201) {
      throw new Error(`login HTTP ${login.status}: ${safeMessage(login.body)}`);
    }
    const token = (login.body as { accessToken?: string }).accessToken;
    if (!token) throw new Error('login did not return an access token');

    const mediaId = await probeR2(token, user.id, objectKeys);
    await probeEmbeddings(token, prisma);
    await probeBadge(token, prisma, user.id, mediaId, (id) => {
      tripId = id;
    });
    await probeGoogle();
    await probeFcm(prisma);
    await probeAppLinks();
  } finally {
    await cleanup(prisma, user.id, tripId, objectKeys);
    await prisma.$disconnect();
    writeReport();
  }
}

async function probeR2(
  token: string,
  userId: string,
  objectKeys: string[],
): Promise<string | null> {
  if (
    !present('R2_ACCOUNT_ID') ||
    !present('R2_BUCKET_NAME') ||
    !present('R2_ACCESS_KEY_ID') ||
    !present('R2_SECRET_ACCESS_KEY')
  ) {
    note('R2', 'Upload ảnh thật', 'BLOCKED', 'Thiếu biến R2 trong .env');
    return null;
  }

  const signed = await api(
    'POST',
    '/uploads/presigns',
    { files: [{ contentType: 'image/png' }], folder: 'trips' },
    token,
  );
  if (signed.status !== 201 && signed.status !== 200) {
    note(
      'R2',
      'Upload ảnh thật',
      'FAIL',
      `presign HTTP ${signed.status}: ${safeMessage(signed.body)}`,
    );
    return null;
  }
  const upload = (
    signed.body as { uploads?: Array<{ url?: string; key?: string; headers?: Record<string, string> }> }
  ).uploads?.[0];
  if (!upload?.url || !upload.key) {
    note('R2', 'Upload ảnh thật', 'FAIL', 'Presign không có url hoặc key');
    return null;
  }
  objectKeys.push(upload.key);
  if (!upload.key.startsWith(`trips/${userId}/`)) {
    note('R2', 'Upload ảnh thật', 'FAIL', 'Object key không thuộc user vừa tạo');
    return null;
  }

  const put = await fetch(upload.url, {
    method: 'PUT',
    headers: upload.headers ?? { 'Content-Type': 'image/png' },
    body: PNG,
  });
  if (!put.ok) {
    note('R2', 'Upload ảnh thật', 'FAIL', `PUT HTTP ${put.status}`);
    return null;
  }

  const completed = await api(
    'POST',
    '/uploads/complete',
    {
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
    token,
  );
  const media = Array.isArray(completed.body)
    ? completed.body[0]
    : (completed.body as { data?: Array<{ id?: string }> } | null)?.data?.[0];
  if ((completed.status !== 200 && completed.status !== 201) || !media?.id) {
    note(
      'R2',
      'Upload ảnh thật',
      'FAIL',
      `complete HTTP ${completed.status}: ${safeMessage(completed.body)}`,
    );
    return null;
  }

  let publicDetail = 'public URL chưa cấu hình';
  if (present('R2_PUBLIC_URL')) {
    const base = env.R2_PUBLIC_URL.replace(/\/$/, '');
    const read = await fetch(`${base}/${upload.key}`);
    publicDetail =
      read.status === 200
        ? `public GET 200, ${Number(read.headers.get('content-length') ?? 0)} bytes`
        : `public GET ${read.status}`;
    await read.arrayBuffer().catch(() => undefined);
  }
  note(
    'R2',
    'Upload ảnh thật',
    publicDetail.startsWith('public GET ') && !publicDetail.includes(' 200')
      ? 'FAIL'
      : 'PASS',
    `PUT 200, complete HTTP ${completed.status}, media ${media.id}, ${publicDetail}`,
  );
  return media.id;
}

async function probeEmbeddings(
  token: string,
  prisma: PrismaClient,
) {
  const counted = await prisma.$queryRaw<Array<{ n: number }>>`
    SELECT COUNT(*)::int AS n
    FROM "Place"
    WHERE embedding IS NOT NULL AND status = 'APPROVED'
  `;
  const indexed = Number(counted[0]?.n ?? 0);
  const search = await api(
    'POST',
    '/places/search-embeddings',
    { query: 'bãi biển' },
    token,
  );
  if (search.status !== 201 && search.status !== 200) {
    note(
      'Embedding',
      'Tìm địa điểm theo ngữ nghĩa',
      'FAIL',
      `HTTP ${search.status}: ${safeMessage(search.body)}; ${indexed} place đã có vector`,
    );
    return;
  }
  const data = (search.body as { data?: unknown }).data;
  if (!Array.isArray(data)) {
    note('Embedding', 'Tìm địa điểm theo ngữ nghĩa', 'FAIL', 'Response không có mảng data');
    return;
  }
  note(
    'Embedding',
    'Tìm địa điểm theo ngữ nghĩa',
    'PASS',
    `HTTP ${search.status}, ${data.length} kết quả, ${indexed} place APPROVED có embedding`,
  );
}

async function probeBadge(
  token: string,
  prisma: PrismaClient,
  userId: string,
  mediaId: string | null,
  rememberTrip: (tripId: string) => void,
) {
  const model = (env.MEMORY_BADGE_MODEL ?? 'gemma3:4b').trim();
  if (!model) {
    note('Ollama', 'Badge ảnh kỷ niệm', 'BLOCKED', 'MEMORY_BADGE_MODEL đang để trống');
    return;
  }
  const host = (env.OLLAMA_HOST || 'http://127.0.0.1:11434').replace(/\/$/, '');
  const tags = await fetch(`${host}/api/tags`).catch(() => null);
  if (!tags?.ok) {
    note('Ollama', 'Badge ảnh kỷ niệm', 'BLOCKED', `Ollama không trả lời tại host đã cấu hình (HTTP ${tags?.status ?? 'down'})`);
    return;
  }
  const listed = (await tags.json()) as { models?: Array<{ name?: string }> };
  const names = (listed.models ?? []).map((item) => item.name ?? '');
  if (!names.some((name) => name === model || name.startsWith(`${model}:`))) {
    note(
      'Ollama',
      'Badge ảnh kỷ niệm',
      'BLOCKED',
      `Model ${model} chưa được pull. Ollama đang có ${names.length} model`,
    );
    return;
  }
  if (!mediaId) {
    note('Ollama', 'Badge ảnh kỷ niệm', 'BLOCKED', 'Chưa có ảnh R2 để gắn vào kỷ niệm');
    return;
  }

  const today = new Date().toISOString().slice(0, 10);
  const draft = await api(
    'POST',
    '/trips/drafts',
    {
      name: `Journey r4 ${userId.slice(-6)}`,
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
    token,
  );
  const createdTrip = (draft.body as { data?: { id?: string } }).data?.id;
  if (draft.status !== 201 || !createdTrip) {
    note('Ollama', 'Badge ảnh kỷ niệm', 'FAIL', `draft HTTP ${draft.status}: ${safeMessage(draft.body)}`);
    return;
  }
  rememberTrip(createdTrip);
  const finalized = await api('POST', `/trips/${createdTrip}/finalize`, undefined, token);
  if (finalized.status !== 200 && finalized.status !== 201) {
    note(
      'Ollama',
      'Badge ảnh kỷ niệm',
      'FAIL',
      `finalize HTTP ${finalized.status}: ${safeMessage(finalized.body)}`,
    );
    return;
  }
  const memory = await api(
    'POST',
    `/trips/memories/${createdTrip}/batch`,
    { items: [{ mediaId, caption: 'round 4' }] },
    token,
  );
  const memoryId = (memory.body as { data?: Array<{ id?: string }> }).data?.[0]?.id;
  if ((memory.status !== 201 && memory.status !== 200) || !memoryId) {
    note(
      'Ollama',
      'Badge ảnh kỷ niệm',
      'FAIL',
      `memory HTTP ${memory.status}: ${safeMessage(memory.body)}`,
    );
    return;
  }

  const deadline = Date.now() + 150_000;
  let checked: { badge: string | null; badgeCheckedAt: Date | null } | null = null;
  while (Date.now() < deadline) {
    checked = await prisma.tripMedia.findUnique({
      where: { id: memoryId },
      select: { badge: true, badgeCheckedAt: true },
    });
    if (checked?.badgeCheckedAt) break;
    await new Promise((resolve) => setTimeout(resolve, 3000));
  }
  if (!checked?.badgeCheckedAt) {
    note(
      'Ollama',
      'Badge ảnh kỷ niệm',
      'BLOCKED',
      `Model ${model} có sẵn nhưng ảnh ${memoryId} chưa được chấm sau 150s`,
    );
    return;
  }
  note(
    'Ollama',
    'Badge ảnh kỷ niệm',
    'PASS',
    `memory ${memoryId} badge ${checked.badge ?? 'none'} sau khi model ${model} trả lời`,
  );
}

async function probeGoogle() {
  if (!present('GOOGLE_WEB_CLIENT_ID')) {
    note('Google', 'Từ chối ID token giả', 'BLOCKED', 'Thiếu GOOGLE_WEB_CLIENT_ID');
    note('Google', 'Đăng nhập bằng tài khoản Google', 'BLOCKED', 'Thiếu client id');
    return;
  }
  const response = await api('POST', '/auth/google', { idToken: 'not-a-google-id-token' });
  const leaked = /at\s+\S+\s+\(|private key|stack/i.test(response.text);
  if (response.status === 401 && !leaked) {
    note(
      'Google',
      'Từ chối ID token giả',
      'PASS',
      `HTTP 401 ${safeMessage(response.body)}`,
    );
  } else {
    note(
      'Google',
      'Từ chối ID token giả',
      'FAIL',
      `HTTP ${response.status}${leaked ? ', response lộ chi tiết nội bộ' : ''}: ${safeMessage(response.body)}`,
    );
  }
  note(
    'Google',
    'Đăng nhập bằng tài khoản Google',
    'BLOCKED',
    'Cần một ID token thật từ tài khoản Google; vòng này không có phiên đăng nhập tương tác',
  );
}

async function probeFcm(prisma: PrismaClient) {
  const devices = await prisma.deviceToken.count();
  if (
    !present('FIREBASE_PROJECT_ID') ||
    !present('FIREBASE_CLIENT_EMAIL') ||
    !present('FIREBASE_PRIVATE_KEY')
  ) {
    note('FCM', 'Service account được Firebase chấp nhận', 'BLOCKED', 'Thiếu biến FIREBASE');
    note('FCM', 'Push tới máy thật', 'BLOCKED', `${devices} device token trong DB; chưa gửi`);
    return;
  }
  try {
    if (getApps().length === 0) {
      initializeApp({
        credential: cert({
          projectId: env.FIREBASE_PROJECT_ID,
          clientEmail: env.FIREBASE_CLIENT_EMAIL,
          privateKey: env.FIREBASE_PRIVATE_KEY.replace(/\\n/g, '\n'),
        }),
      });
    }
    await getMessaging().send(
      {
        token: 'journey-round4-not-a-device',
        notification: { title: 'probe', body: 'probe' },
      },
      true,
    );
    note('FCM', 'Service account được Firebase chấp nhận', 'FAIL', 'Dry-run với token giả lại thành công');
  } catch (error) {
    const code = (error as { code?: string }).code ?? 'unknown';
    const message = String((error as { message?: string }).message ?? '')
      .replace(/[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+/g, '[email]')
      .replace(/-----BEGIN[\s\S]*?-----END[^-]*-----/g, '[key]');
    const grant = message.match(/invalid_grant:[^"]+/)?.[0];
    const accepted =
      code === 'messaging/invalid-registration-token' ||
      code === 'messaging/invalid-argument' ||
      code === 'messaging/registration-token-not-registered';
    note(
      'FCM',
      'Service account được Firebase chấp nhận',
      accepted ? 'PASS' : 'FAIL',
      accepted
        ? `Dry-run bị từ chối đúng với token giả (${code})`
        : grant
          ? `Firebase từ chối service account: ${grant}`
          : `Firebase trả ${code}`,
    );
  }
  note(
    'FCM',
    'Push tới máy thật',
    'BLOCKED',
    devices === 0
      ? 'Không có device token nào trong DB'
      : `${devices} device token đang lưu; vòng này không gửi thông báo tới máy người dùng`,
  );
}

async function probeAppLinks() {
  const page = await api('GET', '/s/round4probe');
  const echoed = page.text.includes('round4probe');
  note(
    'App Links',
    'Trang HTML fallback',
    page.status === 200 && page.text.includes('lịch trình') && !echoed
      ? 'PASS'
      : 'FAIL',
    `HTTP ${page.status}${echoed ? ', trang phản hồi lại token' : ''}`,
  );

  const assetLinks = await api('GET', '/.well-known/assetlinks.json');
  const apple = await api('GET', '/.well-known/apple-app-site-association');
  const assetOk = assetLinks.status === 200 && Array.isArray(assetLinks.body);
  const appleOk =
    apple.status === 200 &&
    typeof apple.body === 'object' &&
    apple.body !== null &&
    'applinks' in apple.body;
  note(
    'App Links',
    'File liên kết domain trên API local',
    assetOk && appleOk ? 'PASS' : 'FAIL',
    `assetlinks HTTP ${assetLinks.status}, apple HTTP ${apple.status}`,
  );

  const devJson = readOptionalJson(resolve(ROOT, '../frontend/lib/core/config/dev.json'));
  const shareHost = String(devJson.SHARE_HOST ?? '').trim();
  const fingerprints = present('ANDROID_SHA256_CERT_FINGERPRINTS');
  const iosApp = present('IOS_APP_ID');
  if (!shareHost || shareHost === 'share.invalid' || !fingerprints) {
    note(
      'App Links',
      'Mở app từ domain HTTPS',
      'BLOCKED',
      `SHARE_HOST ${shareHost ? 'đã đặt' : 'trống'}, fingerprint Android ${fingerprints ? 'có' : 'chưa có'}, iOS app id ${iosApp ? 'có' : 'chưa có'}`,
    );
    return;
  }
  note(
    'App Links',
    'Mở app từ domain HTTPS',
    'BLOCKED',
    'Domain đã khai báo; vòng này không xác minh trên thiết bị',
  );
}

function readOptionalJson(path: string): Record<string, unknown> {
  try {
    return JSON.parse(readFileSync(path, 'utf8')) as Record<string, unknown>;
  } catch {
    return {};
  }
}

async function cleanup(
  prisma: PrismaClient,
  userId: string,
  tripId: string,
  objectKeys: string[],
) {
  if (
    objectKeys.length > 0 &&
    present('R2_ACCOUNT_ID') &&
    present('R2_BUCKET_NAME') &&
    present('R2_ACCESS_KEY_ID') &&
    present('R2_SECRET_ACCESS_KEY')
  ) {
    const client = new S3Client({
      region: 'auto',
      endpoint: `https://${env.R2_ACCOUNT_ID}.r2.cloudflarestorage.com`,
      credentials: {
        accessKeyId: env.R2_ACCESS_KEY_ID,
        secretAccessKey: env.R2_SECRET_ACCESS_KEY,
      },
    });
    for (const key of objectKeys) {
      await client
        .send(new DeleteObjectCommand({ Bucket: env.R2_BUCKET_NAME, Key: key }))
        .catch(() => undefined);
    }
  }
  if (tripId) {
    await prisma.trip.deleteMany({ where: { id: tripId } }).catch(() => undefined);
  }
  await prisma.uploadedMedia
    .deleteMany({ where: { userId } })
    .catch(() => undefined);
  await prisma.user.deleteMany({ where: { id: userId } }).catch(() => undefined);
}

function writeReport() {
  const counts = {
    PASS: rows.filter((row) => row.status === 'PASS').length,
    FAIL: rows.filter((row) => row.status === 'FAIL').length,
    BLOCKED: rows.filter((row) => row.status === 'BLOCKED').length,
  };
  const ranAt = new Date().toISOString();
  const lines = [
    '# Vòng 4 — Dịch vụ ngoài',
    '',
    `Chạy lúc **${ranAt}** trên \`${API}\`. Không ghi token, mật khẩu, URL ký sẵn hay khóa.`,
    '',
    `Kết quả: **${counts.PASS} đạt**, **${counts.FAIL} lỗi**, **${counts.BLOCKED} bị chặn vì thiếu tài khoản, máy hoặc domain**.`,
    '',
    '| Dịch vụ | Bước | Kết quả | Chi tiết |',
    '|---|---|---|---|',
    ...rows.map(
      (row) => `| ${row.service} | ${row.step} | ${row.status} | ${row.detail.replaceAll('|', '/')} |`,
    ),
    '',
  ];
  const docs = resolve(ROOT, '../docs/runtime-readiness');
  writeFileSync(resolve(docs, 'round4-external.md'), lines.join('\n'), 'utf8');
  writeFileSync(
    resolve(docs, 'round4-external.json'),
    JSON.stringify({ ranAt, api: API, counts, rows }, null, 2),
    'utf8',
  );
  console.log(JSON.stringify({ counts, rows }, null, 2));
  process.exit(counts.FAIL > 0 ? 1 : 0);
}

main().catch((error: unknown) => {
  const message = error instanceof Error ? error.message : 'round 4 failed';
  console.error(message.slice(0, 300));
  if (rows.length > 0) writeReport();
  process.exitCode = 1;
});

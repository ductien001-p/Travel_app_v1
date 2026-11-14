# Runtime environment

## Yêu cầu

- Docker + Compose
- Node.js / npm (backend NestJS 11)
- Flutter SDK (Dart ^3.11)
- (Tuỳ chọn) tài khoản Google OAuth, Cloudflare R2, Firebase, Maps API key

## 1. Hạ tầng

Tại root `Travel_V1`:

```bash
cp .env.example .env   # chỉnh POSTGRES_* nếu cần
docker compose up -d
```

| Service | Host mặc định |
|---|---|
| PostgreSQL 17 + pgvector | `localhost:5555` / DB `travel_db` |
| Redis 7 | `localhost:6379` |
| Ollama | `localhost:11434` |

Model Ollama khuyến nghị: `embeddinggemma` (search); `gemma3:4b` nếu bật badge ảnh kỷ niệm.

## 2. Backend (`backend`)

```bash
cd backend
cp .env.example .env   # DATABASE_URL, JWT, R2, Firebase, Google, …
npm install
npx prisma generate
npx prisma migrate deploy
npm run seed           # interests; có thêm seed:social / seed:ranking / seed:trip-missions
npm run start:dev
```

| Endpoint | URL |
|---|---|
| HTTP API | http://localhost:3001 |
| Socket.IO | http://localhost:3002 |
| Swagger | http://localhost:3001/api/docs |

Root helper (tuỳ chọn): `npm run backend:install` / `npm run backend:start`.

## 3. Frontend (`frontend`)

```bash
cd frontend
flutter pub get
flutter run --dart-define-from-file=lib/core/config/dev.json
```

- Android emulator: `dev.json` dùng `10.0.2.2` để trỏ máy host.
- Device thật: đổi `API_BASE_URL` / `SOCKET_URL` sang IP LAN.
- Maps: `MAPS_API_KEY` trong `android/local.properties`; iOS theo `ios/Flutter/GoogleMaps.xcconfig.example`.

## 4. Deep link / share (production)

Link dạng `https://<shareHost>/s/<token>`. Cần domain HTTPS thật và cấu hình đồng bộ:

- FE: `SHARE_HOST` (dart-define / `dev.json`)
- Android: `SHARE_HOST` trong `local.properties`
- iOS: Associated Domains / entitlements
- BE: `PUBLIC_SHARE_BASE_URL`, `ANDROID_SHA256_CERT_FINGERPRINTS`, `IOS_APP_ID`

Chi tiết gap: `docs/khao-sat-du-an.md` §4.3.

## 5. Test nhanh

```bash
# Backend unit
cd backend && npm test

# OpenAPI
cd backend && npm run openapi:generate

# Flutter
cd frontend && flutter test
```

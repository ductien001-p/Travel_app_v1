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

Link dạng `https://<SHARE_HOST>/s/<token>` (HTTPS, cổng 443). Localhost HTTP không đủ cho Android App Links hay iOS Universal Links. Không điền domain giả: để trống cho đến khi có host thật, SHA-256 của chứng chỉ ký Android và `TEAMID.bundleId`.

Khi đã có các giá trị đó, điền cùng một host vào bốn chỗ:

- [ ] `frontend/lib/core/config/dev.json`: `"SHARE_HOST": "<domain>"` (không kèm `https://`)
- [ ] `frontend/android/local.properties`: `SHARE_HOST=<domain>` (file gitignore; Gradle mặc định `share.invalid` nếu thiếu)
- [ ] `frontend/ios/Flutter/ShareLinks.xcconfig`: copy từ `ShareLinks.xcconfig.example`, đặt `SHARE_HOST=<domain>` (entitlement `applinks:$(SHARE_HOST)`; Associated Domains cần Apple Developer team trả phí)
- [ ] `backend/.env`: `PUBLIC_SHARE_BASE_URL=https://<domain>`, `ANDROID_SHA256_CERT_FINGERPRINTS=<sha256>`, `IOS_APP_ID=<TEAMID.bundleId>`

Backend đã phục vụ `/s/:token`, `/.well-known/assetlinks.json` và `/.well-known/apple-app-site-association`. Thử Android sau khi domain xác minh: `adb shell am start -a android.intent.action.VIEW -d "https://<SHARE_HOST>/s/<token>"`.

## 5. Test nhanh

```bash
# Backend unit
cd backend && npm test

# OpenAPI
cd backend && npm run openapi:generate

# Flutter
cd frontend && flutter test
```

# Khảo sát dự án Travel_V1

> Ngày khảo sát: **2026-11-14**  
> Phạm vi: monorepo `Travel_V1` — backend `backend` (BA/API) và frontend `frontend` (FE).  
> Nguồn sự thật: mã nguồn, `backend/contracts/openapi.json`, `frontend/brain/brain.md`, `docker-compose.yml`.

---

## 1. Tổng quan

**Travel Social** là ứng dụng mạng xã hội du lịch: lập kế hoạch chuyến đi nhóm, lịch trình/check-in, chi phí, kỷ niệm, khám phá địa điểm, bảng tin xã hội, bạn bè/chat, Travel DNA và xếp hạng.

| Thành phần | Thư mục | Stack | Vai trò |
|---|---|---|---|
| Backend (BA/API) | `backend/` | NestJS 11, Prisma 7, PostgreSQL + pgvector, Redis, Socket.IO | REST API + realtime chat/timeline |
| Frontend (FE) | `frontend/` | Flutter (Dart ^3.11), Riverpod, go_router, Dio | App mobile (Android/iOS) |
| Hạ tầng local | root `docker-compose.yml` | Postgres 17 (pgvector), Redis 7, Ollama | DB, cache/OTP, embedding/vision |
| Hợp đồng API | `backend/contracts/openapi.json` | OpenAPI 1.0.0 — **~153 path** | Nguồn tin cậy cho FE khi nối API |

Root không phải npm workspace đầy đủ: `package.json` chỉ có script trỏ vào `backend/`. Dependency backend nằm trong `backend/`.

---

## 2. Backend — `backend`

### 2.1 Công nghệ

- NestJS 11 + Express, TypeScript, ValidationPipe (whitelist), Helmet, Throttler
- Prisma 7 + `@prisma/adapter-pg`, PostgreSQL 17 + **pgvector**
- Auth: Passport Local / Google / JWT; bcrypt; `JwtAuthGuard` + `RolesGuard` toàn cục
- Realtime: Socket.IO trên cổng **3002** (HTTP API mặc định **3001**)
- Redis (ioredis): OTP / dữ liệu có TTL
- Cloudflare R2 (AWS S3 SDK): upload qua URL ký sẵn
- Firebase Admin: push notification
- Ollama: embedding địa điểm (`embeddinggemma`, 768d) + badge ảnh kỷ niệm (`MEMORY_BADGE_MODEL`, vd. `gemma3:4b`)
- Swagger UI: `/api/docs`
- Jest + Supertest; script `openapi:generate` / `validate` / `coverage`

### 2.2 Module chính (`src/app.module.ts`)

| Module | Chức năng |
|---|---|
| `Auth` + `DeviceTokens` | Đăng ký/đăng nhập, Google, refresh/logout, verify email, reset password, FCM token |
| `Users` | Hồ sơ `/users/me`, cập nhật, search, showcase |
| `Trips` + quan hệ | Draft/finalize, members, destinations, discover, join, recruitment, share links |
| `TripItineraries` | Ngày lịch trình, hoạt động, check-in, route preview |
| `TripInvitations` / `TripJoinRequests` | Mời bạn / xin vào bằng mã + duyệt |
| `TripExpenses` | Chi phí nhóm + settle |
| `TripTimeline` | Dòng sự kiện chuyến đi |
| `TripCompletion` | Hoàn thành chuyến + thưởng |
| `TripMissions` | Nhiệm vụ trong trip (seed + progress) |
| `TripMessages` | Tin nhắn nhóm trip |
| `Chats` | Hub tin nhắn `GET /chats/hub` |
| `Friends` | Bạn bè, request, conversation, find/nearby |
| `Follow` | Theo dõi |
| `Social` (`Posts`) | Feed, posts, likes, comments, saves, shares, stories, challenges |
| `Places` (+ reviews, saved, collections) | Địa điểm, embedding search, đánh giá, đã lưu |
| `TravelDNA` | Hồ sơ DNA / radar |
| `Ranking` | Leaderboard, me, quests claim |
| `Media` + `PresignUpload` | Media + upload R2 |
| `Notification` | Lưu thông báo + push (chưa có REST inbox rõ ràng) |
| `Mail` / `Redis` | Email mã xác minh; cache |

### 2.3 Model dữ liệu (Prisma — tóm tắt)

Nhóm chính: **User / Auth / DeviceToken**, **Trip + Itinerary + Member + Invitation/Join + Expense + Message + Timeline + Completion + Missions + Share**, **Place + Review + Saved + Collections**, **Social Post/Story/Challenge**, **Friends / Follow / Conversations**, **TravelDNA / Ranking / Quests / Achievements**, **Media / Notification**.

### 2.4 Cổng & env quan trọng

| Mục | Giá trị mặc định / ghi chú |
|---|---|
| HTTP | `PORT=3001` |
| Socket.IO | `3002` (cố định trên gateway) |
| Postgres (Compose) | host port **5555** → `travel_db` |
| Redis | `localhost:6379` |
| Ollama | `http://127.0.0.1:11434` |
| Share | `PUBLIC_SHARE_BASE_URL`, `ANDROID_*`, `IOS_APP_ID` |

Chi tiết biến: `backend/.env.example`. Infra Compose: root `.env.example`.

### 2.5 Điểm mạnh / hạn chế (BE)

**Đã có:** auth đầy đủ, trip lifecycle lớn, places + semantic search, social feed, friends, ranking/quests, missions, share links + well-known files, OpenAPI contract.

**Còn hạn chế / lệch tài liệu:**

- `backend/README.md` còn mô tả cũ (port Postgres 5554, “chưa có frontend”, Compose chưa Ollama) — cần đồng bộ với monorepo hiện tại.
- E2e Nest mặc định vẫn mang dấu scaffold cũ; có thêm `test:mvp:e2e` cho Flutter MVP.
- `NotificationModule` chủ yếu nội bộ — chưa thấy API hộp thư cho FE.
- Album: badge ảnh phụ thuộc Ollama vision; ghi chú sản phẩm còn TODO lọc badge theo ngày/user.

---

## 3. Frontend — `frontend`

### 3.1 Công nghệ

| Nhóm | Lựa chọn |
|---|---|
| SDK | Dart `^3.11.4`, Flutter |
| State | `flutter_riverpod` (không codegen) |
| Routing | `go_router` + `StatefulShellRoute` (4 tab) |
| HTTP | `dio` + interceptor auth/refresh |
| Realtime | `socket_io_client` → `:3002` |
| Auth / push | `google_sign_in`, Firebase Messaging |
| Map | `google_maps_flutter`, `geolocator` |
| Models | freezed + json_serializable |
| Font | Plus Jakarta Sans |

Bản đồ trạng thái chi tiết: **`frontend/brain/brain.md`** (cập nhật 2026-11-13).

### 3.2 Kiến trúc feature

```text
lib/
  app/          # router, shell, theme bootstrap
  core/         # config, network, realtime, deep link, shared widgets
  features/<name>/
    application/   # controllers + view mappers
    data/          # models, datasources, repositories, datamock
    presentation/  # screens + widgets
    provider/      # Riverpod providers
```

Luồng: **Screen → Controller → Repository → RemoteDataSource → Dio ApiClient**.  
Endpoint có trong OpenAPI → nối thật; chưa có → datamock + `// TODO(backend):`.

### 3.3 Trạng thái feature (tóm tắt từ brain)

| Feature | Trạng thái | Ghi chú |
|---|---|---|
| Core / Auth / FCM / Media upload | ✅ | API thật |
| Trips (list, create, detail, itinerary, timeline, memories, invite/join, expenses) | ✅ | API thật |
| Profile / Travel DNA / Saved places / User memories | ✅ | API thật (showcase từng phần đã nối) |
| Home Explore + destination + place detail | 🟢 | Discover / places API |
| Social feed + post detail | 🟢 | API thật |
| Friends hub + find friends | ✅ | API thật |
| Ranking (period + quests + Top-10) | 🟢 | Phase 2 `/ranking/*` |
| Chats hub / friend chat / trip chat | 🟢 | API + socket; datamock chỉ cho test |
| Public Images | 🟡 | UI + datamock / album seed |
| Settings | 🟡 | Chủ logout + switch push thật |

Chú thích: ✅ E2E với BE · 🟢 API đang dùng · 🟡 UI thiếu logic/mock.

### 3.4 Config chạy FE

File `lib/core/config/dev.json`:

- `API_BASE_URL`: `http://10.0.2.2:3001` (Android emulator → máy host)
- `SOCKET_URL`: `http://10.0.2.2:3002`
- Google client IDs
- **Không có `SHARE_HOST`** → deep link chia sẻ đang bị bỏ qua trên app

Lệnh: `flutter run --dart-define-from-file=lib/core/config/dev.json`

---

## 4. Ghép nối FE ↔ BE

### 4.1 Đã nối tốt

Auth, device token, upload R2, trips (hầu hết luồng chính), itinerary/check-in/share preview HTML, timeline + socket, memories, expenses, join/invite, explore/places, social feed/detail, friends, ranking, travel DNA, profile, chats (hub / friend DM / trip group).

### 4.2 Gap còn lại

| Khu vực | Backend | Frontend |
|---|---|---|
| Chat DM + trip group | Hub / thread / socket đã có | FE đã gọi API thật; một số loại tin rich (typing, PLACE_CARD, …) chưa đủ E2E |
| Public image viewer | Media/trip memories có sẵn | Viewer album public còn mock |
| Trip missions | `GET /trips/:id/missions` + seed | Chưa có màn/feature riêng |
| Notifications inbox | Service + push | Icon “sắp có”; chưa hộp thư |
| Stories / challenges UI sâu | API stories/challenges | Feed đã join/create một phần; viewer/challenge còn thiếu |
| Deep link mở app | `PUBLIC_SHARE_BASE_URL` + assetlinks | Thiếu `SHARE_HOST` + domain HTTPS thật |
| Expenses nâng cao | Overview/settle cơ bản | OCR payer khác / hóa đơn / QR / batch settle chưa |
| Settings | `notificationEnabled` trên user | Nhiều mục UI chưa có API |

### 4.3 Deep link / App Links (blocker phát hành)

App chỉ nhận `https://<shareHost>/s/<token>` (HTTPS, host đúng, cổng 443). Localhost HTTP **không** đủ cho Android App Links / iOS Universal Links.

Cần đồng bộ domain trên: `dev.json` (`SHARE_HOST`), Android `local.properties`, iOS entitlements/xcconfig, BE `PUBLIC_SHARE_BASE_URL` + fingerprint / `IOS_APP_ID`.

---

## 5. Tài liệu & thiết kế trong repo

| Vị trí | Nội dung |
|---|---|
| `docs/khao-sat-du-an.md` | Báo cáo khảo sát này |
| `frontend/brain/brain.md` | Bản đồ trạng thái FE (chi tiết nhất) |
| `backend/README.md` | Hướng dẫn backend (một số chỗ lệch monorepo) |
| `backend/contracts/openapi.json` | Hợp đồng API (~153 paths) |
| `frontend/docs/design/screen/**` | HTML/screenshot Stitch theo màn |
| `docs/screens/social_feed/stitch/` | Artifact Stitch social feed (nếu có) |
| `.archify/` | Diagram HTML (overview kiến trúc) |

Quy ước doc theo màn hình (khi làm từ Stitch): `docs/screens/<screen>/` gồm `screen_analysis`, `backend_mapping`, `conflicts`, `screen_contract`, `implementation`, `implementation_report`, `runtime_test_report` + thư mục `stitch/`.

---

## 6. Cách chạy local (tóm tắt)

### Infra

```bash
# Tại root Travel_V1 — copy .env.example → .env
docker compose up -d
```

### Backend

```bash
cd backend
# copy .env.example → .env (DATABASE_URL trỏ localhost:5555, JWT, R2, Firebase, …)
npm install
npx prisma generate
npx prisma migrate deploy
npm run seed
npm run start:dev
```

- API: http://localhost:3001  
- Socket: http://localhost:3002  
- Swagger: http://localhost:3001/api/docs  

### Frontend

```bash
cd frontend
flutter pub get
# Maps: MAPS_API_KEY trong android/local.properties (và iOS xcconfig)
flutter run --dart-define-from-file=lib/core/config/dev.json
```

Device thật: đổi `API_BASE_URL` / `SOCKET_URL` sang IP LAN máy chạy Nest.

---

## 7. Việc ưu tiên đề xuất

Cập nhật 2026-11-14 sau khi đối chiếu lại mã nguồn:

1. **Chat E2E** — hub, thread DM, thread nhóm, gửi TEXT và đánh dấu đã đọc đã gọi API thật. Đã nối thêm: lỗi gửi DM hiện trên bubble, socket `/friends` và `trip:message` cùng shape UI (`kind`), gửi ảnh nhóm, reaction (kể cả TEXT), lời mời `TRIP_INVITE`. Chưa có typing bạn bè và gửi `PLACE_CARD` (chưa có picker địa điểm).
2. **SHARE_HOST** — code deep link đã có. Checklist domain HTTPS, SHA-256 và `TEAMID.bundleId` nằm ở [docs/runtime_environment.md](runtime_environment.md) mục 4. Không điền domain giả.
3. **Hộp thư thông báo** — `GET /notifications`, `POST /notifications/:id/read`, `POST /notifications/read-all`. App mở inbox từ chuông social và home; tap lời mời / join request / recruitment theo `tripId`. Chưa ghi các loại enum chưa có nguồn (`POST_LIKE`, `FRIEND_REQUEST`, …).
4. **Trip missions** — đã có trên trip detail (`GET /trips/:tripId/missions`) và claim qua `POST /trips/:tripId/completion`. Không thêm màn riêng.
5. **Settings / ảnh / chi tiêu / story** — đổi mật khẩu gọi `POST /auth/change-password`. Viewer ảnh mở từ media đã seed, không còn album giả; ẩn đặt bìa, like, xóa, bình luận, tải HD. Chi tiêu xem hóa đơn từ `receipts[]`. Story viewer có thanh tiến trình và tự chuyển. Ngoài phạm vi: sinh trắc học, thiết bị, ngôn ngữ/tiền tệ, QR, settle hàng loạt, rule tiến độ challenge.
6. **README backend** — đã chỉnh port Postgres **5555**, monorepo có Flutter, Compose có Ollama, Redis đọc `REDIS_HOST` / `REDIS_PORT`, và các lệnh seed bổ sung.

---

## 8. Kết luận

Dự án là monorepo **FE Flutter + BE NestJS** khá trưởng thành ở lõi **auth + trips + places + social + ranking + chats**. Phần còn lại tập trung vào **thông báo inbox**, **missions/gamification UI**, **deep link production**, và một số màn/UI phụ vẫn placeholder. Nguồn theo dõi hàng ngày: `frontend/brain/brain.md` (FE) và `backend/contracts/openapi.json` (hợp đồng API).

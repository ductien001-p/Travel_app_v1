# Travel_V1 — Travel Social

Monorepo ứng dụng mạng xã hội du lịch: lập kế hoạch chuyến đi nhóm, lịch trình & check-in, chi phí, kỷ niệm, khám phá địa điểm, bảng tin, bạn bè/chat, Travel DNA và xếp hạng.

| Thành phần | Thư mục | Stack |
|---|---|---|
| Backend (API + Socket) | [`backend/`](./backend/) | NestJS 11, Prisma 7, PostgreSQL + pgvector, Redis, Socket.IO |
| Frontend (mobile) | [`frontend/`](./frontend/) | Flutter, Riverpod, go_router, Dio |
| Hạ tầng local | [`docker-compose.yml`](./docker-compose.yml) | Postgres 17, Redis 7, Ollama |
| Tài liệu | [`docs/`](./docs/) | Khảo sát, context, hướng dẫn chạy |

## Trạng thái nhanh

- **Đã nối E2E (FE ↔ BE):** auth, FCM device token, upload R2, trips (list/create/detail/itinerary/timeline/memories/invite/join/expenses), explore/places, social feed + post detail, friends, ranking, Travel DNA, profile.
- **Đang UI / mock một phần:** chats (hub, DM, trip group), public image viewer, settings (ngoài logout + push).
- **BE có sẵn, FE chưa wire đầy đủ:** trip missions, notification inbox, một số story/challenge sâu.
- **Chặn phát hành deep link:** thiếu domain HTTPS + `SHARE_HOST` đồng bộ FE/BE/Android/iOS.

Báo cáo khảo sát đầy đủ: **[`docs/khao-sat-du-an.md`](./docs/khao-sat-du-an.md)**  
Bản đồ FE chi tiết: **[`frontend/brain/brain.md`](./frontend/brain/brain.md)**  
Hợp đồng API: **[`backend/contracts/openapi.json`](./backend/contracts/openapi.json)** (~153 paths)

## Cấu trúc

```text
Travel_V1/
├── docker-compose.yml
├── .env.example                 # Postgres / Redis / Ollama ports
├── docs/
│   ├── khao-sat-du-an.md        # Khảo sát FE + BE
│   ├── project_context.md
│   └── runtime_environment.md
├── backend/                   # NestJS backend
│   ├── prisma/
│   ├── contracts/openapi.json
│   └── src/module/…             # auth, trips, places, social, …
└── frontend/                  # Flutter app
    ├── brain/brain.md
    ├── lib/{app,core,features}/
    └── docs/design/screen/      # Stitch HTML / screenshot
```

## Chạy nhanh

### 1. Infra

```bash
cp .env.example .env
docker compose up -d
```

- Postgres: `localhost:5555` → `travel_db`
- Redis: `localhost:6379`
- Ollama: `localhost:11434`

### 2. Backend

```bash
cd backend
cp .env.example .env    # điền DATABASE_URL, JWT, R2, Firebase, Google, …
npm install
npx prisma generate
npx prisma migrate deploy
npm run seed
npm run start:dev
```

- API: http://localhost:3001  
- Socket: http://localhost:3002  
- Swagger: http://localhost:3001/api/docs  

### 3. Frontend

```bash
cd frontend
flutter pub get
flutter run --dart-define-from-file=lib/core/config/dev.json
```

Android emulator dùng `10.0.2.2` trong `dev.json`. Device thật: đổi `API_BASE_URL` / `SOCKET_URL` sang IP LAN.  
Maps: xem [`frontend/README.md`](./frontend/README.md).

Chi tiết hơn: [`docs/runtime_environment.md`](./docs/runtime_environment.md).

## Quy ước phát triển

1. **OpenAPI là nguồn tin cậy** cho tên endpoint và shape response. Sinh lại: `npm run openapi:generate` trong `backend` (không sửa tay `openapi.json`).
2. FE theo kiến trúc `features/<name>/{application,data,presentation,provider}`. Endpoint chưa có → datamock + `// TODO(backend):`.
3. Cập nhật `frontend/brain/brain.md` khi đổi trạng thái feature.
4. Màn từ Stitch: đặt artifact + contract trong `docs/screens/<screen>/` (xem [`docs/README.md`](./docs/README.md)).

## Việc tồn đọng (ưu tiên)

1. Nối chat thật (hub / DM / trip group) — bỏ datamock.
2. Cấu hình `SHARE_HOST` + domain HTTPS nếu cần App Links / Universal Links.
3. UI trip missions + hộp thư thông báo.
4. Hoàn thiện Settings, Public Images, expenses nâng cao (OCR/hóa đơn/QR).
5. Đồng bộ nội dung cũ trong `backend/README.md` với monorepo (port DB 5555, có FE, có Ollama).

## Tài liệu liên quan

| Link | Nội dung |
|---|---|
| [docs/README.md](./docs/README.md) | Mục lục docs |
| [docs/khao-sat-du-an.md](./docs/khao-sat-du-an.md) | Khảo sát toàn dự án |
| [docs/project_context.md](./docs/project_context.md) | Context ngắn |
| [backend/README.md](./backend/README.md) | Backend chi tiết |
| [frontend/brain/brain.md](./frontend/brain/brain.md) | Trạng thái Flutter |

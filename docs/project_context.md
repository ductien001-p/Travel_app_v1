# Project context

## Đây là project gì?

**Travel Social** — ứng dụng mạng xã hội du lịch: tạo/tham gia chuyến đi nhóm, lịch trình & check-in, chi phí, album kỷ niệm, khám phá địa điểm, bảng tin, bạn bè/chat, Travel DNA và bảng xếp hạng.

## Monorepo

```text
Travel_V1/
├── docker-compose.yml      # Postgres (pgvector) + Redis + Ollama
├── docs/                   # Tài liệu khảo sát & vận hành
├── backend/              # Backend NestJS (BA / API)
└── frontend/             # Frontend Flutter
```

| Phía | Package / thư mục | Stack |
|---|---|---|
| Backend | `backend` | NestJS 11, Prisma 7, PostgreSQL, Redis, Socket.IO |
| Frontend | `frontend` (`travel_frontend_v1`) | Flutter, Riverpod, go_router, Dio |

## Hợp đồng giữa FE và BE

- OpenAPI: `backend/contracts/openapi.json` (~153 paths) — **không sửa tay**; sinh lại bằng `npm run openapi:generate` trong `backend`.
- FE chỉ sửa backend khi được yêu cầu rõ. Endpoint có trong OpenAPI → nối thật; chưa có → datamock + `// TODO(backend):`.

## Nguồn trạng thái

- FE chi tiết: `frontend/brain/brain.md`
- Khảo sát tổng: `docs/khao-sat-du-an.md`

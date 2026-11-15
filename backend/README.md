# Travel V1 — Backend ứng dụng du lịch

Backend phục vụ lập kế hoạch du lịch, tổ chức chuyến đi theo nhóm và chia sẻ trải nghiệm. Dự án sử dụng NestJS, cung cấp REST API và chat thời gian thực qua Socket.IO. Monorepo `Travel_V1` gồm backend này và ứng dụng Flutter trong `frontend/`.

## Chức năng đã có trong mã nguồn

- **Tài khoản:** đăng ký, đăng nhập bằng email/mật khẩu hoặc Google OAuth, access token/refresh token, đăng xuất, xác minh email và xử lý mật khẩu.
- **Người dùng và kết nối:** hồ sơ người dùng, theo dõi, lời mời kết bạn, hội thoại và tin nhắn giữa bạn bè.
- **Chuyến đi:** tạo và cập nhật chuyến đi, quản lý thành viên, lời mời, sở thích, điểm đến, lịch trình theo ngày, hoạt động, check-in và hoàn thành chuyến đi.
- **Chi phí và kỷ niệm:** ghi nhận chi phí, chia tiền giữa thành viên, lưu ảnh/kỷ niệm, timeline và tin nhắn chuyến đi.
- **Địa điểm:** tạo, sửa, duyệt/từ chối địa điểm, thư viện ảnh, đánh giá, lưu địa điểm và ghi nhận địa điểm đã ghé thăm.
- **Tìm kiếm ngữ nghĩa:** tìm địa điểm trong cơ sở dữ liệu theo nội dung truy vấn và bán kính quanh điểm đến, sử dụng Ollama và pgvector.
- **Mạng xã hội:** bài đăng kèm media, lượt thích, bình luận và chia sẻ.
- **Travel DNA và xếp hạng:** xử lý sự kiện check-in để cập nhật hồ sơ du lịch; cập nhật điểm khi hoàn thành chuyến đi và tổng hợp bảng xếp hạng hằng ngày.
- **Media và thông báo:** tải ảnh trực tiếp lên Cloudflare R2 qua URL ký sẵn, xác nhận upload, lưu thông báo và gửi push notification qua Firebase.

Các mục trên mô tả phần triển khai hiện có; không đồng nghĩa mọi luồng đã được kiểm thử hoàn chỉnh.

## Công nghệ

- TypeScript, NestJS 11, Express.
- PostgreSQL 17 với pgvector; Prisma 7 và PostgreSQL adapter.
- Redis 7 qua ioredis để lưu mã xác minh và dữ liệu có thời hạn.
- Passport Local/Google/JWT, bcrypt và kiểm tra quyền bằng guard.
- Socket.IO, NestJS EventEmitter và Schedule.
- Cloudflare R2 qua AWS SDK S3, Firebase Admin, Nodemailer với Gmail.
- Ollama `embeddinggemma`, vector 768 chiều.
- Jest, Supertest, ESLint và Prettier.

## Cấu trúc thư mục

```text
Travel_V1/
├── docker-compose.yml          # PostgreSQL + pgvector, Redis, Ollama
├── frontend/                   # Ứng dụng Flutter
├── package.json                # Script tiện ích trỏ vào backend
└── backend/                    # Thư mục ứng dụng NestJS; README này nằm ở đây
    ├── package.json            # Scripts chạy, build và test
    ├── prisma.config.ts        # Cấu hình Prisma CLI và seed
    ├── prisma/
    │   ├── schema.prisma       # Model dữ liệu và enum
    │   ├── migrations/         # Lịch sử migration
    │   └── seed.ts             # Dữ liệu sở thích ban đầu
    ├── src/
    │   ├── main.ts             # Bootstrap, validation, cổng HTTP
    │   ├── app.module.ts       # Module và guard toàn cục
    │   ├── generated/prisma/   # Sinh bằng prisma generate
    │   ├── module/
    │   │   ├── auth/           # Xác thực và device token
    │   │   ├── authorization/  # Roles guard
    │   │   ├── users/
    │   │   ├── trips/          # Thành viên, lịch trình, chi phí, kỷ niệm...
    │   │   ├── places/         # Địa điểm, tìm kiếm, đánh giá, địa điểm đã lưu
    │   │   ├── friends/
    │   │   ├── follow/
    │   │   ├── social/
    │   │   ├── travelDNA/
    │   │   ├── ranking/
    │   │   └── media/
    │   ├── uploads/            # R2 và presigned upload
    │   ├── websocket/          # Chat chuyến đi và xác thực socket
    │   ├── notification/
    │   ├── redis/
    │   ├── mail/
    │   ├── config/
    │   ├── decoration/
    │   ├── events/
    │   └── untils/             # Tiện ích ngày và tọa độ; giữ tên hiện tại
    └── test/                   # Cấu hình và test e2e
```

## Chuẩn bị và cài đặt

Cần Node.js/npm tương thích với các phiên bản trong `package.json`, Docker có Compose và thông tin cấu hình các dịch vụ bên ngoài. Dự án chưa khai báo `engines` để chốt phiên bản Node.js.

Chạy từ thư mục **Travel_V1**:

```bash
npm install
docker compose up -d
cd backend
npm install
```

Hiện dependency được khai báo ở cả hai cấp thư mục: AWS SDK, Passport, JWT và Firebase có trong `package.json` cấp ngoài. Vì vậy cần cài ở cả hai cấp khi sử dụng cấu trúc hiện tại.

Docker Compose chỉ chạy hạ tầng, chưa đóng gói/chạy backend:

- PostgreSQL: `localhost:5555` (biến `POSTGRES_HOST_PORT`, mặc định 5555), database `travel_db`.
- Redis: `localhost:6379`.
- Ollama: `localhost:11434`.
- Dữ liệu lưu trong volume `postgres_data` và `redis_data`.

## Biến môi trường

Tạo file `.env` trong **backend/**. Thay các giá trị mẫu bằng cấu hình của bạn; không đưa thông tin bí mật vào Git.

```dotenv
PORT=3001
DATABASE_URL="postgresql://<POSTGRES_USER>:<POSTGRES_PASSWORD>@localhost:5555/travel_db?schema=public"

JWT_SECRET="replace-with-a-random-secret"
JWT_SECRET_REFRESH="replace-with-a-random-secret"
ACCESS_TOKEN_EXPIRY=15m
REFRESH_TOKEN_EXPIRY=7d
SALT_ROUNDS=10

GOOGLE_CLIENT_ID="your-google-client-id"
GOOGLE_CLIENT_SECRET="your-google-client-secret"
GOOGLE_CALLBACK_URL="http://localhost:3001/auth/google/callback"

MAIL_USER="your-email@gmail.com"
MAIL_PASSWORD="your-gmail-app-password"

FIREBASE_PROJECT_ID="your-project-id"
FIREBASE_CLIENT_EMAIL="your-service-account-email"
FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\nYOUR_PRIVATE_KEY\n-----END PRIVATE KEY-----\n"

R2_ACCOUNT_ID="your-account-id"
R2_BUCKET_NAME="your-bucket-name"
R2_ACCESS_KEY_ID="your-access-key-id"
R2_SECRET_ACCESS_KEY="your-secret-access-key"
R2_PUBLIC_URL="https://your-public-media-domain"
R2_PRESIGN_EXPIRES=3600
```

- Lấy `POSTGRES_USER` và `POSTGRES_PASSWORD` từ `../docker-compose.yml`; URL-encode ký tự đặc biệt nếu có trong thông tin kết nối.
- Google OAuth, R2 và Firebase được khởi tạo cùng ứng dụng. Cần cấu hình hợp lệ cho các tích hợp này khi chạy bản mã nguồn hiện tại; không có công tắc tắt riêng từng tích hợp.
- Gmail được cấu hình trực tiếp trong `src/mail/mail.service.ts`; các biến `MAIL_*` phục vụ gửi mã xác minh.
- Redis đọc `REDIS_HOST` và `REDIS_PORT` (mặc định `localhost` / `6379`) trong `src/redis/redis.module.ts`.
- **Lưu ý refresh token:** `issueTokens()` hiện ký cả hai token bằng secret mặc định `JWT_SECRET`, nhưng `refresh()` xác minh bằng `JWT_SECRET_REFRESH`. Hai giá trị phải giống nhau để luồng hiện tại hoạt động; nếu muốn tách khóa cần sửa phần ký refresh token. Thời hạn bản ghi refresh token trong database hiện cố định 7 ngày.

## Khởi tạo cơ sở dữ liệu và chạy ứng dụng

Sau khi cấu hình `.env`, chạy trong **backend/**:

```bash
npx prisma generate
npx prisma migrate deploy
npx prisma db seed
npm run start:dev
```

- Prisma Client được sinh vào `src/generated/prisma`.
- `migrate deploy` áp dụng các migration đã lưu; migration của dự án có tạo extension `vector`.
- Seed `npx prisma db seed` thêm sở thích. Thêm dữ liệu mẫu bằng `npm run seed:social`, `npm run seed:ranking` và `npm run seed:trip-missions`.
- HTTP API mặc định: `http://localhost:3001`.
- Socket.IO: `http://localhost:3002`; cổng này được khai báo trực tiếp trong gateway và không đổi theo `PORT`.

Các lệnh khác:

```bash
npm run start          # Chạy NestJS
npm run start:debug    # Watch kèm debugger
npm run build          # Biên dịch
npm run start:prod     # Chạy dist/main sau khi build
npx prisma studio     # Xem dữ liệu
```

Khi phát triển thay đổi schema, sử dụng `npx prisma migrate dev --name <ten_thay_doi>` trên database phát triển.

## Tìm kiếm địa điểm bằng Ollama

Cài và chạy Ollama trên máy dùng để chạy backend, sau đó tải model:

```bash
ollama pull embeddinggemma
```

Mã nguồn dùng Ollama client mặc định, model `embeddinggemma` và yêu cầu vector đúng 768 chiều. Docker Compose đã có dịch vụ Ollama trên cổng `11434`.

API `POST /places/search-embeddings` nhận `query`, `destinationId` và `radiusKm`. Service lấy tọa độ của điểm đến, lọc theo khoảng cách, rồi sắp xếp theo độ tương đồng ngữ nghĩa; trả tối đa 30 địa điểm. Chỉ địa điểm có tọa độ và embedding mới được đưa vào kết quả.

Embedding được tạo khi tạo/cập nhật các trường liên quan của địa điểm. Nếu tạo embedding lỗi, service ghi log và vẫn giữ địa điểm; địa điểm đó có thể chưa xuất hiện trong tìm kiếm ngữ nghĩa.

## REST API và xác thực

Không có tiền tố `/api` trong bootstrap hiện tại. Những nhóm route chính:

- `/auth`: đăng ký, đăng nhập, Google OAuth, refresh, logout, email và mật khẩu.
- `/users`, `/device-token`: người dùng và thiết bị nhận thông báo.
- `/trips`: chuyến đi, thành viên, kỷ niệm, tin nhắn và nhiệm vụ (`/trips/:tripId/missions`).
- `/trips/:tripId/itineraries`: lịch trình và hoạt động.
- `/trips/:tripId/expenses`: chi phí chuyến đi.
- `/trips/interests`, `/trips/timeline`: sở thích và dòng thời gian.
- `/trip-invitations`, `/trips/:tripId/completion`: lời mời và hoàn thành chuyến đi.
- `/places`: địa điểm, tìm kiếm, đánh giá và địa điểm đã lưu.
- `/friends`, `/follow`: kết bạn và theo dõi.
- `/chats/hub`: danh sách hội thoại.
- `/social/posts`, `/social/stories`, `/social/challenges`: bài đăng, story và thử thách.
- `/notifications`: hộp thư (danh sách, đánh dấu đã đọc, đọc hết).
- `/travel-dna`, `/ranking`: hồ sơ du lịch và bảng xếp hạng.
- `/uploads/presigns`, `/uploads/complete`: lấy URL tải ảnh và xác nhận tải xong.

Contract đầy đủ cho Flutter nằm tại `contracts/openapi.json`; hướng dẫn tích hợp nằm trong `docs/flutter-integration.md`. Swagger UI chạy tại `/api/docs`. `JwtAuthGuard` và `RolesGuard` được đăng ký toàn cục; endpoint có `@Public()` được miễn kiểm tra JWT. Gửi access token bằng header:

```http
Authorization: Bearer <accessToken>
```

Ví dụ đăng nhập:

```http
POST /auth/login
Content-Type: application/json

{"email":"user@example.com","password":"your-password"}
```

Global `ValidationPipe` bật `whitelist`, `forbidNonWhitelisted` và `transform`. HTTP CORS và Swagger đã được cấu hình trong `main.ts`.

## Chat thời gian thực

Kết nối bằng Socket.IO, truyền JWT qua `handshake.auth.token` hoặc header `Authorization: Bearer <accessToken>`.

- Chat chuyến đi: namespace mặc định ở cổng `3002`; sự kiện client gửi gồm `trip:join`, `trip:leave`, `trip:message:send`.
- Chat bạn bè: namespace `/friends` cùng cổng; sự kiện gồm `friend:conversation:join`, `friend:conversation:leave`, `friend:message:send`.

Payload và kiểm tra thành viên/quyền tham gia nằm trong `src/websocket/gateway.ts` và `src/module/friends/friend-gateway.ts`.

## Kiểm thử và định dạng

Chạy trong **backend/**:

```bash
npm test
npm run test:watch
npm run test:cov
npm run test:e2e
npm run lint
npm run format
```

`lint` dùng `--fix`, còn `format` ghi lại định dạng file. Một số test vẫn là scaffold NestJS; test e2e hiện mong đợi `GET /` trả `Hello World!` dù `AppModule` không đăng ký controller gốc. Bộ test cần được cập nhật theo API thực tế trước khi dùng làm tiêu chí xác nhận toàn bộ chức năng.

## Phạm vi phát triển tiếp

README cũ chứa các ý tưởng Travel Style/badge và checklist tìm địa điểm bằng nhà cung cấp bên ngoài. Mã hiện tại đã có Travel DNA, tìm kiếm ngữ nghĩa trong database và ứng dụng Flutter trong `frontend/`. Luồng External Place Provider/Place Candidate vẫn chưa triển khai đầy đủ.

## Tác giả và giấy phép

Theo `package.json`: tác giả **TienPhan**, phiên bản **0.0.1**, package riêng tư (`private: true`), giấy phép **UNLICENSED**.

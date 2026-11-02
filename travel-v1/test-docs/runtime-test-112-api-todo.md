# Travel V1 — Runtime Test TODO for 112 REST APIs

## Mục tiêu

Đạt trạng thái `BACKEND_FULL_RUNTIME_READY` trước khi mở toàn bộ task thiết kế Stitch và code Flutter. Checklist này bao phủ đúng **112 REST operations** trong inventory hiện tại. WebSocket được kiểm tra ở một gate riêng vì không thuộc OpenAPI REST 112 operations.

## Quy tắc chạy tuần tự

1. Chỉ một gate được mang trạng thái `IN_PROGRESS`.
2. Chỉ bắt đầu gate `Gxx` khi gate ngay trước nó là `DONE`.
3. Chỉ đánh dấu endpoint `[x]` khi test runtime thực sự đã chạy và có evidence trong report/test file.
4. Một gate chỉ là `DONE` khi tất cả endpoint và exit criteria trong gate đều đạt.
5. Nếu lỗi: đặt gate thành `BLOCKED`, ghi blocker, sửa nguyên nhân gốc và chạy lại gate; không chuyển sang gate kế tiếp.
6. Sau mỗi endpoint/gate, cập nhật đồng thời file này và `runtime-test-state.json`.
7. Test chỉ dùng PostgreSQL/Redis test riêng; không chạy trên production; cleanup theo ID/marker chính xác.
8. Không dùng `prisma migrate reset`, `DROP DATABASE`, `TRUNCATE` hoặc xóa dữ liệu diện rộng.
9. Không sửa trực tiếp `contracts/openapi.json`; sửa DTO/source rồi sinh lại.
10. Không được skip/làm yếu assertion để chuyển gate.

## Definition of Done áp dụng cho mỗi endpoint

Kiểm tra các mục phù hợp với endpoint:

- Happy path và HTTP status.
- Request validation: required, type, enum, min/max, nullable.
- Public/JWT, expired/invalid token và inactive/deleted user.
- Authorization: owner/member/admin/outsider.
- `404`, `409`, `429` và business errors liên quan.
- Response runtime khớp OpenAPI, bao gồm envelope, nullability, enum, Date, Decimal và pagination.
- Không lộ password, token hash, credential, internal error hoặc field riêng tư.
- Database/storage side effects đúng; transaction rollback khi thất bại.
- Idempotency/duplicate behavior nếu có.
- Cleanup dữ liệu test.
- Regression test được lưu trong repository và chạy đạt.

## Trạng thái tổng

- Tổng REST operations: **112**
- Đã xác minh từ Prompt 2C: **5**
- Gate hiện tại: **G00**
- Trạng thái chung: **IN_PROGRESS**
- Kết quả cuối mong muốn: **BACKEND_FULL_RUNTIME_READY**

---

## G00 — Baseline và môi trường test

**Status:** `IN_PROGRESS`  
**Depends on:** Không có  
**Unlocks:** G01

- [ ] Xác nhận test DB/Redis riêng, không phải production.
- [ ] Xác nhận schema/migration test database phù hợp.
- [ ] Tạo fixture/factory: admin, active user A, active user B, inactive user, outsider.
- [ ] Tạo helper đăng nhập, token, cleanup theo test-run ID.
- [ ] Chạy build, lint, OpenAPI generate/validate/coverage.
- [ ] Ghi baseline 93 paths, 112 operations và schema count hiện tại.
- [ ] Xác nhận global validation pipe và exception filter chạy trong E2E app.
- [ ] Tạo report `docs/runtime-readiness/G00-baseline.md`.

**Exit criteria:** môi trường test chạy lặp lại được, không chạm dữ liệu production, baseline xanh.  
**Completed at:** —  
**Evidence:** —

---

## G01 — Auth và vòng đời token (11 APIs)

**Status:** `BLOCKED_BY_G00`  
**Depends on:** G00  
**Unlocks:** G02

- [ ] `POST /auth/register`
- [x] `POST /auth/login` — đã đạt Prompt 2C
- [ ] `GET /auth/google-login`
- [ ] `GET /auth/google/callback`
- [x] `POST /auth/refresh` — đã đạt Prompt 2C
- [ ] `POST /auth/logout-one`
- [ ] `POST /auth/logout-all`
- [ ] `POST /auth/verify-email`
- [ ] `POST /auth/send-password-reset-code`
- [ ] `POST /auth/reset-password`
- [ ] `POST /auth/change-password`

**Bắt buộc:** Google OAuth dùng guard/provider mock hoặc test environment kiểm soát được; không gọi tài khoản production. Kiểm tra enumeration, token rotation, revoke theo device/all devices, code hết hạn/sai và đổi mật khẩu làm mất hiệu lực session theo policy.

**Exit criteria:** 11/11 endpoint đạt; toàn bộ auth/token tests xanh.  
**Completed at:** —  
**Evidence:** `docs/runtime-readiness/G01-auth.md`

---

## G02 — Users và Device Tokens (8 APIs)

**Status:** `BLOCKED_BY_G01`  
**Depends on:** G01  
**Unlocks:** G03

- [ ] `POST /users/create` — xác nhận legacy/admin policy
- [ ] `GET /users`
- [x] `GET /users/me` — đã đạt Prompt 2C
- [ ] `GET /users/:id`
- [ ] `PATCH /users/update`
- [ ] `DELETE /users/delete`
- [ ] `POST /device-token`
- [ ] `DELETE /device-token/:id`

**Bắt buộc:** kiểm tra public/current-user response khác nhau, `visitedCount`, avatar ownership, soft delete, device token unique/ownership và không lộ email/phone/address ngoài policy.

**Exit criteria:** 8/8 endpoint đạt.  
**Completed at:** —  
**Evidence:** `docs/runtime-readiness/G02-users-devices.md`

---

## G03 — Uploads và Media (4 APIs)

**Status:** `BLOCKED_BY_G02`  
**Depends on:** G02  
**Unlocks:** G04

- [ ] `POST /uploads/presigns`
- [ ] `POST /uploads/complete`
- [ ] `GET /media/:id`
- [ ] `GET /media/own/:id`

**Bắt buộc:** dùng storage test/fake an toàn; kiểm tra MIME/folder/expiry, object tồn tại, objectKey ownership, idempotency, `deletedAt`, user khác và không ghi presigned URL vào report.

**Exit criteria:** 4/4 endpoint đạt; fixture media dùng được cho Places/Social/Memories.  
**Completed at:** —  
**Evidence:** `docs/runtime-readiness/G03-uploads-media.md`

---

## G04 — Trip Interests và dữ liệu nền (5 APIs)

**Status:** `BLOCKED_BY_G03`  
**Depends on:** G03  
**Unlocks:** G05

- [ ] `GET /trips/interests/all`
- [ ] `POST /trips/interests`
- [ ] `PATCH /trips/interests/:id`
- [ ] `DELETE /trips/interests/:id`
- [ ] `PUT /trips/interests/:tripId` — chạy sau khi tạo trip fixture trong chính gate hoặc fixture chuẩn

**Bắt buộc:** admin/non-admin, duplicate name, schema `icon` nếu có, unknown IDs và ảnh hưởng khi xóa interest đang được trip sử dụng.

**Exit criteria:** 5/5 endpoint đạt; interest fixture ổn định cho Trip.  
**Completed at:** —  
**Evidence:** `docs/runtime-readiness/G04-trip-interests.md`

---

## G05 — Places Admin và Place Core (11 APIs)

**Status:** `BLOCKED_BY_G04`  
**Depends on:** G04  
**Unlocks:** G06

### Admin

- [ ] `POST /places/admin/create`
- [ ] `GET /places/admin/pending`
- [ ] `PATCH /places/approve/:id`
- [ ] `PATCH /places/:id/reject`
- [ ] `DELETE /places/:id` — admin path/policy theo source

### User/Core

- [ ] `POST /places`
- [ ] `PATCH /places/:id`
- [ ] `GET /places`
- [ ] `GET /places/:id`
- [ ] `POST /places/search-embeddings`
- [ ] `DELETE /places/:placeId/gallery`

**Bắt buộc:** PENDING/APPROVED visibility, creator/admin permissions, media ownership, gallery partial failure, semantic search location trước vector rank, destination authorization và không trả place chưa duyệt cho user thường.

**Exit criteria:** 11/11 endpoint đạt; approved place fixture sẵn sàng cho Trip/Itinerary/Social.  
**Completed at:** —  
**Evidence:** `docs/runtime-readiness/G05-places.md`

---

## G06 — Trips Core và Membership (8 APIs)

**Status:** `BLOCKED_BY_G05`  
**Depends on:** G05  
**Unlocks:** G07

- [ ] `POST /trips/create`
- [x] `GET /trips` — đã đạt Prompt 2C
- [x] `GET /trips/:id` — đã đạt Prompt 2C
- [ ] `PATCH /trips/:id`
- [ ] `DELETE /trips/:id`
- [ ] `POST /trips/join/:inviteCode`
- [ ] `POST /trips/leave/:tripId`
- [ ] `POST /trips/kick/:tripId/:targetUserId`

**Bắt buộc:** destinations/date range, owner membership, capacity, status, visibility, private isolation, outsider, add/remove destination, recalculation, owner cannot violate invariant và `inviteCode` không xuất hiện ở list/detail.

**Exit criteria:** 8/8 endpoint đạt; reusable owner/member/outsider trip fixtures tồn tại.  
**Completed at:** —  
**Evidence:** `docs/runtime-readiness/G06-trips-core.md`

---

## G07 — Trip Invitations (4 APIs)

**Status:** `BLOCKED_BY_G06`  
**Depends on:** G06  
**Unlocks:** G08

- [ ] `POST /trip-invitations/invite`
- [ ] `GET /trip-invitations/invited`
- [ ] `POST /trip-invitations/accept/:invitationId`
- [ ] `POST /trip-invitations/reject/:invitationId`

**Bắt buộc:** owner-only invite, correct invitee, pending-only transitions, UPCOMING policy, duplicate invitation/membership, capacity và transaction atomicity.

**Exit criteria:** 4/4 endpoint đạt.  
**Completed at:** —  
**Evidence:** `docs/runtime-readiness/G07-trip-invitations.md`

---

## G08 — Itinerary và Check-in (9 APIs)

**Status:** `BLOCKED_BY_G07`  
**Depends on:** G07  
**Unlocks:** G09

- [ ] `GET /trips/:tripId/itineraries`
- [ ] `GET /trips/:tripId/itineraries/destinations/:destinationId`
- [ ] `POST /trips/:tripId/itineraries/days/:dayId/activities`
- [ ] `PATCH /trips/:tripId/itineraries/activities/:activityId`
- [ ] `POST /trips/:tripId/itineraries/activities/:activityId/checkin`
- [ ] `GET /trips/:tripId/itineraries/completion-status`
- [ ] `DELETE /trips/:tripId/itineraries/activities/:activityId/checkin`
- [ ] `DELETE /trips/:tripId/itineraries/activities/:activityId`
- [ ] `DELETE /trips/:tripId/itineraries/destinations/:destinationId`

**Bắt buộc:** chạy read/create/update/check-in/status/undo/delete theo đúng thứ tự; active member, owner mutations, day/destination/trip consistency, title fallback, unique place per trip, distance limit, duplicate check-in, memberId FK và không đổi place sau check-in.

**Exit criteria:** 9/9 endpoint đạt; data cleanup chạy theo thứ tự ngược.  
**Completed at:** —  
**Evidence:** `docs/runtime-readiness/G08-itinerary-checkin.md`

---

## G09 — Trip Memories, Messages, Timeline, Expense và Completion (7 APIs)

**Status:** `BLOCKED_BY_G08`  
**Depends on:** G08  
**Unlocks:** G10

- [ ] `POST /trips/memories/:tripId`
- [ ] `GET /trips/memories/:tripId`
- [ ] `GET /trips/:tripId/messages`
- [ ] `GET /trips/timeline/:tripId`
- [ ] `POST /trips/:tripId/expenses`
- [ ] `POST /trip-completetion/:tripId`
- [ ] `DELETE /trips/memories/:memoryId`

**Bắt buộc:** media ownership, cursor response, active membership, message limit validation, Decimal serialization, expense split invariants, >50% completion rule, one completion/user, points và delete ownership. Giữ nguyên typo route runtime nếu contract hiện tại vẫn dùng `trip-completetion`, chỉ ghi issue/versioning plan.

**Exit criteria:** 7/7 endpoint đạt. REST message/timeline chỉ kiểm tra read endpoints; socket ở G14.  
**Completed at:** —  
**Evidence:** `docs/runtime-readiness/G09-trip-extras.md`

---

## G10 — Saved Places và Place Reviews (11 APIs)

**Status:** `BLOCKED_BY_G09`  
**Depends on:** G09  
**Unlocks:** G11

### Saved Places

- [ ] `POST /places/:placeId/save`
- [ ] `GET /places/:placeId/save/status`
- [ ] `GET /places/saved/me`
- [ ] `GET /places/saved/count`
- [ ] `DELETE /places/:placeId/save`

### Reviews

- [ ] `POST /places/:placeId/reviews`
- [ ] `GET /places/:placeId/reviews`
- [ ] `GET /places/:placeId/reviews/me`
- [ ] `GET /places/:placeId/reviews/summary`
- [ ] `GET /places/reviews/:reviewId`
- [ ] `DELETE /places/reviews/:reviewId`

**Bắt buộc:** approved place, duplicate save/review, historical check-in requirement, author-only delete, rating 1..5, pagination, nullable `me`, summary distribution và aggregate rollback/recalculation.

**Exit criteria:** 11/11 endpoint đạt.  
**Completed at:** —  
**Evidence:** `docs/runtime-readiness/G10-saved-reviews.md`

---

## G11 — Social Posts, Comments, Likes và Shares (16 APIs)

**Status:** `BLOCKED_BY_G10`  
**Depends on:** G10  
**Unlocks:** G12

### Posts

- [ ] `POST /social/posts`
- [ ] `GET /social/posts/feed`
- [ ] `GET /social/posts/me`
- [ ] `GET /social/posts/place/:placeId`
- [ ] `GET /social/posts/:postId`
- [ ] `PATCH /social/posts/:postId`
- [ ] `DELETE /social/posts/:postId`

### Comments

- [ ] `POST /social/posts/:postId/comments`
- [ ] `GET /social/posts/:postId/comments`
- [ ] `DELETE /social/posts/comments/:commentId`

### Likes

- [ ] `POST /social/posts/:postId/like`
- [ ] `GET /social/posts/:postId/like/status`
- [ ] `DELETE /social/posts/:postId/like`

### Shares

- [ ] `POST /social/posts/:postId/share`
- [ ] `GET /social/posts/:postId/share/status`
- [ ] `DELETE /social/posts/:postId/share`

**Bắt buộc:** media ownership, approved place, PUBLIC/FOLLOWERS/PRIVATE visibility, owner/outsider access, soft delete, feed pagination, response shape variants, duplicate interactions, status endpoints phải kiểm tra post/access, author-only mutation và counter consistency.

**Exit criteria:** 16/16 endpoint đạt.  
**Completed at:** —  
**Evidence:** `docs/runtime-readiness/G11-social.md`

---

## G12 — Friends, Follow và Friend Conversations (15 APIs)

**Status:** `BLOCKED_BY_G11`  
**Depends on:** G11  
**Unlocks:** G13

### Friends

- [ ] `POST /friends/requests`
- [ ] `GET /friends/requests/received`
- [ ] `GET /friends/requests/sent`
- [ ] `POST /friends/requests/:requestId/accept`
- [ ] `POST /friends/requests/:requestId/reject`
- [ ] `DELETE /friends/requests/:requestId`
- [ ] `GET /friends`
- [ ] `GET /friends/:friendId/status`
- [ ] `DELETE /friends/:friendId`

### Friend conversations

- [ ] `POST /friends/:friendId/conversation`
- [ ] `GET /friends/conversations`
- [ ] `GET /friends/conversations/:conversationId/messages`

### Follow

- [ ] `POST /follow`
- [ ] `GET /follow/followers`
- [ ] `DELETE /follow`

**Bắt buộc:** self-request/follow, duplicate/opposite pending requests, correct sender/recipient, state transitions, friendship uniqueness, unfriend, participant-only conversations, message limit validation, stable public user IDs, pagination và không lộ private fields.

**Exit criteria:** 15/15 endpoint đạt.  
**Completed at:** —  
**Evidence:** `docs/runtime-readiness/G12-friends-follow.md`

---

## G13 — Ranking và Travel DNA (3 APIs)

**Status:** `BLOCKED_BY_G12`  
**Depends on:** G12  
**Unlocks:** G14

- [ ] `GET /ranking/leaderboard`
- [ ] `GET /ranking/me`
- [ ] `GET /travel-dna`

**Bắt buộc:** empty snapshot, top-1000 boundary, pagination validation, deterministic rank for snapshot, missing ranking, dominant/topBadges/all shape và dữ liệu phát sinh từ completion/check-in fixtures.

**Exit criteria:** 3/3 endpoint đạt. Tổng REST checklist phải là 112/112.  
**Completed at:** —  
**Evidence:** `docs/runtime-readiness/G13-ranking-dna.md`

---

## G14 — WebSocket runtime gate (ngoài 112 REST APIs)

**Status:** `BLOCKED_BY_G13`  
**Depends on:** G13  
**Unlocks:** G15

- [ ] Trip socket authentication hợp lệ/sai/hết hạn.
- [ ] `trip:join` active member và outsider.
- [ ] `trip:leave` và room cleanup.
- [ ] `trip:message:send` validation, persistence, broadcast, ack và error.
- [ ] `trip:timeline` chỉ tới đúng room.
- [ ] Friend namespace authentication.
- [ ] `friend:conversation:join` participant/outsider.
- [ ] `friend:message:send` persistence, broadcast, ack và validation.
- [ ] `friend:conversation:leave`.
- [ ] Disconnect/reconnect/rejoin behavior.

**Exit criteria:** socket tests đạt, không cross-room leak, contract cập nhật trong `docs/websocket-contract.md`.  
**Completed at:** —  
**Evidence:** `docs/runtime-readiness/G14-websocket.md`

---

## G15 — Full regression, contract và security gate

**Status:** `BLOCKED_BY_G14`  
**Depends on:** G14  
**Unlocks:** G16

- [ ] Full build đạt.
- [ ] Full ESLint đạt.
- [ ] Targeted formatter/diff check đạt; không format hàng loạt file ngoài scope.
- [ ] Full unit test đạt hoặc mọi failure được phân loại và không còn regression thật.
- [ ] Tất cả REST E2E suites đạt.
- [ ] WebSocket suites đạt.
- [ ] OpenAPI generate đạt.
- [ ] OpenAPI validate đạt.
- [ ] OpenAPI coverage vẫn 112/112.
- [ ] Runtime response validator đạt cho 112 operations phù hợp.
- [ ] Security matrix owner/member/admin/outsider đạt.
- [ ] Sensitive response scan đạt.
- [ ] Test cleanup verification đạt.
- [ ] `git diff --check` đạt.
- [ ] Không test bị `.skip`, `.only` hoặc assertion bị làm yếu trái phép.

**Exit criteria:** không còn P0/P1 hoặc runtime/OpenAPI mismatch chưa xử lý.  
**Completed at:** —  
**Evidence:** `docs/runtime-readiness/G15-full-regression.md`

---

## G16 — Đóng băng contract và bàn giao Flutter

**Status:** `BLOCKED_BY_G15`  
**Depends on:** G15

- [ ] Sinh `docs/backend-full-runtime-readiness.md`.
- [ ] Báo cáo đủ 112/112 REST operations và WebSocket gate.
- [ ] Sinh lại `contracts/openapi.json` lần cuối.
- [ ] Cập nhật `docs/flutter-integration.md` và `docs/mobile-api-scope.md`.
- [ ] Liệt kê mọi intentional exception/legacy route.
- [ ] Ghi contract version/commit SHA.
- [ ] Chuyển trạng thái tổng thành `BACKEND_FULL_RUNTIME_READY`.
- [ ] Mở khóa task `FULL_APP_TODO_AND_ORCHESTRATION_PLAN`.

**Exit criteria:** contract đã đóng băng và có checkpoint để Flutter/Stitch sử dụng.  
**Completed at:** —  
**Evidence:** `docs/backend-full-runtime-readiness.md`

---

## Cách checkpoint sau mỗi task

Sau khi một endpoint hoàn thành:

1. Đổi `[ ]` thành `[x]` trong file này.
2. Ghi test/evidence vào report của gate.
3. Cập nhật `runtime-test-state.json`:
   - `current_gate`
   - `current_endpoint`
   - `last_completed_endpoint`
   - `next_endpoint`
   - `completed_operations`
   - `changed_files`
   - `commands_run`
   - `blockers`
4. Chạy `git diff --check`.
5. Không chuyển gate khi exit criteria chưa đạt.

## Prompt tiếp tục sau khi hết token

```text
Đọc runtime-test-state.json và runtime-test-112-api-todo.md trước.
Kiểm tra git status và git diff. Tiếp tục đúng current_gate/current_endpoint
hoặc next_endpoint nếu endpoint trước đã có evidence hoàn thành.
Không chạy lại task đã đánh dấu DONE. Không chuyển sang gate kế tiếp nếu gate
hiện tại chưa đạt exit criteria. Sau mỗi endpoint, cập nhật checklist, state JSON
và report của gate. Không commit hoặc push.
```


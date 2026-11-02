# Production Readiness Audit — Trip, Place, Profile

Ngày kiểm toán: 2026-11-02  
Phạm vi: `travel-v1` (NestJS) và `travel_app` (Flutter) cho Trip, Place, Profile.  
Phương pháp: đọc source, đối chiếu OpenAPI và schema, chạy unit test có chọn lọc, gọi API local không xác thực. Không sửa code, migration hay dữ liệu.

Phân loại bằng chứng dùng trong báo cáo:

- **Đã xác nhận (source):** hành vi suy ra trực tiếp từ code đã đọc.
- **Đã xác nhận (chạy):** lệnh hoặc request đã thực thi trong phiên này.
- **Rủi ro:** lỗ hổng có cơ chế trong code, chưa đo được tác động runtime.
- **Chưa kiểm chứng:** không có request, test hoặc số đo tương ứng.

## 1. Executive Summary

Ba module chưa đủ điều kiện production. Kết luận: **NOT READY**.

Lý do chính không phải lỗi biên dịch. Backend đang chạy local và từ chối request không token, nhưng dữ liệu cá nhân của mọi user `ACTIVE` được trả cho bất kỳ user đã đăng nhập nào. Mã mời của trip public được trả trong API preview, trong khi chính mã đó vẫn dùng được để xin vào trip sau khi chuyển private. Tạo review bị bọc response hai lần nên client không parse được. Checklist runtime nội bộ mới hoàn thành 5/112 operation và đang dừng ở gate G00.

Những phần đã đứng được: JWT toàn cục, `ValidationPipe` chặn field lạ, trip private không lộ qua `GET /trips/:id`, sửa/xóa trip và sửa place kiểm tra chủ sở hữu, và phần lớn màn Trip/Place/Profile gọi API thật chứ không còn datamock lúc chạy.

## 2. Tổng quan kiến trúc thực tế

```text
Flutter (Riverpod + Dio)
  AuthInterceptor Bearer, refresh một lần, hết phiên thì về /login
        |
        v
NestJS  :3001
  JwtAuthGuard + RolesGuard (toàn cục)
  ValidationPipe whitelist + forbidNonWhitelisted
  ApiExceptionFilter
  Controller → DTO → Service → Policy (policy gọi trong service, không phải guard)
        |
        v
Prisma / Postgres (pgvector) + Redis + S3/media + Socket.IO
```

| Lớp | Vị trí thực tế |
|---|---|
| Trip HTTP | `travel-v1/src/module/trips/` — trips, itinerary, expense, join, invitation, timeline, memory, share, recruitment, interest |
| Place HTTP | `places/`, `saved-places/`, `reviews-places/`, `place-collections/` |
| Profile HTTP | Không có module Profile riêng. Bề mặt là `users/`, `follow/`, `travelDNA/`. Kỷ niệm và chuyến của tôi nằm ở trips |
| App | `travel_app/lib/features/trips`, `home/places`, `profile`, `travel-dna` |
| Hợp đồng | `travel-v1/contracts/openapi.json` |
| Schema | `travel-v1/prisma/schema.prisma` |

`src/main.ts` dòng 9–19 bật validation toàn cục và CORS `origin: '*'`. `src/app.module.ts` đăng ký `JwtAuthGuard` và `RolesGuard`. Guard vai trò cho qua nếu handler không gắn `@Roles()`.

`docker-compose.yml` chỉ chạy Postgres, Redis và Ollama. Không có service API. Postgres dùng user/password/db dạng literal (dòng 6–8). Redis publish cổng 6379 không mật khẩu (dòng 15–21).

`travel-v1/test-docs/runtime-test-state.json` ghi `status: IN_PROGRESS`, `current_gate: G00`, `completed_operations: 5` / `total_rest_operations: 112`. Năm operation được đánh dấu sẵn: login, refresh, `GET /users/me`, `GET /trips`, `GET /trips/:id`.

## 3. Kết quả audit từng module

### Trip

Luồng đọc private được chặn ở danh sách và chi tiết bằng `buildTripReadAccessWhere` (`trip-access.policy.ts` dòng 162–174): public và không draft, hoặc owner, hoặc member active. `authorizeOwner` trả 404 nếu trip không tồn tại và 403 nếu người gọi không phải owner (`trip-access.policy.ts` dòng 103–125). Sửa place chỉ khi `createdByUserId` khớp (`places.service.ts` dòng 253–255) — tách riêng ở mục Place.

Điểm gãy đã xác nhận trên source:

- `previewByTripId` gọi `previewJoin`, và object trả về luôn có `inviteCode` (`trip-join-requests.service.ts` dòng 165–169 và 214–228). Preview theo id chỉ cho trip `PUBLIC`. Join bằng mã không kiểm tra lại visibility (dòng 291–299; comment dòng 175–176 nói trip private vẫn join được bằng mã). Chi tiết trip thì giấu mã với người không phải owner. Hệ quả: user đã đăng nhập, biết id trip public, lấy được mã mời.
- `TripAccessPolicy.authorize` trả 404 khi trip không tồn tại và 403 khi trip tồn tại nhưng không có membership (`trip-access.policy.ts` dòng 90–96 và 141–146). `GET /trips/:id` thì gộp hai trường hợp thành 404. Expenses, itinerary, memories, timeline phân biệt được “id không có” và “id có nhưng bị cấm”.
- Chi phí `GET /trips/:tripId/expenses` không phân trang. Featured/explore của trip có quota route preview; join và preview không có rate limit toàn cục.

Client Trip gọi remote datasource, không chuyển sang datamock khi chạy. Nhiều hành động trên UI chỉ snackbar “sắp có”: lọc, chia sẻ, chuyển admin, QR join, máy tính chi phí. `PATCH /trips/:id` và `DELETE /trips/:id` có trên client datasource nhưng không có màn hình gọi `updateTripControllerProvider`.

### Place

Catalog public yêu cầu JWT và chỉ trả place `APPROVED` ở list/detail. Admin approve/reject/delete có `@Roles(ADMIN)` và service còn `ensureAdmin`. Collection private bị policy chặn; lỗi policy là `BadRequestException` nên HTTP 400 (`policies/policy.error.ts` dòng 16–24), kể cả `COLLECTION_FORBIDDEN`.

Điểm gãy đã xác nhận trên source:

- `findPublicMany` gán `vistedCount` bằng `placeVisit.count()` không `await` bên trong `map` đồng bộ (`places.service.ts` dòng 112–126). Detail thì có `await` (dòng 56–60). List vừa N+1 vừa trả Promise. `JSON.stringify` của Promise là `{}`. Promise reject sau đó là unhandled rejection. Response list chưa được bắt từ API đang chạy.
- List và detail load `coverImages` không lọc `GalleryStatus.ACTIVE` và không lọc `media.deletedAt` (`places.service.ts` dòng 40–50 và 92–101). Featured có lọc `ACTIVE` (`featured-places.service.ts` dòng 48–50). Ảnh hidden hoặc media đã xóa vẫn có thể thành URL public trên catalog.
- `POST /places/:placeId/reviews`: service trả `{ message, data: review }` (dòng 129–132), controller bọc lại `{ data, message }` (`review-places.controller.ts` dòng 55–60). App lấy `body['data']` rồi `PlaceReviewApi.fromJson`, cần `id` và `rating` ở tầng đó (`place_detail_remote_datasource.dart` dòng 84–97 và 132–140). Tầng `data` thực tế là `{ message, data }`, không có `id`. Tạo review trên app sẽ lỗi parse dù server đã ghi review. `PlaceReview` không có cột `updatedAt` (`schema.prisma` dòng 1224–1230). Factory list có fallback `updatedAt ?? createdAt` (`place_detail_models.dart` dòng 124–128), nên GET list có đường parse; POST create thì không.
- `GET /places/featured` `findMany` mọi place approved, không `take` (`featured-places.service.ts` dòng 30–55), rồi xếp hạng trong bộ nhớ.

`POST /places` cho mọi user đã đăng nhập, status mặc định `PENDING` (`places.controller.ts` dòng 169–174). Đó là hàng chờ duyệt, không phải công khai ngay. Chưa chạy thử luồng duyệt.

### Profile

Không có API đổi hồ sơ người khác: `PATCH /users/update` dùng id từ token (`users.controller.ts` dòng 146–151). `UpdateUserDto` bỏ `email` và `password` (`update-user.dto.ts` dòng 29–31). Không có `role` hay `status` trên DTO. Avatar update kiểm tra media thuộc user và đúng MIME (`users.service.ts` dòng 302–327).

Điểm gãy đã xác nhận trên source:

- `PUBLIC_USER_SELECT` gồm `email`, `phone`, `address`, `dateofBirth`, `gender`, `location`, `bio`, `budgetLevel`, `languages`, `interests`, `notificationEnabled` và relation `travelStyle` (`users.service.ts` dòng 14–31). `findAll`, `findOne` (`/users/me`) và `findOneById` (`/users/:id`) dùng select này. `travelStyle` là `UserTravelDNA[]` (`schema.prisma` dòng 222 và 334–345): type, score, số trip, số activity. Mọi user `ACTIVE` đã đăng nhập đọc được danh bạ này. Password, role, refresh token không nằm trong select.
- `POST /users/create` không có `@Roles` (`users.controller.ts` dòng 54–64). `create` ghi email nguyên văn, không gửi mail xác minh, không kiểm tra chủ `avatarId` (`users.service.ts` dòng 41–78). `status` mặc định `INACTIVE` nên account mới không qua `validateJwtPayload`. `auth.service` đăng ký và đăng nhập bằng `email.toLowerCase()`. Email unique phân biệt hoa thường. User đã đăng nhập có thể chiếm email/username viết thường trước khi nạn nhân đăng ký. Chưa chứng minh được đường kích hoạt account đó thành đăng nhập được.
- `UpdateUserDto.language` không có cột tương ứng (`update-user.dto.ts` dòng 40–42; schema có `languages`). `update` đưa cả DTO vào Prisma (`users.service.ts` dòng 271–274). `PrismaClientValidationError` không phải `PrismaClientKnownRequestError`, filter trả 500 generic (`api-exception.filter.ts` dòng 109–114). App edit profile gửi `languages`, không gửi `language`, nên màn sửa hồ sơ hiện tại không đụng field này. Client hoặc OpenAPI nào gửi `language` sẽ 500. Chưa bắn request thật.
- `FollowService.createFollow` tìm user `ACTIVE` nhưng không loại `deletedAt` (`follow.service.ts` dòng 18–25). `UsersService.remove` chỉ set `deletedAt` và giữ `ACTIVE` (dòng 278–283). User đã “xóa” vẫn follow được.
- App: QR, thẻ trip đang đi/sắp đi, bài viết trên profile là snackbar, không điều hướng. Settings ngoài thông báo đẩy và đăng xuất không gọi API. Xóa tài khoản là nút disabled. Version chữ cứng `Teal Horizon v1.4.2`.

Test `users.service.spec.ts` dòng 26–30 kỳ vọng `findOneById` không có `email`/`phone`, nhưng mock `findFirst` không trả hai field đó (dòng 6–12). Test xanh không chứng minh production select an toàn. Đã chạy: suite này nằm trong nhóm pass.

## 4. Kết quả audit Frontend

| Hạng mục | Kết quả | Bằng chứng |
|---|---|---|
| API thật hay mock | Remote datasource được inject khi chạy. Datamock là fixture | Explore provider, profile showcase `GET /users/me/showcase`, trip remote datasource |
| Auth | Bearer, refresh một lần, 401 lần hai thì hết phiên và redirect login | `auth_interceptor.dart`, `app_router.dart` |
| Phân quyền UI | Ẩn nút theo `viewer.role` / `canManageItinerary`. Router không chặn `/join-requests`, `/invite`, `/expenses` | `app_router.dart`, model chi tiết trip |
| Validation | Tên trip, điểm đến, ảnh bìa, chi phí, mã join 8 ký tự, hồ sơ display name/username/bio | Các controller/screen tương ứng |
| Nháp trip | “Lưu nháp” bỏ qua validate vì điều kiện `continueFlow &&` | `create_trip_details_screen.dart` dòng 71–85 |
| Lỗi phân trang trip | `loadMoreError` được lưu, `trip_screen.dart` chỉ đọc `isLoadingMore` | `trip_list_controller.dart` dòng 166–169; `trip_screen.dart` khoảng dòng 188 |
| Lời mời | `loadMore()` không có caller. `finally` không `catch`, lỗi sẽ để `isLoadingMore: true` | `trip_invitations_controller.dart` dòng 49–72 |
| Place detail | Save status, review của tôi, bài viết: lỗi không phải 401 thành “trống / chưa lưu” | `place_detail_repository.dart` dòng 95–131 |
| A11y | Place không có `Semantics`. Trip/profile có một phần | Grep `lib/features/home/places` |
| Responsive | Card ngang có chiều rộng cố định và ellipsis. Không có overflow đã đo trên thiết bị | Chưa kiểm chứng trên emulator |
| Test UI | Nhiều file widget/controller tồn tại. Phiên này không chạy `flutter test` | Mục 10 |

`brain/brain.md` lệch code: vẫn mô tả place detail hoặc showcase là datamock, trong khi datasource hiện tại gọi API.

## 5. Kết quả audit Backend

| Hạng mục | Kết quả |
|---|---|
| Controller mỏng | Handler trip/place/user ủy quyền service. Không thấy nghiệp vụ nặng trong controller đã đọc |
| DTO | Whitelist toàn cục. Lỗ hổng đã thấy: query `q` thô ở catalog đích, `language` không có cột, path id không parse UUID/cuid |
| Policy | Trip: ma trận vai trò trong `trip-access.policy.ts`. Place collection: `place-collection.policy.ts`, lỗi map thành 400 |
| Authn | JWT access, reload user mỗi request, từ chối không `ACTIVE` hoặc đã `deletedAt` | 
| Transaction | Có trên tạo/sửa/xóa trip, join approve, expense, memory batch, itinerary batch. Không thay thế được kiểm soát truy cập |
| Exception | Một filter. 5xx không trả message nội bộ. Prisma `P2002/P2025/P2003` được map. Đã xác nhận bằng unit test filter |
| OpenAPI | Route trip đã xác thực khớp contract ở mức method/path đã rà. `GET /s/:token` và well-known bị `@ApiExcludeController`. Admin interest/place chỉ là bearer trong contract, code còn `@Roles(ADMIN)`. Review envelope và `PlaceResponseDto.status` không khớp body thực |
| Rate limit | `@nestjs/throttler` có trong `package.json`, không có `ThrottlerModule` trong `src`. Helmet không có |
| Sẵn sàng runtime | 5/112, gate G00 |

Unit test đã chạy (2026-11-02), thư mục `travel-v1`:

```text
npx jest --testPathPatterns="users.service.spec|places.service.spec|trip-join-requests.service.spec|api-exception.filter.spec" --forceExit
```

Kết quả: 8 suites (pattern còn khớp `review-places.service.spec`), 6 pass, 2 fail; 48 tests, 46 pass, 2 fail.

Fail đã xác nhận:

- `places.service.spec.ts`: `findPublicById` gọi `prisma.placeVisit.count` nhưng mock không có `placeVisit`. Test lệch code hiện tại.
- `reviews-places/review-places.service.spec.ts` dòng 8: `ReviewPlacesService is not defined`. Spec scaffold không import service.

`api-exception.filter.spec.ts` pass, gồm case không trả chuỗi lỗi nội bộ ra client. `trip-join-requests.service.spec.ts` pass; spec preview private không assert rằng preview public phải bỏ `inviteCode`.

E2E `flutter-mvp` và finalize không chạy. Cả hai từ chối database không đúng tên test. Chạy nhầm vào DB dev sẽ đụng dữ liệu.

API local `http://localhost:3001` (không gửi token):

| Request | Status |
|---|---|
| `GET /api/docs` | 200 |
| `GET /trips/interests/all` | 200 |
| `GET /trips`, `/places`, `/users`, `/users/me`, `/place-collections/featured`, `/travel-dna` | 401 |

`GET /trips/interests/all` public là cố ý (`@Public()` trên interest controller). Không đo thời gian, không gọi endpoint ghi.

## 6. Kết quả Integration

| Luồng | Trạng thái | Ghi chú |
|---|---|---|
| UI → API không token | Đã xác nhận 401 trên các route lõi | Bảng trên |
| Đăng nhập → đọc trip/place/profile | Chưa kiểm chứng đa tài khoản | Không dùng credential dev để tránh đụng dữ liệu |
| Tạo review UI → API | Đã xác nhận gãy ở parse | Server bọc đôi, client đọc `data.id` |
| List place → `vistedCount` | Đã xác nhận source, chưa bắt body | Promise không await |
| Sửa hồ sơ UI → `languages` | Khớp DTO `languages` | Field `language` là bẫy cho client khác |
| Draft trip thiếu tên | Client cho lưu | Chưa gọi `POST /trips/drafts` |
| Trip private của user khác | Source trả 404 ở detail | E2E có assertion trong `flutter-mvp.e2e-spec.ts` nhưng suite không chạy ở phiên này |
| IDOR sửa trip / sửa place | Source chặn owner | Chưa replay bằng hai token |
| Mạng lỗi / request lặp | Một số màn có cờ `_submitting` / `isBusy`. Unsave trong save sheet không kiểm tra `_saving` trước khi chạy | Chưa thử đứt mạng trên thiết bị |
| CRUD trip đầy đủ | Create draft và nhiều nhánh con có UI. Update/delete trip không có màn | Không có E2E CRUD |
| CRUD place | User tạo place `PENDING`. App explore chỉ đọc catalog đã duyệt, save, review, collection | Không có E2E place |
| CRUD profile | Đọc `/users/me`, sửa field cho phép, avatar qua media rồi patch. Xóa account không nối `DELETE /users/delete` | Settings còn local state |

## 7. Security Findings

| ID | Mức | Phát hiện | Bằng chứng | Loại |
|---|---|---|---|---|
| S1 | Critical | Danh bạ user lộ email, phone, địa chỉ, ngày sinh và điểm Travel DNA | `PUBLIC_USER_SELECT`; `GET /users`, `GET /users/:id` | Đã xác nhận source. Chưa bắt body live |
| S2 | High | Preview trip public trả `inviteCode`; mã vẫn join được trip private | `previewJoin` dòng 214–228; `createJoinRequest` dòng 291–299 | Đã xác nhận source |
| S3 | High | Mọi user đã đăng nhập tạo được account, email không chuẩn hóa, avatar không kiểm tra chủ | `POST /users/create` | Đã xác nhận source. Khai thác đăng nhập chưa chứng minh vì status `INACTIVE` |
| S4 | Medium | Oracle tồn tại trip: 403 thay vì 404 trên route cần membership | `TripAccessPolicy.authorize` | Đã xác nhận source. Cuid không dễ dò |
| S5 | Medium | Collection cấm truy cập trả 400, phân biệt id không tồn tại (404) và id private | `PlacePolicyError` | Đã xác nhận source |
| S6 | Medium | Follow user đã soft-delete | `follow.service.ts` dòng 18–25; `remove` dòng 278–283 | Đã xác nhận source |
| S7 | Medium | Không Helmet, không throttle HTTP, CORS `*` | `main.ts`; không có `Throttler` trong `src` | Đã xác nhận source. Bearer không phải cookie, nên CORS `*` không tự lấy token |
| S8 | Medium | Secret DB commit trong Compose; Redis không auth, cổng public | `docker-compose.yml` dòng 6–8 và 15–21 | Đã xác nhận file. Không ghi lại giá trị mật khẩu |
| S9 | Medium | Advisory dependency production | `npm audit --omit=dev` trong `travel-v1`: 1 critical, 10 high, 3 moderate, tổng 14. Critical: `proxy-addr` (GHSA-jqcg-44mw-7w3h, spoof IP qua IPv4-mapped IPv6). High gồm `multer` kéo từ `@nestjs/platform-express` | Đã xác nhận advisory. Chưa chứng minh exploit trên cấu hình deploy |
| S10 | Low / rủi ro | Mã mời 8 ký tự, join không throttle | `invite-code` và không có guard throttle | Rủi ro, không brute-force trong audit |
| S11 | Giữ được trên source | Không mass-assign `role`, `password`, `ownerId` nhờ whitelist và DTO. Sửa trip/place theo chủ. Gallery xóa theo chủ media. Review xóa theo tác giả | Các service đã đọc | Chưa replay live |

`users.service.spec.ts` không bắt được S1. Coi test đó là không có giá trị hồi quy cho PII.

## 8. Performance Findings

Không có số đo latency. Không bắn tải đồng thời. Các kết luận dưới đây là từ hình dạng query.

| ID | Mức | Phát hiện | Bằng chứng |
|---|---|---|---|
| P1 | High | Visit count list là N+1 và không await | `places.service.ts` dòng 112–126 |
| P2 | Medium | Featured place tải mọi place approved vào bộ nhớ | `featured-places.service.ts` dòng 30–55 |
| P3 | Medium | Ảnh gallery detail không `take` | `findPublicById` include `coverImages` |
| P4 | Medium | Expenses của trip không phân trang | Service expense, đã rà route |
| P5 | Medium | App saved places đi hết trang, tối đa 50 lần × 100, trước khi vẽ list | `saved_places_controller.dart` |
| P6 | Rủi ro | Vòng `await` có giới hạn trong transaction: memory batch, itinerary batch, notify reviewer | Không đo thời gian khóa |
| P7 | Chưa kiểm chứng | Thời gian phản hồi, index thực tế, pool, concurrent finalize trên DB dev | E2E finalize có case song song nhưng không chạy |

List trip dùng query đếm theo lô, không phải N+1 từng dòng. Điều đó không được đo lại trên Postgres.

## 9. Danh sách Bug và mức độ nghiêm trọng

| ID | Mức | Module | Mô tả | Trạng thái |
|---|---|---|---|---|
| B1 | Critical | Profile | `GET /users` và `GET /users/:id` trả PII và Travel DNA | Source |
| B2 | High | Trip | Preview theo trip id lộ `inviteCode` | Source |
| B3 | High | Profile | `POST /users/create` mở cho mọi JWT, lệch luồng đăng ký | Source |
| B4 | High | Place | Tạo review bọc response hai lần, app không parse | Source, hai phía |
| B5 | High | Place | `vistedCount` list là Promise không await | Source. Live body chưa bắt |
| B6 | High | Place | Catalog list/detail phát URL ảnh hidden hoặc media đã xóa | Source. Chưa có hàng hidden để đối chiếu |
| B7 | High | Profile | `language` trên update làm Prisma validation → 500 | Source. Request chưa bắn. App hiện không gửi field này |
| B8 | Medium | Trip | 403/404 lộ sự tồn tại của trip | Source |
| B9 | Medium | Place | Cấm collection trả 400 | Source |
| B10 | Medium | Profile | Follow user đã xóa mềm | Source |
| B11 | Medium | Trip UI | Lưu nháp bỏ qua validate tên, điểm đến, ảnh bìa | Source |
| B12 | Medium | Trip UI | Lỗi “xem thêm” không hiện | Source |
| B13 | Medium | Trip UI | Không tải trang 2 lời mời; lỗi `loadMore` kẹt loading | Source |
| B14 | Medium | Place UI | Lỗi phụ trên detail bị nuốt thành trạng thái trống | Source |
| B15 | Medium | Profile UI | Trip, bài viết, QR, phần lớn settings chưa nối | Source |
| B16 | Medium | Backend | Unit test place và review service đang fail; test PII user cho kết quả giả | Đã chạy |
| B17 | Medium | Ops | Runtime checklist 5/112, gate G00 | File state |
| B18 | Medium | Ops | Compose lộ credential DB, Redis không mật khẩu, không Helmet/throttle | Source |
| B19 | Medium | Supply chain | 14 advisory production, 1 critical `proxy-addr` | `npm audit` |
| B20 | Low | Contract | OpenAPI không ghi role admin; DTO place/review lệch body | Đối chiếu contract |
| B21 | Low | Trip UI | Share, chuyển admin, QR, calculator là stub | Source |
| B22 | Low | Profile UI | Version cứng; xóa tài khoản disabled dù API delete tồn tại | Source |

## 10. Những hạng mục chưa được kiểm chứng

| Hạng mục | Lý do | Nhãn |
|---|---|---|
| Hai tài khoản: đọc/sửa trip, expense, itinerary, memory của nhau | Không đăng nhập audit, tránh ghi dữ liệu dev | NOT TESTED live. Source của các route member đã đọc |
| Body thật của S1, B5, B6 | Cần token và dữ liệu có gallery hidden | NOT TESTED |
| `POST` có `language`, tạo user, preview invite | Request ghi hoặc cần dữ liệu người dùng | NOT TESTED |
| E2E `flutter-mvp`, finalize integration | Cần database tên `travel_mvp_test_` / `travel_finalize_test_` | BLOCKED đối với DB dev. NOT TESTED |
| `flutter test` / `flutter analyze` | Emulator đang `flutter run`; không chạy suite song song | NOT TESTED |
| Toàn bộ Jest `src/**/*.spec.ts` | Chỉ chạy pattern ở mục 5 | NOT TESTED ngoài pattern |
| Accessibility và responsive trên máy | Không thao tác emulator | NOT TESTED |
| Latency, tải đồng thời, hồi phục sau mất mạng | Không có bài đo | NOT TESTED |
| Exploit `proxy-addr` / multer | Chỉ có advisory | NOT TESTED |
| Audit dependency Flutter | Không chạy `dart pub outdated` | NOT TESTED |
| Đồng bộ OpenAPI bằng script `openapi:coverage` | Không chạy | NOT TESTED. Rà tay các route lõi |
| Web E2E | App đang chạy Android emulator, không phải web | NOT TESTED |

Không có mục nào ở bảng này được tính là PASS.

## 11. Đề xuất thứ tự khắc phục

1. **Chặn lộ dữ liệu người dùng.** Tách select của `/users/me` và select công khai. Bỏ email, phone, địa chỉ, ngày sinh, `notificationEnabled` và relation `travelStyle` khỏi `GET /users` và `GET /users/:id`. Sửa test để assert đúng select production, không assert trên mock đã cắt field.
2. **Thu hồi mã mời khỏi preview theo trip id.** Giữ join bằng mã cho người đang cầm mã. Sau khi sửa, mã cũ đã lọt ra ngoài cần rotate. Thêm giới hạn tần suất cho preview và join.
3. **Đóng `POST /users/create` với user thường** hoặc đưa về luồng `auth.register` (email thường, xác minh, không nhận `avatarId` của người khác).
4. **Sửa envelope tạo review** để `data` là review, khớp `PlaceReviewApi`. Thêm test contract cho POST và GET.
5. **Await và gộp `placeVisit` theo trang; lọc gallery `ACTIVE` và media chưa xóa; giới hạn số ảnh.**
6. **Xóa hoặc map `language`.** Không đưa field lạ vào `prisma.user.update`.
7. **Collection forbidden trả 403**, cùng mã với trip không tồn tại nếu muốn tránh oracle.
8. **Follow và đọc profile phải loại `deletedAt`.**
9. **Client:** validate cả nháp; hiện `loadMoreError`; gọi phân trang lời mời; đừng nuốt lỗi place detail; nối hoặc gỡ stub profile/settings.
10. **Chạy lại E2E trên database test**, mở gate sau G00, bắt buộc case hai user cho trip private và place. Sửa hai spec đang fail trước khi coi unit test là tín hiệu.
11. **Helmet, throttle, CORS theo origin, bỏ secret khỏi Compose, Redis có mật khẩu, nâng dependency theo audit** sau khi có bản vá tương thích Nest 11.

## 12. Production Readiness Verdict

**NOT READY**

Trip, Place và Profile chưa triển khai production trong phạm vi đã xem. Có lỗi lộ dữ liệu cá nhân (Critical) và lỗi chức năng đã xác nhận trên source (mã mời, tạo review, visit count). Kiểm thử tự động hiện có không khóa các lỗi đó: test PII thì giả xanh, hai spec place/review thì fail, runtime checklist dừng ở 5/112. Các hạng mục live đa tài khoản và hiệu năng chưa chạy, và chính vì vậy cũng không có cơ sở để nâng verdict lên READY hoặc READY WITH CONDITIONS.

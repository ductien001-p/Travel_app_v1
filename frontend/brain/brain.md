# Travel App — Project Brain

> Bản đồ trạng thái & kiến trúc của Flutter app `frontend` (package `travel_frontend_v1`).
> Cập nhật lần cuối: **2026-11-14** — Achivement UX: tier luôn hiện + badge Nhiệm vụ trên trip card; `/ranking/me` upsert UserRanking; Ranking phase 2.
> Code trong repo luôn là nguồn sự thật. Khi thêm/sửa feature, cập nhật lại mục **2 (Trạng thái)** và **9 (Chất lượng)**.

---

## 1. Tổng quan

- App mạng xã hội du lịch "Travel Social": đăng nhập, quản lý & tạo chuyến đi (trip), lịch trình, hồ sơ cá nhân.
- Backend: `../backend` (NestJS) — **chưa hoàn thành**. Hợp đồng API hiện có: `backend/contracts/openapi.json`. Chỉ sửa backend khi được yêu cầu rõ ràng.
- Màn hình mới: endpoint có trong `openapi.json` thì dùng thật; chưa có thì dùng datamock + API tên demo, đánh dấu `// TODO(backend):` (theo `.cursor/rules/architecture.mdc`).
- Base URL lấy từ `AppConfig.apiBaseUrl` (`--dart-define API_BASE_URL`, mặc định `http://localhost:3001`).
- Socket.IO URL lấy từ `AppConfig.socketUrl` (`--dart-define SOCKET_URL`, mặc định `http://localhost:3002`) — gateway phòng trip (`TripGateway`).
- Lệnh chạy: `flutter run --dart-define-from-file=lib/core/config/dev.json`

### Tech stack (pubspec.yaml)

| Nhóm | Package |
|---|---|
| SDK | Dart `^3.11.4` |
| State management | `flutter_riverpod ^3.3.2` — `Provider`, `FutureProvider`, `Notifier`, `AsyncNotifier`, `.family`, `.autoDispose` (viết tay, **không** dùng riverpod codegen) |
| Routing | `go_router ^17.5.0` — `StatefulShellRoute.indexedStack`, `redirect` theo auth |
| HTTP | `dio ^5.11.1` — interceptor auth + refresh token |
| Realtime | `socket_io_client ^3.1.6` — join/leave phòng trip, đẩy sự kiện timeline |
| Storage | `flutter_secure_storage` (token), `shared_preferences` (draft local) |
| Firebase | `firebase_core`, `firebase_messaging`, `firebase_app_installations` |
| Auth | `google_sign_in` |
| Map / vị trí | `google_maps_flutter`, `geolocator`, `timezone` |
| Chia sẻ / deep link | `share_plus` (share sheet hệ thống), `app_links` (Android App Links / iOS Universal Links) |
| Media | `image_picker`, `mime` (upload qua presigned URL Cloudflare R2) |
| Khác | `uuid` |
| Font | Plus Jakarta Sans (400–800) trong `assets/fonts/` |

---

## 2. Trạng thái dự án (tóm tắt)

| Feature | Trạng thái | Ghi chú |
|---|---|---|
| Hạ tầng core (network, auth interceptor, refresh token, theme, shared widgets, router) | ✅ Hoàn thành | Dùng chung cho mọi feature |
| Realtime Socket.IO (`core/realtime/`, `tripSocketClientProvider`, `friendSocketClientProvider`) | ✅ Hoàn thành | Trip room + namespace `/friends`; URL `SOCKET_URL` |
| Auth (login email/Google, register, verify email, forgot/reset password, logout, restore session) | ✅ Hoàn thành | Nối API thật |
| Device token (FCM) | ✅ Hoàn thành | Tự đăng ký sau login/restore, hủy khi logout |
| Media upload (presign → R2 → complete) | ✅ Hoàn thành | Avatar, ảnh bìa trip khi tạo, album kỷ niệm |
| Profile (xem, sửa, đổi avatar, Travel DNA, khoảnh khắc) | ✅ UI mới | Danh tính từ `GET /users/me`; hạng và chuyến đi trên hồ sơ từ showcase; radar DNA chi tiết dùng `GET /travel-dna`; thư viện ảnh hồ sơ dùng `GET /trips/memories/mine` |
| Settings | 🟡 Một phần | Đăng xuất, thông báo đẩy (`notificationEnabled`), đổi mật khẩu (`POST /auth/change-password`), xóa tài khoản. Sinh trắc học, thiết bị, ngôn ngữ, tiền tệ vẫn cục bộ |
| Trips — dashboard / danh sách / lời mời (invite) | ✅ Hoàn thành | Nối API thật, có phân trang |
| Trips — flow tạo chuyến đi (5 bước + chọn ảnh bìa) | ✅ Hoàn thành | Nối API thật; `TripCoverController` upload cover trước khi save draft |
| Trips — chi tiết chuyến đi & thành viên | ✅ API thật `GET /trips/{id}` | `features/trips/trip-details/` — xem mục 4.8 |
| Trips — lịch trình chi tiết (xem theo ngày, check-in, sửa/xóa hoạt động, đường đi thật, bản đồ, chia sẻ link + deep link) | ✅ API thật | `features/trips/trip-details/` — xem mục 4.9 |
| Trips — dòng thời gian chuyến đi | ✅ API thật + live socket | `features/trips/trip-timeline/` — xem mục 4.11 |
| Trips — album kỷ niệm (xem theo ngày, lọc, đăng nhiều ảnh, xem toàn màn hình, xóa) | ✅ API thật | `features/trips/trip-memories/` — xem mục 4.10 |
| Trips — duyệt yêu cầu tham gia (join requests) | ✅ API thật | `features/trips/trip-invitation/` — xem mục 4.12; vào từ pill "Yêu cầu" (owner/admin) |
| Trips — gửi yêu cầu join bằng mã mời (phía người xin vào) | ✅ API thật | `features/trips/trip-invitation/` — xem mục 4.13; `GET`+`POST /trips/join/{inviteCode}` |
| Trips — mời bạn đồng hành từ chi tiết chuyến đi | ✅ API thật | `features/trips/trip-invitation/` — xem mục 4.19; pill "Mời bạn" (owner) |
| Trips — chi tiêu & quỹ nhóm (xem, thêm khoản chi full screen, tất toán theo vai trò, xem hóa đơn) | ✅ API thật | `features/trips/trip-expenses/` — xem mục 4.14–4.15; `GET/POST /trips/{id}/expenses` + settle; icon hóa đơn mở `receipts[]` |
| Trips — tin nhắn nhóm trong 1 trip | 🟢 API + socket | `GET /trips/{id}/chat/thread`, gửi TEXT/IMAGE, reaction, `trip:message` dạng UI |
| Home / Explore — Chuyến Đi Cộng Đồng | 🟢 discover API | `features/home/` — xem mục 4.16; tab Địa Điểm gọi API places |
| Home — chuyến đi theo điểm đến | 🟢 discover + catalog | `features/home/destination_trips/` — xem mục 4.18; thẻ điểm đến trên Explore mở màn này |
| Social — Bảng tin cộng đồng | 🟢 API thật | `features/social/` — mục 4.27; `GET /social/feed` + like/save |
| Social — Chi tiết bài viết & bình luận | 🟢 API thật | `features/social/social-details/` — mục 4.28; `GET /social/posts/:id` + comments |
| Friends — Hub bạn bè & lời mời | ✅ API enrich | `features/friends/` — mục 4.30; Social friends icon → `/social/friends` |
| Friends — Tìm kiếm bạn bè & đồng hành | ✅ API | `features/friends/` — mục 4.29; Social search → `/social/find-friends` |
| Social / Tin nhắn (Messages Hub) | 🟢 API thật | `features/chats/` — `GET /chats/hub`; tab Chat mở hub |
| Chats — 1-on-1 friend chat | 🟢 API + socket | `features/chats/friend-chat/` — thread, TEXT, `TRIP_INVITE`, namespace `/friends` |
| Chats — trip group chat | 🟢 API + socket | `features/chats/trip-chats/` — thread, TEXT/IMAGE, reaction |
| Place detail | ✅ API thật | `features/home/places/place-details/` — mục 4.23 |
| Public Images — xem ảnh toàn màn hình + menu 3 chấm + bản đồ vệ tinh | 🟢 media đã seed | `features/public-images/` — mở từ post/kỷ niệm; không gọi album giả; ẩn bìa/like/xóa/bình luận/tải HD |
| Ranking — Bảng xếp hạng & gamification | 🟢 Phase 2 + tier | `features/ranking/` — mục 4.32; embed Travel Tier/Achievements từ `achivement` |
| Achivement — Nhiệm vụ trip / thưởng / hạng du lịch | 🟢 API thật | `features/achivement/` — mục 4.33; missions trên trip detail, sheet claim, tier trên Ranking |

Chú thích: ✅ chạy end-to-end với backend · 🟡 có UI nhưng thiếu logic · 🟠 có tầng data/logic nhưng chưa có UI · 🔴 chưa làm/placeholder.

---

## 3. Màn hình & route

Router: `lib/app/router/app_router.dart` (`routerProvider`), tên route: `lib/app/router/router_names.dart`.

| Path | RouteName | Màn hình | Trạng thái |
|---|---|---|---|
| `/splash` | `splash` | Scaffold + `CircularProgressIndicator` (inline trong router) | ✅ |
| `/login` | `login` | `LoginScreen` | ✅ |
| `/register` | `register` | `RegisterScreen` | ✅ |
| `/forgot-password` | `forgotPassword` | `ForgotPasswordScreen` | ✅ |
| `/verify-email?email=` | `verifyEmail` | `VerifyEmailScreen` | ✅ |
| `/reset-password?email=` | `resetPassword` | `ResetPasswordScreen` | ✅ |
| `/home` (tab 1) | `home` | `HomeScreen` (Khám Phá – Chuyến Đi Cộng Đồng) | 🟢 discover API |
| `/home/destination?city=` | `destinationTrips` | `DestinationTripsScreen` (root navigator; từ thẻ điểm đến Explore) | 🟢 discover + catalog |
| `/home/featured` | `featuredDestinations` | `FeaturedDestinationsScreen` (root navigator; từ “Xem tất cả” mục điểm đến nổi bật) | 🟢 `GET /places/featured`, `POST /places/search-embeddings` |
| `/home/places/:placeId` | `placeDetail` | `PlaceDetailScreen` (root navigator) | 🟢 chi tiết, đánh giá, bài viết, lưu |
| `/trips` (tab 2) | `trips` | `TripScreen` | ✅ |
| `/trips/:tripId` | `tripDetail` | `TripDetailScreen` (root navigator, che bottom nav) | ✅ |
| `/trips/:tripId/itinerary` | `tripItinerary` | `TripItineraryScreen` (root navigator) | ✅ |
| `/trips/:tripId/itinerary/map?dayId=` | `tripItineraryMap` | `TripItineraryMapScreen` (root navigator) | ✅ |
| `/trips/:tripId/timeline` | `tripTimeline` | `TripTimelineScreen` (root navigator) | ✅ |
| `/trips/:tripId/memories?post=1&userId=` | `tripMemories` | `TripMemoriesScreen` (root navigator; `post=1` mở trình chọn ảnh ngay, `userId` lọc sẵn theo người chụp); ảnh toàn màn hình `TripMemoryViewerScreen` mở bằng `Navigator.push` | ✅ |
| `/trips/:tripId/join-requests` | `tripJoinRequests` | `TripJoinRequestsScreen` (root navigator; chỉ owner/admin) | ✅ |
| `/trips/:tripId/expenses` | `tripExpenses` | `TripExpensesScreen` (root navigator; từ bottom bar trip detail) | ✅ |
| `/trips/:tripId/expenses/add` | `tripAddExpense` | `TripAddExpenseScreen` (root navigator; từ CTA Thêm khoản chi) | ✅ |
| `/trips/join` | `tripJoinByCode` | `TripJoinByCodeScreen` (root navigator; nhập mã mời → gửi yêu cầu) | ✅ |
| `/shared/:token` | `sharedItinerary` | `SharedItineraryScreen` (root navigator, cần đăng nhập, chỉ xem) | ✅ |
| `/social` (tab Social) | `social` | `SocialScreen` (Bảng Tin) | 🟢 API feed |
| `/social/friends` | `friendsHub` | `FriendsHubScreen` (nhánh Social, còn bottom nav; từ icon bạn bè) | ✅ enrich `/friends` + requests |
| `/social/find-friends` | `findFriends` | `FindFriendsScreen` (nhánh Social, còn bottom nav; từ icon tìm kiếm / hub) | ✅ `/friends/find` + nearby |
| `/social/ranking` | `ranking` | `RankingScreen` (nhánh Social, còn bottom nav; Bảng Xếp Hạng) | 🟢 period + quests + `/ranking/leaderboard|me|quests` |
| `/social/posts/:postId` | `postDetail` | `SocialPostDetailScreen` (`social-details/`; `?focus=comments` cuộn tới bình luận) | 🟢 API post + comments |
| `/images/:albumId?index=&imageId=` | `publicImageViewer` | `PublicImageViewerScreen` (root navigator; fullscreen viewer + sheet tùy chọn) | 🟢 album seed; không fallback datamock |
| `/images/:albumId/map?imageId=` | `publicImageMap` | `PublicImageMapScreen` (root navigator; bản đồ vệ tinh vị trí ảnh) | 🟢 tọa độ ảnh đã seed |
| `/notifications` | `notifications` | `NotificationsScreen` (root navigator) | 🟢 `GET/POST /notifications` |
| `/chats` (tab Chat) | `chats` | `ChatsHubScreen` | 🟢 `GET /chats/hub` |
| `/chats/friend/:conversationId` | `friendChat` | `FriendChatScreen` (root navigator) | 🟢 thread + socket `/friends` |
| `/chats/trip/:tripId` | `tripChat` | `TripChatScreen` (root navigator) | 🟢 thread + `trip:message` |
| `/profile` (tab 4) | `profile` | `ProfileScreen` | ✅ |
| `/profile/edit` | `editProfile` | `EditProfileScreen` | ✅ |
| `/profile/memories` | `userMemories` | `UserMemoriesScreen` (trong nhánh Profile, còn bottom nav; từ dải Khoảnh Khắc Hành Trình) | ✅ |
| `/profile/saved-places` | `savedPlaces` | `SavedPlacesScreen` (trong nhánh Profile, còn bottom nav; từ tab Đã lưu) | ✅ |
| `/profile/travel-dna` | `travelDnaRadar` | `TravelDnaRadarScreen` (trong nhánh Profile, còn bottom nav) | ✅ |
| `/profile/travel-dna/companions` | `travelDnaCompanions` | `TravelDnaCompanionsScreen` (danh sách bạn ≥ 70% độ hợp DNA, chỉ xem) | ✅ |
| `/trips/create` | `createTrip` | `CreateTripDetailsScreen` | ✅ |
| `/trips/create/add-destination` | `addTripDestination` | `AddDestinationScreen` (nhận `AddDestinationRouteData` qua `extra`) | ✅ |
| `/trips/create/:tripId/itinerary` | `createTripItinerary` | `CreateTripItineraryScreen` | ✅ |
| `/trips/create/:tripId/itinerary/activity/new` | `addItineraryActivity` | `AddItineraryActivityScreen` (nhận `AddItineraryActivityArgs` qua `extra`, có màn fallback khi args sai) | ✅ |
| `/trips/create/:tripId/confirm` | `createTripConfirmation` | `CreateTripConfirmationScreen` | ✅ |
| `/trips/publish/manage/:tripId` | `publishTripManage` | `PublishTripManageScreen` (root navigator) | ✅ |

Ghi chú điều hướng:
- `SettingScreen` **không có route** — được mở bằng `Navigator.push(MaterialPageRoute)` từ `ProfileScreen`.
- Redirect (`appAuthRedirect` trong `app_router.dart`): đang load auth → `/splash`; lỗi auth/chưa đăng nhập → `/login`; đã đăng nhập mà ở trang auth/splash → `/home`. Router `refresh()` mỗi khi `authControllerProvider` đổi.
- Khi bị đẩy về splash/login từ một trang sâu (vd. deep link `/shared/:token`), đích được giữ trong `?from=` và quay lại sau khi đăng nhập. `safeReturnPath` chống open-redirect: chỉ nhận path nội bộ bắt đầu bằng `/` (không `//`, `\`, scheme, quá 512 ký tự, không phải trang auth/splash/home).
- Bottom navigation 4 tab (`MainShell` + `AppBottomNavigation`): Explore · Trips · Social · Profile; FAB giữa → `createTrip`.
- Các route tạo trip và các màn con của trip detail dùng `parentNavigatorKey: _rootNavigatorKey` (che bottom nav).

---

## 4. Chi tiết từng feature

### 4.1 Auth — `features/auth/` ✅

- Màn hình: login (email + Google), register (+ Google), verify email (nhập mã, gửi lại), forgot password, reset password.
- Controller: `AuthController` (AsyncNotifier<AuthStatus>: restore session khi khởi động, login, googleLogin, logout, retrySessionRestore), `RegisterController`, `VerifyEmailController`, `ForgotPasswordController`, `ResetPasswordController`.
- Service: `GoogleAuthService` (google_sign_in → idToken).
- Login/restore thành công → gọi `DeviceTokenController` đăng ký FCM (lỗi Firebase không làm fail login).
- Endpoint đã nối: `POST /auth/login`, `/auth/google`, `/auth/refresh`, `/auth/logout-one`, `/auth/register`, `/auth/verify-email`, `/auth/reset-password`, `/auth/resend-verification-email`, `/auth/send-password-reset-code`.

### 4.2 Device token — `features/device_token/` ✅

- `DeviceTokenController` + `DeviceMessagingService` (FCM token, installationId, lắng nghe token refresh).
- Endpoint: `POST /device-tokens`, `DELETE /device-tokens/current`.

### 4.3 Media — `features/media/` ✅

- Upload nhiều file: presign → upload thẳng lên R2 (`R2UploadDataSource`) → complete. Contract gom trong `media_backend_contract.dart`.
- `MediaUploadController` + `MediaUploadStatus` theo dõi tiến trình.
- Endpoint: presign/complete multiple (path trong `MediaBackendContract`), `GET /media/:id`, `GET /media/own/:id`.
- Đang được dùng bởi: `UpdateAvatarController` (profile), `TripCoverController` (ảnh bìa khi tạo trip), `tripMemoriesActionControllerProvider` (album).

### 4.4 Profile — `features/profile/` ✅ (Settings 🟡, Travel DNA demo)

- `ProfileScreen` theo Stitch **Hồ Sơ Cá Nhân & Travel DNA**: thanh trên (quay lại, chia sẻ, cài đặt), avatar có huy hiệu xác minh, hạng vàng, bio, 4 thống kê (điểm đến / chuyến đi / người theo dõi / đang dõi), nút sửa hồ sơ + mã QR, thẻ Travel DNA, tab Chuyến đi / Chỉ số DNA / Đã lưu / Bài viết. Tab chuyến đi có thẻ đang diễn ra, sắp tới và dải khoảnh khắc. Loading skeleton, error + thử lại, unauthorized khi 401.
- Nút **Khám phá bản đồ radar DNA** trên thẻ Travel DNA mở `/profile/travel-dna` (mục 4.20).
- Danh tính (tên, username, bio, địa điểm, avatar, `visitedCount`) lấy từ `GET /users/me`. Hạng, DNA, số chuyến/follower, chuyến đang diễn ra, đã lưu và bài viết lấy từ datamock `getProfileShowcase` — đánh dấu `TODO(backend)`.
- Chia sẻ, mã QR và chi tiết chuyến demo hiện snackbar "sắp có". **Khoảnh Khắc Hành Trình** (tiêu đề, ảnh xem trước, ô thêm ảnh) mở `/profile/memories` (mục 4.21). Tab **Đã lưu**: **Xem tất cả** và từng mục mở `/profile/saved-places` (mục 4.22). **Xem tất cả** trên tab chuyến đi mở tab Trips. **Chỉnh sửa hồ sơ** → `/profile/edit`. Cài đặt vẫn `Navigator.push` tới `SettingScreen` (đăng xuất nằm ở đây).
- `EditProfileScreen` theo Stitch **Chỉnh Sửa Hồ Sơ**, không có ảnh bìa: avatar, thông tin cơ bản, email đã xác thực, số điện thoại che một phần rồi mới sửa, **địa chỉ** (`address`) và **vị trí hiện tại** (`location`) là hai ô riêng, ngày sinh `DD/MM/YYYY` (xóa ngày gửi `dateofBirth: null`), giới tính (có **Không chọn** để xóa), mức ngân sách, ngôn ngữ (chip + thêm), sở thích. Lưu qua `PATCH /users/update`. Ảnh đại diện vẫn upload rồi gắn `avatarId`. Loading, error + thử lại, unauthorized khi 401.
- `SettingScreen`: switch **Thông báo đẩy** gọi `PATCH /users/update` với `notificationEnabled` và hoàn tác nếu lỗi. **Đổi mật khẩu** gọi `POST /auth/change-password`. Các switch còn lại (sinh trắc học, nhắc nhở, tương tác) chỉ là `setState` cục bộ; thiết bị, ngôn ngữ, tiền tệ, chế độ hồ sơ, trợ giúp, điều khoản chưa có hành động; version là text cứng.
- Controller: `ProfileController`, `ProfileShowcaseController`, `UpdateProfileController`, `UpdateAvatarController`.
- Endpoint thật: `GET /users/me`, `PATCH /users/update`. Demo: `getProfileShowcase`.

### 4.5 Trips — phần đã có UI ✅

**Màn `TripScreen` (tab Trips)**
- Dashboard: thống kê, trip đang diễn ra, trip sắp tới (`TripDashboardController` gọi song song 2 query).
- Tab theo trạng thái + danh sách có phân trang (`TripListController`: setQuery, setSearch, refresh, loadNextPage).
- Danh sách lời mời (invite qua `/trip-invitations/...`): chấp nhận / từ chối (`TripInvitationsController`).
- Trạng thái: skeleton, empty, error, pull-to-refresh. Nút "Tạo Chuyến Đi" → `/trips/create`.
- Bấm vào trip → `/trips/:tripId` (`TripDetailScreen`, mục 4.8).

**Flow tạo chuyến đi (5 bước)** — `presentation/create_trip/`

1. `CreateTripDetailsScreen` — thông tin cơ bản, sở thích (`TripInterestsController`), vị trí thiết bị (`DeviceLocationController`), **ảnh bìa** (`TripCoverPicker` + `TripCoverController` → media folder trips, gửi `coverMediaId` khi save draft), danh mục điểm đến → lưu **draft** (`CreateTripController.saveDraft` → `POST /trips/drafts`).
2. `AddDestinationScreen` — chọn điểm đến từ catalog, xem địa điểm nổi bật theo category, vị trí hiện tại; `DestinationMapOverview` vẽ bản đồ + preview tuyến đường (`routePreviewProvider`, decode polyline).
3. `CreateTripItineraryScreen` — xem lịch trình theo ngày, xóa hoạt động, kéo-thả sắp xếp (`TripItineraryController`).
4. `AddItineraryActivityScreen` — tìm địa điểm (semantic search), chọn giờ bắt đầu theo **UTC** (backend dùng UTC đồng nhất cho mọi điểm đến, gửi `startTime` dạng `...Z`), thời lượng, chi phí, ghi chú; **tự lưu draft local** (shared_preferences) và khôi phục khi mở lại (`AddItineraryActivityController`).
5. `CreateTripConfirmationScreen` — xem lại draft + lịch trình, gợi ý bạn đồng hành, tìm user, gửi lời mời, **finalize** trip (`POST /trips/:id/finalize`).

Endpoint đang được UI sử dụng:
- Trip: `GET /trips`, `POST /trips/drafts`, `GET /trips/my-drafts`, `POST /trips/:id/finalize`, `GET /trips/destinations/catalog`, `GET /trips/destinations/catalog/:id/places`, `POST /trips/routes/preview`, `GET /trips/recommend-friends/:tripId`, `GET /users/search`, `GET /trips/interests/all`, `PUT /trips/interests/:tripId`, `POST /trips/interests`.
- Lời mời (invite): `GET /trip-invitations/invited`, `POST /trip-invitations/invite`, `/accept/:id`, `/reject/:id`.
- Lịch trình: `GET /trips/:id/itineraries`, `POST /places/search-embeddings`, `POST /trips/:id/itineraries/days/:dayId/activities`, `DELETE /trips/:id/itineraries/activities/:activityId`, `PATCH /trips/:id/itinerary-days/:dayId/items/reorder`.

### 4.6 Trips — có data/controller nhưng CHƯA có màn hình 🟠

Các phần này đã viết đủ datasource → repository → controller (hoặc method repository), khi làm màn hình chỉ cần tái sử dụng:

| Chức năng | Controller / Provider | Endpoint |
|---|---|---|
| Sửa / xóa trip | `updateTripControllerProvider` | `PATCH /trips/:id`, `DELETE /trips/:id` |
| Tạo trip trực tiếp (không qua draft) | `CreateTripController.submit` | `POST /trips` |
| Thành viên (join bằng mã cũ, rời, kick) | `tripMembersControllerProvider` | `POST /trips/join/:code`, `/trips/leave/:id`, `/trips/kick/:id/:userId` — kick/leave cũng có UI ở trip-details |
| Hủy lời mời | `TripInvitationsController` | `POST /trip-invitations/cancel/:tripId/:invitationId` |
| Xin vào trip bằng mã (join request) | `tripJoinByCodeControllerProvider` + UI mục 4.13 | `GET`+`POST /trips/join/{inviteCode}` |
| Kỷ niệm — sửa caption | action `updateCaption` + viewer UI | `PATCH /trips/memories/:id` — uploader only |
| Tin nhắn nhóm (cursor paging) | `tripChatControllerProvider` (rich thread demo) | UI mục 4.26; OpenAPI `GET /trips/:id/messages` + `POST .../read` — thread rich vẫn demo `/chat/thread` |
| Chi phí (create/settle) + hoàn thành trip | `tripExpensesActionControllerProvider` / `tripDomainMutationControllerProvider` | `POST /trips/:id/expenses`, settle split, `POST /trips/:id/completion` — màn chi tiêu mục 4.14 (form thêm + settle confirm đã có UI) |
| Thêm hàng loạt, xóa điểm đến (sửa hoạt động và check-in đã có UI ở mục 4.9) | `TripItineraryController` | `POST .../itineraries/items/batch`, `DELETE .../itineraries/destinations/:id` |
| Tiến độ hoàn thành lịch trình | `tripItineraryCompletionControllerProvider` | `GET /trips/:id/itineraries/completion-status` |
| Chi tiết lịch trình 1 điểm đến (lazy) | `TripItineraryController` + `tripItineraryPreferLazyProvider` | `GET /trips/:id/itineraries/destinations/:destinationId` — màn browse itinerary; create-trip vẫn full `GET .../itineraries` |
| Sửa/xóa interest | repository | `PATCH/DELETE /trips/interests/:id` |
| Timeline legacy (dead code) | `tripTimelineControllerProvider` trong `trip_feed_controllers.dart` | Cùng path `GET /trips/timeline/:id` nhưng model/cursor cũ; **không còn UI nào watch** — màn thật dùng `trip-timeline/` |

### 4.7 Thiết kế có sẵn trong repo

Trong `frontend/docs/design/screen/` hiện có HTML/screenshot Stitch cho:
- `trip/trip-join-request-approval/` — đã code (mục 4.12).
- `trip/trip-join-by-code/` — đã code (mục 4.13).
- `trip/trip-invite-friends/` — đã code (mục 4.19).
- `trip/trip-memories/` — đã code (mục 4.10).
- `trip/trip-timeline/` — đã code (mục 4.11).
- `trip/trip-expenses/` — đã code UI xem (mục 4.14).
- `trip/trip-add-expense/` — đã code form thêm khoản chi full screen (mục 4.15).
- `explore/community-trips/` — đã code tab Home/Explore community (mục 4.16).
- `explore/places/` — đã code 3 mục tab Địa Điểm trên Home (mục 4.16).
- `explore/featured-destinations/` — đã code màn tất cả điểm đến nổi bật (mục 4.16).
- `explore/destination-trips/` — đã code màn chuyến đi theo điểm đến (mục 4.18).
- `profile/profile-travel-dna/` — đã code màn hồ sơ & Travel DNA (mục 4.4).
- `profile/user-memories/` — đã code thư viện khoảnh khắc trên hồ sơ (mục 4.21).
- `profile/user-saved-trip/` — đã code điểm đến đã lưu (mục 4.22).
- `travel-dna/radar.html` + `radar.png` — đã code màn radar chi tiết (mục 4.20).
- `chats/trip-messages-hub/` — đã code hub tin nhắn (mục 4.24); screenshot Stitch trong thư mục.
- `chats/friend-chat/` — đã code chat 1-on-1 (mục 4.25); screenshot Stitch trong thư mục.
- `chats/trip-group-chat/` — đã code chat nhóm trip (mục 4.26); screenshot Stitch trong thư mục.
- `social/social-details/` — đã code chi tiết bài viết & bình luận (mục 4.28).
- `friends/find-friends/` — đã code tìm kiếm bạn bè (mục 4.29); screenshot Stitch trong thư mục.

Các màn chưa làm (chip lọc trên tab Địa Điểm, …) cần lấy lại từ Stitch hoặc nguồn khác khi làm. Chi tiết địa điểm đã có ở mục 4.23; bấm thẻ địa điểm mở route đó.

### 4.8 Trips — chi tiết chuyến đi & thành viên (`features/trips/trip-details/`) ✅

Theo Stitch "Chi Tiết Chuyến Đi & Thành Viên".
- **Dữ liệu:** API thật. `TripDetailRemoteDataSource` gọi `GET /trips/{id}` (schema `TripDetailResponseDto`), `POST /trips/kick/{id}/{userId}`, `POST /trips/leave/{id}`, `POST /trips/{id}/completion`.
- **Contract `GET /trips/{id}`:** thông tin trip + `inviteCode` (chỉ OWNER, còn lại `null`), `viewer {userId, role|null}`, `checkinProgress`, `members[]` (displayName, avatar, travelPersona = DNA cao nhất, activityNote = sự kiện gần nhất, `isOnline` = có socket trong phòng `trip:{id}` phía server, `isNewMember` = MEMBER tham gia ≤ 3 ngày, `amountSpent`, `memoryCount`), `destinations[].isCurrent`, `nextActivity` (`confirmedCount` = số thành viên đã check-in điểm đó), `completionReward` (điểm = số điểm check-in × 5). Người xem không phải thành viên (trip PUBLIC) nhận `expenseSummary`, `memories`, `completionReward`, `timeline` = `null` → UI ẩn kỷ niệm/timeline, chi phí hiển thị "—".
- **Model:** `data/models/trip_detail_models.dart` (freezed + json_serializable). Quyền suy ra từ `viewer.role`: `canInviteMembers` = OWNER, `canManageMembers` = OWNER/ADMIN, `canRemove` chỉ khi role mình **cao hơn** role người kia, `canLeave` = thành viên nhưng không phải OWNER. Status `NOTCOMPLETED` (backend đã đổi từ `NOTCOM`; các model list trip cũ vẫn map `NOTCOM` — chưa đồng bộ).
- **State:**
  - `tripDetailOverviewControllerProvider(tripId)` (AsyncNotifier, autoDispose.family, có `refresh()`).
  - `tripDetailActionControllerProvider(tripId)` (kick/leave/claim): chống double-submit, invalidate overview sau thành công; leave còn invalidate list/dashboard.
- **UI:** hero, 3 metric, thành viên + mã mời (copy), pill **"Mời bạn"** → `tripInviteFriends` khi `canInviteMembers` (mục 4.19), pill **"Yêu cầu"** → `tripJoinRequests` khi `canManageMembers`, chặng hành trình + hoạt động tiếp theo, kỷ niệm, thẻ nhận thưởng, timeline preview, rời chuyến đi, bottom bar (**Chi phí** → `tripExpenses` mục 4.14; Xem lịch trình → `tripItinerary`). Có skeleton, error + retry, pull-to-refresh; một số nút chưa có API báo "Tính năng đang phát triển".
- **Không dùng** `tripDetailControllerProvider`/`Trip.fromJson` cũ cho màn này: `GET /trips/:id` trả shape chi tiết, không khớp model `Trip` list.

### 4.9 Trips — lịch trình chi tiết (`trip-details/`, route `tripItinerary`) ✅

Theo Stitch "Lịch Trình Chi Tiết - Trip Itinerary". Mở từ trip detail (nút "Xem lịch trình" / chặng hành trình).
- **Endpoint (tất cả là API thật, có trong `openapi.json`):**
  - `GET /trips/{id}/itineraries` → điểm đến/ngày/hoạt động + `permissions.canManageItinerary` (`tripItineraryControllerProvider(tripId)`).
  - `GET /trips/{id}/itineraries/checkins/me` → check-in **của người xem** theo place (`getViewerCheckedInPlaceIds`).
  - `POST/DELETE .../activities/:id/checkin` (vị trí từ `deviceLocationServiceProvider`), `DELETE .../activities/:id`, `PATCH .../activities/:id` (sửa: title, startTime, duration, estimatedCost, `notes` ≤ 300 ký tự).
  - `GET /trips/{id}/itineraries/days/{dayId}/route` → đường đi thật theo ngày (Google Routes, cache phía backend): từng chặng có `available`, `distanceMeters`, `durationSeconds`, `polyline`. Chỉ thành viên.
  - `POST /trips/{id}/share-links` (mọi thành viên ACTIVE, trip không phải DRAFT/CANCELLED, quota 20 link/giờ/người, hạn mặc định 30 ngày), `DELETE /trips/{id}/share-links` (OWNER/ADMIN thu hồi tất cả, trả số link), `GET /trip-shares/{token}` (cần đăng nhập, lịch trình chỉ xem + `viewerIsMember`).
- **Datamock** `data/datamock/trip_itinerary_datamock.dart` chỉ còn dùng cho test (payload mẫu của các endpoint trên).
- `canCheckin` = trip UPCOMING/ONGOING và người xem là thành viên (từ `tripDetailOverviewControllerProvider`).
- **Logic thuần:**
  - `application/trip_itinerary_view.dart` — `buildTripItineraryView` sắp xếp, gán trạng thái hoạt động (đã check-in / tiếp theo = hoạt động chưa check-in đầu tiên của **hôm nay** / sắp tới), trạng thái ngày, tổng chi phí, tổng thời lượng, chọn mặc định điểm đến/ngày chứa hôm nay.
  - `application/trip_itinerary_route.dart` — `tripItineraryDayRouteProvider` (key gồm thứ tự placeId nên tự tải lại khi sắp xếp/sửa; **tắt auto-retry** vì endpoint tính phí), `summarizeDayRoute`: cộng quãng đường/thời gian thật; chặng thiếu dữ liệu đường đi thì bù bằng haversine và gắn nhãn "(ước tính)".
  - `application/trip_itinerary_map.dart` — `buildTripItineraryMap`: marker theo điểm có toạ độ, polyline giải mã từ backend, chặng không có đường thật vẽ nét đứt xám.
- **State:** `tripItineraryViewProvider(tripId)`, `tripItinerarySelectionControllerProvider`, `tripItineraryActionControllerProvider(tripId)` (checkin/uncheckin/xóa), `tripItineraryEditActivityControllerProvider(tripId)` (validate giống backend: start + duration đi cùng nhau, không qua nửa đêm UTC; chỉ gửi field thay đổi; map lỗi `ACTIVITY_OVERLAP`/`OUTSIDE_DESTINATION`/... sang thông báo an toàn), `tripItineraryShareControllerProvider(tripId)` (share/revoke, chống double-submit).
- **UI:**
  - Màn chính: tab điểm đến, rail ngày, thẻ tiến độ ngày, timeline hoạt động (3 biến thể thẻ, hiện ghi chú), thẻ lộ trình (quãng đường thật), bottom bar. Skeleton, empty, error + retry, pull-to-refresh.
  - Nút bản đồ (top bar), "Khám phá lộ trình" (bottom bar), "Toàn màn hình" (thẻ lộ trình) → `tripItineraryMap` với `dayId` đang chọn.
  - `TripItineraryMapScreen`: chip ngày, Google Map + thẻ điểm dừng cuộn ngang, banner lỗi đường đi + "Thử lại"; web/desktop hiện thông báo không hỗ trợ bản đồ.
  - Menu hoạt động → "Chỉnh sửa" mở `TripItineraryEditActivitySheet` (tên, giờ bắt đầu UTC, thời lượng, chi phí, ghi chú).
  - Nút chia sẻ (chỉ thành viên, trip không DRAFT/CANCELLED): MEMBER tạo link và mở share sheet ngay; OWNER/ADMIN có menu "Chia sẻ link lịch trình" / "Thu hồi các link đã chia sẻ" (có xác nhận).
  - `SharedItineraryScreen` (`/shared/:token`): header "Chỉ xem", lịch trình không có check-in/sửa/xóa, quãng đường ước tính (đường đi thật chỉ dành cho thành viên); thành viên có nút "Mở chuyến đi"; link hết hạn/thu hồi/token sai → "Link không còn hiệu lực".
- **Deep link (`lib/core/deep_link/deep_link_service.dart`):**
  - Link chia sẻ: `https://<SHARE_HOST>/s/{token}` (token 43 ký tự base64url). Backend phục vụ trang HTML fallback ở `/s/:token`, `/.well-known/assetlinks.json` và `/.well-known/apple-app-site-association`.
  - `DeepLinkService` nghe `app_links`, chỉ nhận đúng https + host + `/s/{token}` (bỏ query/fragment), chuyển thành `/shared/{token}`; `App` gọi `router.go(path)`. Flutter deep linking mặc định đã tắt trên cả hai nền tảng.
  - Cấu hình host:
    - App: `--dart-define SHARE_HOST=<domain>` (`AppConfig.shareHost`; rỗng = tắt deep link).
    - Android: `SHARE_HOST=<domain>` trong `android/local.properties` (mặc định `share.invalid`) → intent-filter `autoVerify` trong `AndroidManifest.xml`.
    - iOS: copy `ios/Flutter/ShareLinks.xcconfig.example` → `ShareLinks.xcconfig` (đã gitignore) → entitlement `applinks:$(SHARE_HOST)` trong `Runner/Runner.entitlements`. Associated Domains cần Apple Developer team trả phí.
    - Backend: `PUBLIC_SHARE_BASE_URL`, `SHARE_LINK_TTL_DAYS`, `ANDROID_APP_PACKAGE`, `ANDROID_SHA256_CERT_FINGERPRINTS`, `IOS_APP_ID` (`TEAMID.bundleId`).
  - Thử trên Android: `adb shell am start -a android.intent.action.VIEW -d "https://<SHARE_HOST>/s/<token>"`.

### 4.10 Trips — album kỷ niệm (`features/trips/trip-memories/`, route `tripMemories`) ✅

Theo Stitch "Tất Cả Kỷ Niệm Chuyến Đi". Lối vào:
- Ảnh của sự kiện `MEMORY_ADDED` trên timeline ("Xem album" / "+N ảnh").
- Mục "Kỷ niệm chuyến đi" ở trip detail: "Tất cả" và ảnh xem trước mở album; ô "Đăng ảnh mới" mở `/trips/:tripId/memories?post=1` → album tự mở trình chọn ảnh khi trip detail xác nhận người xem được đăng (`TripMemoriesScreen.startPostingQuery`).
- Nút "Xem ảnh" của từng thành viên (danh sách thành viên ở trip detail) mở `/trips/:tripId/memories?userId=<id>` (`TripMemoriesScreen.uploaderQuery`) → album lọc sẵn theo người chụp; bộ lọc được đặt trước khi tải nên request đầu tiên đã có `userId`.
- **Endpoint (API thật):**
  - `GET /trips/memories/{tripId}?limit&cursor&day&userId` → `{data, meta {nextCursor, hasMore, totalCount, dayCounts}}`, mới nhất trước. Chỉ thành viên (403 → màn "Không thể xem album").
    - `day` = ngày thứ N của trip **theo UTC** từ `startDate`; `userId` = người chụp. Cursor chỉ hợp lệ với đúng bộ lọc đã cấp nó.
    - `totalCount` và `dayCounts` **chỉ có ở trang đầu**; trang sau trả `null`, controller giữ số của trang đầu.
    - `badge` từng ảnh: nhãn tiếng Việt backend gợi ý theo nội dung ảnh; `null` khi chưa phân loại. Backend phân loại nền bằng model vision của Ollama sau khi tạo + cron.
  - `POST /trips/memories/{tripId}/batch` `{items: [{mediaId, caption?}]}` (1–20 ảnh, media phải là ảnh của chính người đăng). Ảnh upload trước qua flow media (folder `trips`).
  - `DELETE /trips/memories/{memoryId}` — người đăng, hoặc OWNER/ADMIN.
  - Datamock `data/datamock/trip_memories_datamock.dart` đúng shape API, chỉ dùng cho test.
- **Model** `data/models/trip_memory_models.dart` (freezed): `TripMemoriesPage`, `TripMemoryEntry`, … (tiền tố tránh trùng `TripMemory` viết tay cũ).
- **State:** `tripMemoriesFilterProvider`, `tripMemoriesControllerProvider`, `tripMemoriesActionControllerProvider`, `tripMemoriesViewProvider` — nhóm theo UTC để khớp bộ lọc `day`.
- **UI:** top bar, thẻ kho kỷ niệm, chip ngày/người chụp, lưới bento, đăng tối đa 20 ảnh, viewer toàn màn hình. Skeleton, empty, lỗi + retry, 403, pull-to-refresh.
- **Khác thiết kế:** bỏ lượt thích/bình luận, tìm kiếm, "Chọn nhiều", … (backend chưa có).

### 4.11 Trips — dòng thời gian (`features/trips/trip-timeline/`, route `tripTimeline`) ✅

Theo Stitch "Dòng Thời Gian Chuyến Đi" (HTML ở `docs/design/screen/trip/trip-timeline/`). Lối vào: trip detail → "Xem thêm" / mục timeline → `/trips/:tripId/timeline`.
- **Endpoint:** `GET /trips/timeline/{tripId}?limit&cursor&category` — `category` ∈ `checkin` | `expense` | `memory` | `member` (bỏ trống = tất cả). Page size repository = 30. Response `{ data, meta }` (không dùng envelope `{ success, data }` của các API khác trên endpoint này).
- **Realtime:** `tripTimelineLiveProvider(tripId)` subscribe `tripSocketClientProvider.watchTrip(tripId)`:
  - Client emit `trip:join` / `trip:leave`; server emit `trip:joined`, `trip:error`, `trip:timeline`.
  - Live push → `tripTimelineEventsControllerProvider.receive(entry)` (cùng shape JSON với REST item); sau reconnect (`TripRoomJoined`) gọi `refresh()` catch-up.
  - UI hiện trạng thái connecting / live / offline.
- **Datamock** chỉ cho test; production luôn gọi API thật.
- **Model** freezed: `TripTimelinePage`, `TripTimelineEntry`, `TripTimelineEntryType` (`TRIP_CREATED`, `MEMBER_*`, `ACTIVITY_*`, `EXPENSE_*`, `PHOTO_ADDED`, `MEMORY_*`, …).
- **State:** `tripTimelineEventsControllerProvider` (paging + refresh + receive; tắt auto-retry), `tripTimelineFilterProvider`, `tripTimelineViewProvider` (nhóm theo **giờ local thiết bị**, khác album memories dùng UTC), `tripTimelineHeaderProvider` (từ trip detail overview).
- **UI:** summary + chấm live, filter chip / bottom sheet, thẻ sự kiện theo loại (ảnh → mở album, chi phí, check-in, …), load more gần cuối, pull-to-refresh, empty/error/403. Menu "…" → "Xem chi tiết" hiện stub (`TODO(screen)` — chưa có màn đích theo `targetType`/`targetId`).
- **Legacy:** `tripTimelineControllerProvider` trong `trips/application/trip_feed_controllers.dart` là dead code (model/cursor cũ).

### 4.12 Trips — duyệt yêu cầu tham gia (`features/trips/trip-invitation/`, route `tripJoinRequests`) ✅

Theo Stitch "Yêu Cầu Tham Gia" (`docs/design/screen/trip/trip-join-request-approval/`). **Khác** luồng invite `/trip-invitations/...` (mời bạn từ confirmation / danh sách lời mời trên tab Trips).
- **Mục đích:** OWNER/ADMIN duyệt người xin vào trip qua mã mời (join request).
- **Lối vào:** trip detail → mục thành viên → pill **"Yêu cầu"** khi `trip.canManageMembers` → `/trips/:tripId/join-requests`.
- **Endpoint (API thật, khớp OpenAPI):**
  - `GET /trips/{tripId}/join-requests?status&limit&cursor` — status `PENDING` | `APPROVED` | `REJECTED`.
  - `POST /trips/{tripId}/join-requests/{requestId}/approve` | `/reject`.
  - `GET` / `PATCH /trips/{tripId}/join-requests/settings` — `autoApproveFriends`.
  - Header màn hình lấy từ `tripDetailOverviewControllerProvider` (`GET /trips/{id}`): sức chứa, mã mời, quyền.
  - Phía người xin vào: màn nhập mã (mục 4.13) — `GET` preview + `POST` `requestToJoin`.
- **Model** freezed: `TripJoinRequest`, `TripJoinRequestsPage`, `TripJoinRequestSettings`, …
- **State:** `tripJoinRequestsControllerProvider` (tab + paging cursor, tắt auto-retry), `tripJoinRequestActionControllerProvider` (một quyết định tại một thời điểm; approve invalidate trip detail), `tripJoinRequestSettingsControllerProvider`, `tripJoinRequestsHeaderProvider`.
- **UI:** top bar + badge số pending, thẻ trip (capacity / copy-share mã mời), 3 tab trạng thái + counts, thẻ requester (persona, match score), auto-approve friends, bottom "Rà soát thành viên" → về trip detail. Chặn approve khi trip đầy / không mở / không phải reviewer; reject có dialog xác nhận. Skeleton, empty theo tab, 403 → màn khóa.
- **Datamock** chỉ cho test.

### 4.13 Trips — nhập mã mời gửi yêu cầu (`features/trips/trip-invitation/`, route `tripJoinByCode`) ✅

Theo Stitch "Nhập Mã Chuyến Đi - Gửi Yêu Cầu Tham Gia" (`docs/design/screen/trip/trip-join-by-code/`).
- **Mục đích:** người dùng chưa là thành viên nhập mã mời (8 ký tự, khớp `generateInviteCode`) + lời nhắn tùy chọn → gửi yêu cầu tham gia.
- **Lối vào:** tab Trips (`TripScreen`) → nút header **Nhập mã mời** → `/trips/join`.
- **Endpoint (API thật, tên theo Nest):**
  - `GET /trips/join/{inviteCode}` — `TripsController.previewJoinByInviteCode` → `TripJoinRequestsService.previewByInviteCode` → `TripJoinInvitePreviewResponseDto` (`inviteCode`, `tripId`, `name`, `coverImageUrl`, `startDate`, `endDate`, `ownerDisplayName`, `memberCount`, `maxMembers`, `matchScore`).
  - `POST /trips/join/{inviteCode}` body `{ message? }` — `joinByInviteCode` / `requestToJoin`. `APPROVED` nếu auto-approve bạn của owner; còn lại `PENDING`.
- **Model:** freezed `TripJoinInvitePreview` khớp DTO backend; datamock cùng shape cho test.
- **State:** `tripJoinInvitePreviewProvider(code)` (lookup), `tripJoinByCodeControllerProvider` (submit + lỗi; chống double-submit).
- **UI:** top bar (back + QR stub), hero, 8 ô mã + dán clipboard, preview từ API (loading/error), lời nhắn; **CTA gửi + QR phụ sticky** ở `bottomNavigationBar` (`extendBody: false`) để luôn bấm được khi có preview; lỗi submit hiện ngay trên CTA. QR phụ = coming soon. Sau `APPROVED` → `tripDetail`; `PENDING` → snackbar + pop. Invalidate trip list/dashboard khi được duyệt ngay.
- **Test:** `test/features/trips/trip_join_by_code/*` — incomplete / 404 preview / offline / pending / approved / 409 / loading / QR / back.

### 4.19 Trips — mời bạn đồng hành (`features/trips/trip-invitation/`, route `tripInviteFriends`) ✅

Theo Stitch "Mời Bạn Đồng Hành - Invite Co-travelers" (`docs/design/screen/trip/trip-invite-friends/`). **Khác** màn nhập mã (4.13, phía người xin vào) và màn duyệt yêu cầu (4.12).
- **Mục đích:** trưởng nhóm chọn bạn và gửi lời mời tham gia chuyến đi.
- **Lối vào:** trip detail → pill **"Mời bạn"** (và nút mời thêm trong danh sách thành viên) khi `canInviteMembers` → `/trips/:tripId/invite`.
- **Endpoint (API thật):**
  - Header từ `tripDetailOverviewControllerProvider` (`GET /trips/{id}`): tên, chỗ trống, mã mời, quyền owner, trạng thái `UPCOMING`.
  - `GET /trips/recommend-friends/{tripId}` — `{ data, tripTravelPersona, message }`. Mỗi bạn: `tripsTogetherCount`, `invitationStatus`, `travelPersona`, `matchScore` (0–100 hoặc null), `lastInteractionAt`. `tripTravelPersona` là DNA chuyến nghiêng về.
  - `GET /users/search?q` — tìm theo tên/username khi ô tìm không trống (tối đa 20 kết quả đầu). DNA và % hợp chỉ hiện khi người đó đã có trong danh sách recommend.
  - `POST /trip-invitations/invite` body `{ tripId, inviteeId }` — một request cho mỗi người đã chọn. `409` "already pending" được coi là đã gửi.
- **Chip (lọc trên client):** Tất cả bạn bè, Đã từng đi chung (`tripsTogetherCount > 0`), Gần đây (`lastInteractionAt` trong 30 ngày), Cùng gu du lịch (`matchScore >= 50`, nhãn kèm `tripTravelPersona` khi có), Đã gửi lời mời (`PENDING`).
- **Khối gợi ý:** ai có `matchScore` thì xếp điểm cao trước, tiêu đề "Gợi ý cùng gu du lịch". Không ai có điểm thì giữ gợi ý đã đi chung. Danh bạ còn lại xếp `lastInteractionAt` mới nhất. Thẻ hiện `Beach Lover 🏖️ • Hợp 94%` khi có persona hoặc điểm.
- **Khác thiết kế Stitch:** nút QR mở mã mời để sao chép, không vẽ ảnh QR. Không có trạng thái "đang trong chuyến khác".
- **Chặn gửi:** chuyến không `UPCOMING`, đã đủ chỗ, hoặc chọn quá số chỗ còn trống. Lời mời `PENDING` không chọn lại. Thành viên hiện tại và chính mình bị loại khỏi danh sách.
- **State:** `tripInviteFriendsControllerProvider` (tắt auto-retry), `tripInviteFriendsHeaderProvider`.
- **UI:** top bar, tìm kiếm, chip, ribbon đã chọn, khối gợi ý cùng gu (hoặc đã đi chung khi chưa có DNA), danh bạ, cảnh báo, bottom "Gửi lời mời". Skeleton, empty, error + thử lại, 403 / không phải owner → màn khóa. Pull-to-refresh.
- **Test:** `test/features/trips/trip_invite_friends/*`.

### 4.14 Trips — chi tiêu & quỹ nhóm (`features/trips/trip-expenses/`, route `tripExpenses`) ✅

Theo Stitch "Chi Tiêu & Chia Tiền Nhóm - Trip Expenses" (`docs/design/screen/trip/trip-expenses/`).
- **Mục đích:** xem tổng quỹ nhóm, phân bổ danh mục, đề xuất quyết toán, lọc và duyệt lịch sử chi tiêu; thêm khoản chi; tất toán theo vai trò (không QR — tiền giao dịch ngoài app).
- **Lối vào:** trip detail → bottom bar **Chi phí** → `/trips/:tripId/expenses`.
- **Endpoint (API thật, tên theo Nest `TripExpenseController`):**
  - `GET /trips/{tripId}/expenses` — `getExpenses` → `TripExpenseOverviewDto` (`summary`, `categories`, `settlements` với `fromIsViewer` / `toIsViewer`, `expenses` enriched). Chỉ thành viên (`READ_EXPENSES`).
  - `POST /trips/{tripId}/expenses` — `createExpense` → `TripExpenseResponseDto` (EQUAL không gửi `splits`; CUSTOM gửi `splits[]` tổng = amount).
  - `POST /trips/{tripId}/expenses/{expenseId}/splits/{splitId}/settle` — `settleSplit` (payer hoặc debtor được gọi; UI chỉ xác nhận trong app).
  - Datamock `trip_expenses_datamock.dart` khớp shape overview, chỉ dùng cho test.
- **Model** freezed khớp OpenAPI: `TripExpensesOverview` / `TripExpensesEntry` (list), `TripExpenseCreated` (create), …
- **State:** `tripExpensesControllerProvider` (`getExpenses`, tắt auto-retry), `tripExpensesFilterProvider`, `tripExpensesViewProvider` (lọc client-side), `tripExpensesActionControllerProvider` (create/settle → invalidate overview).
- **CTA đã làm:**
  - **Thêm khoản chi** (hero / bottom bar / empty) → `tripAddExpense` full screen (mục 4.15).
  - **Tất toán / Quyết toán nợ** → bottom sheet công nợ (`viewerRelatedSettlements`); settle từng khoản.
  - Hàng đề xuất: creditor **Xác nhận đã nhận** / debtor **Đã chuyển tiền** → dialog xác nhận → `settleSplit`. Busy disable CTA.
- **Không làm:** QR nhận tiền, batch settle, bank transfer trong app.
- **UI:** top bar glass, hero, danh mục, đề xuất quyết toán, filter, lịch sử, bottom bar. Skeleton, empty (+ CTA thêm), filtered-empty, error + retry, 403, pull-to-refresh.
- **Test:** `trip_expenses_view_test.dart` (filter + formatters); `trip_expenses_settle_and_create_test.dart` (filter viewer, nhãn settle, validate CUSTOM, action invalidate); `trip_add_expense_screen_test.dart` (chrome Stitch).

### 4.15 Trips — thêm khoản chi (`trip-expenses/`, route `tripAddExpense`) ✅

Theo Stitch "Thêm Khoản Chi Mới - Add Expense Form" (`docs/design/screen/trip/trip-add-expense/`).
- **Mục đích:** tạo khoản chi mới (amount, currency, category, description, EQUAL|CUSTOM, payer, spentAt, locationNote, receipts).
- **Lối vào:** màn chi tiêu (`tripExpenses`) → CTA **Thêm khoản chi** → `/trips/:tripId/expenses/add`.
- **Endpoint:** `POST /trips/{tripId}/expenses` — `payerTripMemberId?`, `spentAt?`, `locationNote?`, `receiptMediaIds[]` (upload folder `trips` trước). Prisma: `spentAt`, `locationNote`, `TripExpenseReceipt`.
- **State / form:** `TripExpensesCreateFormState` + OCR parse (`trip_expense_receipt_ocr.dart` + ML Kit reader trên Android/iOS).
- **UI:** top bar quét OCR, hero số tiền, danh mục, chọn payer bất kỳ ACTIVE member, chia đều/tùy chỉnh, đính kèm hóa đơn (camera/gallery, OCR), sheet ngày chi + vị trí; máy tính vẫn coming soon.
- **List:** `TripExpensesListItem` hiển thị `spentAt` + icon hóa đơn khi có receipts.
- **Test:** `trip_add_expense_screen_test.dart`, `trip_expense_receipt_ocr_test.dart`, settle/create form tests.

### 4.16 Home / Explore — Chuyến Đi Cộng Đồng (`features/home/`, route `home`) 🟢

Theo Stitch "Khám Phá - Tab Chuyến Đi Cộng Đồng" (`docs/design/screen/explore/community-trips/`).
- **Mục đích:** tab Explore (path `/home`) — feed chuyến PUBLIC đang tuyển (discover), lọc tripType/destination/search, xin vào không mã.
- **Dữ liệu:** `GET /trips/discover` (`category`, `search`, `seed`, `timezoneOffsetMinutes`, `destinationCatalogId`, `page`, `limit`) qua `ExploreHomeRemoteDataSource` → map `TripListItem` → `CommunityTripCard`. Đọc `meta.hasNextPage`; nút Tải thêm nối trang sau, lỗi trang sau không xóa trang đã có. Datamock chỉ còn cho unit test. Rail điểm đến từ `GET /trips/destinations/catalog` (tối đa 12). Catalog 401 đẩy lỗi lên; lỗi khác lần đầu gom thành phố từ trang discover, lần sau giữ rail cũ. `liveTrips` luôn rỗng nên mục đang diễn ra không hiện.
- **Join:** `POST /trips/:tripId/join` (+ preview `GET .../join/preview`) — PUBLIC only; invite-code giữ cho PRIVATE/link.
- **Model:** `explore_home_models.dart` (freezed): `ExploreHomeFeed` (header, filters, hotTrips, destinations, liveTrips, page, hasNextPage).
- **State:** `exploreHomeControllerProvider` — segment Places|Community, chips gửi `category` lên discover, search debounce chỉ khi đang ở tab cộng đồng, bookmark local (giữ qua lần tải lại, không có API lưu chuyến), `joinTrip(tripId)` khóa nút bằng `joiningTripId` rồi tải lại nền. Refresh, lọc và search khi đã có feed không đổi skeleton; lỗi giữ list và hiện câu ngắn. Lần đầu chưa có data vẫn skeleton. Chip “Đang tuyển người” đã bỏ vì discover chỉ trả chuyến đang mở tuyển; badge “Đang tuyển” vẫn trên thẻ.
- **UI:** header (tên từ `profileControllerProvider`, vị trí từ `profile.location`; không có vị trí thì ẩn dòng đó; không còn chuông và tìm nhanh). Ô tìm chỉ ở tab cộng đồng, không có bộ lọc nâng cao. Segmented control, chips, banner đăng cộng đồng (`ExplorePublishBanner`: nhãn “Quản lý bài đăng” khi summary > 0, lỗi summary vẫn để “Đăng chuyến đi” và bấm được; loading khi gọi `GET /trips/mine`). FAB giữa shell vẫn → `createTrip`. Bấm thẻ hoặc “Xem lịch trình” mở `/trips/:tripId`. Tab **Địa Điểm** giữ header, segmented control và rail “Tìm Theo Điểm Đến”, rồi 3 mục: Điểm đến nổi bật (`GET /places/featured`), Gần bạn (`GET /places/nearby`), Bộ sưu tập (`GET /place-collections/featured`). Lưu chỗ qua membership. **Xem tất cả** trên mục nổi bật mở `/home/featured`. Màn đó lấy featured khi ô tìm trống và gọi `POST /places/search-embeddings` khi có chữ. Bấm thẻ nổi bật hoặc thẻ gần bạn mở `/home/places/:placeId`. Loading skeleton, empty, error + thử lại, 401 không retry và không lộ exception. Pull-to-refresh tải lại feed và tab địa điểm; lỗi feed khi đã có data giữ list.
- **Shell:** `MainShell` dùng `AppBottomNavigation` (Explore · Trips · FAB · Social · Profile); FAB → `createTrip`. Chọn lại tab Explore tải lại summary bài đăng.
- **Test:** `test/features/home/explore_home_models_test.dart`, `explore_home_controller_test.dart`, `explore_places_models_test.dart`, `explore_places_controller_test.dart`, `explore_places_tab_test.dart`, `featured_destinations_view_test.dart`, `featured_destinations_screen_test.dart`.
- **Tất cả điểm đến nổi bật** (`features/home/places/`, route `featuredDestinations`, `/home/featured`): Stitch “Tất Cả Điểm Đến Nổi Bật”. Ô tìm trống dùng `GET /places/featured` — tập nổi bật trong ngày, không phân trang. Có chữ thì debounce rồi `POST /places/search-embeddings` không gửi `destinationId` (tìm place đã duyệt có embedding). Thẻ đang chọn áp lên đúng nguồn đó, không lọc chuỗi trên máy: **Phổ biến nhất** là mặc định và giữ thứ tự nguồn; **Đánh giá trên 4.8** chỉ giữ `averageRating >= 4.8`. Mục **Sắp xếp** nằm riêng: danh sách chỉ xếp theo `saveCount` sau khi user chọn “Lượt lưu nhiều nhất”. Không còn dòng đếm, menu sắp xếp, chip thiên nhiên, nút Chi tiết, bản đồ hay lập lịch trình. Thẻ mở `placeDetail`. Thẻ đầu full-width, các thẻ sau là lưới hai cột. Lưu qua sheet bộ sưu tập và cập nhật cả tab Địa Điểm. Lỗi tải lại hoặc lỗi tìm giữ danh sách. Datamock chỉ cho test.
- **Điểm đến:** rail “Tìm Theo Điểm Đến” nằm ngay dưới tab, trên cả Địa Điểm và Chuyến Đi Cộng Đồng. Nguồn là `GET /trips/destinations/catalog` (tối đa 12, ưu tiên thành phố đang có chuyến mở). Catalog 401 đẩy lỗi; lỗi khác lần đầu gom thành phố từ trang discover, lần sau giữ rail đang có. Bấm thẻ mở `/home/destination?city=&catalogId=` (mục 4.18).

### 4.17 Đăng chuyến lên cộng đồng (`features/trips/trip-publish/`) 🟢

Theo Stitch “Đăng Chuyến Đi Lên Cộng Đồng - Bottom Sheet” (`docs/design/screen/trip/trip-publish/`).
- **Mục đích:** tuyển bạn đồng hành trên chuyến UPCOMING. Tạo trip lập kế hoạch (FAB → `createTrip`) không tạo bài tuyển.
- **Lối vào:** banner Home. Thiếu tên hiển thị hoặc avatar thì mở sửa hồ sơ, xong chạy lại luồng. Không chặn số điện thoại.
- **Nhánh:** `GET /trips/mine`. Có trip UPCOMING thì mở sheet. Không có trip nhưng có `latestPublishDraft` thì hỏi tiếp tục. Không có cả hai thì mở `createTrip`. Đồng ý tiếp tục nháp vào lịch trình của luồng tạo chuyến (`createTripItinerary`); từ chối mở `createTrip`.
- **Sheet:** dòng nháp → `createTripItinerary` của trip đó. **Tạo chuyến đi mới** → `createTrip` (`CreateTripDetailsScreen`, rồi lịch trình và xác nhận). Đăng và Quản lý → `publishTripManage`. Không còn wizard 3 bước.
- **Quản lý:** công tắc **Đăng tuyển gấp** (`urgent`) chỉ ở `publishTripManage`. Lưu, Đăng và Mở lại tuyển gửi `urgent` qua `PATCH /trips/:id/recruitment` trước khi publish hoặc reopen.
- **Đăng:** mỗi lần bấm một `Idempotency-Key`, giữ cho mọi retry. 409 mà mine đã `effectiveState` OPEN thì coi là thành công. `RECRUITMENT_IMPACT_ACK_REQUIRED` mở dialog rồi gửi lại.
- **Route:** `/trips/publish/manage/:tripId` (`publishTripManage`). Tạo chuyến dùng `/trips/create`.
- **Test:** `test/features/trips/trip_publish/trip_publish_flow_test.dart`.

### 4.18 Home — chuyến đi theo điểm đến (`features/home/destination_trips/`, route `destinationTrips`) 🟢

Theo Stitch “Chuyến Đi Theo Điểm Đến - Đà Lạt” (`docs/design/screen/explore/destination-trips/`).
- **Mục đích:** xem chuyến PUBLIC đang tuyển và địa điểm nổi bật của một thành phố. Lối vào: thẻ điểm đến trên Explore → `/home/destination?city=` (có thể kèm `catalogId`). Root navigator, che bottom nav của shell.
- **Dữ liệu:** `GET /trips/destinations/catalog?q=` để khớp tên thành phố, `GET /trips/discover` (`destinationCatalogId` khi khớp catalog, không thì `search` = tên thành phố; `category` `all|weekend|budget|camping`, `seed`, `timezoneOffsetMinutes`), `GET /trips/destinations/catalog/{id}/places?sort=POPULAR`.
- **Editorial:** repository không gắn thời tiết, độ cao, mùa, chi phí hay spot mẫu. `applyDestinationEditorial` chỉ còn cho test parser. Hero ẩn chip thời tiết và hàng thống kê khi catalog không trả các field đó. Places rỗng thì empty view.
- **Lọc client:** “Đang tuyển gấp” hiện các chuyến người đăng bật `urgent` khi đăng (`PATCH /trips/:id/recruitment`). “Bạn bè” lọc `tripType == friends` trên trang discover đã tải; request server của hai chip này vẫn `category=all`.
- **Hành động:** Lịch trình → `/trips/:tripId`; Tham gia → `POST /trips/:tripId/join` (nút khóa khi đang gửi); bookmark và trái tim chỉ local; “Tạo chuyến đi tới …” → `createTrip`; “Xem tất cả” tăng `places` limit lên 20. Bấm một địa điểm nổi bật mở `/home/places/:placeId`. Không còn nút thêm spot vào lịch trình. Lọc hoặc search lỗi giữ danh sách và hiện câu lỗi ngắn.
- **UI:** loading skeleton, empty chuyến/địa điểm, error + thử lại, 401 không retry. Pull-to-refresh đổi seed.
- **Test:** `test/features/home/destination_trips_controller_test.dart`, `destination_trips_screen_test.dart`.

### 4.20 Travel DNA — bản đồ radar (`features/travel-dna/`, route `travelDnaRadar`) ✅

Theo Stitch **Bản Đồ Radar Travel DNA Chi Tiết** (`docs/design/screen/travel-dna/radar.html`, ảnh `radar.png`).
- **Lối vào:** thẻ Travel DNA trên hồ sơ, nút “Khám phá bản đồ radar DNA” → `/profile/travel-dna`. Route nằm trong nhánh Profile nên bottom nav của shell vẫn hiện. Quay lại `pop`, không có stack thì về hồ sơ.
- **Dữ liệu:** `GET /travel-dna/radar`. DNA người đang đăng nhập kèm `shortLabel` và `badgeTitle`, trung bình cộng đồng, `dominantPercentile`, tối đa 2 địa điểm APPROVED cho mỗi trục trong top 6, một chuyến PUBLIC khớp nhất, và bạn bè có độ hợp DNA ≥ 70 (sắp điểm giảm). Tên và avatar người xem từ `profileControllerProvider` (`GET /users/me`). Hạng và điểm từ showcase khi đã tải.
- **Suy ra trên client:** chuyến đi phân tích = tổng `tripTypeCount` của các trục kiểu chuyến; điểm check-in = tổng `activityCount`; độ khớp chân dung = điểm trục nổi bật, kẹp 0–100; radar lấy tối đa 6 trục. Chip spotlight (`Top n%` + nhãn ngắn) chỉ khi có `dominantPercentile`. Nhãn độ hợp: ≥ 90 Cực kỳ hợp, ≥ 80 Rất ăn ý, còn lại trong danh sách đã lọc là Khá ổn. Thẻ radar cắt 3 bạn đầu; nút tìm bạn mở `/profile/travel-dna/companions` với đủ danh sách, chỉ xem vì chưa có hồ sơ người khác. Không có `journey` thì ẩn thẻ hành trình. Xem hành trình → `tripDetail`.
- **UI:** loading skeleton, empty khi chưa có badge hoặc chưa có bạn hợp gu, error + thử lại, 401 không retry. Pull-to-refresh giữ dữ liệu cũ nếu lần tải lại lỗi. Bật/tắt “So sánh cộng đồng”. Không còn nút mời nhóm. Nút chia sẻ mở share sheet.
- **Test:** `test/features/travel_dna/travel_dna_radar_view_test.dart`.

### 4.21 Khoảnh Khắc Hành Trình — `features/profile/user-memories/`, route `userMemories` ✅

Theo Stitch **Khoảnh Khắc Hành Trình - Trip Memories & Gallery** (`docs/design/screen/profile/user-memories/`).
- **Lối vào:** dải “Khoảnh Khắc Hành Trình” trên tab Chuyến đi của hồ sơ (tiêu đề, ảnh xem trước, ô thêm ảnh) → `/profile/memories`. Route nằm trong nhánh Profile nên bottom nav của shell vẫn hiện. Quay lại `pop`, không có stack thì về hồ sơ.
- **Dữ liệu:** `GET /trips/memories/mine` (ảnh do chính user đăng, chỉ chuyến `TripMember` ACTIVE, mọi trạng thái chuyến). Query: `tripId` (bỏ trống = Tất cả), `year`/`month`/`utcOffsetMinutes` (tháng lịch máy, dùng cho điểm nhấn), `q` (caption), `cursor`, `limit`. Trang đầu kèm `collections` (`tripId`, `name`, `status`, `memoryCount`) và `highlight` (ảnh trong tháng có nhiều tim nhất; hòa thì ảnh mới hơn; không có thì null). `meta.totalCount` là tổng ảnh của bộ đang chọn. Trang sau chỉ nối `data`. Tim: `POST`/`DELETE /trips/memories/:memoryId/like`, response `{ likeCount, liked }`. Không còn datamock.
- **Lọc:** chip đầu “Tất cả ảnh (n)” với n = tổng `memoryCount`. Chip sau là tên chuyến và số ảnh; chọn chip gọi lại API với `tripId`. Ô tìm gửi `q`, không lọc cục bộ. Quản lý mở danh sách `collections` đã tải (tên, trạng thái, số ảnh), tìm theo tên trên client; chọn một dòng thì đóng và chọn đúng chip. Đổi lưới chỉ đổi chiều cao ô, luôn hai cột đều.
- **UI:** phụ đề header là `{totalCount} kỷ niệm`. Điểm nhấn chỉ khi `highlight != null`: ảnh, ngày, tên chuyến, caption, số tim (và badge nếu API trả). Không còn Photo Hunter, Teal Cloud, điểm 4.9 hay tác giả giả. Tim gọi API rồi ghi số trả về. Loading skeleton, empty khi hết ảnh, error + thử lại, 401 không retry. Pull-to-refresh giữ dữ liệu cũ nếu lần tải lại lỗi. Cuộn cuối tải trang cursor. Chia sẻ mở share sheet. Bấm ảnh mở viewer toàn màn hình bằng `Navigator.push`.
- **Test:** `test/features/profile/user_memories_view_test.dart` (chip, like), `user_memories_screen_test.dart` (highlight null), navigation trong `profile_screen_test.dart`. Backend: `trip-memories.service.spec.ts` (mine, highlight hòa tim, like).

### 4.22 Điểm Đến Đã Lưu — `features/profile/user-saved-trip/`, route `savedPlaces` ✅

Theo Stitch **Địa Điểm Đã Lưu - Saved Places** (`docs/design/screen/profile/user-saved-trip/`).
- **Lối vào:** tab Đã lưu trên hồ sơ, **Xem tất cả** hoặc bấm một mục xem trước → `/profile/saved-places`. Route nằm trong nhánh Profile nên bottom nav của shell vẫn hiện. Quay lại `pop`, không có stack thì về hồ sơ. Mục xem trước trên hồ sơ vẫn là datamock showcase; danh sách đầy đủ lấy từ API đã lưu.
- **Dữ liệu:** `GET /places/saved/me` (`page`, `limit` 100, mới lưu nhất) được gọi đến hết trang trước khi danh sách sẵn sàng, cùng `GET /places/saved/count`. Trang sau lỗi thì giữ các trang đã có và nút thử lại. Bỏ lưu: `DELETE /places/{placeId}/save`, rồi tải lại từ trang 1. Bộ sưu tập: `GET /place-collections/mine`, tạo bằng `POST /place-collections`. Chọn một bộ gọi `GET /place-collections/{id}` và hiện `places` của detail. Không còn datamock cho danh sách thật. `saved_places_datamock.dart` chỉ là hợp đồng cho test. Hợp đồng không có ảnh bìa, số đánh giá, query tìm kiếm, lọc category, hay tour AI.
- **Lọc trên client:** chip Tất cả dùng `count` (nếu count lỗi thì `meta.total`) khi đang xem danh sách đã lưu; khi đang mở một bộ sưu tập thì đếm trên `places` của detail. Bốn nhóm còn lại map `PLACE_CATEGORY` (ẩm thực, biển/nghỉ dưỡng, văn hóa, núi/cắm trại) trên tập đã tải hết hoặc trên bộ đang mở. Ô tìm lọc local trên cùng tập đó. Bộ sưu tập của user hiện tối đa 2 thẻ, “Tất cả” mở sheet. Nhãn “Mới lưu nhất” là chữ tĩnh vì API luôn trả `createdAt` giảm dần.
- **Bản đồ và chuyến đi:** nút bản đồ mở sheet Google Map, ghim từ tọa độ của địa điểm đã lưu đang nằm trong bộ lọc (khi đang xem bộ sưu tập thì chỉ ghim mục vừa thuộc bộ vừa đã lưu). Không có tọa độ thì sheet báo, không snackbar. Thêm vào chuyến đi: `GET /trips?mine=true` (chỉ chuyến user sở hữu hoặc là member ACTIVE), rồi `GET /trips/{tripId}/itineraries`; nếu `canManageItinerary` là false thì báo không có quyền. Chọn ngày gọi `POST /trips/{tripId}/itineraries/items/batch` với một item (`dayId`, `placeId`, `title`, `orderIndex` 0). Không còn banner tạo tour AI.
- **UI:** badge số địa điểm, thẻ có category, địa điểm, điểm trung bình. Bỏ lưu chỉ hiện khi địa điểm nằm trong danh sách đã lưu. Chia sẻ mở share sheet, kèm link Google Maps khi có tọa độ. Ảnh bìa không có trong hợp đồng địa điểm đã lưu nên dùng ô màu theo nhóm. Loading skeleton, empty khi chưa lưu, error + thử lại, 401 không retry. Pull-to-refresh giữ dữ liệu cũ nếu lần tải lại lỗi.
- **Test:** `saved_places_models_test.dart`, `saved_places_view_test.dart`, `saved_places_controller_test.dart`, `saved_place_trip_test.dart`, `saved_places_screen_test.dart`, navigation trong `profile_screen_test.dart`.

### 4.23 Home — chi tiết điểm đến (`features/home/places/place-details/`, route `placeDetail`) 🟢

Theo Stitch **Chi Tiết Điểm Đến & Đánh Giá - Place Detail**.
- **Lối vào:** route `/home/places/:placeId`, root navigator, che bottom nav. Quay lại `pop`, không có stack thì về Home. Thẻ địa điểm trên tab Địa Điểm, màn nổi bật, địa điểm của một thành phố, bộ sưu tập và danh sách đã lưu đều mở route này. Nút lưu trên thẻ vẫn mở sheet bộ sưu tập.
- **Dữ liệu:** `GET /places/{id}`, `GET /places/{id}/reviews/summary`, `GET /places/{id}/reviews` (trang 10), `GET /places/{id}/reviews/me`, `GET /places/{id}/save/status`, `GET /social/posts/place/{placeId}` (trang 8). Meta đánh giá thiếu `hasNextPage` thì client tính từ `page` và `totalPages`. Đánh giá không có `updatedAt` thì dùng `createdAt`. Ảnh khoảnh khắc resolve qua `GET /media/{id}` khi post có `mediaId`; lỗi media chỉ làm mất ảnh. Bài viết lỗi (trừ 401) thì ẩn mục khoảnh khắc, không làm hỏng cả màn. Lưu: status hoặc chỗ nằm trong `GET /place-collections/mine`. Gửi đánh giá `POST /places/{id}/reviews` (rating 1–5, comment tùy chọn). Đã có đánh giá của mình thì chỉ xóa bằng `DELETE /places/reviews/{reviewId}` vì hợp đồng không có sửa. Thêm lịch trình dùng lại `GET /trips?mine=true`, `GET /trips/{id}/itineraries` và `POST .../itineraries/items/batch`.
- **UI:** hero ảnh bìa, tên, category, địa chỉ, điểm và số đánh giá, bốn hành động (lịch trình, đánh giá, chỉ đường, chia sẻ), giới thiệu thu gọn, dải khoảnh khắc khi có bài, phân bổ sao và danh sách đánh giá. Chip sao lọc trên các trang đã tải, không gọi API mới. Nút xem thêm lấy trang sau; trang sau lỗi giữ danh sách. Chỉ đường và chia sẻ mở share sheet kèm link Google Maps. Không hiện giờ mở cửa, vé, phương tiện hay tag vì `PlaceResponseDto` không có các field đó. Loading skeleton, error + thử lại, 401 không retry. Pull-to-refresh khi đã có dữ liệu mà lỗi thì giữ màn và báo câu ngắn.
- **Test:** `place_detail_view_test.dart`, `place_detail_controller_test.dart`, `place_detail_screen_test.dart`. Datamock chỉ cho test.

### 4.24 Social — Trip Messages Hub (`features/chats/`, route `chats`) 🟢

Theo Stitch **Danh Sách Đoạn Tin Nhắn - Trip Messages Hub** (project Teal Horizon `7389647509421703144`, screen `f7f8a69ffef64d8f91553c815af3179e`). Design: `docs/design/screen/chats/trip-messages-hub/screenshot.jpg`.
- **Lối vào:** tab Chat (`/chats`) → `ChatsHubScreen`. Bottom nav shell vẫn hiện. Tab Social (`/social`) mở Bảng Tin (mục 4.27).
- **Dữ liệu:** `GET /chats/hub` (có trên OpenAPI). Model freezed `ChatsHub` / trip thread / friend thread / active pulse. Datamock dùng trong test.
- **UI:** header avatar + Tin Nhắn / Teal Horizon Hub; pill lọc Tất cả · Chuyến đi · Bạn bè · Chưa đọc; `AppSearchBar`; banner pulse chuyến đang diễn ra; danh sách kênh trip; danh sách DM 1-on-1. Bấm DM → `/chats/friend/:conversationId` (mục 4.25). Bấm kênh trip / pulse → `/chats/trip/:tripId` (mục 4.26). Tạo chat / xem thêm → snackbar “Tính năng đang phát triển”. Loading skeleton, empty, error + thử lại, 401 không retry. Pull-to-refresh.
- **Lọc:** mặc định tab Chuyến đi; tìm kiếm local trên title / last message / sender / role.
- **Test:** `chats_hub_models_test.dart`, `chats_hub_screen_test.dart`.

### 4.25 Chats — Friend Chat 1-on-1 (`features/chats/friend-chat/`, route `friendChat`) 🟢

Theo Stitch **Khung Chat 1-on-1 Chi Tiết - Alex Nguyễn** (project `7389647509421703144`, screen `4cedf415e7894f028ae04e14cb45ede3`). Design: `docs/design/screen/chats/friend-chat/screenshot.jpg`.
- **Lối vào:** từ hub Bạn bè / tile DM → `/chats/friend/:conversationId` (root navigator, che bottom nav).
- **Dữ liệu:** `GET /friends/conversations/{id}/thread`, `POST .../read`, `POST .../messages` TEXT và `TRIP_INVITE`. Socket namespace `/friends`, sự kiện `friend:message:new` (shape UI hoặc hàng lưu). Gửi lỗi đánh dấu bubble `FAILED`. Chưa có typing bạn bè và `PLACE_CARD`. Datamock chỉ cho test.
- **UI:** glass header (back, avatar online, badge Trưởng nhóm, info); banner chuyến đi chung; stream tin nhắn (bubble, place card Faifo, trip invite Đà Lạt); typing indicator; shortcut chips + composer (+ / camera / mic / send); sheet mời vào chuyến đi. Skeleton, error + thử lại, 401 không retry.
- **Test:** `friend_chat_models_test.dart`, `friend_chat_screen_test.dart`.

### 4.26 Chats — Trip Group Chat (`features/chats/trip-chats/`, route `tripChat`) 🟢

Theo Stitch **Khung Chat Chuyến Đi Chi Tiết - Trip Group Chat** (project `7389647509421703144`, screen `88e9d7c0d411402e85d02415ee3fe4a4`). Design: `docs/design/screen/chats/trip-group-chat/screenshot.jpg`.
- **Lối vào:** từ hub kênh chuyến đi / banner pulse → `/chats/trip/:tripId` (root navigator, che bottom nav).
- **Dữ liệu:** `GET /trips/{tripId}/chat/thread`, `POST .../messages` TEXT hoặc IMAGE (sau upload folder `trips`), `POST .../messages/read`, reaction `POST/DELETE .../reactions`. Socket `trip:message` phát DTO UI (`kind`). Giữ reaction trên cả bubble TEXT. Datamock chỉ cho test.
- **UI:** glass header (back, tiêu đề trip, live members, more); pinned next-activity bar (Check-in / mở itinerary); stream (system chip, bubble nhóm + role badge, photo + reactions, expense card → expenses); typing; composer (+ mở utility: vị trí live / chia tiền / album / thêm chặng). Skeleton, error + thử lại, 401 không retry.
- **Test:** `trip_chat_models_test.dart`, `trip_chat_screen_test.dart`.

### 4.27 Social — Bảng Tin cộng đồng (`features/social/`, route `social`) 🟢

Theo Stitch **Mạng Xã Hội Du Lịch - Social Feed (Addictive UX)** (project Teal Horizon `7389647509421703144`, screen `c586ae7545d14197b9dbc6d0e3d479a7`). Design: `docs/screens/social_feed/stitch/{reference.jpg,screen.html}`.
- **Lối vào:** tab Social (`/social`) → `SocialScreen`. Bottom nav shell vẫn hiện.
- **Dữ liệu:** `GET /social/feed` (composite Stitch: header/stories/tabs/chips/composer + items REVIEW/CHALLENGE/TRIP_RECRUIT + `meta` phân trang). Query: `tab`=`explore|following|nearby`, `topic` (`HIDDEN_EATS`/`PHOTO_SPOTS`/`ITINERARY_2N1D`/`FIND_BUDDY`), `page`/`limit`, `lat`/`lng` khi `nearby`. Đổi tab/topic → refetch server; tab Gần bạn xin location qua `deviceLocationController`. Like: `POST`/`DELETE /social/posts/:id/like`. Bookmark: `POST`/`DELETE /social/posts/:id/save` (optimistic + rollback). Share: `POST /social/posts/:id/share`. Challenge join: `POST /social/challenges/:id/join` (cập nhật thẻ). Load more: nút “Xem thêm” theo `meta.hasNextPage`. **Tạo nội dung:** composer/ảnh/check-in → sheet create post (upload `MediaUploadFolder.posts` + `POST /social/posts`); story self (+) → create story (`POST /social/stories`); Xem tất cả / tap story khác → fullscreen viewer. Rủ bạn → `createTrip`. **Điều hướng sâu:** bấm thẻ/caption → `/social/posts/:postId`; bấm bình luận → cùng route + `?focus=comments` (mục 4.28); CTA địa điểm → `placeDetail`; trip recruit join → `POST /trips/:tripId/join`; Bạn bè → tab Chats hub; **search** → `/social/find-friends` (mục 4.29). Không còn fallback datamock runtime; `social_feed_datamock.dart` chỉ cho test. Còn demo/snackbar: notifications inbox, menu more trên thẻ.
- **UI:** top bar Bảng Tin + streak + search/notifications/Bạn bè; khoảnh khắc ngang (LIVE/Mới; avatar null → placeholder); tab Khám phá / Đang theo dõi / Gần bạn + topic chips; composer; thẻ review (tip + media grid + CTA lịch trình); thẻ thử thách tuần; thẻ tuyển thành viên trip (CTA lịch trình → `/trips/:tripId`). Skeleton, empty, error + thử lại, 401 không retry. Pull-to-refresh.
- **Test:** `social_feed_models_test.dart`.

### 4.28 Social — Chi tiết bài viết & bình luận (`features/social/social-details/`, route `postDetail`) 🟢

Theo Stitch **Chi Tiết Bài Viết & Bình Luận** (project Teal Horizon `7389647509421703144`, screen `6411daf1144743f682b355bc2ddcb071`). Design: `docs/design/screen/social/social-details/{screenshot.jpg,screen.html}`.
- **Lối vào:** feed Social → bấm thẻ bài / caption → `/social/posts/:postId` (root navigator). Bấm bình luận trên thẻ → cùng route với `?focus=comments` (cuộn tới mục bình luận). Quay lại `pop`, không stack thì về tab Social.
- **Dữ liệu (API thật):** `GET /social/posts/:id`, `GET`/`POST /social/posts/:id/comments`, like/save/share. Model freezed trong `social-details/data/models/`. Datamock chỉ cho test.
- **State:** `socialPostDetailsControllerProvider(postId)` — post + comments, like/bookmark optimistic, gửi comment, load more, sort client.
- **UI Stitch:** header Bài Viết + Travel Log; tác giả + Theo dõi (stub); thẻ địa điểm → `placeDetail`; caption/hashtag; gallery; stats + action bar; danh sách bình luận + composer sticky. Skeleton, error + thử lại, 401 không retry, pull-to-refresh.
- **Chưa làm theo Stitch:** follow thật, nested reply/like comment, upload ảnh trong comment.
- **Fullscreen gallery:** ảnh bài của người khác mở `PublicImageViewerScreen` (mục 4.31) từ feed hoặc chi tiết bài.
- **Test:** `social_post_detail_models_test.dart`.

### 4.29 Friends — Tìm kiếm bạn bè & đồng hành (`features/friends/`, route `findFriends`) ✅

Theo Stitch **Tìm Kiếm Bạn Bè & Bạn Đồng Hành - Find Friends** (project Teal Horizon `7389647509421703144`, screen `cac136876281409d866009b99b3413f9`). Design: `docs/design/screen/friends/find-friends/screenshot.jpg`.
- **Lối vào:** tab Social → icon **tìm kiếm** trên top bar → `/social/find-friends` (nhánh Social, bottom nav shell vẫn hiện). Quay lại `pop`, không stack thì về Social.
- **Dữ liệu:** `GET /friends/find?q=&lat=&lng=` (composite: `dnaBanner`, `results` enrich status/DNA/shared-trips/presence, `nearbySuggestions`; `recentSearches` luôn `[]` từ server). Opt-in nearby: xin location → `PUT /friends/discovery-location` rồi find; không đọc danh bạ máy. CTA: `POST /friends/requests`, `POST /follow`, `POST /friends/:id/conversation` rồi `friendChat`. Không fallback datamock runtime (fixture chỉ unit test).
- **Model** freezed: `FindFriendsPage`, `FindFriendsUser` (action `ADD_FRIEND` | `REQUEST_SENT` | `MESSAGE` | `FOLLOW`), `FindFriendsNearbySuggestion`, `FindFriendsDnaBanner`, …
- **State:** `findFriendsControllerProvider` (autoDispose, tắt auto-retry) — query mặc định trống, debounce 350ms, recent searches `SharedPreferences`, không optimistic success khi gửi kết bạn lỗi, `busyUserId` chống double-submit.
- **UI Stitch:** top bar back + ô tìm (clear); lịch sử tìm gần đây; banner Travel DNA → `travelDnaRadar`; danh sách kết quả (Kết bạn / Đã gửi / Nhắn tin → `friendChat` / Theo dõi); section **Gợi ý gần bạn** (ẩn nếu rỗng, tối đa 2 thẻ). Skeleton, empty, error + thử lại, 401 không retry, pull-to-refresh.
- **Chưa làm theo Stitch:** QR scanner trên ô tìm, filter chips (rail trống trong HTML).
- **Test:** `find_friends_models_test.dart`.

### 4.30 Friends — Hub bạn bè & lời mời (`features/friends/`, route `friendsHub`) ✅

Theo Stitch **Bạn Bè & Lời Mời Kết Bạn - Friends Hub** (project Teal Horizon `7389647509421703144`, screen `b85b4b6b321d438bbc8450fb8601cd12`). Design: `docs/design/screen/friends/friends-hub/screenshot.png`.
- **Lối vào:** tab Social → icon **bạn bè** trên top bar → `/social/friends` (nhánh Social, bottom nav vẫn hiện). Quay lại `pop`, không stack thì về Social. Icon tìm trên hub → `findFriends`.
- **Dữ liệu (API thật, OpenAPI enrich):** song song `GET /friends`, `GET /friends/requests/received`, `GET /friends/requests/sent`. Payload user: `displayName`, `avatarUrl`, `isOnline`, `verified`, badge/meta; friendship thêm `conversationId`, `sharedTripsCount`, `dnaMatchPercent`. Hành động: `POST .../accept|reject`, `DELETE /friends/requests/:id`, `DELETE /friends/:friendId`, `POST /friends/:id/conversation` → `friendChat`. Không fallback datamock runtime.
- **Model** freezed: `FriendsHubPage`, `FriendsHubUser`, `FriendsHubRequest`, `FriendsHubFriend`.
- **State:** `friendsHubControllerProvider` (autoDispose, tắt auto-retry) — soft refresh giữ data; tab `Bạn bè|Đã nhận|Đã gửi`; sort `Gần đây|A-Z|Online`; lọc query client-side; `busyRequestId` / `busyFriendId`.
- **UI Stitch:** top bar back + tiêu đề + search (không QR/tune); capsule tabs; search bar; tab Bạn bè: preview lời mời + banner đã gửi + danh sách bạn (nhắn tin / hủy kết bạn); empty friends CTA **Tìm bạn** → `findFriends`; tab Đã nhận / Đã gửi đầy đủ. Skeleton lần đầu, error + **Thử lại**, 401, pull-to-refresh.
- **Test:** `friends_hub_models_test.dart`, `friends_hub_controller_test.dart`; BE `friends-hub.service.spec.ts`.

### 4.31 Public Images — xem ảnh toàn màn hình & bản đồ vệ tinh (`features/public-images/`) 🟢

Theo Stitch **Teal Horizon Travel UI System** (`7389647509421703144`):
1. `a2fba0f39d20444b88160077dca4093a` — Fullscreen Photo Viewer  
2. `8bbbf810ccfb470fa25aaac30f469ab7` — Menu Tùy Chọn 3 Chấm  
3. `6d490078fa574daba7147fe29dba9d14` — Xem Vị Trí Trên Bản Đồ (vệ tinh)  
Refs: `lib/features/public-images/.stitch/`.
- **Route (root navigator):** `/images/:albumId` (`publicImageViewer`, query `index` / `imageId`) và `/images/:albumId/map` (`publicImageMap`, query `imageId`). Album demo mặc định `ban-co-sunrise`.
- **UI viewer:** nền tối `#0A0F12`, top bar (đóng / counter+timestamp / xoay / EXIF / more), pinch-zoom + double-tap, filmstrip, caption + share. Ẩn like, bình luận, tải HD, đặt bìa và xóa vì chưa có API. Sheet còn xem bản đồ và copy link (URL ảnh thật). Ẩn chrome → pill vị trí.
- **UI map:** Google Map hybrid/terrain/normal, switcher lớp, pin camera + pulse, cụm zoom/recenter, thẻ glass (thumbnail, GPS, độ cao, thời điểm, Google Maps / Chỉ đường qua `share_plus`).
- **Kiến trúc:** model freezed `PublicImageAlbum` / `PublicImageItem`. Viewer chỉ mở album đã seed trong bộ nhớ (post `social-post-{postId}` hoặc album kỷ niệm). Không gọi `/public-images/albums/...` và không fallback datamock. Album trống thì báo lỗi. `publicImageViewerControllerProvider` (family theo album + index/imageId).
- **Test:** `test/features/public_images/public_image_formatters_test.dart`.
- **Lối vào Social:** chạm ảnh trên thẻ review feed (bài của người khác) hoặc gallery/fullscreen ở `SocialPostDetailScreen` → seed album `social-post-{postId}` rồi mở `/images/...`. Bài của chính mình không mở viewer công khai (feed → chi tiết bài; detail → snackbar).

### 4.32 Ranking — Bảng xếp hạng & gamification (`features/ranking/`) 🟢

Theo Stitch **Teal Horizon Travel UI System** (`7389647509421703144`):
1. `16d66139fbc34464a18104e443be3ab8` — Bảng Xếp Hạng & Gamification - Travel Leaderboard  
Refs: `lib/features/ranking/.stitch/`.
- **Route:** `/social/ranking` (`ranking`, nhánh Social, còn bottom nav). Quay lại `pop`, không stack thì về Trips (lối vào từ Trips).
- **UI:** top bar + `RankingPeriodFilter` (WEEK/MONTH/SEASON/ALL_TIME); podium Top 3; me card progress tới **Top 10** (`nextTierLabel`/`nextRankPoints`/`progressHint`); **`AchivementProgressSection`** (Travel Tier + Thành tích từ `/ranking/me`); list từ hạng 4; section nhiệm vụ + claim khi `claimable`. Skeleton, error + thử lại, 401, pull-to-refresh.
- **API thật:** `GET /ranking/leaderboard?period=` + `GET /ranking/me?period=` + `GET /ranking/quests` + `POST /ranking/quests/:id/claim`. Enrich: badge travel-style (`badgeLabel`/`badgeIcon`), seasonLabel, Top-10 progress. Compose `RankingPage` ở datasource; repository **không** fallback datamock (fixture chỉ test). `/me` hoặc quests lỗi không fail cả trang.
- **Kiến trúc:** freezed `RankingPage` / `RankingTraveler` / `RankingMeCard` / `RankingQuest` (`claimed`/`claimable`); `rankingControllerProvider` (`setPeriod`, `claimQuest`, autoDispose, tắt auto-retry).
- **Test:** `ranking_models_test.dart`, `ranking_controller_test.dart`.
- **Lối vào:** tab Trips → icon cúp (`emoji_events`, có animation) bên phải nút **Nhập mã mời** → `/social/ranking`.

### 4.33 Achivement — Nhiệm vụ chuyến đi / thưởng / Travel Tier (`features/achivement/`) 🟢

Theo Stitch Teal Horizon (`docs/design/screen/achivement/`):
1. `21d411605b4945a394e2ca5b09c32195` — Chi tiết trip + nhiệm vụ  
2. `82a7e0e457024e90b570b3fc2e6fea07` — Bottom sheet nhận thưởng  
3. `045263ced1e64a21a977de72e555b100` — Ranking + Travel Tier / Thành tích  

- **Không route riêng.** Embed:
  - `TripMissionsSection` trên `TripDetailScreen` (member only) → `GET /trips/:id/missions`; CTA mở itinerary / memories.
  - `showCompletionRewardSheet` sau `claimReward` → breakdown `basePoints` + `missionPoints` × `multiplierUsed`.
  - `AchivementProgressSection` trên `RankingScreen` → luôn hiện skeleton/error/empty/data (không `shrink`); fallback Tân binh nếu thiếu tier.
  - `TripMissionsEntryChip` trên thẻ trip (ongoing / list upcoming-completed) → mở detail để thấy nhiệm vụ.
- **API thật:** `GET /trips/{tripId}/missions`, `POST /trips/{tripId}/completion` (breakdown), `GET /ranking/me` (travelTier/achievements; backend upsert `UserRanking` nếu chưa có). Datamock chỉ fixture test.
- **Kiến trúc:** freezed `TripMissionsPage` / `TripMissionItem` / `TravelTier` / `AchievementProgress` / `AchivementCompletionResult`; `tripMissionsControllerProvider(tripId)`, `achivementProgressControllerProvider`; widgets trong `presentation/widgets/`.
- **Trip detail:** `TripDetailRewardClaim` mở rộng fields breakdown; claim invalidate missions.
- **Test:** `test/features/achivement/achivement_models_test.dart`.

---

## 5. Hạ tầng core — `lib/core/`

| Thư mục | Nội dung |
|---|---|
| `config/` | `AppConfig` (`apiBaseUrl`, `socketUrl`, Google client id, `shareHost` qua `--dart-define`), `dev.json` |
| `realtime/` | `TripSocketChannel` + `TripSocketClient`: Socket.IO websocket-only, auth token, ref-count phòng trip, emit `trip:join`/`leave`, nghe `trip:joined`/`error`/`timeline`; `tripSocketClientProvider` trong `core_provider.dart` |
| `deep_link/` | `DeepLinkService` + `deepLinkServiceProvider`: lọc App Links / Universal Links `https://<SHARE_HOST>/s/{token}` → `/shared/{token}` (mục 4.9) |
| `networks/` | `ApiClient` (3 Dio: chính / refresh / retry, timeout 15s, có `get/post/put/patch/delete` + `requiresAuth`, broadcast `tokenRefreshes` cho socket reconnect), `AuthInterceptor`, `TokenRefreshService`, `ApiException`, `TokenRefreshException`, `ApiResponseParser` |
| `providers/core_provider.dart` | `tokenStorageProvider`, `apiClientProvider`, `tripSocketClientProvider` |
| `session/` | `sessionInvalidationProvider` — refresh fail → `AuthController` rebuild → về login |
| `storage/` | `TokenStorage` (flutter_secure_storage) |
| `notification/` | `NotificationService`, `DeviceInstallationService` |
| `location/` | `DeviceLocationService` (geolocator) |
| `maps/` | `google_polyline_decoder.dart` |
| `theme/` | Design token: `AppColors`, `AppTypography`, `AppSpacing`, `AppRadius`, `AppSizes`, `AppShadows`, `AppGradients`, `AppTheme.light` |
| `widget/` | Shared widget prefix `App*`: scaffold, top_bar, bottom_navigation, background, button, icon_button, pressable, chip, badge, text_field, search_bar, segmented_control, card, stat_card, warning_card, glass_surface, avatar, section_header, progress_bar, bottom_sheet, loading, skeleton, empty_view, error_view |

Response envelope backend (đa số REST): `{ success, data, meta?, summary? }`. Phân trang offset dùng `PageMeta`/`PageResult`; phân trang cursor dùng `CursorMeta`/`CursorResult` (trong `trips/data/models/trip_pagination.dart`). Một số endpoint mới (timeline, memories, join-requests) trả `{ data, meta }` trực tiếp — xem datasource từng feature.

---

## 6. Kiến trúc & luồng dữ liệu (theo code thực tế)

```
Screen / Widget (presentation/)          ConsumerWidget / ConsumerStatefulWidget
   │ ref.watch(state) · ref.read(...notifier).action()
   ▼
Controller (application/)                Notifier / AsyncNotifier [.family]
   │ ref.watch / ref.read(xxxRepositoryProvider)
   ▼
Repository (data/repositories/)          gom datasource, trả model sạch
   │
   ▼
RemoteDataSource (data/datasources/)  ── LocalDataSource (shared_preferences, nếu có)
   │ ref.watch(apiClientProvider)
   ▼
ApiClient (core/networks/)               Dio + AuthInterceptor + TokenRefreshService
   ▼
Backend (backend)

Realtime (song song):
tripTimelineLiveProvider → tripSocketClientProvider.watchTrip(tripId)
   → Socket.IO TripGateway (SOCKET_URL)
```

Quy tắc đang được tuân thủ trong code:
- Widget không gọi Dio/datasource trực tiếp; chỉ đọc state và gọi method của controller.
- DI bằng Riverpod: mỗi feature có `provider/*_provider.dart` khai báo `Provider` cho DataSource & Repository; provider của Controller khai báo **ngay trong file controller**.
- Provider đọc dữ liệu đơn giản dùng `FutureProvider(.autoDispose.family)` (vd: `trip_creation_support_controller.dart`).
- Mutation: controller có cờ `_busy/_submitting` chống double-submit; sau khi thành công `ref.invalidate(...)` provider liên quan.
- Phân trang: state giữ `items + meta + isLoadingMore + loadMoreError`; lỗi load-more không xóa dữ liệu cũ.
- Model **hiện có** parse JSON **thủ công** (`fromJson`/`toJson`) — giữ nguyên, không tự refactor.
- Model **mới** bắt buộc dùng code generation (`freezed` / `json_serializable`) theo rule chính. `pubspec.yaml` đã có `freezed_annotation`, `json_annotation` và dev `freezed`, `json_serializable`, `build_runner`. Sinh lại bằng `dart run build_runner build` (bản 2.16 đã bỏ cờ `--delete-conflicting-outputs`).
- Không có tầng `domain/` riêng; model nằm trong `data/models/`.

---

## 7. Cấu trúc thư mục `lib/`

```
lib/
├── main.dart                 # Firebase.initializeApp → ProviderScope(TravelSocialApp)
├── firebase_options.dart
├── app/
│   ├── app.dart              # MaterialApp.router (AppTheme.light + routerProvider), nghe deep link → router.go
│   └── router/               # app_router.dart, main_shell.dart, router_names.dart
├── core/                     # xem mục 5 (gồm realtime/)
└── features/
    ├── auth/                 # application/ data/{datasources,models,repositories}/ presentation/ provider/ services/
    ├── device_token/         # application/ data/{datasource,model,repositories}/ provider/ service/
    ├── media/                # application/ data/{datasource,models,repository}/ providers/
    ├── profile/              # application/ data/{datasources,models,repositories}/ presentation/{screens,widgets}/ provider/
    ├── home/                 # Explore (mục 4.16): community + places/ (tab + tất cả nổi bật + place-details mục 4.23) + destination_trips/ (mục 4.18)
    ├── social/               # Bảng Tin (mục 4.27) + social-details/ chi tiết bài & bình luận (mục 4.28)
    ├── friends/              # Friends Hub + Tìm kiếm bạn bè (mục 4.29–4.30)
    ├── chats/                # Hub (4.24) + friend-chat/ (4.25) + trip-chats/ (4.26)
    └── trips/
        ├── application/      # create_trip, update_trip, trip_list (+dashboard), trip_cover,
        │                     # trip_feed_controllers (messages/mutation + timeline legacy dead),
        │                     # trip_members, trip_invitations, trip_interests,
        │                     # trip_creation_support (FutureProviders), device_location,
        │                     # trip_detail (legacy list-shape)
        ├── data/
        │   ├── datasources/trip_remote_datasource.dart
        │   ├── models/       # trip, trip_list_item, trip_destination, trip_enums, …
        │   └── repositories/trip_repository.dart
        ├── presentation/
        │   ├── screen/trip_screen.dart
        │   └── create_trip/  # 5 màn + TripCoverPicker + destination_map_overview + widgets
        ├── provider/trips_provider.dart
        ├── trip-itineraies/  # sub-feature lịch trình khi tạo trip (typo tên thư mục giữ nguyên)
        ├── trip-details/     # chi tiết + itinerary xem/sửa/check-in/map/share (mục 4.8–4.9)
        ├── trip-timeline/    # dòng thời gian + live socket (mục 4.11)
        ├── trip-memories/    # album kỷ niệm (mục 4.10)
        └── trip-invitation/  # duyệt join requests (4.12) + nhập mã mời (4.13) + mời bạn (4.19)
```

---

## 8. Quy ước đặt tên & vị trí

- Feature-first: `features/<feature>/{application, data, presentation, provider}`.
- Screen: `*_screen.dart`; widget riêng của feature trong `presentation/widgets/` (trips dùng file `*_widgets.dart` cạnh màn hình khi tạo trip).
- Shared widget: `core/widget/app_*.dart`; design token: `core/theme/`. Tái sử dụng trước khi tạo mới.
- Route mới: thêm tên vào `RouteNames` + khai báo trong `app_router.dart`; truyền object phức tạp qua `extra` kèm kiểm tra kiểu và màn fallback.
- Tên thư mục **chưa đồng nhất** (`datasource`/`datasources`, `provider`/`providers`, `repository`/`repositories`, `service`/`services`, `screen`/`screens`) và có typo (`auth_respository.dart`, `requets-create-trip`, `trip-itineraies`). Giữ nguyên tên hiện có, không tự đổi.

---

## 9. Chất lượng code (đo ngày 2026-10-17)

**Thời gian:** toàn app hiển thị ngày/giờ trip và hoạt động theo **UTC** khi liên quan lịch trình/album ngày trip (`trip_detail_formatters.dart` dùng `toUtc()`, `DestinationTimeConverter.toUtcIso`). Timeline full screen nhóm sự kiện theo **giờ local thiết bị**.

**`flutter analyze`** — 17 issues, 0 error, 0 warning:
- Info: `withOpacity` deprecated, Radio `groupValue/onChanged` deprecated, `onReorder` deprecated, import thừa, `__` thừa, thiếu `{}` trong if, `use_null_aware_elements`.

**`flutter test`** — sạch sau khi cập nhật `add_itinerary_activity_screen_test.dart` theo UI hiện tại (`Ghi chú (tùy chọn)`, `Đổi địa điểm khác`).

| File test | Nội dung | Kết quả |
|---|---|---|
| `test/core/maps/google_polyline_decoder_test.dart` | decode polyline | ✅ |
| `test/core/deep_link/deep_link_service_test.dart` | chỉ nhận link share hợp lệ | ✅ |
| `test/core/realtime/trip_socket_client_test.dart` | join/leave, auth refresh handshake, timeline fan-out, reconnect | ✅ |
| `test/app/router/app_auth_redirect_test.dart` | redirect auth giữ `?from=`, chống open-redirect | ✅ |
| `test/features/trips/trip_itinerary_models_test.dart` | parse itinerary, check-in, batch request | ✅ |
| `test/features/trips/trip_list_item_test.dart` | parse dashboard, dựng TripScreen | ✅ |
| `test/features/trips/trip_cover_controller_test.dart` + `create_trip/trip_cover_picker_test.dart` | upload ảnh bìa khi tạo trip | ✅ |
| `test/features/trips/trip_details/*_test.dart` | chi tiết, lịch trình, map, share, shared itinerary | ✅ |
| `test/features/trips/trip_memories/*_test.dart` | album: data, controller, view, screen, navigation | ✅ |
| `test/features/trips/trip_timeline/*_test.dart` | data, controller, view, live socket, screen, navigation → album | ✅ |
| `test/features/trips/trip_join_requests/*_test.dart` | data, controller, screen, navigation từ trip detail | ✅ |
| `test/features/trips/trip_join_by_code/*_test.dart` | nhập mã mời: normalize/preview, controller submit, screen Stitch | ✅ |
| `test/features/trips/trip_invite_friends/*_test.dart` | mời bạn: lọc, chọn theo chỗ trống, gửi lời mời, screen, navigation từ trip detail | ✅ |
| `test/features/trips/trip_expenses/trip_expenses_view_test.dart` | filter chi tiêu + formatters tiền VND | ✅ |
| `test/features/trips/trip_expenses/trip_expenses_settle_and_create_test.dart` | filter công nợ viewer, nhãn settle, validate CUSTOM, currency, format amount, create/settle action | ✅ |
| `test/features/trips/trip_expenses/trip_add_expense_screen_test.dart` | chrome Stitch form thêm khoản chi | ✅ |
| `test/features/trips/add_itinerary_activity_controller_test.dart` | controller thêm hoạt động, giờ UTC | ✅ |
| `test/features/trips/add_itinerary_activity_screen_test.dart` | widget thêm hoạt động, nhãn giờ UTC, ghi chú, đổi địa điểm | ✅ |
| `test/features/trips/create_trip_controller_test.dart` | finalize làm mới dashboard Trips | ✅ |
| `test/features/home/explore_home_models_test.dart` | parse datamock Explore feed | ✅ |
| `test/features/home/explore_places_models_test.dart` | parse datamock 3 mục tab Địa Điểm | ✅ |
| `test/features/home/explore_places_controller_test.dart` | bookmark, tim, giữ khi reload lỗi | ✅ |
| `test/features/home/explore_places_tab_test.dart` | 3 tiêu đề Stitch, bookmark mở sheet, thẻ mở chi tiết | ✅ |
| `test/features/home/explore_home_controller_test.dart` | filter chip, search, bookmark | ✅ |
| `test/features/home/destination_trips_controller_test.dart` | editorial Đà Lạt, filter server/client, search, bookmark, join | ✅ |
| `test/features/home/destination_trips_screen_test.dart` | chrome Stitch điểm đến + chip tuyển gấp | ✅ |
| `test/features/home/featured_destinations_view_test.dart` | phổ biến giữ thứ tự nguồn, lọc từ 4.8, sắp xếp lượt lưu khi được chọn | ✅ |
| `test/features/home/featured_destinations_screen_test.dart` | hai thẻ, tìm embedding không lọc local, giữ list khi tìm hoặc tải lại lỗi | ✅ |
| `test/features/home/place_detail_view_test.dart` | parse hợp đồng chi tiết địa điểm, phân bổ sao, lọc 5 sao | ✅ |
| `test/features/home/place_detail_controller_test.dart` | tải chi tiết, lọc không gọi lại API, giữ review khi trang sau lỗi, 401, gửi đánh giá | ✅ |
| `test/features/home/place_detail_screen_test.dart` | chrome Stitch, xem thêm mô tả, lọc 5 sao | ✅ |
| `test/features/profile/profile_showcase_test.dart` | parse datamock Travel DNA + format số | ✅ |
| `test/features/profile/profile_screen_test.dart` | chrome hồ sơ Stitch, đổi tab DNA và Đã lưu, mở khoảnh khắc và điểm đến đã lưu | ✅ |
| `test/features/profile/user_memories_view_test.dart` | chip gọi lại API theo tripId, like ghi số từ response | ✅ |
| `test/features/profile/saved_places_models_test.dart` | parse hợp đồng saved places | ✅ |
| `test/features/profile/saved_places_view_test.dart` | nhóm category, lọc, bộ sưu tập, ghim bản đồ, link chia sẻ | ✅ |
| `test/features/profile/saved_places_controller_test.dart` | count, tải hết trang, trang sau lỗi, bỏ lưu, chip không gọi lại API, mở bộ sưu tập | ✅ |
| `test/features/profile/saved_place_trip_test.dart` | request batch thêm vào ngày lịch trình, quyền sửa lịch trình | ✅ |
| `test/features/profile/saved_places_screen_test.dart` | chrome Stitch, lọc thẻ, empty | ✅ |
| `test/features/profile/user_memories_screen_test.dart` | highlight null thì ẩn điểm nhấn, không còn Photo Hunter / Teal Cloud | ✅ |
| `test/features/profile/edit_profile_format_test.dart` | che số điện thoại, đổi định dạng ngày sinh | ✅ |
| `test/features/profile/edit_profile_changes_test.dart` | xóa ngày sinh bằng null, xóa giới tính, location và address gửi riêng | ✅ |
| `test/features/profile/setting_notification_test.dart` | switch thông báo đẩy gửi notificationEnabled | ✅ |
| `test/features/profile/edit_profile_screen_test.dart` | chrome Stitch sửa hồ sơ, bỏ ngôn ngữ, thêm ngôn ngữ, đổi ngân sách, mở sửa số điện thoại | ✅ |
| `test/features/travel_dna/travel_dna_radar_view_test.dart` | map payload radar, ẩn chuyến null, mở trip detail và danh sách bạn, không còn nút mời nhóm | ✅ |
| `test/features/chats/chats_hub_models_test.dart` | parse datamock hub + lọc filter/search | ✅ |
| `test/features/chats/chats_hub_screen_test.dart` | chrome Stitch Tin Nhắn, đổi tab Bạn bè | ✅ |
| `test/features/social/social_feed_models_test.dart` | parse datamock Bảng Tin + tab/topic selection | ✅ |
| `test/features/social/social_post_detail_models_test.dart` | parse datamock chi tiết bài + tách hashtag / view | ✅ |
| `test/features/friends/find_friends_models_test.dart` | parse fixture Find Friends + nearbySuggestions + lọc query + nhãn CTA | ✅ |
| `test/features/friends/friends_hub_models_test.dart` | parse fixture Friends Hub + lọc/sort + relative time | ✅ |
| `test/features/friends/friends_hub_controller_test.dart` | soft refresh, accept/cancel counts, online sort | ✅ |
| `test/features/public_images/public_image_formatters_test.dart` | parse datamock album + format counter/GPS/datetime | ✅ |
| `test/features/ranking/ranking_models_test.dart` | parse datamock leaderboard + podium order + format điểm | ✅ |
| `test/features/ranking/ranking_controller_test.dart` | đổi period + claimQuest refresh | ✅ |
| `test/features/achivement/achivement_models_test.dart` | parse missions / tier / completion datamock + format điểm | ✅ |
| `test/features/chats/friend_chat_models_test.dart` | parse datamock thread 1-on-1 | ✅ |
| `test/features/chats/friend_chat_screen_test.dart` | chrome Stitch chat Alex Nguyễn | ✅ |

Chưa có test cho: auth, đổi avatar (upload), media (ngoài qua cover/memories), device_token, trip list controller, phần lớn flow tạo trip.

Lưu ý môi trường Windows: nếu `flutter test` báo `%PROGRAMFILES(X86)% environment variable not found`, đặt `${env:ProgramFiles(x86)} = 'C:\Program Files (x86)'` trước khi chạy.

---

## 10. Việc tồn đọng / bước tiếp theo đề xuất

1. ~~Cập nhật 2 test UI cũ trong `add_itinerary_activity_screen_test.dart`~~ — **đã xong** (2026-10-17).
2. Màn **Trip detail**: làm tiếp các nút đang báo "Tính năng đang phát triển" (chuyển quyền admin, chia sẻ, menu thêm, …). Đồng bộ `NOTCOM` → `NOTCOMPLETED` ở `trip.dart`, `trip_enums.dart`, `trip_list_item.dart`, `trip_related_models.dart`. ~~Mời bạn trên detail~~ — **đã xong** (mục 4.19).
3. ~~**UI xin vào trip bằng mã + lookup preview**~~ — **đã xong** (mục 4.13). Còn thiếu: quét QR.
4. **Chia sẻ lịch trình — cấu hình phát hành:** chọn domain thật cho `SHARE_HOST` / `PUBLIC_SHARE_BASE_URL`; khai báo SHA-256 keystore / Play App Signing; Apple Team ID + Associated Domains. Chưa cấu hình thì link vẫn mở HTML fallback nhưng không tự mở app.
5. ~~Làm **Home / Explore**~~ — **đã xong discover list + phân trang + join-by-tripId** (mục 4.16), **màn theo điểm đến** (mục 4.18, không editorial giả), **3 mục tab Địa Điểm**, **màn tất cả điểm đến nổi bật** (`/home/featured`) và **chi tiết địa điểm** (`/home/places/:placeId`, mục 4.23; bấm thẻ địa điểm mở màn này). Còn: chip lọc trên tab Địa Điểm, live feed, bookmark chuyến trên server. ~~Hộp thư thông báo~~ — **đã có** `GET/POST /notifications` và màn `/notifications` từ chuông social/home. ~~Làm **Social feed**~~ — **đã nối API** (mục 4.27). ~~**Chi tiết bài viết & bình luận**~~ — **đã xong** (mục 4.28). ~~**Tìm kiếm bạn bè**~~ — **đã nối API** (mục 4.29: find + nearby + follow/conversation). Story viewer có thanh tiến trình trên ảnh feed; challenge join đã nối. Còn: follow tác giả trên post detail, nested reply/like comment, reply/view story, rule tăng tiến độ challenge.
6. **Settings:** đăng xuất, thông báo đẩy và đổi mật khẩu đã nối API. Còn sinh trắc học, thiết bị, ngôn ngữ, tiền tệ, quyền hồ sơ, trợ giúp, điều khoản.
7. Dọn info deprecated (`withOpacity`, Radio, `onReorder`, …).
8. **Album kỷ niệm:** sửa caption (`PATCH /trips/memories/:id`) đã có UI trên viewer; tạo ảnh chỉ dùng batch (`POST .../batch`), không wire single create; badge cần Ollama trên server.
9. **Timeline:** màn đích khi bấm "Xem chi tiết" sự kiện (`TODO(screen)`); cân nhắc xóa `tripTimelineControllerProvider` legacy trong `trip_feed_controllers.dart`.
10. ~~Tin nhắn~~ — hub, DM và chat nhóm đã gọi API thread (`/thread`), gửi TEXT, ảnh nhóm, reaction, lời mời trip và socket cùng shape UI (mục 4.24–4.26). Còn typing bạn bè và `PLACE_CARD`. **Chi tiêu:** overview, payer khác, hóa đơn, OCR on-device, settle từng split và xem `receipts[]` đã có. Còn QR thanh toán và settle hàng loạt.

---

## 11. Tài liệu liên quan

- Rule AI chính (tự áp dụng mọi phiên): `../.cursor/rules/architecture.mdc`.
- API: `backend/contracts/openapi.json` là file OpenAPI duy nhất; sinh lại bằng `npm run openapi:generate` trong `backend`, không sửa tay.
- Design Stitch còn trong repo: `frontend/docs/design/screen/trip/{trip-join-by-code,trip-join-request-approval,trip-memories,trip-timeline,trip-expenses,trip-add-expense}/`, `frontend/docs/design/screen/explore/{community-trips,places,destination-trips,featured-destinations}/`, `frontend/docs/design/screen/profile/{profile-travel-dna,edit-profile,user-memories,user-saved-trip}/`, `frontend/docs/design/screen/travel-dna/`, `frontend/docs/design/screen/chats/{trip-messages-hub,friend-chat,trip-group-chat}/`, `frontend/docs/design/screen/social/social-details/`, `frontend/docs/design/screen/friends/{find-friends,friends-hub}/`, `frontend/docs/design/screen/achivement/`, `docs/screens/social_feed/stitch/`.
- Brain này (`frontend/brain/brain.md`) là bản đồ trạng thái frontend; cập nhật khi khảo sát lại `lib/`.

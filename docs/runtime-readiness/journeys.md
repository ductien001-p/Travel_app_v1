# Vòng 1 — Hành trình runtime

Chạy lúc **2026-11-14T13:49:18.368Z** trên `http://127.0.0.1:3001` và socket `http://127.0.0.1:3002`.
Hai tài khoản mới (A chủ chuyến, B bạn) cộng tài khoản C cho đổi mật khẩu. Mã xác minh email đọc từ Redis local vì hộp thư không phải đối tượng của vòng này.

Kết quả: **26 đạt**, **1 lỗi**, **0 bị chặn bởi dịch vụ ngoài**.

| Hành trình | Bước | Kết quả | Chi tiết |
|---|---|---|---|
| 1. Auth | Đăng ký A, chặn login khi chưa xác minh, rồi kích hoạt | PASS | user cmwggnkwm0009fon7y2fweytv; register HTTP 201 |
| 1. Auth | Đăng ký và kích hoạt B | PASS | user cmwggo4hg000cfon7hpf78vqy; register HTTP 201 |
| 1. Auth | Refresh token của A xoay vòng và token cũ hết hiệu lực | PASS | old refresh 401 |
| 1. Auth | Logout một thiết bị thu hồi refresh của A | PASS | refresh after logout 401; access token after logout HTTP 200 |
| 1. Auth | Đăng ký và kích hoạt C | PASS | user cmwggoo1k000hfon7isfm3no1 |
| 1. Auth | Đổi mật khẩu C thu hồi refresh và access token cũ | FAIL | old access token still accepted (HTTP 200); passwordChangeAt is not checked on JWT access |
| 2. Trip | A tạo nháp với điểm đến trong hôm nay (UTC) | PASS | cmwggp7wv000lfon7p0llcefc |
| 2. Trip | Lấy một địa điểm đã duyệt để gắn hoạt động | PASS | 8ed4bd9f-88b8-4a2f-9fb0-4cbf92bd856f (Bãi biển Mỹ Khê) |
| 2. Trip | A thêm một hoạt động vào ngày lịch trình | PASS | cmwggp83s000pfon7mxcdm20k |
| 2. Trip | A chốt nháp thành chuyến sắp đi | PASS | UPCOMING code length 8 |
| 2. Trip | A mời B | PASS | cmwggp8du0010fon7s14vavgn |
| 2. Trip | B chưa là thành viên thì không xem chi tiêu và không gửi tin nhóm | PASS | expenses 404, message 404 |
| 2. Trip | C đứng ngoài cũng bị từ chối chi tiêu | PASS | HTTP 404 |
| 2. Trip | B vào bằng mã mời | PASS | pending cmwggp8gv0012fon7linhkdmz then approved |
| 2. Trip | A check-in tại tọa độ địa điểm | PASS | cmwggp8jm0017fon7jbevkz4f |
| 2. Trip | A thêm một khoản chi tiêu chia đều | PASS | expense cmwggp8l20019fon7ls3ch1yr; B HTTP 200 |
| 2. Trip | Timeline của chuyến có sự kiện | PASS | 4 events |
| 2. Trip | A xem nhiệm vụ rồi hoàn thành chuyến | PASS | missions HTTP 200; points 85 |
| 3. Chat | A kết bạn với B và mở hội thoại | PASS | cmwggp8td001rfon7wmerjve1 |
| 3. Chat | A gửi TEXT, B nhận trên socket và đánh dấu đã đọc | PASS | cmwggp93m001sfon7t1qvy9cj |
| 3. Chat | Nhóm: TEXT tới socket của B và một reaction | PASS | cmwggp9gt001tfon73afdjfu0 |
| 3. Chat | A gửi một ảnh trong nhóm | PASS | cmwggpaje001wfon7c6eu5yg3 |
| 4. Notifications | Hộp thư của B có thông báo đúng chuyến, đọc một và đọc tất cả | PASS | TRIP_JOIN_REQUEST_APPROVED trip cmwggp7wv000lfon7p0llcefc; read-all updated 1 |
| 5. Social / places / ranking | A lưu địa điểm | PASS | 8ed4bd9f-88b8-4a2f-9fb0-4cbf92bd856f |
| 5. Social / places / ranking | A đăng một bài | PASS | cmwggpb1u001yfon79syr94h9 |
| 5. Social / places / ranking | B thích và bình luận bài | PASS | cmwggpb2y0021fon7vz3wub0q |
| 5. Social / places / ranking | Bảng xếp hạng và claim quest nếu đang nhận được | PASS | claimed cmwer66la00010sn7g1fj7y2m |

## Định danh tạo ra

- User A: `cmwggnkwm0009fon7y2fweytv` (`j1amwggnktk@example.com`)
- User B: `cmwggo4hg000cfon7hpf78vqy` (`j1bmwggnktk@example.com`)
- User C: `cmwggoo1k000hfon7isfm3no1` (`j1cmwggnktk@example.com`)
- Trip: `cmwggp7wv000lfon7p0llcefc`
- Place: `8ed4bd9f-88b8-4a2f-9fb0-4cbf92bd856f`
- Conversation: `cmwggp8td001rfon7wmerjve1`
- Post: `cmwggpb1u001yfon79syr94h9`

Dữ liệu test nằm trên database local. Không xóa rộng.

## Nhận xét

Đăng ký trả HTTP 201 (mail gửi được). Script đọc mã xác minh từ Redis local để kích hoạt, không mở hộp thư.

Một lỗi so với tiêu chí “token cũ hết hiệu lực sau đổi mật khẩu”: refresh token cũ trả 401 và mật khẩu cũ không đăng nhập được, nhưng access token cũ vẫn gọi được `GET /users/me` (HTTP 200). `validateJwtPayload` không đối chiếu `passwordChangeAt`. Logout một thiết bị cũng chỉ thu hồi refresh token; access token sau logout vẫn HTTP 200 cho đến khi hết hạn.

Người chưa vào chuyến bị `404` khi xem chi tiêu hoặc gửi tin nhóm (C cũng vậy). B vào bằng mã ở trạng thái chờ, A duyệt thì B thành viên. Check-in, một khoản chi, timeline (4 sự kiện), nhiệm vụ và hoàn thành chuyến (85 điểm) chạy xong. Chat DM và nhóm có socket, reaction, ảnh đã upload. Hộp thư của B có `TRIP_JOIN_REQUEST_APPROVED` đúng `tripId`. Lưu địa điểm, đăng bài, like, comment, bảng xếp hạng và claim quest đều đạt.

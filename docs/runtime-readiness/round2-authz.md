# Vòng 2 — Ma trận quyền

Chạy lúc **2026-11-15T07:53:48.267Z** trên `http://127.0.0.1:3001`.
Bốn ca: không token, access token hết hạn, chủ chuyến (A), người ngoài (C). B được dùng thêm ở vài API nhóm để xác nhận thành viên vẫn đọc được.
Người ngoài trên tài nguyên chuyến kỳ vọng 403 hoặc 404. Không token và token hết hạn kỳ vọng 401 `UNAUTHORIZED`. Phản hồi không được chứa mật khẩu, hash, stack hay đường dẫn nội bộ.

Kết quả: **74 đạt**, **0 lỗi**.

| Khu vực | API | Vai trò | Kết quả | Chi tiết |
|---|---|---|---|---|
| Trip | GET /trips/:id/itineraries | không token | PASS | 401 UNAUTHORIZED |
| Trip | GET /trips/:id/itineraries | token hết hạn | PASS | 401 UNAUTHORIZED |
| Trip | GET /trips/:id/itineraries | chủ chuyến | PASS | HTTP 200 |
| Trip | GET /trips/:id/itineraries | người ngoài | PASS | 404 Trip not found |
| Trip | GET /trips/:id/itineraries | thành viên | PASS | HTTP 200 |
| Trip | GET /trips/:id/expenses | không token | PASS | 401 UNAUTHORIZED |
| Trip | GET /trips/:id/expenses | token hết hạn | PASS | 401 UNAUTHORIZED |
| Trip | GET /trips/:id/expenses | chủ chuyến | PASS | HTTP 200 |
| Trip | GET /trips/:id/expenses | người ngoài | PASS | 404 Trip not found |
| Trip | GET /trips/:id/expenses | thành viên | PASS | HTTP 200 |
| Trip | GET /trips/:id/missions | không token | PASS | 401 UNAUTHORIZED |
| Trip | GET /trips/:id/missions | token hết hạn | PASS | 401 UNAUTHORIZED |
| Trip | GET /trips/:id/missions | chủ chuyến | PASS | HTTP 200 |
| Trip | GET /trips/:id/missions | người ngoài | PASS | 404 Trip not found |
| Trip | GET /trips/:id/missions | thành viên | PASS | HTTP 200 |
| Trip | GET /trips/:id/chat/thread | không token | PASS | 401 UNAUTHORIZED |
| Trip | GET /trips/:id/chat/thread | token hết hạn | PASS | 401 UNAUTHORIZED |
| Trip | GET /trips/:id/chat/thread | chủ chuyến | PASS | HTTP 200 |
| Trip | GET /trips/:id/chat/thread | người ngoài | PASS | 404 Trip not found |
| Trip | GET /trips/:id/chat/thread | thành viên | PASS | HTTP 200 |
| Trip | GET /trips/:id/messages | không token | PASS | 401 UNAUTHORIZED |
| Trip | GET /trips/:id/messages | token hết hạn | PASS | 401 UNAUTHORIZED |
| Trip | GET /trips/:id/messages | chủ chuyến | PASS | HTTP 200 |
| Trip | GET /trips/:id/messages | người ngoài | PASS | 404 Trip not found |
| Trip | GET /trips/:id/messages | thành viên | PASS | HTTP 200 |
| Trip | GET /trips/timeline/:tripId | không token | PASS | 401 UNAUTHORIZED |
| Trip | GET /trips/timeline/:tripId | token hết hạn | PASS | 401 UNAUTHORIZED |
| Trip | GET /trips/timeline/:tripId | chủ chuyến | PASS | HTTP 200 |
| Trip | GET /trips/timeline/:tripId | người ngoài | PASS | 404 Trip not found |
| Trip | GET /trips/timeline/:tripId | thành viên | PASS | HTTP 200 |
| Trip | POST /trips/:id/messages | không token | PASS | 401 UNAUTHORIZED |
| Trip | POST /trips/:id/messages | token hết hạn | PASS | 401 UNAUTHORIZED |
| Trip | POST /trips/:id/messages | chủ chuyến | PASS | HTTP 201 |
| Trip | POST /trips/:id/messages | người ngoài | PASS | 404 Trip not found |
| Chi tiêu | POST /trips/:id/expenses | không token | PASS | 401 UNAUTHORIZED |
| Chi tiêu | POST /trips/:id/expenses | token hết hạn | PASS | 401 UNAUTHORIZED |
| Chi tiêu | POST /trips/:id/expenses | chủ chuyến | PASS | HTTP 201 |
| Chi tiêu | POST /trips/:id/expenses | người ngoài | PASS | 403 Active trip membership required |
| Trip | POST /trip-invitations/invite | không token | PASS | 401 UNAUTHORIZED |
| Trip | POST /trip-invitations/invite | token hết hạn | PASS | 401 UNAUTHORIZED |
| Trip | POST /trip-invitations/invite | chủ chuyến | PASS | HTTP 409 |
| Trip | POST /trip-invitations/invite | người ngoài | PASS | 403 Active trip membership required |
| Trip | GET /trips/:id chuyến công khai | người ngoài | PASS | HTTP 200; inviteCode/chi tiêu/kỷ niệm/timeline/thưởng đã ẩn |
| Trip | GET /trips/:id | không token | PASS | 401 UNAUTHORIZED |
| Trip | GET /trips/:id | token hết hạn | PASS | 401 UNAUTHORIZED |
| Trip | GET /trips/:id | chủ chuyến | PASS | HTTP 200 |
| Trip | GET /trips/:id | thành viên | PASS | HTTP 200 |
| Chat | GET /friends/conversations/:id/thread | không token | PASS | 401 UNAUTHORIZED |
| Chat | GET /friends/conversations/:id/thread | token hết hạn | PASS | 401 UNAUTHORIZED |
| Chat | GET /friends/conversations/:id/thread | chủ hội thoại | PASS | HTTP 200 |
| Chat | GET /friends/conversations/:id/thread | người ngoài | PASS | 403 You are not a member of this conversation |
| Chat | POST /friends/conversations/:id/messages | không token | PASS | 401 UNAUTHORIZED |
| Chat | POST /friends/conversations/:id/messages | token hết hạn | PASS | 401 UNAUTHORIZED |
| Chat | POST /friends/conversations/:id/messages | chủ hội thoại | PASS | HTTP 201 |
| Chat | POST /friends/conversations/:id/messages | người ngoài | PASS | 403 You are not a member of this conversation |
| Chat | GET /chats/hub | không token | PASS | 401 UNAUTHORIZED |
| Chat | GET /chats/hub | token hết hạn | PASS | 401 UNAUTHORIZED |
| Chat | GET /chats/hub | chủ chuyến | PASS | HTTP 200 |
| Chat | GET /chats/hub | người ngoài | PASS | HTTP 200 |
| Chat | GET /chats/hub không lộ hội thoại A-B | người ngoài | PASS | HTTP 200 |
| Chat | GET /chats/hub của chủ hội thoại | chủ hội thoại | PASS | HTTP 200 và thấy hội thoại của mình |
| Thông báo | GET /notifications | không token | PASS | 401 UNAUTHORIZED |
| Thông báo | GET /notifications | token hết hạn | PASS | 401 UNAUTHORIZED |
| Thông báo | GET /notifications | chủ chuyến | PASS | HTTP 200 |
| Thông báo | GET /notifications | người ngoài | PASS | HTTP 200 |
| Thông báo | POST /notifications/:id/read | không token | PASS | 401 UNAUTHORIZED |
| Thông báo | POST /notifications/:id/read | token hết hạn | PASS | 401 UNAUTHORIZED |
| Thông báo | POST /notifications/:id/read | chủ thông báo | PASS | HTTP 201 |
| Thông báo | POST /notifications/:id/read | người ngoài | PASS | 404 Notification not found |
| Thông báo | POST /notifications/read-all | không token | PASS | 401 UNAUTHORIZED |
| Thông báo | POST /notifications/read-all | token hết hạn | PASS | 401 UNAUTHORIZED |
| Thông báo | POST /notifications/read-all | chủ chuyến | PASS | HTTP 201 |
| Thông báo | POST /notifications/read-all | người ngoài | PASS | HTTP 201 |
| Hồ sơ | GET /users/me không lộ mật khẩu | chủ chuyến | PASS | HTTP 200, id khớp: true |

## Định danh

- Chủ chuyến A: `cmwggnkwm0009fon7y2fweytv`
- Thành viên B: `cmwggo4hg000cfon7hpf78vqy`
- Người ngoài C: `cmwggoo1k000hfon7isfm3no1`
- Trip: `cmwggp7wv000lfon7p0llcefc`
- Hội thoại A-B: `cmwggp8td001rfon7wmerjve1`

## Nhận xét

Không token và access token hết hạn đều 401 `UNAUTHORIZED`. Phản hồi không chứa mật khẩu, hash, stack hay đường dẫn nội bộ.

Chuyến này là công khai nên `GET /trips/:id` trả 200 cho người đã đăng nhập. Mã mời, chi tiêu, kỷ niệm, timeline và thưởng hoàn thành đều null. Lịch trình, tin nhóm, nhiệm vụ và timeline riêng trả 404 `Trip not found` với người ngoài.

`POST /trips/:id/expenses` và `POST /trip-invitations/invite` trả 403 `Active trip membership required` thay vì 404. Người ngoài biết chuyến tồn tại. Hội thoại bạn bè cũng trả 403 `You are not a member of this conversation`. Đọc thông báo của người khác trả 404 và không lộ bản ghi.

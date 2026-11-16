# Vòng 4 — Dịch vụ ngoài

Chạy lúc **2026-11-15T08:55:54.187Z** trên `http://127.0.0.1:3001`. Không ghi token, mật khẩu, URL ký sẵn hay khóa.

Kết quả: **7 đạt**, **0 lỗi**, **3 bị chặn vì thiếu tài khoản, máy hoặc domain**. FCM được kiểm lại lúc 2026-11-16 sau khi thay service account.

| Dịch vụ | Bước | Kết quả | Chi tiết |
|---|---|---|---|
| R2 | Upload ảnh thật | PASS | PUT 200, complete HTTP 201, media cmwhllyvs001xxsn7jx0v3aq3, public GET 200, 70 bytes |
| Embedding | Tìm địa điểm theo ngữ nghĩa | PASS | HTTP 201, 2 kết quả, 2 place APPROVED có embedding |
| Ollama | Badge ảnh kỷ niệm | PASS | memory cmwhlm14o0023xsn7lzyhoxg3 badge none sau khi model gemma3:4b trả lời |
| Google | Từ chối ID token giả | PASS | HTTP 401 Invalid or expired Google ID token |
| Google | Đăng nhập bằng tài khoản Google | BLOCKED | Cần một ID token thật từ tài khoản Google; vòng này không có phiên đăng nhập tương tác |
| FCM | Service account được Firebase chấp nhận | PASS | Dry-run với token giả bị từ chối đúng (`messaging/invalid-argument`); khóa mới được Firebase chấp nhận |
| FCM | Push tới máy thật | BLOCKED | 30 device token đang lưu; vòng này không gửi thông báo tới máy người dùng |
| App Links | Trang HTML fallback | PASS | HTTP 200 |
| App Links | File liên kết domain trên API local | PASS | assetlinks HTTP 200, apple HTTP 200 |
| App Links | Mở app từ domain HTTPS | BLOCKED | SHARE_HOST trống, fingerprint Android có, iOS app id chưa có |

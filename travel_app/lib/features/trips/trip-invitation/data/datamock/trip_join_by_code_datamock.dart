// Dữ liệu mẫu cho màn Nhập mã mời → gửi yêu cầu tham gia.
//
// API thật (tên theo backend `TripsController` / `TripJoinRequestsService`):
// - `GET /trips/join/{inviteCode}` → `{ data: TripJoinInvitePreview, message }`
//   (`previewByInviteCode` / `previewJoinByInviteCode`).
// - `POST /trips/join/{inviteCode}` body `{ message? }`
//   → `{ data: joinRequest, message }`. `status` là `APPROVED` khi chuyến đi
//   tự duyệt bạn bè của chủ nhóm; còn lại `PENDING`.
//
// Shape `invitePreview` khớp `TripJoinInvitePreviewResponseDto`. App gọi API
// thật; datamock chỉ còn làm dữ liệu cho test / placeholder UI.

const tripJoinByCodeDatamockNow = '2025-07-10T08:00:00.000Z';

/// Độ dài mã mời sau khi bỏ ký tự không phải chữ/số — khớp `generateInviteCode`.
const tripInviteCodeLength = 8;

/// Mã demo sau chuẩn hoá (khớp `inviteCode` của backend).
const tripJoinByCodeDemoInviteCode = 'HE2025VN';

/// Placeholder lời nhắn trên form (không thuộc response lookup).
const tripJoinByCodeSampleMessage =
    'Chào Alex! Mình rất thích khám phá ẩm thực Hội An và chụp ảnh, '
    'mong được đồng hành cùng nhóm nhé!';

const Map<String, dynamic> tripJoinByCodeDatamock = {
  'invitePreview': {
    'inviteCode': tripJoinByCodeDemoInviteCode,
    'tripId': 'trip-demo-summer-2025',
    'name': 'Mùa Hè Rực Rỡ: Bán Đảo Sơn Trà & Phố Cổ Hội An',
    'coverImageUrl':
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAZIqT-ekqVCz8w1F84p4smKzCnxGn0-aoQ7hfsUKNcakhlbNgJyBG40eaEcvF1-nEeFt5y19QrFjvF9XQewvFEft_6u-hzMWPATADt7g_ShTcxwpbz4z8E5RbeD7ADKp5iuuAXTJAJKeNS6FUktAn-6e1E94yHzSyTktK5FeBcYFJayprfmGSoPexa_uUWTCITZkA1f0GpIsZnUDMVdLkS90_ZSGtXFp8IBbwO4Vwdpcx9oDvPx-3j',
    'startDate': '2025-07-19T00:00:00.000Z',
    'endDate': '2025-07-22T00:00:00.000Z',
    'ownerDisplayName': 'Alex Nguyễn',
    'memberCount': 4,
    'maxMembers': 5,
    'matchScore': 94,
  },
};

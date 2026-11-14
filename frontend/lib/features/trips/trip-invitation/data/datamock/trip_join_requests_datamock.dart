// Dữ liệu mẫu cho màn Phê duyệt yêu cầu tham gia chuyến đi, cùng dạng với
// response của backend (`TripJoinRequestsController`):
//
// - `GET /trips/{tripId}/join-requests?status&limit&cursor`
//   → `{ data: [joinRequest], meta: { nextCursor, hasMore, counts } }`.
//   `data` mới nhất trước; `counts` đếm theo mọi trạng thái của cả chuyến đi.
// - `POST /trips/{tripId}/join-requests/{requestId}/approve|reject`
//   → `{ data: joinRequest, message }`. Chỉ OWNER/ADMIN; 409 khi yêu cầu đã
//   được xử lý hoặc nhóm đã đủ `maxMembers`.
// - `GET|PATCH /trips/{tripId}/join-requests/settings`
//   → `{ data: { autoApproveFriends }, message }`.
// - `POST /trips/join/{inviteCode}` (body `{ message? }`) tạo yêu cầu
//   → `{ data: joinRequest, message }`; `status` là `APPROVED` khi chuyến đi
//   tự duyệt bạn bè của chủ nhóm.
//
// `travelPersona` là tên Travel DNA cao nhất của người gửi, `matchScore` do
// backend tính từ Travel DNA so với loại chuyến đi và địa điểm trong lịch
// trình; backend chưa sinh `matchNote` nên luôn là `null`.
//
// Thời gian viết theo mốc `tripJoinRequestsDatamockNow`. App gọi API thật;
// datamock chỉ còn làm dữ liệu cho test.
const tripJoinRequestsDatamockNow = '2025-07-10T08:00:00.000Z';

const Map<String, dynamic> tripJoinRequestsDatamock = {
  'joinRequests': [
    {
      'id': 'join-request-minh-anh',
      'tripId': 'trip-demo-summer-2025',
      'status': 'PENDING',
      'requester': {
        'id': 'user-minh-anh',
        'displayName': 'Minh Anh',
        'username': 'minhanh_travel',
        'avatarUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBfA8UwmoNXppHVcqgYoScRdao4PB-rdmiDV8p1u7A6ItormTtRhSjwB9RRgW1mC-xsYTIvmLS9hLH1BN5raTj_BXD3mxHfEqvojTuc87tQvVijMTl-qFayjPWirHc7wo9qUwcW5qQv0Yl1UKkv7IExze2RMrWTgaFzUFfHraZHhbxnyYhYUVexah6cnXcX1AQOibfdhrBaszcfk_DLrCWymsGawE2dvmCh3ytlrah1gPxrw917l5e9',
        'isVerified': true,
        'isOnline': true,
      },
      'message':
          'Chào nhóm! Mình có máy ảnh cơ và mê ẩm thực đường phố, rất mong '
          'được nhập hội trải nghiệm cùng mọi người!',
      'travelPersona': 'Foodie Traveler',
      'personaType': 'FOODIE_TRAVELER',
      'matchScore': 96,
      'matchNote': null,
      'createdAt': '2025-07-10T07:45:00.000Z',
      'decidedAt': null,
    },
    {
      'id': 'join-request-dang-khoa',
      'tripId': 'trip-demo-summer-2025',
      'status': 'PENDING',
      'requester': {
        'id': 'user-dang-khoa',
        'displayName': 'Đăng Khoa',
        'username': 'khoa_outdoor',
        'avatarUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuB8ORMCvCdkm_CfWIxmmgTn-V_zduCnKYTJmEYHip8M05D_hymJ_2kQ1mrokc3xgYGaAgCrrwK3vdQrIyN0XFv60fJDg9FiFozBxxfj_K2YSwyAfkYDpaQEm1pCwlDjiQwkCiI5HO9434LunPMaeaZ9QmQXBueHjpgi9HniXxco9ReM4DFwZVQNEi966-j7utbQHBvpZbTgubm6EMRltpEjbd5tVRLxfswqIbXXNCbD8_Wnq4oi9llJ',
        'isVerified': false,
        'isOnline': false,
      },
      'message': 'Mình có kinh nghiệm phượt miền Trung, xe cộ tự túc.',
      'travelPersona': 'Backpacker',
      'personaType': 'BACKPACKER',
      'matchScore': 78,
      'matchNote': null,
      'createdAt': '2025-07-10T07:00:00.000Z',
      'decidedAt': null,
    },
    {
      'id': 'join-request-thanh-thao',
      'tripId': 'trip-demo-summer-2025',
      'status': 'PENDING',
      'requester': {
        'id': 'user-thanh-thao',
        'displayName': 'Thanh Thảo',
        'username': 'thao_journey',
        'avatarUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBhlJQ3XJHEu25J-6MZnN6O_Pa_TWthuZHDnxiiuqfvcFtvi8wKliN--OB0643inOdOrbh80d5vWXBvWI7G2wNlf_z8pJPHrZAoTGLJFKlEi-qNICheYSpdY0kPhVrAPw5_TZ3nefu_GhxJQJmwUGi5HeUUKdh33t9xrmNE1LZ3wGOXCvSqRemYSoWC1D9QupDNUEeJLaICex-WG9H8UL91U340ejKYlMQuu8Owg0l7VypEn2h0hY0Q',
        'isVerified': false,
        'isOnline': false,
      },
      'message':
          'Rất thích lịch trình khám phá văn hóa làng gốm và đi dạo sông '
          'Hoài của trip!',
      'travelPersona': 'Culture Traveler',
      'personaType': 'CULTURE_TRAVELER',
      'matchScore': 84,
      'matchNote': null,
      'createdAt': '2025-07-09T06:30:00.000Z',
      'decidedAt': null,
    },
    {
      'id': 'join-request-ngoc-han',
      'tripId': 'trip-demo-summer-2025',
      'status': 'APPROVED',
      'requester': {
        'id': 'user-ngoc-han',
        'displayName': 'Ngọc Hân',
        'username': 'han_beachlover',
        'avatarUrl': null,
        'isVerified': true,
        'isOnline': false,
      },
      'message': 'Mình mê biển Mỹ Khê, cho mình đi cùng với nhé!',
      'travelPersona': 'Beach Lover',
      'personaType': 'BEACH_LOVER',
      'matchScore': 91,
      'matchNote': null,
      'createdAt': '2025-07-08T09:10:00.000Z',
      'decidedAt': '2025-07-08T10:00:00.000Z',
    },
    {
      'id': 'join-request-tuan-kiet',
      'tripId': 'trip-demo-summer-2025',
      'status': 'APPROVED',
      'requester': {
        'id': 'user-tuan-kiet',
        'displayName': 'Tuấn Kiệt',
        'username': 'kiet.adventure',
        'avatarUrl': null,
        'isVerified': false,
        'isOnline': true,
      },
      'message': null,
      'travelPersona': 'Adventure Traveler',
      'personaType': 'ADVENTURE_TRAVELER',
      'matchScore': 72,
      'matchNote': null,
      'createdAt': '2025-07-06T13:20:00.000Z',
      'decidedAt': '2025-07-06T15:45:00.000Z',
    },
    {
      'id': 'join-request-bao-ngoc',
      'tripId': 'trip-demo-summer-2025',
      'status': 'APPROVED',
      'requester': {
        'id': 'user-bao-ngoc',
        'displayName': 'Bảo Ngọc',
        'username': 'ngoc_shutter',
        'avatarUrl': null,
        'isVerified': false,
        'isOnline': false,
      },
      'message': 'Mình sẽ lo phần chụp ảnh kỷ niệm cho cả nhóm.',
      'travelPersona': 'Photography Lover',
      'personaType': 'PHOTOGRAPHY_LOVER',
      'matchScore': 88,
      'matchNote': null,
      'createdAt': '2025-07-05T02:00:00.000Z',
      'decidedAt': '2025-07-05T03:30:00.000Z',
    },
    {
      'id': 'join-request-hoang-long',
      'tripId': 'trip-demo-summer-2025',
      'status': 'APPROVED',
      'requester': {
        'id': 'user-hoang-long',
        'displayName': 'Hoàng Long',
        'username': 'long_mountain',
        'avatarUrl': null,
        'isVerified': false,
        'isOnline': false,
      },
      'message': null,
      'travelPersona': 'Mountain Lover',
      'personaType': 'MOUNTAIN_LOVER',
      'matchScore': null,
      'matchNote': null,
      'createdAt': '2025-07-03T11:00:00.000Z',
      'decidedAt': '2025-07-04T01:15:00.000Z',
    },
    {
      'id': 'join-request-van-tai',
      'tripId': 'trip-demo-summer-2025',
      'status': 'REJECTED',
      'requester': {
        'id': 'user-van-tai',
        'displayName': 'Văn Tài',
        'username': 'tai_party',
        'avatarUrl': null,
        'isVerified': false,
        'isOnline': false,
      },
      'message': 'Cho mình tham gia với, mình rảnh cả tuần.',
      'travelPersona': 'Fun Seeker',
      'personaType': 'ENTERTAINMENT_TRAVELLER',
      'matchScore': 41,
      'matchNote': null,
      'createdAt': '2025-07-02T08:00:00.000Z',
      'decidedAt': '2025-07-02T12:00:00.000Z',
    },
  ],
  'joinRequestSettings': {'autoApproveFriends': true},
};

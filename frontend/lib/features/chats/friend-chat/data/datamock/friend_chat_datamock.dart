// Dữ liệu mẫu cho màn Khung Chat 1-on-1 (Stitch "Khung Chat 1-on-1 Chi Tiết - Alex Nguyễn").
// Shape demo của GET /friends/conversations/{conversationId}/thread —
// OpenAPI hiện chỉ có GET messages (TEXT) nên payload UI giàu hơn dùng API tên demo.
//
// TODO(backend): API demo — thay bằng endpoint thật khi backend xong
const Map<String, dynamic> friendChatDatamock = {
  'conversationId': 'conv-alex',
  'peer': {
    'userId': 'user-alex',
    'displayName': 'Alex Nguyễn',
    'avatarUrl':
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAdPnWTylbGd1vTrXkL65MDfD0Eaw7inHS35dKoKE_k-IZyAEp5ykXj2cm1401PfmAW5xr3sa2bFebNsN0iqC0CpsLic5y4Rsl76r7NiO1TcpXnb8Kk1RxuW1yfWoCNjhlxizHsBtYon_FFQyQNt1O1PM1o1mab0Rp1Nyxdmu0La5eJRLoGi2Yaw1hpelTgpODmkbWidmn-_IuVFw6V8y8Hoz8ib34gxWHdX8R9TsI',
    'roleBadge': 'Trưởng nhóm',
    'isOnline': true,
    'presenceLabel': 'Đang hoạt động',
    'sharedTripsLabel': '3 chuyến chung',
  },
  'sharedTrip': {
    'tripId': 'trip-mien-trung-2025',
    'title': 'Mùa Hè Rực Rỡ 2025',
    'destinationHint': 'Sơn Trà',
    'statusLabel': 'Đang diễn ra',
  },
  'dateLabel': 'Hôm nay, 19 Tháng 7',
  'isPeerTyping': true,
  'typingLabel': 'Alex Nguyễn đang soạn tin nhắn',
  'messages': [
    {
      'id': 'msg-1',
      'kind': 'TEXT',
      'isMine': false,
      'text':
          'Chào Phương! Mình vừa xem lại lịch trình Ngày mai ở Hội An, thấy có quán Cafe Faifo ngắm hoàng hôn rất chill. Cậu muốn ghé qua không? ☕🌅',
      'timeLabel': '14:22',
      'showAvatar': true,
    },
    {
      'id': 'msg-2',
      'kind': 'PLACE_CARD',
      'isMine': false,
      'timeLabel': '14:22',
      'showAvatar': false,
      'placeCard': {
        'placeId': 'place-faifo',
        'name': 'Faifo Coffee Hội An',
        'address': '130 Trần Phú, Phường Minh An, Hội An',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDBkvbpKuNQUL-Ovqzuzkc_tBiGgD4lsUY4Mt8VLfRR8ZITwyIwSJmJvFuQ6rAJ-BnHZNT4vGIopUr0wsjdZqmZs1S8vFnrjDFs0M9Sq4eAFLyssjgxPRnK6kex0Iz39g1tFACXDvTXVlhmg8jUIcdQ4OJqeYOQlAdS_Fpd9TTZCmqnWWrOH6wMwbFmOXd8VA3cUWfokhCt5_A59GS6b9MuN6WahzCXzIkYL7SvRcE',
        'rating': 4.8,
        'reviewCount': 312,
        'badgeLabel': 'Điểm ngắm hoàng hôn số 1',
        'footerLabel': 'Đã thêm vào gợi ý nhóm',
        'actionLabel': 'Thêm vào chuyến đi +',
      },
    },
    {
      'id': 'msg-3',
      'kind': 'TEXT',
      'isMine': true,
      'text':
          'Quán đấy đẹp lắm! Chiều mai 16:30 nhóm mình qua nhé. À vé thuyền rồng sông Hoài hôm qua hết bao nhiêu để mình gửi lại cậu nhỉ? 🛶',
      'timeLabel': '14:26',
      'readStatus': 'READ',
      'showAvatar': false,
    },
    {
      'id': 'msg-4',
      'kind': 'TEXT',
      'isMine': false,
      'text':
          'Phượng ơi, nhóm mình chuẩn bị đi Đà Lạt cuối tháng này, còn 2 chỗ trống nè! Cậu tham gia chung với tụi mình cho vui nhé! 🏕️✨',
      'timeLabel': '14:27',
      'showAvatar': true,
    },
    {
      'id': 'msg-5',
      'kind': 'TRIP_INVITE',
      'isMine': false,
      'timeLabel': '14:27',
      'showAvatar': false,
      'tripInvite': {
        'tripId': 'trip-da-lat',
        'title': 'Săn Mây Đồi Đa Phú & Acoustic Đêm Đà Lạt 3N2Đ',
        'imageUrl':
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=700&q=80',
        'dateLabel': '25/10 - 27/10',
        'priceLabel': '~1.650.000đ/người',
        'seatsLabel': '4/6 thành viên (Còn 2 chỗ)',
        'badgeLabel': 'Lời mời tham gia chuyến đi',
        'primaryActionLabel': 'Tham gia chuyến đi',
        'secondaryActionLabel': 'Xem chi tiết',
      },
    },
    {
      'id': 'msg-6',
      'kind': 'TEXT',
      'isMine': true,
      'text':
          'Nghe hấp dẫn quá Alex ơi! Để mình xem lịch trình chi tiết rồi bấm tham gia ngay nhé! 🙌🎒',
      'timeLabel': '14:28',
      'readStatus': 'DELIVERED',
      'showAvatar': false,
    },
    {
      'id': 'msg-7',
      'kind': 'TEXT',
      'isMine': false,
      'text':
          'Nhận được rồi nhé, cảm ơn cậu nhiều! Hẹn gặp cả nhóm chiều mai lúc 15h30 ở sảnh homestay nhé! 🛵🌊',
      'timeLabel': '14:29',
      'showAvatar': true,
    },
  ],
  'shortcuts': [
    {'kind': 'INVITE_TRIP', 'label': 'Mời vào chuyến đi', 'emphasized': true},
    {
      'kind': 'SEND_LOCATION',
      'label': '📍 Gửi vị trí GPS',
      'emphasized': false,
    },
    {'kind': 'SPLIT_BILL', 'label': '💸 Chia tiền', 'emphasized': false},
    {
      'kind': 'SUGGEST_ITINERARY',
      'label': '🗓️ Gợi ý lịch trình',
      'emphasized': false,
    },
    {'kind': 'SEND_PHOTO', 'label': '📸 Gửi ảnh HD', 'emphasized': false},
  ],
  'inviteCandidates': [
    {
      'tripId': 'trip-da-lat',
      'title': 'Săn Mây Đồi Đa Phú & Acoustic Đà Lạt',
      'imageUrl':
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=200&q=80',
      'metaLabel': '📅 25/10 - 27/10 • Còn 2 chỗ',
      'badgeLabel': '3N2Đ',
      'actionLabel': 'Gửi thẻ',
    },
    {
      'tripId': 'trip-mien-trung-2025',
      'title': 'Mùa Hè Rực Rỡ 2025 (Sơn Trà - Hội An)',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDBkvbpKuNQUL-Ovqzuzkc_tBiGgD4lsUY4Mt8VLfRR8ZITwyIwSJmJvFuQ6rAJ-BnHZNT4vGIopUr0wsjdZqmZs1S8vFnrjDFs0M9Sq4eAFLyssjgxPRnK6kex0Iz39g1tFACXDvTXVlhmg8jUIcdQ4OJqeYOQlAdS_Fpd9TTZCmqnWWrOH6wMwbFmOXd8VA3cUWfokhCt5_A59GS6b9MuN6WahzCXzIkYL7SvRcE',
      'metaLabel': '📅 Đang diễn ra • 5 thành viên',
      'badgeLabel': 'Đang đi',
      'actionLabel': 'Gửi thẻ',
    },
  ],
};

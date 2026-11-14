// Fixture dùng cho widget/unit tests của Trip Group Chat.
// Production đi qua GET /trips/{tripId}/chat/thread.
const Map<String, dynamic> tripChatDatamock = {
  'tripId': 'trip-mien-trung-2025',
  'title': 'Mùa hè rực rỡ 2025 🏝️',
  'memberSummaryLabel': '4 thành viên • 3 đang online (Alex, Trang, Bảo)',
  'isLive': true,
  'pinnedActivity': {
    'badgeLabel': 'Hoạt động tiếp theo',
    'dayChipLabel': 'Hôm nay',
    'title': '18:30: Cầu Rồng phun lửa & Du thuyền sông Hàn',
    'checkInLabel': 'Check-in',
    'itineraryDayId': 'day-2',
  },
  'dateLabel': 'Hôm nay, 19 Tháng 7',
  'isSomeoneTyping': true,
  'typingLabel': 'Lan Phương đang nhập',
  'typingAvatarUrl':
      'https://lh3.googleusercontent.com/aida-public/AB6AXuAeEEv_s7GknPYo9uwrDJj_JSq-TUsxUMAd-XvlWUQpH564mtpFGWmGoMzdUImsfZY2paDIBeL0SVxvVoykqSzbVcEQI3plfvbNFzXGK-THbnV0jrXWcmmTYD_LtLizTodQrq7ZjApjt1-vrwPxASAl2kfdprv2UVHsTPEsBYx7LxXcNPpeeEMnXTWLro0xmwxnQYEwfHF-oIBXVX7jkFdp8bsEoN0ykyyGa9vN-aE',
  'messages': [
    {
      'id': 'msg-sys-1',
      'kind': 'SYSTEM',
      'isMine': false,
      'timeLabel': '14:05',
      'showAvatar': false,
      'system': {
        'icon': 'add_location_alt',
        'richText':
            '**Alex Nguyễn** đã thêm 1 điểm dừng: **Quán Mót Hội An** vào Ngày 2',
      },
    },
    {
      'id': 'msg-1',
      'kind': 'TEXT',
      'isMine': false,
      'text':
          'Cả nhà ơi, thời tiết Đà Nẵng chiều nay cực kỳ đẹp, 28°C trời trong. Nhóm mình chuẩn bị xe máy để 15h30 xuất phát lên Bán Đảo Sơn Trà nhé! 🛵💨',
      'timeLabel': '14:10',
      'showAvatar': true,
      'sender': {
        'userId': 'user-alex',
        'displayName': 'Alex Nguyễn',
        'avatarUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDJG1X4k74T50lney73N6RBGJ9CBUjZc2AmqLYeuhPW7B_QExS69bcEH74erwBbT8_t9gE5otnddn4W-JKPcOovk_bMdvh6iuUlXgKl4Z1agLTGSoyjsAGPn7TTyX2YXYwWxIeUJA3npZz7Ldk6ZaPKl3F-FNgpVRTBeLCA-QLwvpcs8sj9OcJgb1Tx3gWARrLVYVKiPEuL37HOEpP_TxFDLINKTzipAskCF1cwAWE',
        'roleBadge': 'Trưởng nhóm',
        'roleTone': 'LEADER',
        'isLeader': true,
      },
    },
    {
      'id': 'msg-2',
      'kind': 'PHOTO',
      'isMine': false,
      'timeLabel': '14:15',
      'showAvatar': true,
      'sender': {
        'userId': 'user-bao',
        'displayName': 'Quốc Bảo',
        'avatarUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuB6hRJksTphgtK4ZcTOSb5uzfccKRT0VCCrD9Yp8Qd0H5CAJiSD2qvDL0YfhG6H4n20kMpHsQHwPEbHhXHNq9JrbylcN6iQRUzMRbzOshlWa1HJ5AFEGYDVzFGNuUWERJvLeFxq-HLaIA8wdDkAMlCmoCHmrOIZ1azJEtBklkYEcXKbtO04vbe8HDDySEq5S4qBtkkRjCSM6lMlpTUaUznOFlcbgXJlJGrlVarX4q8',
        'roleBadge': 'Nhiếp ảnh',
        'roleTone': 'PHOTOGRAPHER',
        'isLeader': false,
      },
      'photo': {
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAxf3t8yqjGaZtsP4e5CBBJ80K3fLu_ZUAQ4mlV6Th2XuXZHLwOS6f8c2oMwRJNaHQHFDo6IrIi6A4W0LOSWY107fGWF86MIDuKz4SsevYcaOHrKJMFMPJGK6QNrgrwG36mrKJIJuEwlf33Lh_kcRv4i0SWGKuNjYUwXQYY90P1T9yCfDGoRjgeJzM4koO05Pv3-qzzfKLs7cEBHS3nQifgs-zErYBX4JwIiEdPM94',
        'caption':
            'View từ Đỉnh Bàn Cờ hiện tại đây mọi người, mây bồng bềnh cực đỉnh!',
        'locationLabel': 'Đỉnh Bàn Cờ • 14:12',
        'reactions': [
          {'emoji': '❤️', 'count': 4},
          {'emoji': '🔥', 'count': 3},
        ],
      },
    },
    {
      'id': 'msg-3',
      'kind': 'EXPENSE',
      'isMine': false,
      'timeLabel': '14:22',
      'showAvatar': true,
      'sender': {
        'userId': 'user-trang',
        'displayName': 'Thu Trang',
        'avatarUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuD6BTyIJB1JqeYUuvnH9GJH4JcdR739Wces3B-e5zNPrmhCgUAc7n10yl2Z1mYWtq-QpAnQXT5MrVW4u0hN1iTl4gyhtNNXVyYFunwj4ELoMC-kXlW21fqwl8dctfEsvnkQGXo4imTHmHKtWkvJT9m1uSVuJu1GdZO5C19bsj1PwYEs3l654U1rVVlQMv8QjXlyR3Fj8XH7tpUAtAAUPGQXoUPkhe70jcDjMYEC_54',
        'roleBadge': 'Thủ quỹ',
        'roleTone': 'TREASURER',
        'isLeader': false,
      },
      'expense': {
        'expenseId': 'exp-banh-mi-mot',
        'title': 'Khoản chi mới được tạo',
        'subtitle': 'Bánh Mì Phượng & Nước Mót Hội An',
        'amountLabel': '160.000đ',
        'splitLabel': 'Chia đều 4 người',
        'perPersonLabel': '40.000đ / người',
        'actionLabel': 'Xem chi tiết chi tiêu',
      },
    },
    {
      'id': 'msg-4',
      'kind': 'TEXT',
      'isMine': true,
      'text':
          'Mình và Lan Phương đã thuê xong xe máy rồi nhé, đổ đầy xăng sẵn sàng rồi! 👍🌊',
      'timeLabel': '14:25',
      'readStatus': 'READ',
      'showAvatar': false,
    },
  ],
  'utilities': [
    {'kind': 'LIVE_LOCATION', 'label': 'Vị trí live'},
    {'kind': 'SPLIT_BILL', 'label': 'Chia tiền'},
    {'kind': 'ALBUM', 'label': 'Album trip'},
    {'kind': 'ADD_STOP', 'label': 'Thêm chặng'},
  ],
};

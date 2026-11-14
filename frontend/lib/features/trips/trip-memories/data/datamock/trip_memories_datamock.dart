// Dữ liệu mẫu cho màn Album kỷ niệm chuyến đi, đúng shape của
// `getMemories` (`GET /trips/memories/{tripId}`, `MemoriesCursorResponseDto`)
// và `createTripMemories` (`POST /trips/memories/{tripId}/batch`).
// App luôn gọi API thật; file này dùng cho test và làm tài liệu hợp đồng.
//
// - `data` mới nhất trước (`createdAt` desc, rồi `id` desc).
// - `meta.totalCount` / `meta.dayCounts` chỉ có ở trang đầu (không cursor);
//   ngày chuyến đi đếm theo UTC từ `startDate`.
// - `badge` là nhãn backend gợi ý theo nội dung ảnh, null khi chưa phân loại
//   (ảnh vừa đăng) hoặc không nhãn nào phù hợp.
//
// Chuyến đi mẫu: 15/07/2025 – 20/07/2025, Đà Nẵng (15–18) rồi Hội An (18–20).
const Map<String, dynamic> tripMemoriesDatamock = {
  'tripMemoriesPage': {
    'data': [
      {
        'id': 'memory-lanterns',
        'tripId': 'trip-demo-summer-2025',
        'caption': 'Đèn lồng phố Hội lung linh',
        'createdAt': '2025-07-18T13:15:00.000Z',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBTJ_34g9HXkUod21ScfQK3UK22OHcvS1KIpeUgNTLZeZLAEIhyHRNm7qpMUQc16jvsflcfTXtPiQmBmd9zM7fupqyPAQWnjWCLmEfbMd6_h-wpGxZVv31zztmSOBVY-MvuVP3DXuNS9WWHjVQzxXLAgL5KJJz1sOX1_kdULhPh0fnf1CVxA-RQN0SuiFZeQRmOkPybRE3bA9r8hbaa-lJi0b6jANSR99t8RbOSFW6RnQWd3hSXH9WI',
        'badge': 'Khoảnh khắc đêm',
        'user': {'id': 'user-trang', 'username': 'minhtrang', 'avatarId': null},
        'media': {
          'id': 'media-lanterns',
          'mimeType': 'image/jpeg',
          'width': 1600,
          'height': 1000,
        },
      },
      {
        'id': 'memory-hoai-river',
        'tripId': 'trip-demo-summer-2025',
        'caption': 'Thả hoa đăng sông Hoài',
        'createdAt': '2025-07-18T12:50:00.000Z',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCgy08aTVQtOiuueftXVsGTo0BJkfC4v7X3Z_Gsa_VuNN-EZB-w5B7SiAsF_RVHavN7U6A30XdJr9NZ29k8qeHKPR0RXnuedK6cL14kERP5iRbwDcHKvIiEpeChwQpsE0e7uq32Pk3aPuZB8aMGdTCCJngMhLAHjxCIA-rjvpqVp1vBjL3yrG5SZwXFMqE4XPwYWUn0cIIRCs-Y5K84Zzi8-876dN5yS80w8pkpvkxX8pL69TS2kOYr',
        'badge': 'Khoảnh khắc đêm',
        'user': {'id': 'user-trang', 'username': 'minhtrang', 'avatarId': null},
        'media': {
          'id': 'media-hoai-river',
          'mimeType': 'image/jpeg',
          'width': 1200,
          'height': 1200,
        },
      },
      {
        'id': 'memory-yellow-wall',
        'tripId': 'trip-demo-summer-2025',
        'caption': 'Tường vàng hoa giấy',
        'createdAt': '2025-07-18T09:05:00.000Z',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBgGqKiymQAXejia_5ZCKix5LBmPSPPtrREzvDQ4hq48rUuQcS9wI83QSY0-TUWI7LXMfpWxtzaJYqk5cKPfm04202C87vwfdFkz4COIVEeLs7GVFSSMJrItjzhN_Wo1mKTtlQsj-DdxNj4aO0wn5LHAL9W7RU2_uGG9myq5rC7lBQf1APKgg0K1ZcWcun_cc4NATur6kFAi7-SXEPzPAbTKMeDX8cAOzMn59Rd5aoPDg20qvq0Gd9X',
        'badge': null,
        'user': {'id': 'user-alex', 'username': 'alex', 'avatarId': null},
        'media': {
          'id': 'media-yellow-wall',
          'mimeType': 'image/jpeg',
          'width': 1200,
          'height': 1200,
        },
      },
      {
        'id': 'memory-banh-mi',
        'tripId': 'trip-demo-summer-2025',
        'caption': 'Bánh mì Phượng',
        'createdAt': '2025-07-18T05:40:00.000Z',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuByPwNHBFxj8-bCHWBgiF3sfxlVWPyW1sZSj2tAHYPwkA0kUA7OFEbuYJGvCvsbgS9cdMkBjkw7a2PT0CC-qzovsEbSplmXEa8puN3fGqV8KzZ1q7AusKa3M8lk1qt6NPoFLKukyQnV6sb9m8ISVMAuTgQIgeX5LzGcAvOdc7aNA0FyOptQQrPP-tUVo1KTTwlWvObeR7qBCtpqYumw5bCwcoVHBaeboZ4kjTaI3l-Qhut4K7M0gKj_',
        'badge': 'Khoảnh khắc ẩm thực',
        'user': {
          'id': 'user-phuong',
          'username': 'lanphuong',
          'avatarId': null,
        },
        'media': {
          'id': 'media-banh-mi',
          'mimeType': 'image/jpeg',
          'width': 1200,
          'height': 1200,
        },
      },
      {
        'id': 'memory-mi-quang',
        'tripId': 'trip-demo-summer-2025',
        'caption': 'Mì Quảng ếch',
        'createdAt': '2025-07-18T04:30:00.000Z',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuABH-RXJ-OMcGNHByNSUOs_Ox06fQ8fLBfWMerEUwunBSdZwdL_3FW-GxXf-TyxEA4WteYIo8aVPEEuKlRGHIyO2zETPXuVCjWDr13wvjzEZn9BFg29tRY-cttTUawC7SaGz-W5_mbS30fotfwKmItmkxh-4IdjZ0fEGYTOo-XKESe5w4bHxMcPWdjJFmx6Z8ZwUAx4on-zvY62cOvDUQKK4-16WdbksqGtaakkXpUMObR06woDesD8',
        'badge': null,
        'user': null,
        'media': {
          'id': 'media-mi-quang',
          'mimeType': 'image/jpeg',
          'width': 1200,
          'height': 1200,
        },
      },
      {
        'id': 'memory-linh-ung',
        'tripId': 'trip-demo-summer-2025',
        'caption': 'Hoàng hôn chùa Linh Ứng',
        'createdAt': '2025-07-15T11:30:00.000Z',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuB87FKp5wXy-YK6UzW7tXafL52rmosIMeDbBibcT5RIfVAbis2D_JVXbIwwKGwxilM9hk8kcZjbF5cyJxawPXPQFgfQoAqEngXe5CCA-Y38FGtHpa-Vpv4n3uYjw2QXOO_1Jgvvf5H9MCFJymk8hLzljOePJ7HudedCP0g1CpgIjt2seJtsB9AKdtXzu-m2S5UwnyP6OO2xHDCTjBTN5k3ZwtZ4PO08Ox83Ldu6bUcx_tkiKWwm_SUu',
        'badge': null,
        'user': {'id': 'user-bao', 'username': 'quocbao', 'avatarId': null},
        'media': {
          'id': 'media-linh-ung',
          'mimeType': 'image/jpeg',
          'width': 1200,
          'height': 1200,
        },
      },
      {
        'id': 'memory-salt-coffee',
        'tripId': 'trip-demo-summer-2025',
        'caption': null,
        'createdAt': '2025-07-15T05:00:00.000Z',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDKsV-07XtFKv8Cp4xX3E5sD4CotzBgUBa2L3eO4TNON5NqIYc7TCRZb-xyL7dOMidjEoTAAQuNaSHTe5hwEKB-96zMNeqIM4Lu9-noviAYuO785eiZAF3lm4ckOpfdfeWzJjlxVaK5cHaEyCuR2_8-7-kQsXTeoapE1-zGOyigryNyAAA-XiVTG91pdwIOSv4mQqBi54SbnygAfAyvyz1sFWPze0-jzdFlomDfnkPLv6ve2R23lvRM',
        'badge': null,
        'user': {'id': 'user-alex', 'username': 'alex', 'avatarId': null},
        'media': {
          'id': 'media-salt-coffee',
          'mimeType': 'image/jpeg',
          'width': null,
          'height': null,
        },
      },
      {
        'id': 'memory-group-checkin',
        'tripId': 'trip-demo-summer-2025',
        'caption': 'Cả nhóm ở bán đảo Sơn Trà',
        'createdAt': '2025-07-15T04:20:00.000Z',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCfXAIpsCfjD5dm_7k2_I2CL7fJA4_zq1MnHFsKsFtQBtt8Dj_xpA3Yd9K4qym-BBVni7Kz76qo5UMZXay3cEwEvGkc2E8u11CyAoSx2KI37XMuzvZNhcC4Jwlof9mLcmwkOD6-pQvm-VfwHQ-gL7bhi_J1ZYcFf-_2iBpmjH_e3YRmFobbmEJd_T3CXL02pwWm3pHchip_QBv9rsWPG_-9PhJ8EOUGwtWiMcKz8KHoK89vaX6kqIWp',
        'badge': 'Khoảnh khắc đáng nhớ',
        'user': {'id': 'user-trang', 'username': 'minhtrang', 'avatarId': null},
        'media': {
          'id': 'media-group-checkin',
          'mimeType': 'image/jpeg',
          'width': 1200,
          'height': 1200,
        },
      },
      {
        'id': 'memory-son-tra-pass',
        'tripId': 'trip-demo-summer-2025',
        'caption': 'Đường đèo Sơn Trà từ trên cao',
        'createdAt': '2025-07-15T03:10:00.000Z',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuC3ZWqFkU5ASZYaMXxvzyWX1OCPB7HK4WkTkocToTPW9b3FTrG1ODGL76xe1a89TFoebeBCV50lptYLafItUu_FK2EglKFM-3KFXzouu1xRK60TJ9xITMfk378Uroizh1S0G5H6klQFUalqL_JF0CWpS1DPp7bFtfJpzsakeGIq4Qrmxax7U-XYEp8osh2xhsXMuricbYYrW_zYLXd5pn3FxV1RLBrE0qVZ62NJqKLok8QnKuh4Zens',
        'badge': null,
        'user': {'id': 'user-bao', 'username': 'quocbao', 'avatarId': null},
        'media': {
          'id': 'media-son-tra-pass',
          'mimeType': 'image/jpeg',
          'width': 1200,
          'height': 1200,
        },
      },
      {
        'id': 'memory-ban-co',
        'tripId': 'trip-demo-summer-2025',
        'caption': 'Bình minh Đỉnh Bàn Cờ',
        'createdAt': '2025-07-15T01:45:00.000Z',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCR51yJbSyFGStA_RunGBNbBytWj681C-9KZ5LjGTdBTBmlCfg4aerVvUrba5yj2BZw38QcEXHW8SJyXPs85NB_jivviR-TCDdLcyl2YBmWp462Eh3bBNMVKQOlk-tjj_GxaWefUrf3myIzPBeisU-jKyPIpbTLCmN7tS0Q1rsdaCxHGjkTnB6curhFq6e7yqud_VXBIfQHPsHX29VLOSGCK9gi7wWWUCHjHd4eWyNgZzTy_eaxhzK3',
        'badge': 'Khoảnh khắc nổi bật',
        'user': {'id': 'user-alex', 'username': 'alex', 'avatarId': null},
        'media': {
          'id': 'media-ban-co',
          'mimeType': 'image/jpeg',
          'width': 1600,
          'height': 1600,
        },
      },
    ],
    'meta': {
      'nextCursor': null,
      'hasMore': false,
      'totalCount': 10,
      'dayCounts': [
        {'day': 1, 'count': 5},
        {'day': 4, 'count': 5},
      ],
    },
  },
  'tripMemoriesBatchResponse': {
    'data': [
      {
        'id': 'memory-new-1',
        'tripId': 'trip-demo-summer-2025',
        'caption': null,
        'createdAt': '2025-07-19T02:00:00.000Z',
        'imageUrl': 'https://cdn.example.com/trips/memory-new-1.jpg',
        'user': {'id': 'user-alex', 'username': 'alex', 'avatarId': null},
        'media': {
          'id': 'media-new-1',
          'mimeType': 'image/jpeg',
          'width': 1080,
          'height': 1350,
        },
        'badge': null,
      },
    ],
    'message': 'Memories created successfully',
  },
};

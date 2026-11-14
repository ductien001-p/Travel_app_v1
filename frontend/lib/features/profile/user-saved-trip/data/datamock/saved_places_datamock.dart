// Dữ liệu mẫu đúng shape của `GET /places/saved/me` (`SavedPlacesPageResponseDto`)
// và `GET /places/saved/count` (`SavedPlacesCountEnvelopeResponseDto`).
// App luôn gọi API thật; file này dùng cho test và làm tài liệu hợp đồng.
//
// Danh sách xếp `createdAt` giảm dần. Hợp đồng không có ảnh bìa, số đánh giá,
// bộ sưu tập tùy chỉnh, hay query tìm kiếm / lọc category.
const Map<String, dynamic> savedPlacesDatamock = {
  'savedPlacesPage': {
    'data': [
      {
        'id': 'saved-hoi-an',
        'userId': 'user-1',
        'placeId': 'place-hoi-an',
        'createdAt': '2026-10-20T08:00:00.000Z',
        'place': {
          'id': 'place-hoi-an',
          'name': 'Phố Cổ Hội An',
          'description': null,
          'category': 'OLD_TOWN',
          'city': 'Hội An',
          'country': 'Việt Nam',
          'address': 'TP. Hội An, Quảng Nam',
          'latitude': 15.8801,
          'longitude': 108.338,
          'averageRating': 4.9,
        },
      },
      {
        'id': 'saved-son-tra',
        'userId': 'user-1',
        'placeId': 'place-son-tra',
        'createdAt': '2026-10-18T08:00:00.000Z',
        'place': {
          'id': 'place-son-tra',
          'name': 'Bán Đảo Sơn Trà',
          'description': null,
          'category': 'MOUNTAIN',
          'city': 'Đà Nẵng',
          'country': 'Việt Nam',
          'address': 'Sơn Trà, TP. Đà Nẵng',
          'latitude': 16.124,
          'longitude': 108.277,
          'averageRating': 5,
        },
      },
    ],
    'meta': {
      'page': 1,
      'limit': 20,
      'total': 2,
      'totalPages': 1,
      'hasNextPage': false,
      'hasPreviousPage': false,
    },
  },
  'savedPlacesCount': {
    'data': {'count': 2},
    'message': 'Saved places count retrieved successfully',
  },
};

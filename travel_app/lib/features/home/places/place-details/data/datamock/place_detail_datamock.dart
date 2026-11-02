// Hợp đồng mẫu của màn Chi Tiết Điểm Đến, chỉ dùng cho test.
// Luồng chạy lấy GET /places/{id}, reviews, summary, save status và posts.

const Map<String, dynamic> placeDetailDatamock = {
  'placeDetail': {
    'place': {
      'id': 'pho-co-hoi-an',
      'name': 'Phố Cổ Hội An',
      'description':
          'Phố Cổ Hội An từng là thương cảng quốc tế sầm uất. Hoàng hôn buông xuống, sông Hoài lấp lánh đèn hoa đăng.',
      'city': 'Hội An',
      'country': 'Việt Nam',
      'address': 'Trần Phú, Phường Minh An, Hội An',
      'latitude': 15.8801,
      'longitude': 108.338,
      'category': 'OLD_TOWN',
      'status': 'APPROVED',
      'averageRating': 4.8,
      'coverImageUrls': <String>[],
    },
    'summary': {
      'averageRating': 4.8,
      'totalReviews': 128,
      'distribution': {'1': 2, '2': 4, '3': 8, '4': 26, '5': 88},
    },
    'reviews': {
      'data': [
        {
          'id': 'review-lan',
          'userId': 'user-lan',
          'placeId': 'pho-co-hoi-an',
          'rating': 5,
          'comment': 'Hoàng hôn trên sông Hoài rất đẹp.',
          'createdAt': '2026-10-30T08:00:00.000Z',
          'updatedAt': '2026-10-30T08:00:00.000Z',
          'user': {'id': 'user-lan', 'username': 'lanphuong', 'avatarId': null},
        },
        {
          'id': 'review-trang',
          'userId': 'user-trang',
          'placeId': 'pho-co-hoi-an',
          'rating': 4,
          'comment': 'Cuối tuần khá đông nhưng đèn lồng rất đẹp.',
          'createdAt': '2026-10-25T08:00:00.000Z',
          'updatedAt': '2026-10-25T08:00:00.000Z',
          'user': {
            'id': 'user-trang',
            'username': 'thutrang',
            'avatarId': null,
          },
        },
      ],
      'meta': {
        'page': 1,
        'limit': 10,
        'total': 128,
        'totalPages': 13,
        'hasNextPage': true,
        'hasPreviousPage': false,
      },
    },
    'saveStatus': {'saved': true, 'savedAt': '2026-10-01T00:00:00.000Z'},
    'myReview': null,
    'posts': {
      'data': [
        {
          'id': 'post-lan',
          'caption': 'Thả hoa đăng',
          'likesCount': 184,
          'author': {
            'id': 'user-lan',
            'username': 'lanphuong.travel',
            'avatarId': null,
          },
          'postMedias': [
            {'mediaId': 'media-lan', 'orderIndex': 0},
          ],
        },
      ],
      'meta': {
        'page': 1,
        'limit': 8,
        'total': 46,
        'totalPages': 6,
        'hasNextPage': true,
        'hasPreviousPage': false,
      },
    },
  },
};

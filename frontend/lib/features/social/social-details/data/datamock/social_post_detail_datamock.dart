/// Datamock khớp Stitch "Chi Tiết Bài Viết & Bình Luận" + shape
/// `GET /social/posts/:id` và `GET /social/posts/:id/comments`.
const Map<String, dynamic> socialPostDetailDatamock = {
  'id': 'post-hoi-an-lan',
  'authorId': 'user-lan',
  'placeId': 'place-hoi-an',
  'caption':
      'Hoàng hôn trên Chùa Cầu đẹp đến nao lòng ✨ Đừng quên thử trà Mót và '
      'Cao Lầu khi ghé Hội An nhé! 🏮\n\n#HoiAn #FoodieTravel #VietnamTravel '
      '#TealHorizon',
  'visibility': 'PUBLIC',
  'tipTitle': 'Mẹo ẩm thực Hội An',
  'tipBody': 'Ghé trà Mót buổi chiều, Cao Lầu nên ăn nóng.',
  'topic': 'HIDDEN_EATS',
  'placeDetail': 'Quảng Nam, Việt Nam • Di sản thế giới',
  'likesCount': 248,
  'commentsCount': 42,
  'sharesCount': 18,
  'savesCount': 56,
  'createdAt': '2026-11-11T08:00:00.000Z',
  'updatedAt': '2026-11-11T08:00:00.000Z',
  'author': {
    'id': 'user-lan',
    'username': 'lanphuong',
    'displayName': 'Lan Phương',
    'avatarId': 'media-avatar-lan',
    'avatarUrl':
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAW0AyliY5IvYiMFN23p7gwAlFrt4xvFQzQH7_EytyxMPEU4f-zVDhVBvzVbG9yYHeJbX2kThXJ11K-7dIe2wyuqHDZy1dlG6LLwuSOHnjdnBa1yc5A6u0ecdzZEYodLq8Ht2wp-5wyfIem2UkxTLI6lAbOGQL1eo7aSMqDVS81oOeugVQ9gvMxQ7ZYeP34vlr4BJZF_2e6Q3NxFf4jHKzvrcwzl9KTF8_AgvmCG6f5IE7sGKE7ReWk',
    'badgeLabel': 'Foodie Traveler 🍜',
    'verified': true,
  },
  'place': {
    'id': 'place-hoi-an',
    'name': 'Phố Cổ Hội An',
    'detail': 'Quảng Nam, Việt Nam • Di sản thế giới',
  },
  'postMedias': [
    {
      'mediaId': 'media-boat',
      'orderIndex': 0,
      'url':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBq-6VMpAmYy2EsnxXC3YyzxQfh9C3JAO8mPha728kWRroopZatNKz3zMwKuuGx6wxcQ8TPkXsPksWD7au26UDRZNoFb1DX56wADbwz66hey1SU1HiA39meuYaWieoWLYiNE0GG09kvUqByN3vYhBJUPoZJKBAtoqeOBOVCdQGbE955KA2loqkwuvehj13oIcvUDkEX5MeU1gDV1LwfCteWzppXx0IwVavPg5lOaTdkLGrZ-lcp6KbF',
    },
    {
      'mediaId': 'media-caolau',
      'orderIndex': 1,
      'url':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBUjVjCZ55Zsa09t-mM6UOHnjdnBa1yc5A6u0ecdzZEYodLq8Ht2wp-5wyfIem2UkxTLI6lAbOGQL1eo7aSMqDVS81oOeugVQ9gvMxQ7ZYeP34vlr4BJZF_2e6Q3NxFf4jHKzvrcwzl9KTF8_AgvmCG6f5IE7sGKE7ReWk',
    },
    {
      'mediaId': 'media-tea',
      'orderIndex': 2,
      'url':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBvhvvdzCqNSc3cmX_FUHS1VwPaCVLCVC2E4ZUvBwjxSB_TNzToZGRBVaE9py9LdOjVbG9yYHeJbX2kThXJ11K-7dIe2wyuqHDZy1dlG6LLwuSOHnjdnBa1yc5A6u0ecdzZEYodLq8Ht2wp',
    },
    {
      'mediaId': 'media-lantern',
      'orderIndex': 3,
      'url':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDOn06sH_MpIq4nucomMGbn7e-d4IJYWyxJ1k1hZs8N8TRdI_bzPxFpSy1yNOEMVNSEID-RjJndlriwT0BIVtoBeADS_FebW33sKGzNzja7GmIBIna0Z3TzEOZPSfckmu8VobAGDw7XZgM',
    },
  ],
  '_count': {'likes': 248, 'comments': 42, 'shares': 18, 'saves': 56},
  'liked': false,
  'shared': false,
  'bookmarked': false,
  'trendLabel': 'Đang hot',
  'timeLabel': '2 giờ trước',
};

const Map<String, dynamic> socialPostDetailCommentsDatamock = {
  'data': [
    {
      'id': 'cmt-alex',
      'postId': 'post-hoi-an-lan',
      'userId': 'user-alex',
      'content':
          'Ảnh đẹp quá Lan ơi! Chuyến Hội An của team mình sắp đi rồi, '
          'ghi chú ẩm thực này quá hữu ích 🙌',
      'createdAt': '2026-11-11T09:00:00.000Z',
      'updatedAt': '2026-11-11T09:00:00.000Z',
      'user': {
        'id': 'user-alex',
        'username': 'Alex Nguyễn',
        'avatarId': null,
        'avatarUrl': null,
      },
    },
    {
      'id': 'cmt-minh',
      'postId': 'post-hoi-an-lan',
      'userId': 'user-minh',
      'content': 'Trà Mót đúng là must-try! Mình hay mua mang về làm quà.',
      'createdAt': '2026-11-11T09:15:00.000Z',
      'updatedAt': '2026-11-11T09:15:00.000Z',
      'user': {
        'id': 'user-minh',
        'username': 'Minh Trang',
        'avatarId': null,
        'avatarUrl': null,
      },
    },
    {
      'id': 'cmt-quoc',
      'postId': 'post-hoi-an-lan',
      'userId': 'user-quoc',
      'content':
          'Góc thuyền hoa đăng này chụp lúc golden hour chuẩn luôn. '
          'ISO và shutter tip được không bạn? 📸',
      'createdAt': '2026-11-11T09:40:00.000Z',
      'updatedAt': '2026-11-11T09:40:00.000Z',
      'user': {
        'id': 'user-quoc',
        'username': 'Quốc Bảo',
        'avatarId': null,
        'avatarUrl': null,
      },
    },
  ],
  'meta': {
    'page': 1,
    'limit': 20,
    'total': 42,
    'totalPages': 3,
    'hasNextPage': true,
    'hasPreviousPage': false,
  },
};

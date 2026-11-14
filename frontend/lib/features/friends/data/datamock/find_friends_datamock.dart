// Fixture cho unit test (shape khớp GET /friends/find). Runtime dùng API thật.
const Map<String, dynamic> findFriendsDatamock = {
  'query': 'Nam',
  'matchCount': 4,
  'matchCountLabel': '4 tìm kiếm khớp',
  'recentSearches': ['@linh_le', 'Đà Nẵng Traveler', 'Foodie Group'],
  'dnaBanner': {
    'badgeLabel': 'TRAVEL DNA MATCH',
    'title': 'Tìm Bạn Đồng Hành Hợp Gu 95%+',
    'subtitle':
        'Khám phá những người có cùng tốc độ du lịch, sở thích trekking và phong cách ẩm thực quanh bạn.',
    'ctaLabel': 'Quét DNA ngay',
    'extraCount': 42,
    'previewAvatars': [
      'https://lh3.googleusercontent.com/aida-public/AB6AXuC01t64_Ozsqv4k_hfMKltG-aJQaX9VautjW5hyv3YHuJu3sPaITph2XVVW0eNmDrObatdEsAK74rphoPWzTW9CyvNuFNGgqdQsLA8nchMTInBu0SR23iyGYQ-ed_kf4DlULgMhQ1B-adi19ohOULnUd5e5ypcKTlZzC7G4XIrvT_M--k4OM0prdtdFtNiQ7bLWPzJNnRUqCBSJ_ibSGLH1QPU_PBa324I81o7o7M4',
      'https://lh3.googleusercontent.com/aida-public/AB6AXuCrvwDIojPRmMFuL6iyJb81ED1yZbeKTOL4pzUMWsu5l-hjtF-Vx_HgC4dcJmd6ZBDgZLm4XeZNsMFWlShp5McfOupk9fsYG2R80S2Rt1aA2Ix9vjgcdJD_1wAWuantiZ5KliwNDO2HM31ei2nom61hTXUcTfYDf2sunEyNrwq2HKHb16mxXAwMDGTq8huF_YNHEOkAYiWXdTHVbzrKu8cNPIsA7ic4Ifxwy2fsPuU',
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBeHEGvztaQkuk3BL5FyG9oF6ugbJaU5AngjL2VMWOA9As15UAx7QYUyFbtjBAxdFIZGvilIQo5_aqdUkmSRIcMN-VUKKr14AFoQ9Y6IdoYV4VZkCqH3nV7QSP4KFKwhG_a7ohxp12MWotWuOUHlfQwdl5bZI2seoWl3c4sGe2XO-Of-nG48s1xlvRdDaHWp7WswYkWTfAWhoyjI6HChpv0hC8sx4xoP-6yZKei8Ac',
    ],
  },
  'results': [
    {
      'id': 'user-hoang-nam',
      'displayName': 'Hoàng Nam',
      'username': 'nam_wanderer',
      'avatarUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCpozSWaL6765yFW0HfcEftkrip991w_E7Ah84HZUimo6Anyqk2mR5moysG7Joxg_zclEpvycPbAwlrSKs9iZ-x3bvRGmEQrQRwIF8uijI7ctSl7Z576e_n2GucKWJlXfnAyVcpYKLNj9GIBFknP_ScrgXRsHGK5LCsend19PnhIVwXvSMqyuDKbIpsNPoq7gMp9bUW4wwy3GqDbvbHFLDS9-pFb5T_YFNE9xT4eoE',
      'isOnline': true,
      'verified': false,
      'action': 'ADD_FRIEND',
      'conversationId': null,
      'badges': [
        {'label': '🍜 Foodie Traveler', 'tone': 'AMBER'},
        {'label': 'Cùng sở thích leo núi', 'tone': 'PRIMARY', 'icon': 'hiking'},
      ],
      'metaIcon': 'group',
      'metaLine': 'Chung 4 chuyến đi • Kết nối qua Hội Trekking Tà Năng',
      'travelPersona': 'Foodie Traveler',
      'dnaMatchPercent': null,
      'sharedTripsCount': 4,
    },
    {
      'id': 'user-le-thao-linh',
      'displayName': 'Lê Thảo Linh',
      'username': 'linh_le',
      'avatarUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCuQsofykDg26kuYR7MFctc_kEtvDRouZCwKZHM_H5RPtiZnuMMYE8kXGa9T3Y9vmXKf7_L8vNM1qtsIs2spWqsLBW_rmniaTSKLwsSRUWAF9OI9aMaYIYcziYotk7TAF2wY0j7z-C-uosndWPzuYwm6vINKDLAORFTNV329of8FvwlLC3GblDzEnhnYOuVoPMD36Vulx_tEarLSWGJig7cTqSlUAjgfuVAGczsNnw',
      'isOnline': false,
      'verified': true,
      'action': 'REQUEST_SENT',
      'friendRequestId': 'req-linh',
      'conversationId': null,
      'badges': [
        {'label': '98% tương thích DNA', 'tone': 'TEAL', 'icon': 'bolt'},
        {'label': '🏛️ Culture Traveler', 'tone': 'INDIGO'},
      ],
      'metaIcon': 'location_on',
      'metaLine': 'Đang ở Đà Nẵng • Điểm đến tiếp theo: Hội An',
      'travelPersona': 'Culture Traveler',
      'dnaMatchPercent': 98,
      'sharedTripsCount': null,
    },
    {
      'id': 'user-alex-nguyen',
      'displayName': 'Alex Nguyễn',
      'username': 'alex_wander',
      'avatarUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuA6rSuKfwz_ZsKudRokfsbkZIi3BzwwFhMrc1o1Rjfguc--XK_AU52_4NLYubs8x6TDYYFiuKceaZB3BAOXypSVe2hN8dVvUutA8jBQtKjMauJ9Qzb3pcViSMyPg_hBDaxPQCvDgzhW0iZo-tFhhboTV-ZoKzP93BjSqQwlpsXRBCgwWmXm83oKjy6fuNg5_PNX6bM7lD5YL6JNYoW1mXM3I9NiV0MEbz3T66e6NaE',
      'isOnline': true,
      'verified': false,
      'action': 'MESSAGE',
      'conversationId': 'conv-alex-nguyen',
      'badges': [
        {
          'label': 'Bạn bè thân thiết',
          'tone': 'PRIMARY_SOFT',
          'icon': 'how_to_reg',
        },
        {'label': '🎒 Khám phá thiên nhiên', 'tone': 'SUBDUED'},
      ],
      'metaIcon': 'luggage',
      'metaLine': 'Đã cùng đi 12 chuyến (Hà Giang, Phú Quốc, Bali...)',
      'travelPersona': 'Nature Explorer',
      'dnaMatchPercent': null,
      'sharedTripsCount': 12,
    },
    {
      'id': 'user-minh-triet',
      'displayName': 'Minh Triết',
      'username': 'triet_photographer',
      'avatarUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCv03OqFTPpTOpeWjVFcTCTEShS894YYIkR5TIqn04OSx2CAu_XMKghS3BcBytWctgIjOougYLJdTLW0DkIDxss3YZrpMsYOlCl1DL3AiE7t7nzZj-vJ-bZzzWzKTJbPWjKyE2NM5Bcgc2N6-Pb2jc3D0edeIFdJpM6Biyz8DlpTXfK60hzIDAujGNAY8hvF3aL6o8Xx_0s_WR1LCzjW2AAZT3DUzPt3J35oDiw4sw',
      'isOnline': false,
      'verified': false,
      'action': 'FOLLOW',
      'conversationId': null,
      'badges': [
        {'label': '📷 Photography Lover', 'tone': 'ROSE'},
        {'label': 'Landscape Creator', 'tone': 'SUBDUED'},
      ],
      'metaIcon': 'diversity_1',
      'metaLine': 'Được theo dõi bởi Lan Phương và 8 người khác',
      'travelPersona': 'Photography Lover',
      'dnaMatchPercent': null,
      'sharedTripsCount': null,
    },
  ],
  'nearbySuggestions': [
    {
      'id': 'user-van-hung',
      'displayName': 'Văn Hưng',
      'avatarUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCPZfR_HwOzUTBZH3chi-HUGX1euYhDj9iUj83GsNzKbhl-yxIy8gRciH2bsyyH3DaiSBv2No_c8MFpOg08QW1cg9qJ7w_LG9VZy_Ix0fMm0bZ20pylgWgbdCmHhvs9kQ4SqlS8DvUHI1f9UNc0MXOqLXEr0ioYaAMWCNKBB6s4IJ_UDxkGfac8PNsgJoWhTm5HVjlqCkfwkME_vYweu_n0QNVe-GnREfGZNkF6ckU',
      'subtitle': 'Đang ở gần bạn (1.2km)',
      'chipLabel': 'Cùng thích Camp',
      'chipTone': 'SECONDARY',
      'action': 'ADD_FRIEND',
      'distanceKm': 1.2,
    },
  ],
};

/// Lọc fixture theo query (unit test).
Map<String, dynamic> findFriendsDatamockForQuery(String? query) {
  final q = (query ?? '').trim().toLowerCase();
  if (q.isEmpty) {
    return Map<String, dynamic>.from(findFriendsDatamock)
      ..['query'] = ''
      ..['matchCount'] = (findFriendsDatamock['results'] as List).length
      ..['matchCountLabel'] =
          '${(findFriendsDatamock['results'] as List).length} tìm kiếm khớp';
  }

  final results = (findFriendsDatamock['results'] as List)
      .whereType<Map>()
      .map((e) => Map<String, dynamic>.from(e))
      .where((user) {
        final name = (user['displayName'] as String? ?? '').toLowerCase();
        final username = (user['username'] as String? ?? '').toLowerCase();
        final persona = (user['travelPersona'] as String? ?? '').toLowerCase();
        return name.contains(q) ||
            username.contains(q) ||
            '@$username'.contains(q) ||
            persona.contains(q);
      })
      .toList();

  return Map<String, dynamic>.from(findFriendsDatamock)
    ..['query'] = query!.trim()
    ..['results'] = results
    ..['matchCount'] = results.length
    ..['matchCountLabel'] = '${results.length} tìm kiếm khớp';
}

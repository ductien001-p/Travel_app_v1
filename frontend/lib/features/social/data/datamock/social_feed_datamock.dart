// Dữ liệu mẫu cho màn Social Feed (Stitch "Mạng Xã Hội Du Lịch - Social Feed").
// Shape demo của GET /social/feed — backend chưa có endpoint tổng hợp addictive UX.
// Phần bài viết thô có GET /social/posts/feed (OpenAPI) nhưng thiếu stories/challenge/tip/CTA.
//
// TODO(backend): API demo — thay bằng endpoint thật khi backend xong
const Map<String, dynamic> socialFeedDatamock = {
  'header': {
    'title': 'Bảng Tin',
    'streakLabel': '7 ngày xê dịch',
    'hasUnreadNotifications': true,
    'showFriendsCta': true,
  },
  'composer': {
    'displayName': 'Alex',
    'avatarUrl':
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAW0AyliY5IvYiMFN23p7gwAlFrt4xvFQzQH7_EytyxMPEU4f-zVDhVBvzVbG9yYHeJbX2kThXJ11K-7dIe2wyuqHDZy1dlG6LLwuSOHnjdnBa1yc5A6u0ecdzZEYodLq8Ht2wp-5wyfIem2UkxTLI6lAbOGQL1eo7aSMqDVS81oOeugVQ9gvMxQ7ZYeP34vlr4BJZF_2e6Q3NxFf4jHKzvrcwzl9KTF8_AgvmCG6f5IE7sGKE7ReWk',
    'prompt': 'Alex ơi, chia sẻ khoảnh khắc tuyệt vời hôm nay nào! ✨',
  },
  'stories': [
    {
      'id': 'story-self',
      'label': 'Bạn',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBfvwPcjg-ZEGEq1zd8yMjOkogD1lpPdlzeOQ9EGtDgrPxBO3x9z3t-zpm17YADhCE-y98eaUMJbwF8b-JEjbNr431VcR_tZLVWeowlT4CXcg8L4rKN4kaEHpDgJJYcRsRrngjSKSu6BX1D_kbfFRVwVdxP3YUitgYY5I-_nkMfxNUu-xFqU1ePRZEn5MTGAnwAtaWLI7zfyxVvsd--hNBXrI0X33hrr_pMr7EjFMTb3_h7oeKi61EH',
      'isSelf': true,
      'isActive': false,
      'badge': 'NONE',
    },
    {
      'id': 'story-da-nang',
      'label': 'Đà Nẵng',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBUjVjCZ55Zsa09t-mM6Obvue67QVSJl0poNjkAh1S_-NcqpSNgu7DQWQ9fKOECIx7pegLLLBW603S9WC6cHRW9IErim7enZwLEuoFsf6Lwf-t7_FUgGWn1L3jm_QtQjxqzbQALUFKzYfnI8e0cXwuq5o9O21pMZYnkD6XKFxXmUVMUhGTFWqyaGVYl0e6CHklEEMwmOEotx_gvtBAppJDCAg8VNcEbn1AZwmP-15unaqhEpXtx0xPG',
      'isSelf': false,
      'isActive': true,
      'badge': 'LIVE',
    },
    {
      'id': 'story-hoi-an',
      'label': 'Hội An',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBq-6VMpAmYy2EsnxXC3YyzxQfh9C3JAO8mPha728kWRroopZatNKz3zMwKuuGx6wxcQ8TPkXsPksWD7au26UDRZNoFb1DX56wADbwz66hey1SU1HiA39meuYaWieoWLZiNE0GG09kvUqByN3vYhBJUPoZJKBAtoqeOBOVCdQGbE955KA2loqkwuvehj13oIcvUDkEX5MeU1gDV1LwfCteWzppXx0IwVavPg5lOaTdkLGrZ-lcp6KbF',
      'isSelf': false,
      'isActive': true,
      'badge': 'NEW',
    },
    {
      'id': 'story-phu-quoc',
      'label': 'Phú Quốc',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBvhvvdzCqNSc3cmX_FUHS1VwPaCVLCVC2E4ZUvBwjxSB_TNzToZGRBVaE9pyXLdObVULUD3qcPsMiKOzhVb_fsUwB7lpcAnk7qbHI4pipUSzqDoLFzLiqrXydZGpEuA7zz5kcDWlLXF7pRTlk1aPrkahMeO7_LKW5EdQkz5adX2eJoWmaZB6ftVfqru2AH4Gag9nJU3nATJoIcaOLqwEZ2Q9uIPg2NF2avJO95Rl_bUNgkBMlzF5oz',
      'isSelf': false,
      'isActive': true,
      'badge': 'NONE',
    },
    {
      'id': 'story-sapa',
      'label': 'Sapa',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDOn06sH_MpIq4nucomMGbn7e-d4IJYWyxJ1k1hZs8N8TRdI_bzPxFpSy1yNOEMVNSEID-RjJndlriwT0BIVtoBeADS_FebW33sKGzNzja7GmIBIna0Z3TzEOZPSfckmu8VobAGDw7XZgM-Cf2bALZ-0QRQi8_ZoSuLXgC-NKIl2BZvaW1j6cM82IPfEKWz1nYFxJrGm3EnUJvRMVmNb5SCxE6rEvLTtZUrj7Q-S-CEa7B6wNQ2Wg2P',
      'isSelf': false,
      'isActive': false,
      'badge': 'NONE',
    },
    {
      'id': 'story-ha-giang',
      'label': 'Hà Giang',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD7U1JVT2qhbCE48gmO6U_xkbp6_CFoVewI3d8OKUD-gQfMj0tdjYqAR8FzJlzGV9DzLznmXlCsC_rdFhGrxcbFqgz0cHKT3rChxBugnr1nK1DB7AXQHYPwF3f63kjKDNeBlos0s3O4NCmEoFBb_HAlBt_UOVa5nDJkBuUrnTB0z7XmTRTv-fTCmQ6k3VSBJLkMnQfVPnkTPgxsLd_hgaydqJ39BhZklUCBrZ6KxzYjc66oJeTY0Msh',
      'isSelf': false,
      'isActive': false,
      'badge': 'NONE',
    },
  ],
  'tabs': [
    {'id': 'explore', 'label': 'Khám phá', 'selected': true},
    {
      'id': 'following',
      'label': 'Đang theo dõi',
      'badgeLabel': '12',
      'selected': false,
    },
    {'id': 'nearby', 'label': 'Gần bạn', 'emoji': '🔥', 'selected': false},
  ],
  'topicChips': [
    {'id': 'HIDDEN_EATS', 'label': '🍜 Quán ngon giấu kín', 'selected': false},
    {'id': 'PHOTO_SPOTS', 'label': '📸 Góc sống ảo', 'selected': false},
    {'id': 'ITINERARY_2N1D', 'label': '🗺️ Lộ trình 2N1Đ', 'selected': false},
    {'id': 'FIND_BUDDY', 'label': '🎒 Tìm bạn đồng hành', 'selected': false},
  ],
  'items': [
    {
      'id': 'item-review-lan-phuong',
      'type': 'REVIEW',
      'review': {
        'postId': 'post-lan-phuong-hoi-an',
        'author': {
          'id': 'user-lan-phuong',
          'displayName': 'Lan Phương',
          'avatarUrl':
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDXUPowuJaUTgN2uHchBD9FdangJs0jf4XJ3jQNBqrVx1GJuVxzmdhYQAsBPAYAbsJuvXzbnL73XjlE-yWMpEI4vgsktqrb0YsJVGDvPnLi1FSH90xhbOVh5LajKm6vsB0USY9FlOWRRgTGorK1Widx9UdzFZmxLPHd8nIfJvTLvoCYa0ylX1RVCkNfclcHhZmBAlcNrRNSBA4FLFqpReteWWLWSn1Zo8HG3OqY0xrqGGRMkSRcqRcb',
          'badgeLabel': 'Top 1% Foodie Hoi An',
          'verified': true,
        },
        'timeLabel': '2 giờ trước',
        'trendLabel': 'Trending hôm nay',
        'placeLabel': 'Phố Cổ Hội An, Quảng Nam',
        'placeDetail': '📍 Quán Mót',
        'placeId': 'place-hoi-an',
        'savedByLabel': '+320 người đã lưu',
        'caption':
            'Một buổi chiều hoàng hôn buông xuống chùa Cầu thật êm ả. Bọn mình đã ghé quán nước Mót thơm lừng mùi sen sả và thử món cao lầu gia truyền ngon nức nở! Đừng quên đi thuyền hoa đăng lúc 18:30 nhé cả nhà ✨🛶',
        'tipTitle': 'Mẹo độc quyền:',
        'tipBody':
            'Đến Chùa Cầu vào 16:30 để lấy góc nắng vàng chiếu qua mái ngói không dính người, sau đó tạt ngay qua Quán Mót uống thảo mộc lạnh!',
        'medias': [
          {
            'id': 'media-1',
            'imageUrl':
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCny07n4SuOACUF7DhOyEsJKj7xnB4ocGHQ15WqrrvuADdYPNg4Vao0SqW22FaQ2GCLq7Sa0D3g7VMJRXcGA6udwXWO2cDrEFTl1CsoUE_uCzSR1bIK3TzUCnOl7T63_08QS0aTpfIbauXLQusHdnjotUgXqS6atu9t1eHX3pIVs1Gr_f55Ie9qeQRR1BEADGlFBxqGPj6sMLOHdndpII5RK6j_d7RJbGiXXiCZ6N56Tn3YofhMcue5',
            'caption': 'Thuyền hoa đăng Chùa Cầu',
            'isHero': true,
            'overlayLabel': 'Thuyền hoa đăng Chùa Cầu',
          },
          {
            'id': 'media-2',
            'imageUrl':
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBLzO8GulF_859ohS3NswuDJqb7LaCiEOpy1jbrO5TJRaV5sD8UAraITzdsRLx08LxcKmn1ZF_HGyapma-x_sUZAqZ1GI27aJFw9oSRcFrxLQ6IfQprs4wKCv_wQ7R46dQeQCyYEcVT4yo1gQUhndlS1CNQqvOWEYrC-1YDJG9IwamXva5Ha9pTFSrpnpcBsXSZCkfVvIiM1jQm---qVnnQQ2jz6EEon0uanbpeY8B65Wa4APmyxPRk',
            'caption': 'Cao lầu',
            'isHero': false,
          },
        ],
        'extraMediaCount': 3,
        'primaryCtaLabel': 'Gợi ý lịch trình 1 ngày phố cổ',
        'secondaryCtaLabel': 'Lưu vào lịch trình',
        'likesCount': 428,
        'commentsCount': 56,
        'savesCount': 120,
        'liked': true,
        'bookmarked': false,
        'previewComment': {
          'id': 'cmt-1',
          'authorName': 'Alex Nguyễn',
          'avatarUrl':
              'https://lh3.googleusercontent.com/aida-public/AB6AXuAW0AyliY5IvYiMFN23p7gwAlFrt4xvFQzQH7_EytyxMPEU4f-zVDhVBvzVbG9yYHeJbX2kThXJ11K-7dIe2wyuqHDZy1dlG6LLwuSOHnjdnBa1yc5A6u0ecdzZEYodLq8Ht2wp-5wyfIem2UkxTLI6lAbOGQL1eo7aSMqDVS81oOeugVQ9gvMxQ7ZYeP34vlr4BJZF_2e6Q3NxFf4jHKzvrcwzl9KTF8_AgvmCG6f5IE7sGKE7ReWk',
          'text':
              'Quán Mót giờ tối có phải xếp hàng lâu không Phương ơi? Nhóm mình mai cũng tới Hội An nè! 🪷',
          'timeLabel': '15p trước',
          'replyLabel': 'Trả lời • 4 phản hồi khác',
        },
      },
    },
    {
      'id': 'item-challenge-son-tra',
      'type': 'CHALLENGE',
      'challenge': {
        'id': 'challenge-son-tra-cafes',
        'eyebrow': 'THỬ THÁCH TUẦN NÀY',
        'title': 'Khám phá 3 Quán Cà Phê View Biển Sơn Trà',
        'rewardLabel': '+150 Xu',
        'progressLabel': '1/3 quán đã check-in',
        'progressRatio': 0.33,
        'daysLeftLabel': 'Còn 3 ngày',
        'badgeLabel': '🌊 Nhận huy hiệu độc quyền: Biển Xanh 2025',
        'ctaLabel': 'Tham gia ngay',
      },
    },
    {
      'id': 'item-trip-quoc-bao',
      'type': 'TRIP_RECRUIT',
      'tripRecruit': {
        'postId': 'post-quoc-bao-son-tra',
        'author': {
          'id': 'user-quoc-bao',
          'displayName': 'Quốc Bảo',
          'avatarUrl':
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDnTPAFN_BJNTjktWBiUXXqLbHpUl3spBDZiLrUmPWw1BXppG9meCXbwt1qsSuaY3Zva7SDQ5xOzj9_QgA32Uqne22_ilUUeHYEx6YTss_1BLbmdTw8T2ww_Wlbe25pv8625Wk0N7c5wjepUCjv4MMweHgKszegewOHz9zAycegJl4hq4CZH5dDGYFQOUePIX2D-wGuMvJYolo4Hyu7vVu6XSxVDka6NCnxwF_yCKY',
          'badgeLabel': 'Nhiếp ảnh gia 📸',
          'verified': false,
        },
        'timeLabel': '5 giờ trước',
        'recruitBadge': 'Tuyển thành viên',
        'placeLabel': 'Bán đảo Sơn Trà & Đỉnh Bàn Cờ, Đà Nẵng',
        'caption':
            'Cuối tuần này (Thứ 7 - 19/07) nhóm mình cần tuyển thêm 2 bạn đồng hành săn bình minh Sơn Trà. Ai mê nhiếp ảnh và view biển thì join nhé!',
        'tripId': 'trip-mien-trung-2025',
        'tripTitle': 'Mùa Hè Rực Rỡ: Săn Mây Sơn Trà',
        'spotsLeftLabel': 'Còn 2 chỗ',
        'urgencyLabel': '⚡ Chỉ còn 2 ngày',
        'scheduleLabel': '19/07 • 05:00 Sáng',
        'priceLabel': '~150.000đ / người',
        'membersLabel': '4/6',
        'fillRatio': 0.66,
        'fillPercentLabel': 'Đã đủ 66%',
        'memberAvatars': [
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDnTPAFN_BJNTjktWBiUXXqLbHpUl3spBDZiLrUmPWw1BXppG9meCXbwt1qsSuaY3Zva7SDQ5xOzj9_QgA32Uqne22_ilUUeHYEx6YTss_1BLbmdTw8T2ww_Wlbe25pv8625Wk0N7c5wjepUCjv4MMweHgKszegewOHz9zAycegJl4hq4CZH5dDGYFQOUePIX2D-wGuMvJYolo4Hyu7vVu6XSxVDka6NCnxwF_yCKY',
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCCnzwjsO2nFbthk-eVBKQZpldEE1s-JBDOeU7URXtYKumkoKli_-3zr99W-kbsTjqy13O-luKtWyj_l6hZRmBr8nlMDIdhpvOwIOdx7Oo3bPPcVoKsAT6EPzhH60UsI0Y6EG6XFcuzg_PFGzd7iebZYxdDl_tLeNyqpHJJiT4Usson1dRvrdEPwtOdrKFAM0K2GOFQ_dfEzLvXlSv0yeNOyfAvx-uL8-zEmdysg2o',
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCxpAuiq8ricR5H1I41dYwSA8Z8XFsnvf-iNj7Bo0Iq9rbCitJDTHeaSJvSJHE4LShS0OJLv2275VhQHu8Cr2MQFzSKG_CmolYkMOTr236CYrUWkMGL6EKNgdEeRtNxk5qV3rBrDSxDL9pQHdaWb6y4yp8l2c7hFXc9D99jf5eBVEuK2LilW-QzUyNcIcrMekoSnKloDtwVGeWho1qDfLkrHKYm1QpZ0YOLDZitUuQ',
        ],
        'extraMemberCount': 2,
        'highlightLabel': 'Đón bình minh 5:30 AM tại Đỉnh Bàn Cờ',
        'highlightDetail': 'View biển 360°',
        'likesCount': 185,
        'commentsCount': 31,
        'sharesCount': 9,
        'liked': false,
        'bookmarked': false,
        'itineraryCtaLabel': 'Lịch trình',
        'joinCtaLabel': '🚀 Tham gia ngay',
      },
    },
  ],
};

// Dữ liệu mẫu cho unit test Home/Explore.
// Feed production dùng GET /trips/discover (xem explore_home_remote_datasource).

const Map<String, dynamic> exploreHomeDatamock = {
  'header': {
    'displayName': 'Alex',
    'avatarUrl':
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBC62iS3WSW5kQbMxhNXs-c64qGnETgQwiA6Y48nvCIju2hQ3Q3a28BHp2xSURrA_lNwnixOLkkLh5HR9Xs0vNaa9N1M51tdmkobmKMbQk2UwBIcui6KEHuK1eHhVmRC5w7jyZoFKdtC1wIeTc34XFI5zXgmKYs9qIm3aCSR-EunIqeJCWdLoetrS6mJzGsfH6kindHdfllrg4Z795CX62hOzv6SDNIaFK5-vz_zdZXNi0sZSP7YkaN',
    'locationLabel': 'Đà Nẵng, Việt Nam',
    'hasUnreadNotifications': true,
  },
  'filters': [
    {'id': 'all', 'label': 'Tất cả chuyến đi'},
    {'id': 'backpacker', 'label': 'Phượt & Bụi (Backpacker) 🎒'},
    {'id': 'camping', 'label': 'Cắm trại & Trekking ⛺'},
    {'id': 'beach', 'label': 'Bãi biển & Hóng mát'},
    {'id': 'budget', 'label': 'Chi phí < 2 triệu 💰'},
    {'id': 'weekend', 'label': 'Cuối tuần này 🗓️'},
  ],
  'hotTrips': [
    {
      'id': 'trip-co-to',
      'author': {
        'name': 'Minh Trang',
        'handle': '@minhtrang.lens',
        'avatarUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuA7FbuYXv-LlmsrKLjw0q34oZbPT18YzWCVVMUr8uIVxpXiOjxrvEXU4GjypeDDMRvfYpl78XjqMNgrhFJtZaZkQoncYzYKvF-v1FdjQtmPFKCmu735mgJJyGsf8HKBlYMPADv5Po-HpCG_7Y8FOUoaSUK1NBQtSOMmx3GawUOMhmv6Uiyu7zrdOYYBtwDwyfrUvvXDKfDIBh-Yt4_YX84i2kjY2bUSjRksU0o27I1fVP8ehQD4mIR7',
        'badgeLabel': 'Chủ trip uy tín 🏅',
      },
      'coverUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAl9z7m9CXTZKk_Y_NQlna0Szo5PxDHL-Q2hIrM7Ovj5YDMfoGc8FUFb1E1wNxCPEVmkjPdCCjhAKKy5dwX3mmmpvS3k6pOKajZToYM6RnWJuJTslr1hji0Zriqj6O9R8O9YdMz1LV_wo5SKE61SOi4_rvls5MGjw4yCQtklS6qgHpUdbwPu2Om2wkY5umeei_T3D8E_kDN5TjLSFrrLVTzpcoTyKLqfmIM-0gKLcCJNGOYbk0tTHwl',
      'badges': ['Mở đăng ký', 'Phượt tự túc'],
      'durationLabel': '3N2Đ',
      'title': 'Phượt Đảo Cô Tô 3N2Đ – Chèo SUP & Cắm Trại Biển',
      'dateLabel': '26 - 28 Tháng 7',
      'costLabel': '~1.850.000đ',
      'departureLabel': 'Hà Nội / Cảng Cái Rồng',
      'memberCount': 3,
      'capacity': 6,
      'memberAvatars': [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDqa3gytcOlQJuGPZkYLRkKd4_acq5DSYo8UAgpC40GDa7nz8iWFs53MnlHlcNQkpWjYfdhUzwrjRqSytzLhZecCgT14YloLpstyZTT3CNqsI91aw9pqH2wu3jGSL9gzRQJ8ouuXhw4yda4uNYgJLy-3lCrg_gRpx-TQs6CNwx0RAXJ0aiY1Ysu96ngHquMvFmU0k6ct1ONCVEeB8reeljPzbZF116LtFt2KkXIElxZx_tiRpUDUi6j',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAe3mnYIsWq47zUYMyzRQLZly0CEpkaOe3NEP3wHdgy5_x9ROEBb6LiMC4Bj-tmZR-X6jVF76UVy8UOwslXxA1lbTk91Fi0DC5-7qS-r5Zo9qnp3ey2meEV2IsbDAM9VIurqvBGDNYrsEl049hGkBbQPvAqaHZsx467nz7jwbaVXPz2oK1FpQyitXaUNpapLKoZb5Qef-WnvqCca-FJZgq4TfA8-UjytU2Ivy500FgsrkWzstz1T6cL',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDTa4iQ40VWTA2qjHrnU2KpKvkWMWLXMRmP3d2eEfqeA5dEm9dpVOqaVUq-03ffrQ63ARDCaPLLQq1Ql3hYmx0mdyRCxV_Bqqn0XxOv7Hz6v-El5QuO8M5RyY5aOhvh7SITD9kp-y24NY9cka8ThyHNpcrRF85vP9WAAaJhk9qGjawiB4x4pjwCa82hMN-6KFbnMV9HnvyycDqMZZBfD_9izUvvQFARbvWTuSNJG3rFu9i2sNp34YS3',
      ],
      'filterTags': ['all', 'backpacker', 'camping', 'beach', 'budget'],
      'recruiting': true,
    },
    {
      'id': 'trip-ban-co',
      'author': {
        'name': 'Quốc Bảo',
        'handle': '@quocbao.lens',
        'avatarUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuASoFLKKaSjm361F0CgvKGjnFGF7SH8OMqkH6z1ECFyx8pa2KktrR9vCMAPdnNLlnguegBpMoQOdU2QfUYF2p5C5KoI6wafiGvdKjqVjnUygtwo5BYOBwPlbiGBh0QgWDJrU994Gkqd5CNW8AJWLuPUkkqm5hdTg0uJ21FnpmWTW-mz5L-WXo4QEWiWIEmzi51n1YhPQetI9OcY75nuzgivP4C6jL0suzWxmjjTK1waSffGoLjoa15U',
        'badgeLabel': 'Nhiếp ảnh gia',
      },
      'coverUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAt54u5mYHwLXzqwUbhkoeCI5sPD6ylheHQpOkf2xkh_550iNYNAEDZKzPWpR6VCAXz1qL0uu9-gdofGBGvT6OSl2lNqP9jM0N1gBBpPQlccKnW3vV40FWvHtKF5gYFmyYNpNgW7YMot82CoruyhIrYky9YsTjNvMVoI2Pikj6OqLSItnlbSTrbuVbM9bjYBqul7yHRGeC_mVmGReZnl_jIeT2VjdTYxn8Lu4DBlKjMCBV8T4yZvBrt',
      'badges': ['Chỉ còn 2 ngày', 'Sắp đủ chỗ'],
      'durationLabel': '1 Ngày (Sáng sớm)',
      'title': 'Săn Mây Bình Minh Đỉnh Bàn Cờ & Hải Vân Quan',
      'dateLabel': '19/07 • 05:00 Sáng',
      'costLabel': '~150.000đ',
      'departureLabel': 'Đà Nẵng / Ngã ba Hải Vân',
      'memberCount': 4,
      'capacity': 6,
      'memberAvatars': <String>[],
      'filterTags': ['all', 'budget', 'weekend'],
      'recruiting': true,
    },
  ],
  'destinations': [
    {
      'id': 'dest-da-lat',
      'name': 'Đà Lạt',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuB-DEwLC7VFNvH3b1WsQD3_Y-zh9P7ypbdRIcxLyHBhgZGAchMUC80kJQlpQKbwgXuSw6GV-WdOgV8_GxCDW5IqGd-6XhLnHLMwhO3efrOgExEPATAWv7aCT73qNgcA2GRHbgfmNzzPXbQ9Tvd1QuHGmRJAnogFYEWuhmRTA_615UYBCe_U5CbVEU6WFZfXkMyItl3QyGjGk5VekdEG_p0MqYJVIOuJya6IDqQ1hTKNSoSTlQBrBnVp',
      'openTripCount': 12,
    },
    {
      'id': 'dest-ha-giang',
      'name': 'Hà Giang',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAZAk7It2UVOS8u0CIPBGOrGACRI05Xf0IOR11PI8M68ugouQJB7I20flyKQ6TlaLLuwusYXXk1AqwLssD_qWSQ1y_X6WgexqR1Gwn7xrG_CnnFe-WNuqDm7C9oIu6LVzszGMaIjNmLySAGnr_Unz6t3jbnEDmYY84bqxstVY8yx8k26ZLK8KUg60aBm9qR9Lp8-J9Fyp0xspOzvb-769ubnsy2g7QoH7MBLVqrsb72QGm_G9xpe5Or',
      'openTripCount': 8,
    },
    {
      'id': 'dest-phu-quoc',
      'name': 'Phú Quốc',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBBk0i4oETAFxoWArhQpVNG9Xn4sZlRuyxUbW1J8k5PQc4RTK4sTZ1twqWQn-DbLMuCsxlgXMzqCcTWh8clFHchAZh4L2J-feIAq3xLt4jSQ4gaCk2DljAFKU9N_6xGf_AP_xPBhEj9XTbzah-KN9gdgwdjgTGcrkraZ3WfoptDAhGYzvgQuGvQ_4EpohRAjKKZYZyBVDJSdNbq44dYcN068SRwnSFrEl43GBuSY9lX6-5Dmu4DA-bK',
      'openTripCount': 15,
    },
    {
      'id': 'dest-ta-xua',
      'name': 'Tà Xùa',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAq6-ekJtYhpMpxMaw0ab-3hKgX4NNnsnlhojTkN9ldqqToBEbbK0DsdVJIP5OSbzGY7wThS7XKmz7GfjfD1jWa18p2DPzDmM2kkpF_4KVe5lTVgIO3-uwzjCIGDiLeQm34WfYwVYTzJhheXTIAGex2dSVN-yTtMNYB0a03CB3ySsQJI8yJMMTY1Ow98kVukalrcd0cLCMqRRjv0W6ZfjNO9EZuyrEf0yV62A6oFjxOS-_njMjEfhxx',
      'openTripCount': 6,
    },
  ],
  'liveTrips': [
    {
      'id': 'live-xuyen-viet',
      'title': 'Hành Trình Xuyên Việt 2025',
      'placeLabel': 'Đèo Hải Vân',
      'memberCount': 8,
      'minutesAgo': 5,
    },
  ],
};

// Dữ liệu mẫu cho màn Chuyến đi theo điểm đến (Stitch: Đà Lạt).
// Production lấy catalog, discover và places từ API.
// Thời tiết, độ cao, mùa và chi phí trung bình chỉ có trong mẫu này.

const String _heroImage =
    'https://lh3.googleusercontent.com/aida-public/AB6AXuDDmXL4nNJLjb24-lYVy89I9ev1bLblEI_JfHJmRL3RBAGV3EtNGSdRiOA8pCgqke01PaK-byu3RMdtebQCAt-xiUXrjTVxBtMN1vV_L3ksq0bAVJ0s9avT7YncdXUP1wKxB8byE8_KnFdU3zs6M8icdsjbmidjTw8RkDTwOOmMWyaML3hKjzvBBOdNL-5QlxHbBcHObny-OS-BzfJDjRs4fyupEH4bP282mLS6rJXpHpzA-ta38t8e';

const String _hostNam =
    'https://lh3.googleusercontent.com/aida-public/AB6AXuBU91iHgk8wtWaXgNWwjKec5Mb-X3Zo4BjB44OkxlkVnykg0PPsw1yXTF2-inPlPQ8QhXH2QwC7jbD1SH1beSZvM2XyqcZpbYidlPcAPVds7O8fHpPOFbxBK34zOXIWVvmuAOM4iyH0-4u6Rk2lgXaPrJz3wV_qTR8EB8wcWDuzZE8EbSVulUshmZk-IO4aoz4s6ZRf4Cc2gP68ho1C8_zDQtVKUR5KrVqEJw3TwHj9HlbxMyF7abKz';

const String _hostLinh =
    'https://lh3.googleusercontent.com/aida-public/AB6AXuDiaU_6NuHEPuTbFNyW83ztHlWNlHZHuK--EDOqFL1vXZYuCL-hvt8CGEItLvWjNohrDa3Br2O_n7E-N5vLKM5vh4uc5GUepXdSuws9F5tAin4C0hueb1RGa-iaHuEXUmBqq9zJolUmIDKXXqrprjzbIae7HRxLoaDupCJet2Y0_-7r8B-LCyqkpVJTjuKmS9RTeeIMuyPSYwu7Ni3MD-Ovyq753KH2JQIkp-JYhiLyOmldXpUPUOks';

const String _hostTrong =
    'https://lh3.googleusercontent.com/aida-public/AB6AXuBnq6r_5rqMxxnKo4mGtk7FjmX2MBapcLrgBLR5X0kEVQqUAUh1GHj8IaIV99uayjmtPlTW3vQGjXPIevsyn9t2wLcTozJxXjMi9ckYLS8E9dYEkTVvV_aE3vli7xihfJjLSrLf9FmQPvzwkZzLePv7XFgprfxv2QB0V5eEbxRZ-nB00cEnHYiYjBAcTkZoHrfCeRw1YrFiartHmCCMCjp_OkTWBTeZa3oeATsuJ4OSpM8GNhmef5Km';

const Map<String, dynamic> destinationTripsDatamock = {
  'daLat': {
    'profile': {
      'catalogId': 'dest-da-lat',
      'name': 'Đà Lạt',
      'regionLabel': 'Lâm Đồng',
      'coverImageUrl': _heroImage,
      'tagline': 'Thành phố ngàn hoa',
      'summary':
          'Mùa hoa dã quỳ, săn mây đồi chè Cầu Đất, cafe thung lũng chill',
      'weatherLabel': '18°C Mát mẻ • Mùa săn mây',
      'altitudeLabel': '1.500m',
      'seasonLabel': 'T10 - T02',
      'averageCostLabel': '~1.5M/người',
    },
    'openTripCount': 12,
    'spotsTotal': 3,
    'tripTypesById': {
      'trip-da-phu': 'backpacker',
      'trip-mua-suong': 'friends',
      'trip-langbiang': 'backpacker',
    },
    'trips': [
      {
        'id': 'trip-da-phu',
        'author': {
          'name': 'Hoàng Nam',
          'handle': '@nam.wander',
          'avatarUrl': _hostNam,
          'badgeLabel': 'Trưởng nhóm',
        },
        'coverUrl': _heroImage,
        'badges': ['Đang tuyển gấp'],
        'durationLabel': '3N2Đ',
        'title': 'Săn Mây Đồi Đa Phú & Acoustic Đêm Đà Lạt 3N2Đ',
        'dateLabel': '25/10 - 27/10',
        'costLabel': '~1.650.000đ',
        'departureLabel': 'Đà Lạt',
        'memberCount': 4,
        'capacity': 6,
        'memberAvatars': [_hostNam],
        'filterTags': ['all'],
        'recruiting': true,
        'slotsRemaining': 2,
        'urgent': true,
      },
      {
        'id': 'trip-mua-suong',
        'author': {
          'name': 'Thuỳ Linh',
          'handle': '@linhtravel',
          'avatarUrl': _hostLinh,
          'badgeLabel': 'Khởi xướng',
        },
        'coverUrl': _heroImage,
        'badges': ['Chill & Cafe ngắm cảnh'],
        'durationLabel': '2N1Đ',
        'title': 'Đà Lạt Mùa Sương: Check-in Quán Mơ & Vườn Hồng Treo Gió',
        'dateLabel': 'Cuối tuần tới',
        'costLabel': '~1.200.000đ',
        'departureLabel': 'Đà Lạt',
        'memberCount': 3,
        'capacity': 4,
        'memberAvatars': [_hostLinh],
        'filterTags': ['all', 'weekend', 'budget'],
        'recruiting': true,
        'slotsRemaining': 1,
        'urgent': true,
      },
      {
        'id': 'trip-langbiang',
        'author': {
          'name': 'Bảo Trọng',
          'handle': '@trong_trek',
          'avatarUrl': _hostTrong,
          'badgeLabel': 'Hướng dẫn viên',
        },
        'coverUrl': _heroImage,
        'badges': ['Trekking & Khám phá'],
        'durationLabel': '2N2Đ',
        'title': 'Chinh Phục Đỉnh Langbiang & Cắm Trại Rừng Thông Suối Vàng',
        'dateLabel': '01/11 - 03/11',
        'costLabel': '~1.950.000đ',
        'departureLabel': 'Đà Lạt',
        'memberCount': 5,
        'capacity': 8,
        'memberAvatars': [_hostTrong],
        'filterTags': ['all', 'camping'],
        'recruiting': true,
        'slotsRemaining': 3,
        'urgent': false,
      },
    ],
    'spots': [
      {
        'id': 'spot-tuyen-lam',
        'name': 'Hồ Tuyền Lâm',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuA4OQwsSoUKHvSWVIWC6PaxSA1Zy6K8K-De_rDnv0lQ_RKVE5ha5sWk2vMkXjD7XD5wVlbsNL6PE_yMiF7lx18ivZLI6Mg1nS1wQvt-vVlcI8JbQaHtsYVFol527yOsdp3snxDQGRO-90YP5Uikq05C3W-ZbTmVn3BllFQlHM9ArMN0Jg-Rz7xqxOGnV9SbfWTbd5pDRfeLRosALictH6ozja0gr-XjKNx-hqdL6jwYM-sGlOF22bZ1',
        'rating': 4.9,
        'categoryLabel': 'Chèo SUP & Cắm trại',
        'note': 'Cách trung tâm 6km',
      },
      {
        'id': 'spot-cau-dat',
        'name': 'Đồi Chè Cầu Đất',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCJQdE7DkBFrV2hmUbiUCQi0Cfl14QE9ptxdpkb8kZ8fZpuaxfbfjVxMBIhzSdSM5nyWb_b9D2uQzAFGAW_zwUBxSK8_2zbi45Evj9dkqXRpsV7Z9yam0JxNke1Z5KGm6t2vuoTN2ZYa64tEXC5Hjswqx8bkqfbcmPYgbXkS8_aYFYa2jUqF_DkIYGlA2gikrQ-MSLFIl-MeH1m1cPFpr2M9byx2eLSLBIoS5IQiXF4HuQhaxe61wqX',
        'rating': 4.8,
        'categoryLabel': 'Thiên đường săn mây',
        'note': 'Đón bình minh 5:00 - 6:30',
      },
      {
        'id': 'spot-ga',
        'name': 'Ga Đà Lạt',
        'imageUrl':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuB2eEoUzukZA5NWkShhZwpq4xPR-IpVW42T96NBwhs8QnkDzHLH7eoKLLN1XS4XP73uypyISlbJl5TYTeMI7MD3wbshYWbwOBp-mZS9m6_DIenoYwAiZYTQWD_A1QM82Wk-u_GPGcg4ewZV2daxKeqMh-gkyd1ep3oXxJB3PB9-ddVvtrTYw-OuuPv-M7m701u3uAddv4xu287yfWeGAU-6KgloE6HD4SLbaywjuHQM1A31PzWYHSXL',
        'rating': 4.7,
        'categoryLabel': 'Di sản & Nhiếp ảnh',
        'note': 'Ga cổ nhất Đông Dương',
      },
    ],
  },
};

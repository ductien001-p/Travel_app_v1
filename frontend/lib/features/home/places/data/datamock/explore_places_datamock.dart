// Hợp đồng mẫu cũ của tab Địa Điểm, chỉ dùng cho test parse.
// Luồng chạy lấy GET /places/featured, GET /places/nearby
// và GET /place-collections/featured.

const String _ghenhBang =
    'https://lh3.googleusercontent.com/aida-public/AB6AXuCSelbIB5wlolBGc3SF3cCzN-dszhh4mz73sKSNL5Y7L09ZGN5Tfhv5HkWuVOUOqGFb17vU3ER6gBxtrRgNHk4a8MjLHiMzAdR9MCmh0tze3zYg0K6H_oGclo4Z2ajb4PVqEWRUVHFXpXI3c-XRUiKKlOKjA5-l-iIgdNbwDRzza66qjn-Qt1E9WDbh2sZrInFbleQcjfd_RRm0Yc7LQXv2mwgdhhgvjArcfPU5gNgl-1n2-j5l-Qgy';

const String _baNa =
    'https://lh3.googleusercontent.com/aida-public/AB6AXuDndm3f4Wot5zJEM9MyQtoR7hUqtTuLo_LXMxyDepOR0vz5jyBWhd8fVg-FcU7RRSH9ytbkTiY1tEMbJ4PPrzFYLXxBzCbk4ZspBw0qPBVSrguzpfo1cPM8gdtGxNqhkGFEBhHT2RKt-WwVJflBFOmjS5nA_7fXOHARjeW9wQdUf7hALZX3DB8Pyza2K3thED1lHPLXBZt3PIZz-sRKJNvDizrav8KAoFHOuoZNeYgWm_JGLSP0RS7V';

const String _hoiAn =
    'https://lh3.googleusercontent.com/aida-public/AB6AXuCXcAeOwJ1rm0ER-YSC_1-OStbQ8kRxHAiFjCYqf0qAq-YjNCmKNlG38XdjqgBwJfs9hCRIEIailzaV6hRkooaHSoIvYqXzhraNxGJ6zC1AcNrQrg3NpNjgbv1kFF0h1sCBrLXyK0gYEm6mL8_1RhwsTzazam4w0uEooKy2VqgHGL_FBGPoTsbb3F89lUxQ1AUAaU1wJ66BsytBsTgoJZCYN73I5S3JiwHU-zQzOPUuy5xMmT3Q02F_';

const String _linhUng =
    'https://lh3.googleusercontent.com/aida-public/AB6AXuAn1QcRhv_ED_Smwku-o5Fo6z9g2PevssvDZ6dKuNK1tOCV4tZHkwutK3RG4qMUn2xWbPQKCovW9kvs61QjJsCChn88WHbnKaKj4AqLj6sQJk8FXXp5S1EGxpn6cdCMyJrX90GLAWzaPvpLP1u5U6s8748J5oAPOcmEgUMA9moGDGRJAyEfjyaimPRga4vr82F3zBuNQgHTJZfdVlX9pYOBzHnMgrMmJK3wUr9T-58xda_G1JAk_OeY';

const String _horizonBay =
    'https://lh3.googleusercontent.com/aida-public/AB6AXuA6cQ4uf0FgSw0FNpQ77Cgvny02i7ZEuOhCVBye2T14shGoR1QRFzU4Xw0ODkcC_GbkI5iccWrG0qT8oEk8-pioWHwJUtW3LQcYTjCHvI7ul-tsiD6_rSB_KPKk2H8o21vr9l2IimDcFt999EAPGRLqjMHHt7xqWDr7HYgw3nNdrPdGXLGIUqAKKfkwAPzavi7lhVjH3fg26BbzXrnmJ58pgcy4wa76GA-CwdM42yAdUTUcYnMHlNln';

const String _myKhe =
    'https://lh3.googleusercontent.com/aida-public/AB6AXuDt6EsnYaHXHtTPYvf6rBG6Qr9l_RkR0X0mPOOsTutAuRfVzmWqfR0IACrPKmcUsnGVPLwTFfysn16XXYaYcMGcffldioT9qJNQafvT1s4BjIZ-iQmdZqyLV4yvWY66FLoTgZOBSa0WxUx9yioB1bP1hj6A9T_YGMlmRx1L2CnJyY1EkB43ggb4Bz6KvTyTa3yv6f1hc56MXZQIlowRrFJtJ9SviWbk_SFukJccszVatogOVgwUCD53';

const String _wildBeaches =
    'https://lh3.googleusercontent.com/aida-public/AB6AXuAhn2BeKh9DBdhU9jhF2cHLz3s4KmH1WpCfPpBfSP3Yh5F4Vo-KBA6VXw7g5Yt0D_MUz3w3FHIEarDE--kq6xLUIWRKHaD-FUytl8bZ0bvMVQihfHp1EvVyKleLb7jwK_3bhbGRZzrcSi2LZkeuuJHs1sypC_7BacRdXaybezp0wC-xNhkdiO52-38mOZcNeYLmbIPOAeULmzkoAMAU742YTewg8ysqe0DalStfs8guYRNn07KvTBSW';

const String _sunset =
    'https://lh3.googleusercontent.com/aida-public/AB6AXuCp1pcexBUlvCFdV2Jkrst6GmIbgqEkgxEWFfnOWL9105FOXQS4oQ-rbfojQp09XdBtue1xArgtrpiEltKjpdw-l8VfKSEdMpcQkH159AXYfHFv_RfR0QIQD1gmEabkAa6ljihaK1eY5GJHpSlbpRZCmz6WSCbUgjejpwhxyT7_zir92mr9gjFf1TGZzZqYIJOfS2HV127duBF6lIIAaaqEyWmV1T4JFzUI4tnT_EM6WrEWVBoCLfzw';

const Map<String, dynamic> explorePlacesDatamock = {
  'explorePlaces': {
    'featuredSubtitle': 'Được bình chọn nhiều nhất mùa hè này',
    'featured': [
      {
        'id': 'ghenh-bang',
        'name': 'Ghềnh Bàng - Bán Đảo Sơn Trà',
        'imageUrl': _ghenhBang,
        'categoryLabel': 'BÃI BIỂN',
        'rating': 4.9,
        'saveCountLabel': '340+ lưu',
        'locationLabel': 'Bán Đảo Sơn Trà, Đà Nẵng',
        'tagline': 'Hoang sơ & lặn ngắm san hô',
        'bookmarked': true,
      },
      {
        'id': 'ba-na-hills',
        'name': 'Bà Nà Hills - Cầu Vàng',
        'imageUrl': _baNa,
        'categoryLabel': 'NGHỈ DƯỠNG',
        'rating': 4.8,
        'saveCountLabel': '580+ lưu',
        'locationLabel': 'Hòa Vang, Đà Nẵng',
        'tagline': 'Khí hậu 4 mùa trong 1 ngày',
        'bookmarked': false,
      },
      {
        'id': 'pho-co-hoi-an',
        'name': 'Phố Cổ Hội An',
        'imageUrl': _hoiAn,
        'categoryLabel': 'VĂN HÓA',
        'rating': 4.9,
        'saveCountLabel': '820+ lưu',
        'locationLabel': 'Quảng Nam (Cách 28km)',
        'tagline': 'Di sản văn hóa thế giới UNESCO',
        'bookmarked': true,
      },
    ],
    'nearbySubtitle': 'Dựa trên định vị thời gian thực',
    'nearbyRadiusLabel': '10 km',
    'nearby': [
      {
        'id': 'chua-linh-ung',
        'name': 'Chùa Linh Ứng - Bán Đảo Sơn Trà',
        'imageUrl': _linhUng,
        'categoryLabel': 'DI TÍCH',
        'rating': 4.9,
        'reviewCountLabel': '1.2k',
        'address': 'Hoàng Sa, Thọ Quang, Sơn Trà',
        'distanceLabel': '2.4 km',
        'travelLabel': '30 phút đi bộ',
        'travelMode': 'walk',
        'liked': true,
      },
      {
        'id': 'horizon-bay',
        'name': 'Horizon Bay Roastery & Lounge',
        'imageUrl': _horizonBay,
        'categoryLabel': 'CÀ PHÊ',
        'rating': 4.7,
        'reviewCountLabel': '480',
        'address': 'Võ Nguyên Giáp, Phước Mỹ',
        'distanceLabel': '1.1 km',
        'travelLabel': '4 phút lái xe',
        'travelMode': 'drive',
        'liked': false,
      },
      {
        'id': 'my-khe',
        'name': 'Bãi Biển Mỹ Khê (Bãi Tắm 1)',
        'imageUrl': _myKhe,
        'categoryLabel': 'BÃI BIỂN',
        'rating': 4.9,
        'reviewCountLabel': '3.5k',
        'address': 'Đường Võ Nguyên Giáp',
        'distanceLabel': '850 m',
        'travelLabel': '10 phút đi bộ',
        'travelMode': 'walk',
        'liked': true,
      },
    ],
    'collectionsSubtitle': 'Được giám tuyển riêng theo mùa nắng đẹp',
    'collections': [
      {
        'id': 'collection-beaches',
        'title': 'Top 10 Bãi Biển Hoang Sơ Đà Nẵng',
        'eyebrow': 'Bộ Sưu Tập Hè',
        'imageUrl': _wildBeaches,
        'countLabel': '10 địa điểm chọn lọc',
        'tone': 'summer',
      },
      {
        'id': 'collection-sunset',
        'title': 'Check-in Hoàng Hôn Chill Nhất 2025',
        'eyebrow': 'Xu Hướng 2025',
        'imageUrl': _sunset,
        'countLabel': '8 địa điểm view triệu đô',
        'tone': 'trend',
      },
    ],
  },
};

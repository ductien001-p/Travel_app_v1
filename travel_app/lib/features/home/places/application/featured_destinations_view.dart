import '../data/models/place_explore_api_models.dart';

enum FeaturedDestinationChip { popular, topRated }

enum FeaturedDestinationSort { none, saves }

const featuredTopRatedFloor = 4.8;

const _categoryLabels = {
  'FOOD': 'Ẩm thực',
  'CAFE': 'Cà phê',
  'HOTEL': 'Khách sạn',
  'RESORT': 'Nghỉ dưỡng',
  'HOSTEL': 'Hostel',
  'HOMESTAY': 'Homestay',
  'VILLA': 'Villa',
  'MOUNTAIN': 'Núi',
  'BEACH': 'Bãi biển',
  'CAVE': 'Hang động',
  'WATERFALL': 'Thác nước',
  'LAKE': 'Hồ',
  'CAMPING': 'Cắm trại',
  'MUSEUM': 'Bảo tàng',
  'TEMPLES': 'Đền chùa',
  'CHURCH': 'Nhà thờ',
  'HISTORICAL_SITE': 'Di tích',
  'MONUMENT': 'Tượng đài',
  'PALACE': 'Cung điện',
  'CASTLE': 'Lâu đài',
  'OLD_TOWN': 'Phố cổ',
  'ZOO': 'Sở thú',
  'WATER_PARK': 'Công viên nước',
  'PARK': 'Công viên',
  'CINEMA': 'Rạp chiếu phim',
  'THEATER': 'Nhà hát',
  'NIGHT_MARKET': 'Chợ đêm',
  'SHOPPING_MALL': 'Trung tâm thương mại',
  'MARKET': 'Chợ',
  'ZIPLINE': 'Cáp treo',
  'WALKING_STREET': 'Phố đi bộ',
};

class FeaturedDestinationCardData {
  const FeaturedDestinationCardData({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.categoryLabel,
    required this.ratingLabel,
    required this.saveLabel,
    required this.locationLabel,
    required this.bookmarked,
  });

  final String id;
  final String name;
  final String imageUrl;
  final String categoryLabel;
  final String ratingLabel;
  final String saveLabel;
  final String locationLabel;
  final bool bookmarked;
}

class FeaturedDestinationsView {
  const FeaturedDestinationsView({
    required this.subtitle,
    required this.headerCaption,
    required this.totalCount,
    required this.places,
    required this.chip,
    required this.sort,
    required this.sortLabel,
  });

  final String subtitle;
  final String headerCaption;
  final int totalCount;
  final List<FeaturedDestinationCardData> places;
  final FeaturedDestinationChip chip;
  final FeaturedDestinationSort sort;
  final String sortLabel;

  bool get isSourceEmpty => totalCount == 0;
}

FeaturedDestinationsView buildFeaturedDestinationsView({
  required String subtitle,
  required List<FeaturedPlaceApi> places,
  required FeaturedDestinationChip chip,
  FeaturedDestinationSort sort = FeaturedDestinationSort.none,
}) {
  final matched = [
    for (final place in places)
      if (_matchesChip(place, chip)) place,
  ];
  final ordered = sort == FeaturedDestinationSort.saves
      ? ([...matched]..sort(_bySaves))
      : matched;
  return FeaturedDestinationsView(
    subtitle: subtitle,
    headerCaption: _headerCaption(places.length),
    totalCount: places.length,
    places: [for (final place in ordered) _card(place)],
    chip: chip,
    sort: sort,
    sortLabel: sort == FeaturedDestinationSort.saves
        ? 'Sắp xếp: Lượt lưu nhiều nhất'
        : 'Sắp xếp',
  );
}

String foldFeaturedQuery(String value) {
  const folded = {
    'à': 'a',
    'á': 'a',
    'ạ': 'a',
    'ả': 'a',
    'ã': 'a',
    'â': 'a',
    'ầ': 'a',
    'ấ': 'a',
    'ậ': 'a',
    'ẩ': 'a',
    'ẫ': 'a',
    'ă': 'a',
    'ằ': 'a',
    'ắ': 'a',
    'ặ': 'a',
    'ẳ': 'a',
    'ẵ': 'a',
    'è': 'e',
    'é': 'e',
    'ẹ': 'e',
    'ẻ': 'e',
    'ẽ': 'e',
    'ê': 'e',
    'ề': 'e',
    'ế': 'e',
    'ệ': 'e',
    'ể': 'e',
    'ễ': 'e',
    'ì': 'i',
    'í': 'i',
    'ị': 'i',
    'ỉ': 'i',
    'ĩ': 'i',
    'ò': 'o',
    'ó': 'o',
    'ọ': 'o',
    'ỏ': 'o',
    'õ': 'o',
    'ô': 'o',
    'ồ': 'o',
    'ố': 'o',
    'ộ': 'o',
    'ổ': 'o',
    'ỗ': 'o',
    'ơ': 'o',
    'ờ': 'o',
    'ớ': 'o',
    'ợ': 'o',
    'ở': 'o',
    'ỡ': 'o',
    'ù': 'u',
    'ú': 'u',
    'ụ': 'u',
    'ủ': 'u',
    'ũ': 'u',
    'ư': 'u',
    'ừ': 'u',
    'ứ': 'u',
    'ự': 'u',
    'ử': 'u',
    'ữ': 'u',
    'ỳ': 'y',
    'ý': 'y',
    'ỵ': 'y',
    'ỷ': 'y',
    'ỹ': 'y',
    'đ': 'd',
  };
  final buffer = StringBuffer();
  for (final rune in value.toLowerCase().runes) {
    final char = String.fromCharCode(rune);
    buffer.write(folded[char] ?? char);
  }
  return buffer.toString();
}

String featuredCategoryLabel(String category) {
  final key = category.trim().toUpperCase();
  return _categoryLabels[key] ?? key.replaceAll('_', ' ');
}

bool _matchesChip(FeaturedPlaceApi place, FeaturedDestinationChip chip) {
  return switch (chip) {
    FeaturedDestinationChip.popular => true,
    FeaturedDestinationChip.topRated =>
      place.averageRating >= featuredTopRatedFloor,
  };
}

int _bySaves(FeaturedPlaceApi a, FeaturedPlaceApi b) {
  final saves = b.saveCount.compareTo(a.saveCount);
  if (saves != 0) return saves;
  return foldFeaturedQuery(a.name).compareTo(foldFeaturedQuery(b.name));
}

FeaturedDestinationCardData _card(FeaturedPlaceApi place) {
  final city = place.city.trim();
  final address = place.address.trim();
  return FeaturedDestinationCardData(
    id: place.id,
    name: place.name,
    imageUrl: place.coverImageUrl?.trim() ?? '',
    categoryLabel: featuredCategoryLabel(place.category),
    ratingLabel: place.averageRating.toStringAsFixed(1),
    saveLabel: '${place.saveCount} lượt lưu',
    locationLabel: address.isEmpty ? city : address,
    bookmarked: place.bookmarked,
  );
}

String _headerCaption(int count) {
  if (count <= 0) return 'Chưa có địa danh nổi bật';
  return 'Khám phá $count địa danh nổi bật';
}

import 'dart:convert';

import '../datamock/destination_trips_datamock.dart';
import '../models/destination_trips_models.dart';

/// Folds Vietnamese diacritics so "Đà Lạt" and "Da Lat" share one editorial key.
String foldCityKey(String value) {
  const replacements = <String, String>{
    'á': 'a',
    'à': 'a',
    'ả': 'a',
    'ã': 'a',
    'ạ': 'a',
    'ă': 'a',
    'ắ': 'a',
    'ằ': 'a',
    'ẳ': 'a',
    'ẵ': 'a',
    'ặ': 'a',
    'â': 'a',
    'ấ': 'a',
    'ầ': 'a',
    'ẩ': 'a',
    'ẫ': 'a',
    'ậ': 'a',
    'é': 'e',
    'è': 'e',
    'ẻ': 'e',
    'ẽ': 'e',
    'ẹ': 'e',
    'ê': 'e',
    'ế': 'e',
    'ề': 'e',
    'ể': 'e',
    'ễ': 'e',
    'ệ': 'e',
    'í': 'i',
    'ì': 'i',
    'ỉ': 'i',
    'ĩ': 'i',
    'ị': 'i',
    'ó': 'o',
    'ò': 'o',
    'ỏ': 'o',
    'õ': 'o',
    'ọ': 'o',
    'ô': 'o',
    'ố': 'o',
    'ồ': 'o',
    'ổ': 'o',
    'ỗ': 'o',
    'ộ': 'o',
    'ơ': 'o',
    'ớ': 'o',
    'ờ': 'o',
    'ở': 'o',
    'ỡ': 'o',
    'ợ': 'o',
    'ú': 'u',
    'ù': 'u',
    'ủ': 'u',
    'ũ': 'u',
    'ụ': 'u',
    'ư': 'u',
    'ứ': 'u',
    'ừ': 'u',
    'ử': 'u',
    'ữ': 'u',
    'ự': 'u',
    'ý': 'y',
    'ỳ': 'y',
    'ỷ': 'y',
    'ỹ': 'y',
    'ỵ': 'y',
    'đ': 'd',
  };
  final buffer = StringBuffer();
  for (final rune in value.toLowerCase().trim().runes) {
    final char = String.fromCharCode(rune);
    buffer.write(replacements[char] ?? char);
  }
  return buffer.toString().replaceAll(RegExp(r'\s+'), ' ');
}

List<DestinationTripsPage>? _editorialPages;

List<DestinationTripsPage> get _pages {
  return _editorialPages ??= [
    for (final raw in destinationTripsDatamock.values)
      DestinationTripsPage.fromJson(
        jsonDecode(jsonEncode(raw)) as Map<String, dynamic>,
      ),
  ];
}

DestinationTripsPage? editorialPageForCity(String cityName) {
  final key = foldCityKey(cityName);
  for (final page in _pages) {
    if (foldCityKey(page.profile.name) == key) return page;
  }
  return null;
}

/// Fills weather, altitude, season, cost, and copy the catalog API does not return.
DestinationTripsPage applyDestinationEditorial(DestinationTripsPage page) {
  final editorial = editorialPageForCity(page.profile.name);
  if (editorial == null) return page;
  final source = editorial.profile;
  final cover = page.profile.coverImageUrl.trim();
  final profile = page.profile.copyWith(
    regionLabel: source.regionLabel,
    tagline: source.tagline,
    summary: source.summary,
    weatherLabel: source.weatherLabel,
    altitudeLabel: source.altitudeLabel,
    seasonLabel: source.seasonLabel,
    averageCostLabel: source.averageCostLabel,
    coverImageUrl: cover.isNotEmpty ? cover : source.coverImageUrl,
  );
  if (page.spots.isNotEmpty) {
    return page.copyWith(profile: profile);
  }
  return page.copyWith(
    profile: profile,
    spots: editorial.spots,
    spotsTotal: editorial.spotsTotal,
  );
}

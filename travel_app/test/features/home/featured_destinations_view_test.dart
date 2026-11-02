import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/home/places/application/featured_destinations_view.dart';
import 'package:travel_frontend_v1/features/home/places/data/datamock/featured_destinations_datamock.dart';
import 'package:travel_frontend_v1/features/home/places/data/models/place_explore_api_models.dart';

void main() {
  final data = FeaturedPlacesData.fromJson(
    jsonDecode(jsonEncode(featuredDestinationsDatamock['featuredDestinations']))
        as Map<String, dynamic>,
  );

  FeaturedDestinationsView view({
    FeaturedDestinationChip chip = FeaturedDestinationChip.popular,
    FeaturedDestinationSort sort = FeaturedDestinationSort.none,
    List<FeaturedPlaceApi>? places,
  }) {
    return buildFeaturedDestinationsView(
      subtitle: data.subtitle,
      places: places ?? data.places,
      chip: chip,
      sort: sort,
    );
  }

  test('popular chip keeps the source order', () {
    final result = view();

    expect(result.sortLabel, 'Sắp xếp');
    expect(result.headerCaption, 'Khám phá 4 địa danh nổi bật');
    expect(result.places.map((place) => place.id), [
      'ghenh-bang',
      'ba-na-hills',
      'pho-co-hoi-an',
      'cafe-cong',
    ]);
    expect(result.places.first.saveLabel, '340 lượt lưu');
    expect(result.places[2].bookmarked, isFalse);
    expect(result.places.first.bookmarked, isTrue);
  });

  test('save sort runs only when that option is selected', () {
    final result = view(sort: FeaturedDestinationSort.saves);

    expect(result.sortLabel, 'Sắp xếp: Lượt lưu nhiều nhất');
    expect(result.places.map((place) => place.id), [
      'pho-co-hoi-an',
      'ba-na-hills',
      'ghenh-bang',
      'cafe-cong',
    ]);
  });

  test('high rating keeps source order and drops places under 4.8', () {
    final result = view(chip: FeaturedDestinationChip.topRated);

    expect(result.places.map((place) => place.id), [
      'ghenh-bang',
      'ba-na-hills',
      'pho-co-hoi-an',
    ]);
  });

  test('breaks save ties by folded name', () {
    final result = view(
      sort: FeaturedDestinationSort.saves,
      places: const [
        FeaturedPlaceApi(
          id: 'bai',
          name: 'Bãi',
          category: 'BEACH',
          averageRating: 4,
          saveCount: 5,
          city: 'Huế',
          address: 'Huế',
        ),
        FeaturedPlaceApi(
          id: 'ao',
          name: 'Ao',
          category: 'LAKE',
          averageRating: 4,
          saveCount: 5,
          city: 'Huế',
          address: 'Huế',
        ),
      ],
    );

    expect(result.places.map((place) => place.id), ['ao', 'bai']);
  });
}

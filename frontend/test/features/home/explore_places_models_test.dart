import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/home/places/data/datamock/explore_places_datamock.dart';
import 'package:travel_frontend_v1/features/home/places/data/models/explore_places_mapper.dart';
import 'package:travel_frontend_v1/features/home/places/data/models/explore_places_models.dart';
import 'package:travel_frontend_v1/features/home/places/data/models/place_explore_api_models.dart';

void main() {
  test('parses the places tab demo into three sections', () {
    final payload = explorePlacesDatamock['explorePlaces'];
    expect(payload, isA<Map>());
    final feed = ExplorePlacesFeed.fromJson(
      Map<String, dynamic>.from(payload! as Map),
    );

    expect(feed.featured, hasLength(3));
    expect(feed.featured.first.name, 'Ghềnh Bàng - Bán Đảo Sơn Trà');
    expect(feed.featured.first.bookmarked, isTrue);
    expect(feed.featured[1].bookmarked, isFalse);
    expect(feed.nearby, hasLength(3));
    expect(feed.nearby[1].travelMode, NearbyTravelMode.drive);
    expect(feed.nearbyRadiusLabel, '10 km');
    expect(feed.collections, hasLength(2));
    expect(feed.collections.first.tone, PlaceCollectionTone.summer);
    expect(feed.collections.last.tone, PlaceCollectionTone.trend);
  });

  test('maps a featured place response into the card model', () {
    final place = mapFeaturedPlace(
      FeaturedPlaceApi.fromJson({
        'id': 'ghenh-bang',
        'name': 'Ghềnh Bàng',
        'coverImageUrl': 'https://cdn.example/a.jpg',
        'category': 'BEACH',
        'averageRating': 4.9,
        'saveCount': 12,
        'city': 'Đà Nẵng',
        'address': 'Sơn Trà',
        'description': 'Hoang sơ',
        'bookmarked': true,
      }),
    );
    final nearby = mapNearbyPlace(
      NearbyPlaceApi.fromJson({
        'id': 'my-khe',
        'name': 'Mỹ Khê',
        'category': 'BEACH',
        'averageRating': 4,
        'reviewCount': 1200,
        'address': 'Võ Nguyên Giáp',
        'distanceMeters': 850,
        'travelMode': 'walk',
        'travelMinutes': 10,
      }),
    );
    expect(place.bookmarked, isTrue);
    expect(place.saveCountLabel, '12 lưu');
    expect(place.categoryLabel, 'BEACH');
    expect(nearby.travelMode, NearbyTravelMode.walk);
    expect(nearby.distanceLabel, '850 m');
    expect(nearby.reviewCountLabel, '1.2k');
  });
}

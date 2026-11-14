import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/location/device_location_service.dart';
import 'package:travel_frontend_v1/features/home/places/application/explore_places_controller.dart';
import 'package:travel_frontend_v1/features/home/places/data/datasources/explore_places_datasource.dart';
import 'package:travel_frontend_v1/features/home/places/data/models/explore_places_models.dart';
import 'package:travel_frontend_v1/features/home/places/data/models/place_explore_api_models.dart';
import 'package:travel_frontend_v1/features/home/places/data/repositories/explore_places_repository.dart';
import 'package:travel_frontend_v1/features/home/places/provider/explore_places_provider.dart';
import 'package:travel_frontend_v1/features/trips/application/device_location_controller.dart';

class _FakeExplorePlacesDataSource implements ExplorePlacesDataSource {
  bool failFeatured = false;
  int nearbyCalls = 0;
  int lastRadius = 10;
  final saved = <String, List<String>>{};

  @override
  Future<FeaturedPlacesData> getFeatured({
    required int utcOffsetMinutes,
  }) async {
    if (failFeatured) throw Exception('offline');
    return FeaturedPlacesData(
      subtitle: 'Nổi bật hôm nay',
      date: '2026-10-31',
      places: [
        FeaturedPlaceApi(
          id: 'ghenh-bang',
          name: 'Ghềnh Bàng - Bán Đảo Sơn Trà',
          category: 'BEACH',
          averageRating: 4.9,
          saveCount: 340,
          city: 'Đà Nẵng',
          address: 'Bán Đảo Sơn Trà, Đà Nẵng',
          description: 'Hoang sơ',
          bookmarked: saved['ghenh-bang']?.isNotEmpty ?? false,
        ),
      ],
    );
  }

  @override
  Future<List<NearbyPlaceApi>> getNearby({
    required double latitude,
    required double longitude,
    required int radiusKm,
  }) async {
    nearbyCalls += 1;
    lastRadius = radiusKm;
    return [
      NearbyPlaceApi(
        id: 'my-khe',
        name: 'Bãi Biển Mỹ Khê',
        category: 'BEACH',
        averageRating: 4.9,
        reviewCount: 3500,
        address: 'Võ Nguyên Giáp',
        distanceMeters: radiusKm == 1 ? 800 : 2400,
        travelMode: radiusKm == 1 ? 'walk' : 'drive',
        travelMinutes: radiusKm == 1 ? 10 : 6,
      ),
    ];
  }

  @override
  Future<List<FeaturedCollectionApi>> getFeaturedCollections() async {
    return const [
      FeaturedCollectionApi(
        id: 'collection-beaches',
        title: 'Top 10 Bãi Biển Hoang Sơ Đà Nẵng',
        ownerDisplayName: 'Lan',
        placeCount: 10,
        averageRating: 4.8,
        ratingCount: 4,
      ),
    ];
  }

  @override
  Future<List<OwnedPlaceCollection>> listMine() async => [
    OwnedPlaceCollection(
      id: 'mine-1',
      title: 'Cuối tuần',
      visibility: 'PRIVATE',
      placeCount: saved['ghenh-bang']?.length ?? 0,
      placeIds: saved['ghenh-bang'] ?? const [],
    ),
  ];

  @override
  Future<OwnedPlaceCollection> createCollection(String title) async {
    return OwnedPlaceCollection(
      id: 'created',
      title: title,
      visibility: 'PRIVATE',
      placeCount: 0,
    );
  }

  @override
  Future<void> setMembership({
    required String placeId,
    required List<String> collectionIds,
  }) async {
    saved[placeId] = collectionIds;
  }

  @override
  Future<void> unsave(String placeId) async {
    saved.remove(placeId);
  }

  @override
  Future<PlaceCollectionDetail> getCollection(String id) async {
    return PlaceCollectionDetail(
      id: id,
      title: 'Top 10 Bãi Biển Hoang Sơ Đà Nẵng',
      visibility: 'PUBLIC',
      ownerDisplayName: 'Lan',
      placeCount: 1,
      averageRating: 4.8,
      ratingCount: 4,
      places: const [
        CollectionPlaceItem(
          id: 'my-khe',
          name: 'Bãi Biển Mỹ Khê',
          category: 'BEACH',
          city: 'Đà Nẵng',
          averageRating: 4.9,
        ),
      ],
    );
  }

  @override
  Future<PlaceCollectionDetail> rateCollection({
    required String id,
    required int rating,
  }) {
    return getCollection(id);
  }

  @override
  Future<OwnedPlaceCollection> copyCollection(String id) async {
    return const OwnedPlaceCollection(
      id: 'copy',
      title: 'Top 10 Bãi Biển Hoang Sơ Đà Nẵng',
      visibility: 'PRIVATE',
      placeCount: 1,
      placeIds: ['my-khe'],
    );
  }

  @override
  Future<List<PlaceEmbeddingSearchApi>> searchEmbeddings(String query) {
    throw UnimplementedError();
  }
}

class _FixedLocation implements DeviceLocationService {
  @override
  Future<DeviceCoordinate> current() async {
    return const DeviceCoordinate(latitude: 16.07, longitude: 108.22);
  }
}

void main() {
  test('loads featured places and saves one into a collection', () async {
    final dataSource = _FakeExplorePlacesDataSource();
    final container = ProviderContainer(
      overrides: [
        explorePlacesRepositoryProvider.overrideWithValue(
          ExplorePlacesRepository(dataSource: dataSource),
        ),
        deviceLocationServiceProvider.overrideWithValue(_FixedLocation()),
      ],
    );
    addTearDown(container.dispose);

    final initial = await container.read(
      explorePlacesControllerProvider.future,
    );
    expect(initial.feed.featured.single.name, 'Ghềnh Bàng - Bán Đảo Sơn Trà');
    expect(initial.feed.featured.single.saveCountLabel, '340 lưu');
    expect(initial.isBookmarked('ghenh-bang'), isFalse);
    expect(initial.feed.nearby.single.travelMode, NearbyTravelMode.drive);
    expect(initial.radiusKm, 10);
    expect(initial.feed.collections.single.eyebrow, 'Lan');

    final saved = await container
        .read(explorePlacesControllerProvider.notifier)
        .saveToCollections(placeId: 'ghenh-bang', collectionIds: ['mine-1']);
    expect(saved, isTrue);
    expect(
      container
          .read(explorePlacesControllerProvider)
          .requireValue
          .isBookmarked('ghenh-bang'),
      isTrue,
    );

    await container.read(explorePlacesControllerProvider.notifier).setRadius(5);
    expect(dataSource.lastRadius, 5);
    expect(
      container.read(explorePlacesControllerProvider).requireValue.radiusKm,
      5,
    );
  });

  test('keeps the previous feed when a reload fails', () async {
    final dataSource = _FakeExplorePlacesDataSource();
    final container = ProviderContainer(
      overrides: [
        explorePlacesRepositoryProvider.overrideWithValue(
          ExplorePlacesRepository(dataSource: dataSource),
        ),
        deviceLocationServiceProvider.overrideWithValue(_FixedLocation()),
      ],
    );
    addTearDown(container.dispose);
    await container.read(explorePlacesControllerProvider.future);
    dataSource.failFeatured = true;
    await container.read(explorePlacesControllerProvider.notifier).refresh();
    expect(
      container
          .read(explorePlacesControllerProvider)
          .requireValue
          .feed
          .featured,
      isNotEmpty,
    );
  });
}

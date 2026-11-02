import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/location/device_location_service.dart';
import 'package:travel_frontend_v1/features/home/places/data/datasources/explore_places_datasource.dart';
import 'package:travel_frontend_v1/features/home/places/data/models/place_explore_api_models.dart';
import 'package:travel_frontend_v1/features/home/places/data/repositories/explore_places_repository.dart';
import 'package:travel_frontend_v1/features/home/places/presentation/widgets/explore_places_tab.dart';
import 'package:travel_frontend_v1/features/home/places/provider/explore_places_provider.dart';
import 'package:travel_frontend_v1/features/trips/application/device_location_controller.dart';

class _FakeSource implements ExplorePlacesDataSource {
  int radiusKm = 10;

  @override
  Future<FeaturedPlacesData> getFeatured({
    required int utcOffsetMinutes,
  }) async {
    return const FeaturedPlacesData(
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
          bookmarked: true,
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
    this.radiusKm = radiusKm;
    return [
      NearbyPlaceApi(
        id: 'chua-linh-ung',
        name: 'Chùa Linh Ứng - Bán Đảo Sơn Trà',
        category: 'TEMPLES',
        averageRating: 4.9,
        reviewCount: 1200,
        address: 'Hoàng Sa, Thọ Quang, Sơn Trà',
        distanceMeters: 2400,
        travelMode: 'drive',
        travelMinutes: 6,
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
        ratingCount: 2,
      ),
    ];
  }

  @override
  Future<List<OwnedPlaceCollection>> listMine() async => const [
    OwnedPlaceCollection(
      id: 'mine-1',
      title: 'Cuối tuần',
      visibility: 'PRIVATE',
      placeCount: 1,
      placeIds: ['ghenh-bang'],
    ),
  ];

  @override
  Future<OwnedPlaceCollection> createCollection(String title) async {
    return OwnedPlaceCollection(
      id: 'new',
      title: title,
      visibility: 'PRIVATE',
      placeCount: 0,
    );
  }

  @override
  Future<void> setMembership({
    required String placeId,
    required List<String> collectionIds,
  }) async {}

  @override
  Future<void> unsave(String placeId) async {}

  @override
  Future<PlaceCollectionDetail> getCollection(String id) async {
    return const PlaceCollectionDetail(
      id: 'collection-beaches',
      title: 'Top 10 Bãi Biển Hoang Sơ Đà Nẵng',
      visibility: 'PUBLIC',
      ownerDisplayName: 'Lan',
      placeCount: 10,
      ratingCount: 2,
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
      placeCount: 10,
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
  testWidgets('shows the three place sections and a radius choice', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(900, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final source = _FakeSource();
    final container = ProviderContainer(
      overrides: [
        explorePlacesRepositoryProvider.overrideWithValue(
          ExplorePlacesRepository(dataSource: source),
        ),
        deviceLocationServiceProvider.overrideWithValue(_FixedLocation()),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(home: Scaffold(body: const ExplorePlacesTab())),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('Điểm Đến Nổi Bật'), findsOneWidget);
    expect(find.text('Gần Bạn Nhất'), findsOneWidget);
    expect(find.text('Bộ Sưu Tập Điểm Đến'), findsOneWidget);
    expect(find.text('Ghềnh Bàng - Bán Đảo Sơn Trà'), findsOneWidget);
    expect(find.text('10 km'), findsOneWidget);
    expect(find.text('5 km'), findsOneWidget);
    expect(find.text('1 km'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_rounded), findsNothing);
    expect(find.byIcon(Icons.favorite_border_rounded), findsNothing);

    await tester.tap(find.byKey(const Key('nearby-radius-5 km')));
    await tester.pump();
    await tester.pump();
    expect(source.radiusKm, 5);

    await tester.tap(find.byKey(const Key('featured-bookmark-ghenh-bang')));
    await tester.pump();
    await tester.pump();
    expect(find.text('Lưu vào bộ sưu tập'), findsOneWidget);
    expect(find.text('Cuối tuần'), findsOneWidget);
  });

  testWidgets('lays out the places tab on a phone width', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final container = ProviderContainer(
      overrides: [
        explorePlacesRepositoryProvider.overrideWithValue(
          ExplorePlacesRepository(dataSource: _FakeSource()),
        ),
        deviceLocationServiceProvider.overrideWithValue(_FixedLocation()),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: const ExplorePlacesTab()),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('Điểm Đến Nổi Bật'), findsOneWidget);
    expect(find.text('Gần Bạn Nhất'), findsOneWidget);
    expect(find.text('Bộ Sưu Tập Điểm Đến'), findsOneWidget);
    expect(find.text('Chùa Linh Ứng - Bán Đảo Sơn Trà'), findsOneWidget);
  });

  testWidgets('opens place detail from a featured card and a nearby tile', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(900, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final container = ProviderContainer(
      overrides: [
        explorePlacesRepositoryProvider.overrideWithValue(
          ExplorePlacesRepository(dataSource: _FakeSource()),
        ),
        deviceLocationServiceProvider.overrideWithValue(_FixedLocation()),
      ],
    );
    addTearDown(container.dispose);
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(body: ExplorePlacesTab()),
        ),
        GoRoute(
          path: '/home/places/:placeId',
          name: RouteNames.placeDetail,
          builder: (context, state) =>
              Text('opened ${state.pathParameters['placeId']}'),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('Ghềnh Bàng - Bán Đảo Sơn Trà'));
    await tester.pump();
    await tester.pump();
    expect(find.text('opened ghenh-bang'), findsOneWidget);

    router.pop();
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('Chùa Linh Ứng - Bán Đảo Sơn Trà'));
    await tester.pump();
    await tester.pump();
    expect(find.text('opened chua-linh-ung'), findsOneWidget);
  });
}

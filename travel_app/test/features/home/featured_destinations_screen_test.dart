import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/features/home/places/application/featured_destinations_controller.dart';
import 'package:travel_frontend_v1/features/home/places/application/featured_destinations_view.dart';
import 'package:travel_frontend_v1/features/home/places/data/datamock/featured_destinations_datamock.dart';
import 'package:travel_frontend_v1/features/home/places/data/datasources/explore_places_datasource.dart';
import 'package:travel_frontend_v1/features/home/places/data/models/place_explore_api_models.dart';
import 'package:travel_frontend_v1/features/home/places/data/repositories/explore_places_repository.dart';
import 'package:travel_frontend_v1/features/home/places/presentation/screen/featured_destinations_screen.dart';
import 'package:travel_frontend_v1/features/home/places/provider/explore_places_provider.dart';

class _FakeFeaturedSource implements ExplorePlacesDataSource {
  _FakeFeaturedSource(this.data);

  FeaturedPlacesData data;
  var featuredCalls = 0;
  var searchCalls = 0;
  String? lastSearchQuery;
  var failFeatured = false;
  var failSearch = false;
  List<PlaceEmbeddingSearchApi> searchHits = const [];

  @override
  Future<FeaturedPlacesData> getFeatured({
    required int utcOffsetMinutes,
  }) async {
    featuredCalls += 1;
    if (failFeatured) throw Exception('offline');
    return data;
  }

  @override
  Future<List<PlaceEmbeddingSearchApi>> searchEmbeddings(String query) async {
    searchCalls += 1;
    lastSearchQuery = query;
    if (failSearch) throw Exception('search');
    return searchHits;
  }

  @override
  Future<List<NearbyPlaceApi>> getNearby({
    required double latitude,
    required double longitude,
    required int radiusKm,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<List<FeaturedCollectionApi>> getFeaturedCollections() {
    throw UnimplementedError();
  }

  @override
  Future<List<OwnedPlaceCollection>> listMine() async => const [];

  @override
  Future<OwnedPlaceCollection> createCollection(String title) {
    throw UnimplementedError();
  }

  @override
  Future<void> setMembership({
    required String placeId,
    required List<String> collectionIds,
  }) async {}

  @override
  Future<void> unsave(String placeId) async {}

  @override
  Future<PlaceCollectionDetail> getCollection(String id) {
    throw UnimplementedError();
  }

  @override
  Future<PlaceCollectionDetail> rateCollection({
    required String id,
    required int rating,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<OwnedPlaceCollection> copyCollection(String id) {
    throw UnimplementedError();
  }
}

FeaturedPlacesData _sample() {
  return FeaturedPlacesData.fromJson(
    jsonDecode(jsonEncode(featuredDestinationsDatamock['featuredDestinations']))
        as Map<String, dynamic>,
  );
}

List<PlaceEmbeddingSearchApi> _searchSample() {
  final raw = featuredDestinationsDatamock['embeddingSearch'] as List;
  return [
    for (final item in raw)
      PlaceEmbeddingSearchApi.fromJson(
        jsonDecode(jsonEncode(item)) as Map<String, dynamic>,
      ),
  ];
}

Future<ProviderContainer> _pump(
  WidgetTester tester,
  ExplorePlacesDataSource source,
) async {
  final container = ProviderContainer(
    overrides: [
      explorePlacesRepositoryProvider.overrideWithValue(
        ExplorePlacesRepository(dataSource: source),
      ),
    ],
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const MaterialApp(home: FeaturedDestinationsScreen()),
    ),
  );
  await tester.pump();
  await tester.pump();
  return container;
}

void main() {
  testWidgets('shows the featured feed and filters it on the device', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final source = _FakeFeaturedSource(_sample());
    final container = await _pump(tester, source);

    expect(find.text('Điểm Đến Nổi Bật'), findsOneWidget);
    expect(find.text('Khám phá 4 địa danh nổi bật'), findsOneWidget);
    expect(find.text('Phố Cổ Hội An'), findsOneWidget);
    expect(find.text('Cộng Cà Phê'), findsOneWidget);
    expect(find.textContaining('Hiển thị'), findsNothing);
    expect(tester.takeException(), isNull);

    await tester.ensureVisible(
      find.byKey(const Key('featured-chip-top-rated')),
    );
    await tester.tap(find.byKey(const Key('featured-chip-top-rated')));
    await tester.pump();

    expect(find.text('Ghềnh Bàng - Bán Đảo Sơn Trà'), findsOneWidget);
    expect(find.text('Phố Cổ Hội An'), findsOneWidget);
    expect(find.text('Cộng Cà Phê'), findsNothing);
    expect(
      container.read(featuredDestinationsControllerProvider).requireValue.chip,
      FeaturedDestinationChip.topRated,
    );
    expect(source.featuredCalls, 1);
    expect(source.searchCalls, 0);

    await tester.enterText(find.byType(TextField), 'khong co');
    await tester.pump();
    expect(find.text('Phố Cổ Hội An'), findsOneWidget);
    expect(source.searchCalls, 0);

    source.searchHits = _searchSample();
    await tester.pump(featuredSearchDebounce);
    await tester.pump();

    expect(source.searchCalls, 1);
    expect(source.lastSearchQuery, 'khong co');
    expect(find.text('Phố Cổ Hội An'), findsNothing);
    expect(find.text('Vịnh Lăng Cô'), findsOneWidget);
    expect(find.text('Cà phê view biển'), findsNothing);

    await tester.tap(find.byKey(const Key('featured-sort')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lượt lưu nhiều nhất'));
    await tester.pumpAndSettle();

    expect(find.text('Sắp xếp: Lượt lưu nhiều nhất'), findsOneWidget);
    expect(
      container
          .read(featuredDestinationsControllerProvider)
          .requireValue
          .view
          .places
          .map((place) => place.id),
      ['lang-co'],
    );

    await tester.ensureVisible(find.byKey(const Key('featured-chip-popular')));
    await tester.tap(find.byKey(const Key('featured-chip-popular')));
    await tester.pump();
    expect(
      container
          .read(featuredDestinationsControllerProvider)
          .requireValue
          .view
          .places
          .map((place) => place.id),
      ['cafe-search', 'lang-co'],
    );
  });

  testWidgets('keeps the list when a refresh fails', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final source = _FakeFeaturedSource(_sample());
    final container = await _pump(tester, source);

    source.failFeatured = true;
    await container
        .read(featuredDestinationsControllerProvider.notifier)
        .refresh();
    await tester.pump();

    expect(find.text('Phố Cổ Hội An'), findsOneWidget);
    expect(find.text('Không tải lại được điểm đến.'), findsOneWidget);
  });

  testWidgets('keeps the featured list when search fails', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final source = _FakeFeaturedSource(_sample())..failSearch = true;
    await _pump(tester, source);

    await tester.enterText(find.byType(TextField), 'bien');
    await tester.pump(featuredSearchDebounce);
    await tester.pump();

    expect(find.text('Phố Cổ Hội An'), findsOneWidget);
    expect(find.text('Không tìm được điểm đến.'), findsOneWidget);
    expect(source.searchCalls, 1);
  });

  testWidgets('opens place detail when a destination card is tapped', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final container = ProviderContainer(
      overrides: [
        explorePlacesRepositoryProvider.overrideWithValue(
          ExplorePlacesRepository(dataSource: _FakeFeaturedSource(_sample())),
        ),
      ],
    );
    addTearDown(container.dispose);
    final router = GoRouter(
      initialLocation: '/home/featured',
      routes: [
        GoRoute(
          path: '/home/featured',
          builder: (context, state) => const FeaturedDestinationsScreen(),
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
  });
}

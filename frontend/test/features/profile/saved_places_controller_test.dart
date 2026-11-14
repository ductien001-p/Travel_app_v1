import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/profile/user-saved-trip/application/saved_places_controller.dart';
import 'package:travel_frontend_v1/features/profile/user-saved-trip/application/saved_places_view.dart';
import 'package:travel_frontend_v1/features/home/places/data/models/place_explore_api_models.dart';
import 'package:travel_frontend_v1/features/profile/user-saved-trip/data/datasources/saved_places_datasource.dart';
import 'package:travel_frontend_v1/features/profile/user-saved-trip/data/models/saved_places_models.dart';
import 'package:travel_frontend_v1/features/profile/user-saved-trip/data/repositories/saved_places_repository.dart';
import 'package:travel_frontend_v1/features/profile/user-saved-trip/provider/saved_places_provider.dart';

void main() {
  test('loads only the first saved page before the list is ready', () async {
    final source = _FakeSavedPlacesSource(
      pages: [
        _page([_place('a')], page: 1, total: 2, hasNextPage: true),
        _page([_place('b')], page: 2, total: 2, hasNextPage: false),
      ],
      count: 2,
    );
    final container = _container(source);
    addTearDown(container.dispose);
    container.listen(savedPlacesControllerProvider, (_, _) {});

    final first = await container.read(savedPlacesControllerProvider.future);
    expect(first.total, 2);
    expect(first.items.map((item) => item.placeId), ['a']);
    expect(first.hasNextPage, isTrue);
    expect(source.pagesRequested, [1]);
    expect(source.limits, [savedPlacesPageSize]);

    await container.read(savedPlacesControllerProvider.notifier).loadMore();
    final loaded = container.read(savedPlacesControllerProvider).requireValue;
    expect(loaded.items.map((item) => item.placeId), ['a', 'b']);
    expect(loaded.hasNextPage, isFalse);
    expect(source.pagesRequested, [1, 2]);
  });

  test('keeps loaded pages when a later page fails', () async {
    final source = _FakeSavedPlacesSource(
      pages: [
        _page([_place('a')], page: 1, total: 2, hasNextPage: true),
        _page([_place('b')], page: 2, total: 2, hasNextPage: false),
      ],
      count: 2,
      failAtPage: 2,
    );
    final container = _container(source);
    addTearDown(container.dispose);
    container.listen(savedPlacesControllerProvider, (_, _) {});

    final first = await container.read(savedPlacesControllerProvider.future);
    expect(first.items.single.placeId, 'a');
    expect(first.hasNextPage, isTrue);
    expect(first.loadMoreError, isNull);

    await container.read(savedPlacesControllerProvider.notifier).loadMore();
    final failed = container.read(savedPlacesControllerProvider).requireValue;
    expect(failed.items.single.placeId, 'a');
    expect(failed.hasNextPage, isTrue);
    expect(failed.loadingMore, isFalse);
    expect(failed.loadMoreError, isNotNull);

    source.failAtPage = null;
    await container.read(savedPlacesControllerProvider.notifier).loadMore();
    final loaded = container.read(savedPlacesControllerProvider).requireValue;
    expect(loaded.items.map((item) => item.placeId), ['a', 'b']);
    expect(loaded.hasNextPage, isFalse);
    expect(loaded.loadMoreError, isNull);
  });

  test('falls back to page total when the count request fails', () async {
    final source = _FakeSavedPlacesSource(
      pages: [
        _page([_place('a')], page: 1, total: 4, hasNextPage: true),
      ],
      countError: Exception('count'),
    );
    final container = _container(source);
    addTearDown(container.dispose);
    container.listen(savedPlacesControllerProvider, (_, _) {});

    final first = await container.read(savedPlacesControllerProvider.future);
    expect(first.total, 4);
  });

  test('unsaves a place and reloads the first page', () async {
    final source = _FakeSavedPlacesSource(
      pages: [
        _page([_place('a'), _place('b')], page: 1, total: 2),
      ],
      count: 2,
    );
    final container = _container(source);
    addTearDown(container.dispose);
    container.listen(savedPlacesControllerProvider, (_, _) {});
    await container.read(savedPlacesControllerProvider.future);

    final ok = await container
        .read(savedPlacesControllerProvider.notifier)
        .unsave('a');
    final latest = container.read(savedPlacesControllerProvider).requireValue;

    expect(ok, isTrue);
    expect(source.unsaved, ['a']);
    expect(latest.items.map((item) => item.placeId), ['b']);
    expect(latest.total, 1);
  });

  test('a category chip does not request another page', () async {
    final source = _FakeSavedPlacesSource(
      pages: [
        _page([_place('a')], page: 1, total: 1),
      ],
      count: 1,
    );
    final container = _container(source);
    addTearDown(container.dispose);
    container.listen(savedPlacesControllerProvider, (_, _) {});
    container.listen(savedPlacesFilterProvider, (_, _) {});
    await container.read(savedPlacesControllerProvider.future);

    container
        .read(savedPlacesFilterProvider.notifier)
        .selectGroup(SavedPlaceGroup.food);
    await container.read(savedPlacesControllerProvider.future);

    expect(source.pagesRequested, [1]);
    expect(
      container.read(savedPlacesFilterProvider).group,
      SavedPlaceGroup.food,
    );
  });

  test('restores the place when unsave fails', () async {
    final source = _FakeSavedPlacesSource(
      pages: [
        _page([_place('a')], page: 1, total: 1),
      ],
      count: 1,
      unsaveError: Exception('offline'),
    );
    final container = _container(source);
    addTearDown(container.dispose);
    container.listen(savedPlacesControllerProvider, (_, _) {});
    await container.read(savedPlacesControllerProvider.future);

    final ok = await container
        .read(savedPlacesControllerProvider.notifier)
        .unsave('a');
    final latest = container.read(savedPlacesControllerProvider).requireValue;

    expect(ok, isFalse);
    expect(latest.items.single.placeId, 'a');
    expect(latest.total, 1);
  });

  test('create collection reloads the owned folders', () async {
    final source = _FakeSavedPlacesSource(
      pages: [_page(<SavedPlace>[], page: 1, total: 0)],
      count: 0,
    );
    final container = _container(source);
    addTearDown(container.dispose);
    container.listen(savedPlacesControllerProvider, (_, _) {});
    await container.read(savedPlacesControllerProvider.future);

    final ok = await container
        .read(savedPlacesControllerProvider.notifier)
        .createCollection('Kế hoạch Hè');
    final latest = container.read(savedPlacesControllerProvider).requireValue;

    expect(ok, isTrue);
    expect(latest.ownedCollections.single.title, 'Kế hoạch Hè');
  });

  test(
    'opening a collection loads its places from the detail endpoint',
    () async {
      final source = _FakeSavedPlacesSource(
        pages: [
          _page([_place('a')], page: 1, total: 1),
        ],
        count: 1,
        collectionDetail: PlaceCollectionDetail(
          id: 'summer',
          title: 'Kế hoạch Hè',
          visibility: 'PRIVATE',
          ownerDisplayName: 'Lan',
          placeCount: 1,
          ratingCount: 0,
          places: [
            CollectionPlaceItem(
              id: 'cafe',
              name: 'Cafe',
              category: 'CAFE',
              city: 'Hội An',
              averageRating: 4,
            ),
          ],
        ),
      );
      final container = _container(source);
      addTearDown(container.dispose);
      container.listen(savedPlacesControllerProvider, (_, _) {});
      container.listen(savedPlacesFilterProvider, (_, _) {});
      await container.read(savedPlacesControllerProvider.future);

      container
          .read(savedPlacesFilterProvider.notifier)
          .selectCollection('summer');
      await container
          .read(savedPlacesControllerProvider.notifier)
          .syncCollection('summer');
      final latest = container.read(savedPlacesControllerProvider).requireValue;

      expect(source.collectionRequests, ['summer']);
      expect(latest.selectedCollection?.places.single.id, 'cafe');
      expect(latest.loadingCollection, isFalse);
    },
  );
}

ProviderContainer _container(_FakeSavedPlacesSource source) {
  return ProviderContainer(
    overrides: [
      savedPlacesRepositoryProvider.overrideWithValue(
        SavedPlacesRepository(dataSource: source),
      ),
    ],
  );
}

class _FakeSavedPlacesSource extends SavedPlacesDataSource {
  _FakeSavedPlacesSource({
    required this.pages,
    this.count = 0,
    this.countError,
    this.unsaveError,
    this.failAtPage,
    this.collectionDetail,
  }) : super.testing();

  final List<SavedPlacesPage> pages;
  final int count;
  final Object? countError;
  final Object? unsaveError;
  int? failAtPage;
  final PlaceCollectionDetail? collectionDetail;
  final pagesRequested = <int>[];
  final limits = <int>[];
  final unsaved = <String>[];
  final owned = <OwnedPlaceCollection>[];
  final collectionRequests = <String>[];
  var _removed = false;

  @override
  Future<SavedPlacesPage> getMine({int page = 1, int limit = 20}) async {
    pagesRequested.add(page);
    limits.add(limit);
    if (failAtPage == page) throw Exception('page');
    final current = pages[page - 1];
    if (!_removed) return current;
    final items = [
      for (final item in current.items)
        if (!unsaved.contains(item.placeId)) item,
    ];
    return SavedPlacesPage(
      items: items,
      meta: SavedPlacesPageMeta(
        page: current.meta.page,
        limit: current.meta.limit,
        total: items.length,
        totalPages: 1,
        hasNextPage: false,
        hasPreviousPage: false,
      ),
    );
  }

  @override
  Future<int> getCount() async {
    final error = countError;
    if (error != null) throw error;
    return _removed ? count - unsaved.length : count;
  }

  @override
  Future<void> unsave(String placeId) async {
    final error = unsaveError;
    if (error != null) throw error;
    unsaved.add(placeId);
    _removed = true;
  }

  @override
  Future<List<OwnedPlaceCollection>> listCollections() async => owned;

  @override
  Future<PlaceCollectionDetail> getCollection(String id) async {
    collectionRequests.add(id);
    final detail = collectionDetail;
    if (detail == null) throw StateError('missing collection');
    return detail;
  }

  @override
  Future<OwnedPlaceCollection> createCollection(String title) async {
    final collection = OwnedPlaceCollection(
      id: 'col-${owned.length}',
      title: title,
      visibility: 'PRIVATE',
      placeCount: 0,
    );
    owned.add(collection);
    return collection;
  }
}

SavedPlace _place(String id) {
  return SavedPlace(
    id: 'saved-$id',
    userId: 'user-1',
    placeId: id,
    createdAt: DateTime.utc(2026, 10, 20),
    place: SavedPlaceDetails(
      id: id,
      name: id,
      category: 'FOOD',
      city: 'Hội An',
      country: 'Việt Nam',
      address: 'Hội An',
      latitude: 15,
      longitude: 108,
      averageRating: 4,
    ),
  );
}

SavedPlacesPage _page(
  List<SavedPlace> items, {
  required int page,
  required int total,
  bool hasNextPage = false,
}) {
  return SavedPlacesPage(
    items: items,
    meta: SavedPlacesPageMeta(
      page: page,
      limit: 20,
      total: total,
      totalPages: hasNextPage ? 2 : 1,
      hasNextPage: hasNextPage,
      hasPreviousPage: page > 1,
    ),
  );
}

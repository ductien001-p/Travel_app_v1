import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/features/home/places/data/models/place_explore_api_models.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_query.dart';
import 'package:travel_frontend_v1/features/trips/provider/trips_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/provider/trip_itinerary_provider.dart';

import '../data/models/saved_places_models.dart';
import '../data/repositories/saved_places_repository.dart';
import '../provider/saved_places_provider.dart';
import 'saved_place_trip.dart';
import 'saved_places_view.dart';

/// `GET /places/saved/me` allows at most 100 rows per page.
const savedPlacesPageSize = 100;

/// Cap for the trip picker used when adding a saved place to an itinerary.
const _maxTripPages = 50;

final savedPlacesControllerProvider =
    AsyncNotifierProvider<SavedPlacesController, SavedPlacesState>(
      SavedPlacesController.new,
    );

class SavedPlacesController extends AsyncNotifier<SavedPlacesState> {
  var _requestId = 0;
  var _collectionRequest = 0;
  final _pendingUnsave = <String>{};

  @override
  Future<SavedPlacesState> build() => _loadFirst();

  Future<bool> refresh() async {
    if (state.isLoading) return true;
    final previous = state.value;
    state = await AsyncValue.guard(_loadFirst);
    if (state.hasError && previous != null) {
      state = AsyncData(previous);
      return false;
    }
    return !state.hasError;
  }

  /// Continues a load that stopped after a later page failed.
  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || current.loadingMore || !current.hasNextPage) {
      return;
    }
    final requestId = _requestId;
    state = AsyncData(current.copyWith(loadingMore: true, loadMoreError: null));
    final loaded = await _readRemainingPages(
      repository: ref.read(savedPlacesRepositoryProvider),
      isCurrent: () => requestId == _requestId,
      items: current.items,
      page: current.page,
      total: current.total,
      hasNextPage: current.hasNextPage,
    );
    if (requestId != _requestId) return;
    final latest = state.value ?? current;
    state = AsyncData(
      latest.copyWith(
        items: loaded.items,
        page: loaded.page,
        hasNextPage: loaded.hasNextPage,
        loadingMore: false,
        loadMoreError: loaded.loadMoreError,
      ),
    );
  }

  /// Removes the place, then reloads so offset paging stays aligned.
  Future<bool> unsave(String placeId) async {
    final current = state.value;
    if (current == null || _pendingUnsave.contains(placeId)) return false;
    final index = current.items.indexWhere((item) => item.placeId == placeId);
    if (index < 0) return false;
    final removed = current.items[index];
    _pendingUnsave.add(placeId);
    final remaining = [...current.items]..removeAt(index);
    state = AsyncData(
      current.copyWith(
        items: remaining,
        total: current.total > 0 ? current.total - 1 : 0,
      ),
    );
    try {
      await ref.read(savedPlacesRepositoryProvider).unsave(placeId);
      await _reloadAfterUnsave();
      return true;
    } catch (_) {
      final latest = state.value;
      if (latest != null &&
          !latest.items.any((item) => item.placeId == placeId)) {
        final restored = [...latest.items];
        restored.insert(index.clamp(0, restored.length), removed);
        state = AsyncData(
          latest.copyWith(items: restored, total: latest.total + 1),
        );
      }
      return false;
    } finally {
      _pendingUnsave.remove(placeId);
    }
  }

  Future<bool> createCollection(String title) async {
    final trimmed = title.trim();
    if (trimmed.isEmpty) return false;
    try {
      await ref.read(savedPlacesRepositoryProvider).createCollection(trimmed);
      final next = await _loadFirst();
      state = AsyncData(next);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Loads `GET /place-collections/{id}`, or clears the open collection.
  Future<void> syncCollection(String? id) async {
    final current = state.value;
    if (current == null) return;
    final request = ++_collectionRequest;
    if (id == null) {
      state = AsyncData(
        current.copyWith(
          selectedCollection: null,
          loadingCollection: false,
          collectionError: null,
        ),
      );
      return;
    }
    state = AsyncData(
      current.copyWith(
        selectedCollection: null,
        loadingCollection: true,
        collectionError: null,
      ),
    );
    try {
      final detail = await ref
          .read(savedPlacesRepositoryProvider)
          .getCollection(id);
      if (request != _collectionRequest) return;
      final latest = state.value;
      if (latest == null) return;
      if (ref.read(savedPlacesFilterProvider).collectionId != id) return;
      state = AsyncData(
        latest.copyWith(
          selectedCollection: detail,
          loadingCollection: false,
          collectionError: null,
        ),
      );
    } catch (error) {
      if (request != _collectionRequest) return;
      final latest = state.value;
      if (latest == null) return;
      state = AsyncData(
        latest.copyWith(
          loadingCollection: false,
          collectionError: error,
          selectedCollection: null,
        ),
      );
    }
  }

  Future<List<SavedTripOption>> listMyTrips() async {
    final repository = ref.read(tripRepositoryProvider);
    final options = <SavedTripOption>[];
    var page = 1;
    while (page <= _maxTripPages) {
      final result = await repository.getTrips(
        TripQuery(mine: true, page: page, limit: savedPlacesPageSize),
      );
      options.addAll(
        result.items.map(
          (item) => SavedTripOption(id: item.id, name: item.name),
        ),
      );
      if (!result.meta.hasNextPage) break;
      page++;
    }
    return options;
  }

  Future<SavedTripDayLookup> daysForTrip(String tripId) async {
    final data = await ref
        .read(tripItineraryRepositoryProvider)
        .getItinerary(tripId);
    return savedTripDays(data);
  }

  Future<void> addPlaceToTrip({
    required String tripId,
    required String dayId,
    required String placeId,
    required String title,
  }) {
    return ref
        .read(tripItineraryRepositoryProvider)
        .createItemsBatch(
          tripId,
          savedPlaceItineraryBatch(
            dayId: dayId,
            placeId: placeId,
            title: title,
          ),
        );
  }

  Future<SavedPlacesState> _loadFirst() async {
    final requestId = ++_requestId;
    _collectionRequest++;
    final repository = ref.read(savedPlacesRepositoryProvider);
    final countFuture = _countOrNull(repository);
    final collectionsFuture = repository.listCollections();
    final pages = await _readRemainingPages(
      repository: repository,
      isCurrent: () => requestId == _requestId,
      items: const [],
      page: 0,
      total: 0,
      hasNextPage: true,
    );
    if (requestId != _requestId) {
      final latest = state.value;
      if (latest != null) return latest;
    }
    final count = await countFuture;
    final collections = await collectionsFuture;
    final collectionId = ref.read(savedPlacesFilterProvider).collectionId;
    PlaceCollectionDetail? selected;
    Object? collectionError;
    if (collectionId != null) {
      try {
        selected = await repository.getCollection(collectionId);
      } catch (error) {
        collectionError = error;
      }
    }
    if (requestId != _requestId) {
      final latest = state.value;
      if (latest != null) return latest;
    }
    return SavedPlacesState(
      items: pages.items,
      total: count ?? pages.total,
      page: pages.page,
      hasNextPage: pages.hasNextPage,
      loadMoreError: pages.loadMoreError,
      ownedCollections: collections,
      selectedCollection: selected,
      collectionError: collectionError,
    );
  }

  Future<void> _reloadAfterUnsave() async {
    try {
      final next = await _loadFirst();
      state = AsyncData(next);
    } catch (_) {
      // The row is already gone. A later refresh can reconcile the page.
    }
  }

  Future<int?> _countOrNull(SavedPlacesRepository repository) async {
    try {
      return await repository.getCount();
    } catch (_) {
      return null;
    }
  }
}

class _PageLoad {
  const _PageLoad({
    required this.items,
    required this.page,
    required this.total,
    required this.hasNextPage,
    this.loadMoreError,
  });

  final List<SavedPlace> items;
  final int page;
  final int total;
  final bool hasNextPage;
  final Object? loadMoreError;
}

Future<_PageLoad> _readRemainingPages({
  required SavedPlacesRepository repository,
  required bool Function() isCurrent,
  required List<SavedPlace> items,
  required int page,
  required int total,
  required bool hasNextPage,
}) async {
  var loadedItems = items;
  var loadedPage = page;
  var loadedTotal = total;
  var hasNext = hasNextPage;
  Object? loadMoreError;
  if (loadedPage == 0) {
    final first = await repository.getMine(page: 1, limit: savedPlacesPageSize);
    loadedItems = first.items;
    loadedPage = first.meta.page;
    loadedTotal = first.meta.total;
    hasNext = first.meta.hasNextPage;
  } else if (hasNext) {
    if (!isCurrent()) {
      return _PageLoad(
        items: loadedItems,
        page: loadedPage,
        total: loadedTotal,
        hasNextPage: hasNext,
      );
    }
    try {
      final next = await repository.getMine(
        page: loadedPage + 1,
        limit: savedPlacesPageSize,
      );
      loadedItems = _merge(loadedItems, next.items);
      loadedPage = next.meta.page;
      loadedTotal = next.meta.total;
      hasNext = next.meta.hasNextPage;
    } catch (error) {
      loadMoreError = error;
    }
  }
  return _PageLoad(
    items: loadedItems,
    page: loadedPage == 0 ? 1 : loadedPage,
    total: loadedTotal,
    hasNextPage: hasNext,
    loadMoreError: loadMoreError,
  );
}

List<SavedPlace> _merge(List<SavedPlace> current, List<SavedPlace> incoming) {
  final seen = current.map((item) => item.placeId).toSet();
  return [
    ...current,
    for (final item in incoming)
      if (seen.add(item.placeId)) item,
  ];
}

final savedPlacesFilterProvider =
    NotifierProvider.autoDispose<
      SavedPlacesFilterController,
      SavedPlacesFilterState
    >(SavedPlacesFilterController.new);

class SavedPlacesFilterController extends Notifier<SavedPlacesFilterState> {
  @override
  SavedPlacesFilterState build() => const SavedPlacesFilterState();

  void selectGroup(SavedPlaceGroup group) {
    state = state.copyWith(group: group);
  }

  void setQuery(String query) {
    state = state.copyWith(query: query);
  }

  void selectCollection(String id) {
    state = state.copyWith(collectionId: state.collectionId == id ? null : id);
  }

  void reset() {
    state = const SavedPlacesFilterState();
  }
}

import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/models/trip_join_request_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/provider/trip_join_requests_provider.dart';

import '../data/datasources/explore_home_datasource.dart';
import '../data/models/explore_home_models.dart';
import '../provider/explore_home_provider.dart';
import 'home_failure_message.dart';

enum ExploreHomeSegment { places, community }

class ExploreHomeViewState {
  const ExploreHomeViewState({
    required this.feed,
    this.segment = ExploreHomeSegment.community,
    this.selectedFilterId = 'all',
    this.destinationCatalogId,
    this.bookmarkedTripIds = const <String>{},
    this.searchQuery = '',
    this.loadedSearchQuery = '',
    this.joiningTripId,
    this.reloadError,
    this.loadingMore = false,
    this.loadMoreError,
  });

  final ExploreHomeFeed feed;
  final ExploreHomeSegment segment;
  final String selectedFilterId;
  final String? destinationCatalogId;
  final Set<String> bookmarkedTripIds;
  final String searchQuery;

  /// Search string that produced [feed]. Typing on the Places tab does not
  /// update this until the community segment reloads.
  final String loadedSearchQuery;
  final String? joiningTripId;
  final String? reloadError;
  final bool loadingMore;
  final String? loadMoreError;

  /// Category, search, and destination are applied by `GET /trips/discover`.
  List<CommunityTripCard> get filteredHotTrips => feed.hotTrips;

  ExploreHomeViewState copyWith({
    ExploreHomeFeed? feed,
    ExploreHomeSegment? segment,
    String? selectedFilterId,
    String? destinationCatalogId,
    bool clearDestinationCatalogId = false,
    Set<String>? bookmarkedTripIds,
    String? searchQuery,
    String? loadedSearchQuery,
    String? joiningTripId,
    bool clearJoiningTripId = false,
    String? reloadError,
    bool clearReloadError = false,
    bool? loadingMore,
    String? loadMoreError,
    bool clearLoadMoreError = false,
  }) => ExploreHomeViewState(
    feed: feed ?? this.feed,
    segment: segment ?? this.segment,
    selectedFilterId: selectedFilterId ?? this.selectedFilterId,
    destinationCatalogId: clearDestinationCatalogId
        ? null
        : (destinationCatalogId ?? this.destinationCatalogId),
    bookmarkedTripIds: bookmarkedTripIds ?? this.bookmarkedTripIds,
    searchQuery: searchQuery ?? this.searchQuery,
    loadedSearchQuery: loadedSearchQuery ?? this.loadedSearchQuery,
    joiningTripId: clearJoiningTripId
        ? null
        : (joiningTripId ?? this.joiningTripId),
    reloadError: clearReloadError ? null : (reloadError ?? this.reloadError),
    loadingMore: loadingMore ?? this.loadingMore,
    loadMoreError: clearLoadMoreError
        ? null
        : (loadMoreError ?? this.loadMoreError),
  );
}

final exploreHomeControllerProvider =
    AsyncNotifierProvider.autoDispose<
      ExploreHomeController,
      ExploreHomeViewState
    >(ExploreHomeController.new);

String _newDiscoverSeed() {
  final random = Random.secure();
  final buffer = StringBuffer();
  for (var index = 0; index < 16; index++) {
    buffer.write(random.nextInt(256).toRadixString(16).padLeft(2, '0'));
  }
  return buffer.toString();
}

class ExploreHomeController extends AsyncNotifier<ExploreHomeViewState> {
  Timer? _searchDebounce;
  var _generation = 0;
  String _seed = _newDiscoverSeed();

  ExploreHomeQuery _queryFrom({
    required String filterId,
    String? destinationCatalogId,
    required String searchQuery,
    int page = 1,
    bool includeCatalog = true,
  }) {
    final search = searchQuery.trim();
    return ExploreHomeQuery(
      category: filterId,
      destinationCatalogId: destinationCatalogId,
      search: search.isEmpty ? null : search,
      seed: _seed,
      timezoneOffsetMinutes: DateTime.now().timeZoneOffset.inMinutes,
      page: page,
      includeCatalog: includeCatalog,
    );
  }

  Future<ExploreHomeFeed> _loadFeed(ExploreHomeQuery query) =>
      ref.read(exploreHomeRepositoryProvider).getCommunityExploreFeed(query);

  @override
  FutureOr<ExploreHomeViewState> build() async {
    ref.onDispose(() => _searchDebounce?.cancel());
    _seed = _newDiscoverSeed();
    final feed = await _loadFeed(
      _queryFrom(filterId: 'all', destinationCatalogId: null, searchQuery: ''),
    );
    return ExploreHomeViewState(feed: feed);
  }

  /// New seed when the Home tab is opened again, without replacing the list
  /// with a skeleton while the ranked feed reloads.
  Future<void> revisit() async {
    final previous = state.asData?.value;
    if (previous == null) return;
    _seed = _newDiscoverSeed();
    await _loadKeeping(
      previous,
      filterId: previous.selectedFilterId,
      destinationCatalogId: previous.destinationCatalogId,
      searchQuery: previous.searchQuery,
    );
  }

  Future<void> refresh() async {
    final previous = state.asData?.value;
    _seed = _newDiscoverSeed();
    if (previous == null) {
      state = const AsyncLoading<ExploreHomeViewState>();
      state = await AsyncValue.guard(() async {
        final feed = await _loadFeed(
          _queryFrom(
            filterId: 'all',
            destinationCatalogId: null,
            searchQuery: '',
          ),
        );
        return ExploreHomeViewState(feed: feed);
      });
      return;
    }
    await _loadKeeping(
      previous,
      filterId: previous.selectedFilterId,
      destinationCatalogId: previous.destinationCatalogId,
      searchQuery: previous.searchQuery,
    );
  }

  void selectSegment(ExploreHomeSegment segment) {
    final current = state.asData?.value;
    if (current == null || current.segment == segment) return;
    _searchDebounce?.cancel();
    state = AsyncData(current.copyWith(segment: segment));
    if (segment == ExploreHomeSegment.community &&
        current.searchQuery != current.loadedSearchQuery) {
      unawaited(_reloadForSearch(current.searchQuery));
    }
  }

  Future<void> selectFilter(String filterId) async {
    final current = state.asData?.value;
    if (current == null || current.selectedFilterId == filterId) return;
    await _loadKeeping(
      current,
      filterId: filterId,
      destinationCatalogId: current.destinationCatalogId,
      searchQuery: current.searchQuery,
    );
  }

  /// Phase 1: destination rail aggregates cities from the list; filter via
  /// `search` until catalog ids are on TripListDestination.
  Future<void> selectDestinationCity(String cityName) async {
    final current = state.asData?.value;
    if (current == null) return;
    final city = cityName.trim();
    if (city.isEmpty) return;
    state = AsyncData(current.copyWith(searchQuery: city));
    await _loadKeeping(
      current.copyWith(searchQuery: city),
      filterId: current.selectedFilterId,
      destinationCatalogId: current.destinationCatalogId,
      searchQuery: city,
    );
  }

  Future<void> selectDestinationCatalog(String? catalogId) async {
    final current = state.asData?.value;
    if (current == null) return;
    final nextId = catalogId?.trim();
    final clear = nextId == null || nextId.isEmpty;
    if (!clear && current.destinationCatalogId == nextId) return;
    await _loadKeeping(
      current,
      filterId: current.selectedFilterId,
      destinationCatalogId: clear ? null : nextId,
      clearDestination: clear,
      searchQuery: current.searchQuery,
    );
  }

  void setSearchQuery(String query) {
    final current = state.asData?.value;
    if (current == null || current.searchQuery == query) return;
    state = AsyncData(current.copyWith(searchQuery: query));
    _searchDebounce?.cancel();
    if (current.segment != ExploreHomeSegment.community) return;
    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      unawaited(_reloadForSearch(query));
    });
  }

  Future<void> loadNextPage() async {
    final current = state.asData?.value;
    if (current == null || current.loadingMore || !current.feed.hasNextPage) {
      return;
    }
    final generation = _generation;
    final filterId = current.selectedFilterId;
    final searchQuery = current.searchQuery;
    state = AsyncData(
      current.copyWith(loadingMore: true, clearLoadMoreError: true),
    );
    try {
      final incoming = await _loadFeed(
        _queryFrom(
          filterId: filterId,
          destinationCatalogId: current.destinationCatalogId,
          searchQuery: searchQuery,
          page: current.feed.page + 1,
          includeCatalog: false,
        ),
      );
      if (generation != _generation) return;
      final latest = state.asData?.value;
      if (latest == null ||
          latest.selectedFilterId != filterId ||
          latest.searchQuery != searchQuery) {
        return;
      }
      state = AsyncData(
        latest.copyWith(
          loadingMore: false,
          clearLoadMoreError: true,
          feed: latest.feed.copyWith(
            hotTrips: _appendTrips(latest.feed.hotTrips, incoming.hotTrips),
            page: incoming.page,
            hasNextPage: incoming.hasNextPage,
          ),
        ),
      );
    } catch (error) {
      if (generation != _generation) return;
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(
          loadingMore: false,
          loadMoreError: homeFailureMessage(error),
        ),
      );
    }
  }

  Future<void> _reloadForSearch(String query) async {
    final current = state.asData?.value;
    if (current == null || current.searchQuery != query) return;
    if (current.segment != ExploreHomeSegment.community) return;
    await _loadKeeping(
      current,
      filterId: current.selectedFilterId,
      destinationCatalogId: current.destinationCatalogId,
      searchQuery: query,
    );
  }

  Future<void> _loadKeeping(
    ExploreHomeViewState current, {
    required String filterId,
    String? destinationCatalogId,
    bool clearDestination = false,
    required String searchQuery,
  }) async {
    final generation = ++_generation;
    try {
      final incoming = await _loadFeed(
        _queryFrom(
          filterId: filterId,
          destinationCatalogId: clearDestination ? null : destinationCatalogId,
          searchQuery: searchQuery,
        ),
      );
      if (generation != _generation) return;
      final latest = state.asData?.value ?? current;
      final feed = incoming.catalogUnavailable
          ? incoming.copyWith(destinations: latest.feed.destinations)
          : incoming;
      state = AsyncData(
        latest.copyWith(
          feed: feed,
          selectedFilterId: filterId,
          destinationCatalogId: destinationCatalogId,
          clearDestinationCatalogId: clearDestination,
          searchQuery: searchQuery,
          loadedSearchQuery: searchQuery,
          loadingMore: false,
          clearReloadError: true,
          clearLoadMoreError: true,
        ),
      );
    } catch (error) {
      if (generation != _generation) return;
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(reloadError: homeFailureMessage(error)),
      );
    }
  }

  void toggleBookmark(String tripId) {
    final current = state.asData?.value;
    if (current == null) return;
    final next = Set<String>.from(current.bookmarkedTripIds);
    if (!next.add(tripId)) {
      next.remove(tripId);
    }
    state = AsyncData(current.copyWith(bookmarkedTripIds: next));
  }

  /// Returns the join request after `POST /trips/:tripId/join`.
  Future<TripJoinRequest> joinTrip(String tripId) async {
    final current = state.asData?.value;
    if (current?.joiningTripId != null) {
      throw const ApiException(message: 'Đang gửi yêu cầu tham gia.');
    }
    if (current != null) {
      state = AsyncData(current.copyWith(joiningTripId: tripId));
    }
    try {
      final request = await ref
          .read(tripJoinRequestsRepositoryProvider)
          .requestToJoinByTripId(tripId);
      final latest = state.asData?.value ?? current;
      if (latest != null) {
        await _loadKeeping(
          latest,
          filterId: latest.selectedFilterId,
          destinationCatalogId: latest.destinationCatalogId,
          searchQuery: latest.searchQuery,
        );
      }
      return request;
    } finally {
      final after = state.asData?.value;
      if (after != null && after.joiningTripId != null) {
        state = AsyncData(after.copyWith(clearJoiningTripId: true));
      }
    }
  }
}

List<CommunityTripCard> _appendTrips(
  List<CommunityTripCard> current,
  List<CommunityTripCard> incoming,
) {
  final seen = {for (final trip in current) trip.id};
  return [
    ...current,
    for (final trip in incoming)
      if (seen.add(trip.id)) trip,
  ];
}

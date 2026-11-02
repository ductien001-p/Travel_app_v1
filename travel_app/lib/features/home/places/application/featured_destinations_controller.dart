import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/place_explore_api_models.dart';
import '../provider/explore_places_provider.dart';
import 'featured_destinations_view.dart';

const featuredSearchDebounce = Duration(milliseconds: 350);

class FeaturedDestinationsState {
  const FeaturedDestinationsState({
    required this.subtitle,
    required this.places,
    this.query = '',
    this.chip = FeaturedDestinationChip.popular,
    this.sort = FeaturedDestinationSort.none,
    this.searchPlaces,
    this.searching = false,
    this.reloadError,
    this.searchError,
  });

  final String subtitle;
  final List<FeaturedPlaceApi> places;
  final String query;
  final FeaturedDestinationChip chip;
  final FeaturedDestinationSort sort;
  final List<FeaturedPlaceApi>? searchPlaces;
  final bool searching;
  final String? reloadError;
  final String? searchError;

  List<FeaturedPlaceApi> get activePlaces {
    if (query.trim().isEmpty) return places;
    return searchPlaces ?? places;
  }

  FeaturedDestinationsView get view => buildFeaturedDestinationsView(
    subtitle: subtitle,
    places: activePlaces,
    chip: chip,
    sort: sort,
  );

  FeaturedDestinationsState copyWith({
    String? subtitle,
    List<FeaturedPlaceApi>? places,
    String? query,
    FeaturedDestinationChip? chip,
    FeaturedDestinationSort? sort,
    Object? searchPlaces = _keepSearch,
    bool? searching,
    Object? reloadError = _keepError,
    Object? searchError = _keepSearchError,
  }) {
    return FeaturedDestinationsState(
      subtitle: subtitle ?? this.subtitle,
      places: places ?? this.places,
      query: query ?? this.query,
      chip: chip ?? this.chip,
      sort: sort ?? this.sort,
      searchPlaces: identical(searchPlaces, _keepSearch)
          ? this.searchPlaces
          : searchPlaces as List<FeaturedPlaceApi>?,
      searching: searching ?? this.searching,
      reloadError: identical(reloadError, _keepError)
          ? this.reloadError
          : reloadError as String?,
      searchError: identical(searchError, _keepSearchError)
          ? this.searchError
          : searchError as String?,
    );
  }
}

const _keepError = Object();
const _keepSearch = Object();
const _keepSearchError = Object();

final featuredDestinationsControllerProvider =
    AsyncNotifierProvider.autoDispose<
      FeaturedDestinationsController,
      FeaturedDestinationsState
    >(FeaturedDestinationsController.new);

class FeaturedDestinationsController
    extends AsyncNotifier<FeaturedDestinationsState> {
  Timer? _searchDebounce;
  var _searchGeneration = 0;

  @override
  FutureOr<FeaturedDestinationsState> build() {
    ref.onDispose(() => _searchDebounce?.cancel());
    return _load();
  }

  Future<void> refresh() async {
    final previous = state.asData?.value;
    try {
      final next = await _load(previous: previous);
      state = AsyncData(next);
      final query = next.query.trim();
      if (query.isNotEmpty) {
        await _runSearch(query, ++_searchGeneration);
      }
    } catch (error, stackTrace) {
      if (previous == null) {
        state = AsyncError(error, stackTrace);
        return;
      }
      state = AsyncData(
        previous.copyWith(reloadError: 'Không tải lại được điểm đến.'),
      );
    }
  }

  void setQuery(String query) {
    final current = state.asData?.value;
    if (current == null || query == current.query) return;
    _searchDebounce?.cancel();
    if (query.trim().isEmpty) {
      _searchGeneration += 1;
      state = AsyncData(
        current.copyWith(
          query: query,
          searchPlaces: null,
          searching: false,
          searchError: null,
        ),
      );
      return;
    }
    state = AsyncData(
      current.copyWith(query: query, searching: true, searchError: null),
    );
    final generation = ++_searchGeneration;
    final trimmed = query.trim();
    _searchDebounce = Timer(featuredSearchDebounce, () {
      unawaited(_runSearch(trimmed, generation));
    });
  }

  void selectSort(FeaturedDestinationSort sort) {
    final current = state.asData?.value;
    if (current == null || sort == current.sort) return;
    state = AsyncData(current.copyWith(sort: sort));
  }

  void selectChip(FeaturedDestinationChip chip) {
    final current = state.asData?.value;
    if (current == null || chip == current.chip) return;
    state = AsyncData(current.copyWith(chip: chip));
  }

  void noteBookmark(String placeId, bool bookmarked) {
    final current = state.asData?.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        places: _withBookmark(current.places, placeId, bookmarked),
        searchPlaces: current.searchPlaces == null
            ? null
            : _withBookmark(current.searchPlaces!, placeId, bookmarked),
      ),
    );
  }

  Future<void> _runSearch(String query, int generation) async {
    try {
      final hits = await ref
          .read(explorePlacesRepositoryProvider)
          .searchEmbeddings(query);
      if (generation != _searchGeneration) return;
      final current = state.asData?.value;
      if (current == null || current.query.trim() != query) return;
      state = AsyncData(
        current.copyWith(
          searchPlaces: hits,
          searching: false,
          searchError: null,
        ),
      );
    } catch (_) {
      if (generation != _searchGeneration) return;
      final current = state.asData?.value;
      if (current == null || current.query.trim() != query) return;
      state = AsyncData(
        current.copyWith(
          searching: false,
          searchError: 'Không tìm được điểm đến.',
        ),
      );
    }
  }

  Future<FeaturedDestinationsState> _load({
    FeaturedDestinationsState? previous,
  }) async {
    final data = await ref
        .read(explorePlacesRepositoryProvider)
        .getFeatured(utcOffsetMinutes: DateTime.now().timeZoneOffset.inMinutes);
    return FeaturedDestinationsState(
      subtitle: data.subtitle,
      places: data.places,
      query: previous?.query ?? '',
      chip: previous?.chip ?? FeaturedDestinationChip.popular,
      sort: previous?.sort ?? FeaturedDestinationSort.none,
      searchPlaces: previous?.searchPlaces,
    );
  }
}

List<FeaturedPlaceApi> _withBookmark(
  List<FeaturedPlaceApi> places,
  String placeId,
  bool bookmarked,
) {
  return [
    for (final place in places)
      if (place.id == placeId)
        place.copyWith(bookmarked: bookmarked)
      else
        place,
  ];
}

import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/home/application/home_failure_message.dart';
import 'package:travel_frontend_v1/features/home/data/models/explore_home_models.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_enums.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/models/trip_join_request_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/provider/trip_join_requests_provider.dart';

import '../data/datasources/destination_trips_datasource.dart';
import '../data/models/destination_trips_models.dart';
import '../provider/destination_trips_provider.dart';

const destinationTripServerFilters = {'all', 'weekend', 'budget', 'camping'};

const destinationTripFilters = <({String id, String label})>[
  (id: 'all', label: 'Tất cả'),
  (id: 'urgent', label: 'Đang tuyển gấp'),
  (id: 'weekend', label: 'Cuối tuần này'),
  (id: 'budget', label: 'Chi phí < 2 triệu'),
  (id: 'camping', label: 'Camping & Trekking'),
  (id: 'friends', label: 'Bạn bè'),
];

class DestinationTripsArgs {
  const DestinationTripsArgs({required this.cityName, this.catalogId});

  final String cityName;
  final String? catalogId;

  @override
  bool operator ==(Object other) =>
      other is DestinationTripsArgs &&
      other.cityName == cityName &&
      other.catalogId == catalogId;

  @override
  int get hashCode => Object.hash(cityName, catalogId);
}

class DestinationTripsViewState {
  const DestinationTripsViewState({
    required this.page,
    required this.openTripCount,
    this.selectedFilterId = 'all',
    this.searchQuery = '',
    this.bookmarkedTripIds = const <String>{},
    this.saved = false,
    this.placesLimit = 3,
    this.joiningTripId,
    this.reloadError,
  });

  final DestinationTripsPage page;
  final int openTripCount;
  final String selectedFilterId;
  final String searchQuery;
  final Set<String> bookmarkedTripIds;
  final bool saved;
  final int placesLimit;
  final String? joiningTripId;
  final String? reloadError;

  List<CommunityTripCard> get visibleTrips => filterDestinationTrips(
    trips: page.trips,
    tripTypesById: page.tripTypesById,
    filterId: selectedFilterId,
  );

  bool get canExpandSpots =>
      placesLimit < 20 && page.spots.length < page.spotsTotal;

  DestinationTripsViewState copyWith({
    DestinationTripsPage? page,
    int? openTripCount,
    String? selectedFilterId,
    String? searchQuery,
    Set<String>? bookmarkedTripIds,
    bool? saved,
    int? placesLimit,
    String? joiningTripId,
    bool clearJoiningTripId = false,
    String? reloadError,
    bool clearReloadError = false,
  }) => DestinationTripsViewState(
    page: page ?? this.page,
    openTripCount: openTripCount ?? this.openTripCount,
    selectedFilterId: selectedFilterId ?? this.selectedFilterId,
    searchQuery: searchQuery ?? this.searchQuery,
    bookmarkedTripIds: bookmarkedTripIds ?? this.bookmarkedTripIds,
    saved: saved ?? this.saved,
    placesLimit: placesLimit ?? this.placesLimit,
    joiningTripId: clearJoiningTripId
        ? null
        : (joiningTripId ?? this.joiningTripId),
    reloadError: clearReloadError ? null : (reloadError ?? this.reloadError),
  );
}

bool isUrgentDestinationTrip(CommunityTripCard trip) => trip.urgent;

List<CommunityTripCard> filterDestinationTrips({
  required List<CommunityTripCard> trips,
  required Map<String, String> tripTypesById,
  required String filterId,
}) {
  return switch (filterId) {
    'urgent' => [
      for (final trip in trips)
        if (isUrgentDestinationTrip(trip)) trip,
    ],
    'friends' => [
      for (final trip in trips)
        if (tripTypesById[trip.id] == TripType.friends.name) trip,
    ],
    _ => trips,
  };
}

String destinationServerCategory(String filterId) =>
    destinationTripServerFilters.contains(filterId) ? filterId : 'all';

final destinationTripsControllerProvider = AsyncNotifierProvider.autoDispose
    .family<
      DestinationTripsController,
      DestinationTripsViewState,
      DestinationTripsArgs
    >(DestinationTripsController.new, retry: (_, _) => null);

class DestinationTripsController
    extends AsyncNotifier<DestinationTripsViewState> {
  DestinationTripsController(this.args);

  final DestinationTripsArgs args;

  Timer? _searchDebounce;
  var _generation = 0;
  String _seed = _newDiscoverSeed();

  @override
  Future<DestinationTripsViewState> build() {
    ref.onDispose(() => _searchDebounce?.cancel());
    _seed = _newDiscoverSeed();
    return _fetch(
      const DestinationTripsViewState(
        page: DestinationTripsPage(
          profile: DestinationProfile(
            catalogId: '',
            name: '',
            regionLabel: '',
            coverImageUrl: '',
            tagline: '',
            summary: '',
          ),
          trips: [],
          spots: [],
          openTripCount: 0,
        ),
        openTripCount: 0,
      ),
    );
  }

  Future<void> refresh() async {
    final previous = state.asData?.value;
    _seed = _newDiscoverSeed();
    if (previous == null) {
      state = const AsyncLoading();
      state = await AsyncValue.guard(
        () => _fetch(
          const DestinationTripsViewState(
            page: DestinationTripsPage(
              profile: DestinationProfile(
                catalogId: '',
                name: '',
                regionLabel: '',
                coverImageUrl: '',
                tagline: '',
                summary: '',
              ),
              trips: [],
              spots: [],
              openTripCount: 0,
            ),
            openTripCount: 0,
          ),
        ),
      );
      return;
    }
    await _commit(previous);
  }

  Future<void> selectFilter(String filterId) async {
    final current = state.asData?.value;
    if (current == null || current.selectedFilterId == filterId) return;
    await _commit(current.copyWith(selectedFilterId: filterId));
  }

  Future<void> resetFilters() async {
    final current = state.asData?.value;
    if (current == null) return;
    if (current.selectedFilterId == 'all' && current.searchQuery.isEmpty) {
      return;
    }
    _searchDebounce?.cancel();
    await _commit(current.copyWith(selectedFilterId: 'all', searchQuery: ''));
  }

  void setSearchQuery(String query) {
    final current = state.asData?.value;
    if (current == null || current.searchQuery == query) return;
    state = AsyncData(current.copyWith(searchQuery: query));
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      final latest = state.asData?.value;
      if (latest == null || latest.searchQuery != query) return;
      unawaited(_reload(latest));
    });
  }

  Future<void> expandSpots() async {
    final current = state.asData?.value;
    if (current == null || !current.canExpandSpots) return;
    await _commit(current.copyWith(placesLimit: 20));
  }

  void toggleSaved() {
    final current = state.asData?.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(saved: !current.saved));
  }

  void toggleBookmark(String tripId) {
    final current = state.asData?.value;
    if (current == null) return;
    final next = Set<String>.from(current.bookmarkedTripIds);
    if (!next.add(tripId)) next.remove(tripId);
    state = AsyncData(current.copyWith(bookmarkedTripIds: next));
  }

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
        await _commit(latest.copyWith(clearJoiningTripId: true));
      }
      return request;
    } finally {
      final after = state.asData?.value;
      if (after != null && after.joiningTripId != null) {
        state = AsyncData(after.copyWith(clearJoiningTripId: true));
      }
    }
  }

  Future<void> _reload(DestinationTripsViewState current) async {
    await _commit(current);
  }

  Future<void> _commit(DestinationTripsViewState basis) async {
    final generation = ++_generation;
    final previous = state.asData?.value ?? basis;
    try {
      final next = await _fetch(basis);
      if (generation != _generation) return;
      state = AsyncData(next.copyWith(clearReloadError: true));
    } catch (error) {
      if (generation != _generation) return;
      final latest = state.asData?.value ?? previous;
      state = AsyncData(
        latest.copyWith(reloadError: homeFailureMessage(error)),
      );
    }
  }

  Future<DestinationTripsViewState> _fetch(
    DestinationTripsViewState current,
  ) async {
    final category = destinationServerCategory(current.selectedFilterId);
    final search = current.searchQuery.trim();
    final page = await ref
        .read(destinationTripsRepositoryProvider)
        .load(
          DestinationTripsQuery(
            cityName: args.cityName,
            catalogId: args.catalogId,
            category: category,
            search: search.isEmpty ? null : search,
            seed: _seed,
            timezoneOffsetMinutes: DateTime.now().timeZoneOffset.inMinutes,
            placesLimit: current.placesLimit,
          ),
        );
    final openTripCount = category == 'all'
        ? page.openTripCount
        : current.openTripCount;
    return current.copyWith(
      page: page,
      openTripCount: openTripCount,
      clearJoiningTripId: true,
    );
  }
}

String _newDiscoverSeed() {
  final random = Random.secure();
  final buffer = StringBuffer();
  for (var index = 0; index < 16; index++) {
    buffer.write(random.nextInt(256).toRadixString(16).padLeft(2, '0'));
  }
  return buffer.toString();
}

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../trip-details/application/trip_detail_overview_controller.dart';
import '../../trip-details/data/models/trip_detail_models.dart';
import '../data/models/itinerary_models.dart';
import '../data/models/itinerary_requests.dart';
import '../provider/trip_itinerary_provider.dart';

/// Overridable in tests to pin "today" for lazy destination selection.
final tripItineraryClockProvider = Provider<DateTime Function()>(
  (ref) => DateTime.now,
);

/// When true, the itinerary controller loads destinations one at a time.
///
/// Trip browse screens override this to `true`. Create-trip keeps the default
/// full `GET .../itineraries` payload.
final tripItineraryPreferLazyProvider = Provider.family<bool, String>(
  (ref, tripId) => false,
);

final tripItineraryControllerProvider =
    AsyncNotifierProvider.family<
      TripItineraryController,
      TripItineraryData,
      String
    >(TripItineraryController.new);

/// Destination id currently fetched for a tab switch, or null.
final tripItineraryLoadingDestinationProvider = NotifierProvider.autoDispose
    .family<TripItineraryLoadingDestination, String?, String>(
      TripItineraryLoadingDestination.new,
    );

class TripItineraryLoadingDestination extends Notifier<String?> {
  TripItineraryLoadingDestination(this.tripId);

  final String tripId;

  @override
  String? build() => null;

  void setLoading(String? destinationId) => state = destinationId;
}

class TripItineraryController extends AsyncNotifier<TripItineraryData> {
  TripItineraryController(this.tripId);

  final String tripId;
  bool _mutating = false;

  /// Destinations whose days came from the API (not empty stubs).
  final Set<String> _loadedDestinationIds = {};

  /// True while browsing with per-destination fetches.
  bool _lazyMode = false;

  bool isDestinationLoaded(String destinationId) =>
      _loadedDestinationIds.contains(destinationId);

  @override
  FutureOr<TripItineraryData> build() async {
    _loadedDestinationIds.clear();
    _lazyMode = false;

    final preferLazy = ref.watch(tripItineraryPreferLazyProvider(tripId));
    if (preferLazy) {
      _lazyMode = true;
      final overview = await ref.watch(
        tripDetailOverviewControllerProvider(tripId).future,
      );
      return _bootstrapLazy(overview);
    }
    return _loadFull();
  }

  Future<TripItineraryData> _loadFull() async {
    final data = await ref
        .read(tripItineraryRepositoryProvider)
        .getItinerary(tripId);
    _lazyMode = false;
    _loadedDestinationIds
      ..clear()
      ..addAll(data.destinations.map((d) => d.id));
    return data;
  }

  Future<TripItineraryData> _bootstrapLazy(TripDetailOverview trip) async {
    final stubs = _stubsFromOverview(trip);
    if (stubs.isEmpty) {
      return TripItineraryData(
        destinations: const [],
        canManageItinerary: trip.canManageMembers,
      );
    }

    final preferredId = _preferredDestinationId(
      stubs,
      ref.read(tripItineraryClockProvider)().toUtc(),
    );
    final first = await ref
        .read(tripItineraryRepositoryProvider)
        .getDestination(tripId, preferredId);
    _loadedDestinationIds.add(first.id);

    return TripItineraryData(
      destinations: [
        for (final stub in stubs)
          if (stub.id == first.id) first else stub,
      ],
      canManageItinerary: trip.canManageMembers,
    );
  }

  /// Loads one destination's days if not yet fetched (tab switch).
  Future<void> ensureDestinationLoaded(String destinationId) async {
    if (!_lazyMode || _loadedDestinationIds.contains(destinationId)) return;
    final current = state.value;
    if (current == null) return;
    if (!current.destinations.any((d) => d.id == destinationId)) return;

    final loading = ref.read(
      tripItineraryLoadingDestinationProvider(tripId).notifier,
    );
    loading.setLoading(destinationId);
    try {
      final destination = await ref
          .read(tripItineraryRepositoryProvider)
          .getDestination(tripId, destinationId);
      if (!ref.mounted) return;
      _loadedDestinationIds.add(destination.id);
      final data = state.value ?? current;
      state = AsyncData(
        TripItineraryData(
          destinations: [
            for (final item in data.destinations)
              if (item.id == destination.id) destination else item,
          ],
          canManageItinerary: data.canManageItinerary,
        ),
      );
    } finally {
      if (ref.mounted) loading.setLoading(null);
    }
  }

  Future<void> refresh() async {
    if (_lazyMode) {
      final overview = ref
          .read(tripDetailOverviewControllerProvider(tripId))
          .value;
      if (overview != null) {
        state = const AsyncLoading();
        _loadedDestinationIds.clear();
        state = await AsyncValue.guard(() => _bootstrapLazy(overview));
        return;
      }
    }
    await _reloadFull();
  }

  /// Forces the full itinerary payload (create-trip editor / confirm).
  Future<void> refreshFull() => _reloadFull();

  Future<ItineraryActivity> createActivity(
    String dayId,
    CreateActivityRequest request,
  ) => _mutate(
    () => ref
        .read(tripItineraryRepositoryProvider)
        .createActivity(tripId, dayId, request),
  );

  Future<CreateItineraryItemsBatchResult> createItemsBatch(
    CreateItineraryItemsBatchRequest request,
  ) => _mutate(
    () => ref
        .read(tripItineraryRepositoryProvider)
        .createItemsBatch(tripId, request),
  );

  Future<ItineraryActivity> updateActivity(
    String activityId,
    UpdateActivityRequest request,
  ) => _mutate(
    () => ref
        .read(tripItineraryRepositoryProvider)
        .updateActivity(tripId, activityId, request),
  );

  Future<void> deleteActivity(String activityId) => _mutate(
    () => ref
        .read(tripItineraryRepositoryProvider)
        .deleteActivity(tripId, activityId),
    refreshCompletion: true,
  );

  Future<void> deleteDestination(
    String destinationId, {
    bool acknowledgeRecruitmentImpact = false,
  }) => _mutate(
    () => ref
        .read(tripItineraryRepositoryProvider)
        .deleteDestination(
          tripId,
          destinationId,
          acknowledgeRecruitmentImpact: acknowledgeRecruitmentImpact,
        ),
    refreshCompletion: true,
  );

  Future<List<ItineraryActivity>> reorderItems(
    String dayId,
    List<String> orderedItemIds,
  ) => _mutate(
    () => ref
        .read(tripItineraryRepositoryProvider)
        .reorderItems(tripId, dayId, orderedItemIds),
  );

  Future<TripCheckin> checkin(
    String activityId,
    CheckinActivityRequest request,
  ) => _mutate(
    () => ref
        .read(tripItineraryRepositoryProvider)
        .checkin(tripId, activityId, request),
    refreshCompletion: true,
  );

  Future<void> uncheckin(String activityId) => _mutate(
    () =>
        ref.read(tripItineraryRepositoryProvider).uncheckin(tripId, activityId),
    refreshCompletion: true,
  );

  Future<T> _mutate<T>(
    Future<T> Function() action, {
    bool refreshCompletion = false,
  }) async {
    if (_mutating) {
      throw StateError('An itinerary mutation is already in progress.');
    }
    _mutating = true;
    try {
      final result = await action();
      // Mutations change days/activities — reload the full tree for consistency.
      await _reloadFull();
      if (refreshCompletion) {
        ref.invalidate(tripItineraryCompletionControllerProvider(tripId));
      }
      return result;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    } finally {
      _mutating = false;
    }
  }

  Future<void> _reloadFull() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadFull);
  }

  List<DestinationItinerary> _stubsFromOverview(TripDetailOverview trip) {
    final sorted = [...trip.destinations]
      ..sort((a, b) => a.order.compareTo(b.order));
    return [
      for (final destination in sorted)
        DestinationItinerary(
          id: destination.id,
          tripId: trip.id,
          city: destination.city,
          country: destination.country,
          latitude: 0,
          longitude: 0,
          order: destination.order,
          startDate: destination.startDate,
          endDate: destination.endDate,
          days: const [],
        ),
    ];
  }

  /// Same defaults as the itinerary view, using destination date ranges.
  String _preferredDestinationId(
    List<DestinationItinerary> destinations,
    DateTime now,
  ) {
    final today = DateTime.utc(now.year, now.month, now.day);
    DateTime dateOf(DateTime value) {
      final utc = value.toUtc();
      return DateTime.utc(utc.year, utc.month, utc.day);
    }

    for (final destination in destinations) {
      final start = dateOf(destination.startDate);
      final end = dateOf(destination.endDate);
      if (!today.isBefore(start) && !today.isAfter(end)) {
        return destination.id;
      }
    }
    for (final destination in destinations) {
      if (!dateOf(destination.endDate).isBefore(today)) {
        return destination.id;
      }
    }
    return destinations.first.id;
  }
}

final tripItineraryCompletionControllerProvider =
    AsyncNotifierProvider.family<
      TripItineraryCompletionController,
      TripItineraryCompletion,
      String
    >(TripItineraryCompletionController.new);

class TripItineraryCompletionController
    extends AsyncNotifier<TripItineraryCompletion> {
  TripItineraryCompletionController(this.tripId);

  final String tripId;

  @override
  FutureOr<TripItineraryCompletion> build() =>
      ref.watch(tripItineraryRepositoryProvider).getCompletion(tripId);

  Future<void> refresh() async {
    if (state.isLoading) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(tripItineraryRepositoryProvider).getCompletion(tripId),
    );
  }
}

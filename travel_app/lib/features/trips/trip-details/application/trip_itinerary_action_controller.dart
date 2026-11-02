import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';

import '../../application/device_location_controller.dart';
import '../../trip-itineraies/application/trip_itinerary_controller.dart';
import '../../trip-itineraies/data/models/itinerary_requests.dart';
import 'trip_detail_overview_controller.dart';
import 'trip_itinerary_controller.dart';

enum TripItineraryAction { checkin, uncheckin, deleteActivity }

class TripItineraryActionState {
  const TripItineraryActionState({this.pending, this.activityId});

  final TripItineraryAction? pending;
  final String? activityId;

  bool get isBusy => pending != null;

  bool isPending(TripItineraryAction action, String activityId) =>
      pending == action && this.activityId == activityId;
}

final tripItineraryActionControllerProvider = NotifierProvider.autoDispose
    .family<TripItineraryActionController, TripItineraryActionState, String>(
      TripItineraryActionController.new,
    );

class TripItineraryActionController extends Notifier<TripItineraryActionState> {
  TripItineraryActionController(this.tripId);

  final String tripId;

  @override
  TripItineraryActionState build() => const TripItineraryActionState();

  /// The backend validates that the device is near the place.
  Future<void> checkin(String activityId) => _run(
    TripItineraryAction.checkin,
    activityId,
    () async {
      final position = await ref.read(deviceLocationServiceProvider).current();
      await _itinerary.checkin(
        activityId,
        CheckinActivityRequest(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
    },
  );

  Future<void> uncheckin(String activityId) => _run(
    TripItineraryAction.uncheckin,
    activityId,
    () => _itinerary.uncheckin(activityId),
  );

  Future<void> deleteActivity(String activityId) => _run(
    TripItineraryAction.deleteActivity,
    activityId,
    () => _itinerary.deleteActivity(activityId),
  );

  TripItineraryController get _itinerary =>
      ref.read(tripItineraryControllerProvider(tripId).notifier);

  Future<void> _run(
    TripItineraryAction action,
    String activityId,
    Future<void> Function() task,
  ) async {
    if (state.isBusy) {
      throw StateError('An itinerary action is already in progress.');
    }
    state = TripItineraryActionState(pending: action, activityId: activityId);
    try {
      await task();
      _refreshDependents();
    } on ApiException {
      // The server state may differ from ours (e.g. 409 "already checked in").
      _refreshDependents();
      rethrow;
    } finally {
      if (ref.mounted) state = const TripItineraryActionState();
    }
  }

  void _refreshDependents() {
    if (!ref.mounted) return;
    ref
      ..invalidate(tripItineraryViewerCheckinsProvider(tripId))
      ..invalidate(tripDetailOverviewControllerProvider(tripId));
  }
}

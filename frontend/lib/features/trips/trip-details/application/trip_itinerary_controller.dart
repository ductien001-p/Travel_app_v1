import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../trip-itineraies/application/trip_itinerary_controller.dart';
import '../data/models/trip_detail_models.dart';
import '../provider/trip_detail_provider.dart';
import 'trip_detail_overview_controller.dart';
import 'trip_itinerary_view.dart';

export '../../trip-itineraies/application/trip_itinerary_controller.dart'
    show tripItineraryClockProvider;

final tripItineraryViewerCheckinsProvider = FutureProvider.autoDispose
    .family<Set<String>, String>(
      (ref, tripId) => ref
          .watch(tripDetailRepositoryProvider)
          .getViewerCheckedInPlaceIds(tripId),
    );

typedef TripItinerarySelection = ({String? destinationId, String? dayId});

final tripItinerarySelectionProvider = NotifierProvider.autoDispose
    .family<TripItinerarySelectionController, TripItinerarySelection, String>(
      TripItinerarySelectionController.new,
    );

/// Null ids let [buildTripItineraryView] pick a sensible default.
class TripItinerarySelectionController
    extends Notifier<TripItinerarySelection> {
  TripItinerarySelectionController(this.tripId);

  final String tripId;

  @override
  TripItinerarySelection build() => (destinationId: null, dayId: null);

  Future<void> selectDestination(String destinationId) async {
    state = (destinationId: destinationId, dayId: null);
    await ref
        .read(tripItineraryControllerProvider(tripId).notifier)
        .ensureDestinationLoaded(destinationId);
  }

  Future<void> selectDay({
    required String destinationId,
    required String dayId,
  }) async {
    state = (destinationId: destinationId, dayId: dayId);
    await ref
        .read(tripItineraryControllerProvider(tripId).notifier)
        .ensureDestinationLoaded(destinationId);
  }
}

const _checkinTripStatuses = {
  TripDetailStatus.upcoming,
  TripDetailStatus.ongoing,
};

/// Mirrors the backend rule: active members check in while the trip is
/// upcoming or ongoing.
bool canCheckinTrip(TripDetailOverview? trip) =>
    trip != null && trip.isMember && _checkinTripStatuses.contains(trip.status);

final tripItineraryViewProvider = Provider.autoDispose
    .family<AsyncValue<TripItineraryView>, String>((ref, tripId) {
      final itinerary = ref.watch(tripItineraryControllerProvider(tripId));
      final checkins = ref.watch(tripItineraryViewerCheckinsProvider(tripId));
      final trip = ref.watch(tripDetailOverviewControllerProvider(tripId));
      final selection = ref.watch(tripItinerarySelectionProvider(tripId));

      if (itinerary.hasValue && checkins.hasValue) {
        return AsyncData(
          buildTripItineraryView(
            itinerary: itinerary.requireValue,
            viewerCheckedInPlaceIds: checkins.requireValue,
            canCheckin: canCheckinTrip(trip.value),
            now: ref.watch(tripItineraryClockProvider)(),
            selectedDestinationId: selection.destinationId,
            selectedDayId: selection.dayId,
          ),
        );
      }
      // A failed provider stays "loading with error" while Riverpod retries it.
      for (final source in [itinerary, checkins]) {
        if (source.hasError) {
          return AsyncError(source.error!, source.stackTrace!);
        }
      }
      return const AsyncLoading();
    });

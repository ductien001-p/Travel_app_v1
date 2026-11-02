import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/trip.dart';
import '../provider/trips_provider.dart';
import '../trip-details/application/trip_detail_overview_controller.dart';
import 'trip_list_controller.dart';

final tripInterestsControllerProvider =
    AsyncNotifierProvider<TripInterestsController, List<TripInterest>>(
      TripInterestsController.new,
    );

/// Catalog + assign interests to a trip. Admin CRUD stays on the backend only.
class TripInterestsController extends AsyncNotifier<List<TripInterest>> {
  @override
  FutureOr<List<TripInterest>> build() =>
      ref.watch(tripRepositoryProvider).getInterests();

  Future<List<TripInterest>> setForTrip(
    String tripId,
    List<String> interestIds,
  ) async {
    final previous = state;
    state = const AsyncLoading();
    try {
      final interests = await ref
          .read(tripRepositoryProvider)
          .setTripInterests(tripId, interestIds);
      state = previous;
      ref.invalidate(tripDetailOverviewControllerProvider(tripId));
      ref.invalidate(tripListControllerProvider);
      return interests;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }
}

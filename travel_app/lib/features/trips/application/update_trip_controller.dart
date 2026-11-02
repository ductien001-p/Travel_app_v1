import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/trip.dart';
import '../data/models/update_trip_request.dart';
import '../provider/trips_provider.dart';
import '../trip-details/application/trip_detail_overview_controller.dart';
import 'trip_list_controller.dart';

final updateTripControllerProvider =
    AsyncNotifierProvider<UpdateTripController, Trip?>(
      UpdateTripController.new,
    );

class UpdateTripController extends AsyncNotifier<Trip?> {
  bool _submitting = false;
  @override
  Trip? build() => null;

  Future<Trip> submit(String tripId, UpdateTripRequest request) async {
    if (_submitting) {
      throw StateError('A trip mutation is already in progress.');
    }
    _submitting = true;
    state = const AsyncLoading();
    try {
      final trip = await ref
          .read(tripRepositoryProvider)
          .updateTrip(tripId, request);
      state = AsyncData(trip);
      ref.invalidate(tripListControllerProvider);
      ref.invalidate(tripDetailOverviewControllerProvider(tripId));
      return trip;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    } finally {
      _submitting = false;
    }
  }

  Future<void> delete(String tripId) async {
    if (_submitting) {
      throw StateError('A trip mutation is already in progress.');
    }
    _submitting = true;
    state = const AsyncLoading();
    try {
      await ref.read(tripRepositoryProvider).deleteTrip(tripId);
      state = const AsyncData(null);
      ref.invalidate(tripListControllerProvider);
      ref.invalidate(tripDetailOverviewControllerProvider(tripId));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    } finally {
      _submitting = false;
    }
  }
}

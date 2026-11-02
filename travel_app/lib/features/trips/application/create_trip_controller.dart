import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/create_trip.dart';
import '../data/models/trip.dart';
import '../provider/trips_provider.dart';
import 'trip_list_controller.dart';

final createTripControllerProvider =
    AsyncNotifierProvider<CreateTripController, Trip?>(
      CreateTripController.new,
    );

class CreateTripController extends AsyncNotifier<Trip?> {
  bool _submitting = false;

  @override
  Trip? build() => null;

  Future<Trip> submit(CreateTripRequest request) async {
    if (_submitting) throw StateError('Trip creation is already in progress.');
    _submitting = true;
    state = const AsyncLoading();
    try {
      final trip = await ref.read(tripRepositoryProvider).createTrip(request);
      state = AsyncData(trip);
      _invalidateTripCollections();
      return trip;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    } finally {
      _submitting = false;
    }
  }

  Future<Trip> saveDraft(CreateTripDraftRequest request) async {
    if (_submitting) throw StateError('Trip creation is already in progress.');
    _submitting = true;
    state = const AsyncLoading();
    try {
      final trip = await ref.read(tripRepositoryProvider).createDraft(request);
      state = AsyncData(trip);
      _invalidateTripCollections();
      return trip;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    } finally {
      _submitting = false;
    }
  }

  Future<Trip> finalize(String tripId) async {
    state = const AsyncLoading();
    try {
      final trip = await ref.read(tripRepositoryProvider).finalizeTrip(tripId);
      state = AsyncData(trip);
      _invalidateTripCollections();
      return trip;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  void reset() => state = const AsyncData(null);

  void _invalidateTripCollections() {
    ref.invalidate(tripListControllerProvider);
    ref.invalidate(tripDashboardControllerProvider);
  }
}

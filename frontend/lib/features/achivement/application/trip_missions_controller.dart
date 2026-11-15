import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/achivement_models.dart';
import '../provider/achivement_provider.dart';

final tripMissionsControllerProvider = AsyncNotifierProvider.autoDispose
    .family<TripMissionsController, TripMissionsPage, String>(
      TripMissionsController.new,
    );

class TripMissionsController extends AsyncNotifier<TripMissionsPage> {
  TripMissionsController(this.tripId);

  final String tripId;

  @override
  Future<TripMissionsPage> build() =>
      ref.read(achivementRepositoryProvider).getTripMissions(tripId);

  Future<void> refresh() async {
    final previous = state.asData?.value;
    state = await AsyncValue.guard(
      () => ref.read(achivementRepositoryProvider).getTripMissions(tripId),
    );
    if (state.hasError && previous != null) {
      state = AsyncData(previous);
    }
  }
}

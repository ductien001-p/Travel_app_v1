import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/trip_detail_models.dart';
import '../provider/trip_detail_provider.dart';

final tripDetailOverviewControllerProvider = AsyncNotifierProvider.autoDispose
    .family<TripDetailOverviewController, TripDetailOverview, String>(
      TripDetailOverviewController.new,
    );

class TripDetailOverviewController extends AsyncNotifier<TripDetailOverview> {
  TripDetailOverviewController(this.tripId);

  final String tripId;

  @override
  FutureOr<TripDetailOverview> build() =>
      ref.watch(tripDetailRepositoryProvider).getTripDetail(tripId);

  Future<void> refresh() async {
    if (state.isLoading) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(tripDetailRepositoryProvider).getTripDetail(tripId),
    );
  }
}

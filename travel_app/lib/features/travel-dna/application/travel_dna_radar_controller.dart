import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/travel_dna_models.dart';
import '../provider/travel_dna_provider.dart';

final travelDnaRadarControllerProvider =
    AsyncNotifierProvider<TravelDnaRadarController, TravelDnaRadar>(
      TravelDnaRadarController.new,
    );

class TravelDnaRadarController extends AsyncNotifier<TravelDnaRadar> {
  @override
  FutureOr<TravelDnaRadar> build() =>
      ref.watch(travelDnaRepositoryProvider).loadRadar();

  Future<void> refresh() async {
    if (state.isLoading) return;
    final previous = state;
    state = AsyncLoading<TravelDnaRadar>().copyWithPrevious(previous);
    final next = await AsyncValue.guard(
      () => ref.read(travelDnaRepositoryProvider).loadRadar(),
    );
    state = next.hasError ? next.copyWithPrevious(previous) : next;
  }
}

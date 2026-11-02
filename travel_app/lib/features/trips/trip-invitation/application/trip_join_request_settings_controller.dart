import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/trip_join_request_models.dart';
import '../provider/trip_join_requests_provider.dart';

final tripJoinRequestSettingsControllerProvider = AsyncNotifierProvider
    .autoDispose
    .family<TripJoinRequestSettingsController, TripJoinRequestSettings, String>(
      TripJoinRequestSettingsController.new,
      retry: (_, _) => null,
    );

class TripJoinRequestSettingsController
    extends AsyncNotifier<TripJoinRequestSettings> {
  TripJoinRequestSettingsController(this.tripId);

  final String tripId;
  bool _saving = false;

  @override
  FutureOr<TripJoinRequestSettings> build() =>
      ref.read(tripJoinRequestsRepositoryProvider).getSettings(tripId);

  /// Shows the new value right away and restores the previous one if saving
  /// fails; the failure is reported through the returned future.
  Future<void> setAutoApproveFriends(bool enabled) async {
    final current = state.value;
    if (current == null || _saving || current.autoApproveFriends == enabled) {
      return;
    }
    _saving = true;
    state = AsyncData(current.copyWith(autoApproveFriends: enabled));
    try {
      final saved = await ref
          .read(tripJoinRequestsRepositoryProvider)
          .updateSettings(
            tripId,
            current.copyWith(autoApproveFriends: enabled),
          );
      if (ref.mounted) state = AsyncData(saved);
    } catch (_) {
      if (ref.mounted) state = AsyncData(current);
      rethrow;
    } finally {
      _saving = false;
    }
  }
}

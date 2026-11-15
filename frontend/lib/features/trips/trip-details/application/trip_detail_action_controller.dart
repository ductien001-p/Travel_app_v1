import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/features/achivement/application/trip_missions_controller.dart';

import '../../application/trip_list_controller.dart';
import '../data/models/trip_detail_models.dart';
import '../provider/trip_detail_provider.dart';
import 'trip_detail_overview_controller.dart';

enum TripDetailAction { kickMember, leaveTrip, claimReward, rotateInviteCode }

class TripDetailActionState {
  const TripDetailActionState({this.pending, this.targetUserId});

  final TripDetailAction? pending;
  final String? targetUserId;

  bool get isBusy => pending != null;

  bool isPending(TripDetailAction action, {String? targetUserId}) =>
      pending == action &&
      (targetUserId == null || this.targetUserId == targetUserId);
}

final tripDetailActionControllerProvider = NotifierProvider.autoDispose
    .family<TripDetailActionController, TripDetailActionState, String>(
      TripDetailActionController.new,
    );

class TripDetailActionController extends Notifier<TripDetailActionState> {
  TripDetailActionController(this.tripId);

  final String tripId;

  @override
  TripDetailActionState build() => const TripDetailActionState();

  Future<void> kickMember(String targetUserId) => _run(
    TripDetailAction.kickMember,
    () =>
        ref.read(tripDetailRepositoryProvider).kickMember(tripId, targetUserId),
    targetUserId: targetUserId,
  );

  /// The caller leaves the screen afterwards, so the detail is not refetched.
  Future<void> leaveTrip() async {
    await _run(
      TripDetailAction.leaveTrip,
      () => ref.read(tripDetailRepositoryProvider).leaveTrip(tripId),
      refreshOverview: false,
    );
    ref
      ..invalidate(tripListControllerProvider)
      ..invalidate(tripDashboardControllerProvider);
  }

  Future<TripDetailRewardClaim> claimReward() async {
    final claim = await _run(
      TripDetailAction.claimReward,
      () =>
          ref.read(tripDetailRepositoryProvider).claimCompletionReward(tripId),
    );
    ref.invalidate(tripMissionsControllerProvider(tripId));
    return claim;
  }

  /// Invalidates the previous invite code; overview refresh picks up the new one.
  Future<String> rotateInviteCode() => _run(
    TripDetailAction.rotateInviteCode,
    () => ref.read(tripDetailRepositoryProvider).rotateInviteCode(tripId),
  );

  Future<T> _run<T>(
    TripDetailAction action,
    Future<T> Function() task, {
    String? targetUserId,
    bool refreshOverview = true,
  }) async {
    if (state.isBusy) {
      throw StateError('A trip action is already in progress.');
    }
    state = TripDetailActionState(pending: action, targetUserId: targetUserId);
    try {
      final result = await task();
      if (refreshOverview) {
        ref.invalidate(tripDetailOverviewControllerProvider(tripId));
      }
      return result;
    } finally {
      if (ref.mounted) state = const TripDetailActionState();
    }
  }
}

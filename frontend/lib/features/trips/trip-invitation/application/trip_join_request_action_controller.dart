import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';

import '../../trip-details/application/trip_detail_overview_controller.dart';
import '../data/models/trip_join_request_models.dart';
import '../provider/trip_join_requests_provider.dart';
import 'trip_join_requests_controller.dart';
import 'trip_join_requests_header.dart';

/// Decision being sent; at most one at a time.
class TripJoinRequestActionState {
  const TripJoinRequestActionState({this.requestId, this.decision});

  final String? requestId;
  final TripJoinRequestStatus? decision;

  bool get isBusy => requestId != null;

  bool isDeciding(String id, TripJoinRequestStatus value) =>
      requestId == id && decision == value;
}

final tripJoinRequestActionControllerProvider = NotifierProvider.autoDispose
    .family<
      TripJoinRequestActionController,
      TripJoinRequestActionState,
      String
    >(TripJoinRequestActionController.new);

class TripJoinRequestActionController
    extends Notifier<TripJoinRequestActionState> {
  TripJoinRequestActionController(this.tripId);

  final String tripId;

  @override
  TripJoinRequestActionState build() => const TripJoinRequestActionState();

  Future<TripJoinRequest> approve(String requestId) =>
      _decide(requestId, TripJoinRequestStatus.approved);

  Future<TripJoinRequest> reject(String requestId) =>
      _decide(requestId, TripJoinRequestStatus.rejected);

  Future<TripJoinRequest> _decide(
    String requestId,
    TripJoinRequestStatus decision,
  ) async {
    if (state.isBusy) {
      throw StateError('A join request decision is already in progress.');
    }
    if (decision == TripJoinRequestStatus.approved) _ensureApprovable();
    state = TripJoinRequestActionState(
      requestId: requestId,
      decision: decision,
    );
    try {
      final reviewed = await ref
          .read(tripJoinRequestsRepositoryProvider)
          .decide(tripId, requestId, decision);
      if (ref.mounted) {
        _requests.applyDecision(reviewed);
        if (reviewed.status == TripJoinRequestStatus.approved) {
          _invalidateMembers();
        }
      }
      return reviewed;
    } on ApiException catch (error) {
      if (ref.mounted) _resyncAfter(error);
      rethrow;
    } finally {
      if (ref.mounted) state = const TripJoinRequestActionState();
    }
  }

  /// The backend enforces the same rules; this only saves a doomed request.
  /// While the trip is still loading the backend decides.
  void _ensureApprovable() {
    final header = ref.read(tripJoinRequestsHeaderProvider(tripId)).value;
    final block = header?.approvalBlock;
    if (block != null) throw TripJoinApprovalBlockedException(block);
  }

  TripJoinRequestsController get _requests =>
      ref.read(tripJoinRequestsControllerProvider(tripId).notifier);

  /// Member count and seats come from `GET /trips/{id}`.
  void _invalidateMembers() =>
      ref.invalidate(tripDetailOverviewControllerProvider(tripId));

  /// 404/409 mean the list or the seat count on screen is stale.
  void _resyncAfter(ApiException error) {
    if (error.statusCode != 404 && error.statusCode != 409) return;
    _invalidateMembers();
    _requests.refresh().ignore();
  }
}

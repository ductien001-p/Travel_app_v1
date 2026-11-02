import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../trip-details/application/trip_detail_overview_controller.dart';
import '../../trip-details/data/models/trip_detail_models.dart';

/// What the review screen needs from `GET /trips/{id}`.
class TripJoinRequestsHeader {
  const TripJoinRequestsHeader({
    required this.tripName,
    required this.tripType,
    required this.memberCount,
    required this.maxMembers,
    required this.canReview,
    required this.isOpen,
    this.viewerRole,
    this.inviteCode,
  });

  final String tripName;
  final TripDetailType tripType;
  final int memberCount;
  final int maxMembers;

  /// Owners and admins review join requests.
  final bool canReview;

  /// The backend only adds members before the trip starts.
  final bool isOpen;
  final TripDetailMemberRole? viewerRole;

  /// Only sent to the owner.
  final String? inviteCode;

  int get remainingSlots =>
      memberCount >= maxMembers ? 0 : maxMembers - memberCount;

  bool get isFull => remainingSlots == 0;

  /// 0..1 share of the seats taken.
  double get fillRatio =>
      maxMembers <= 0 ? 1 : (memberCount / maxMembers).clamp(0.0, 1.0);

  /// Why approving is not possible right now; null when it is.
  TripJoinApprovalBlock? get approvalBlock {
    if (!canReview) return TripJoinApprovalBlock.notReviewer;
    if (!isOpen) return TripJoinApprovalBlock.closed;
    if (isFull) return TripJoinApprovalBlock.full;
    return null;
  }

  bool get canApprove => approvalBlock == null;
}

enum TripJoinApprovalBlock { notReviewer, closed, full }

/// Thrown instead of calling the backend when the request cannot be approved.
class TripJoinApprovalBlockedException implements Exception {
  const TripJoinApprovalBlockedException(this.block);

  final TripJoinApprovalBlock block;

  @override
  String toString() => 'TripJoinApprovalBlockedException(${block.name})';
}

TripJoinRequestsHeader buildTripJoinRequestsHeader(TripDetailOverview trip) =>
    TripJoinRequestsHeader(
      tripName: trip.name,
      tripType: trip.tripType,
      memberCount: trip.members.length,
      maxMembers: trip.maxMembers,
      canReview: trip.canManageMembers,
      isOpen: trip.status == TripDetailStatus.upcoming,
      viewerRole: trip.viewer.role,
      inviteCode: trip.inviteCode,
    );

/// Reuses the trip detail request, so approving a member refreshes both.
final tripJoinRequestsHeaderProvider = Provider.autoDispose
    .family<AsyncValue<TripJoinRequestsHeader>, String>(
      (ref, tripId) => ref
          .watch(tripDetailOverviewControllerProvider(tripId))
          .whenData(buildTripJoinRequestsHeader),
    );

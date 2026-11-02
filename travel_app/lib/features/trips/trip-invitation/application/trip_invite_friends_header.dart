import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../trip-details/application/trip_detail_overview_controller.dart';
import '../../trip-details/data/models/trip_detail_models.dart';

/// Header fields taken from `GET /trips/{id}`.
class TripInviteFriendsHeader {
  const TripInviteFriendsHeader({
    required this.tripName,
    required this.memberCount,
    required this.maxMembers,
    required this.canInvite,
    required this.isOpen,
    required this.memberIds,
    this.viewerUserId,
    this.inviteCode,
  });

  final String tripName;
  final int memberCount;
  final int maxMembers;
  final bool canInvite;
  final bool isOpen;
  final Set<String> memberIds;
  final String? viewerUserId;
  final String? inviteCode;

  int get openSlots => memberCount >= maxMembers ? 0 : maxMembers - memberCount;

  bool get isFull => openSlots == 0;

  Set<String> get excludedUserIds => {...memberIds, ?viewerUserId};
}

TripInviteFriendsHeader buildTripInviteFriendsHeader(TripDetailOverview trip) =>
    TripInviteFriendsHeader(
      tripName: trip.name,
      memberCount: trip.members.length,
      maxMembers: trip.maxMembers,
      canInvite: trip.canInviteMembers,
      isOpen: trip.status == TripDetailStatus.upcoming,
      memberIds: {for (final member in trip.members) member.userId},
      viewerUserId: trip.viewer.userId,
      inviteCode: trip.inviteCode,
    );

final tripInviteFriendsHeaderProvider = Provider.autoDispose
    .family<AsyncValue<TripInviteFriendsHeader>, String>(
      (ref, tripId) => ref
          .watch(tripDetailOverviewControllerProvider(tripId))
          .whenData(buildTripInviteFriendsHeader),
    );

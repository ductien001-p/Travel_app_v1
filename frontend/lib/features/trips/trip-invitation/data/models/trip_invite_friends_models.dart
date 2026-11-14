import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_invite_friends_models.freezed.dart';
part 'trip_invite_friends_models.g.dart';

/// Status of `TripInvitation` on the recommend-friends payload.
@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TripInviteStatus { pending, accepted, rejected, cancelled }

/// Public profile returned by recommend-friends and `GET /users/search`.
@freezed
abstract class TripInviteFriend with _$TripInviteFriend {
  const factory TripInviteFriend({
    required String id,
    required String username,
    @JsonKey(name: 'displayname') required String displayName,
    String? avatarId,
  }) = _TripInviteFriend;

  factory TripInviteFriend.fromJson(Map<String, dynamic> json) =>
      _$TripInviteFriendFromJson(json);
}

/// One row of `GET /trips/recommend-friends/{tripId}` (`data[]`).
///
/// Friends who are already active members are omitted by the backend.
/// [invitationStatus] is null when this trip has no invitation for them.
@freezed
abstract class TripInviteCandidate with _$TripInviteCandidate {
  const factory TripInviteCandidate({
    required TripInviteFriend user,
    @Default(0) int tripsTogetherCount,
    TripInviteStatus? invitationStatus,

    /// Strongest Travel DNA badge, for example `Beach Lover 🏖️`.
    String? travelPersona,

    /// 0–100 fit with this trip. Null when either side has no DNA to compare.
    int? matchScore,

    /// Later of the friendship date and the latest direct message.
    DateTime? lastInteractionAt,
  }) = _TripInviteCandidate;

  factory TripInviteCandidate.fromJson(Map<String, dynamic> json) =>
      _$TripInviteCandidateFromJson(json);
}

/// First page of `GET /users/search`.
@freezed
abstract class TripInviteSearchPage with _$TripInviteSearchPage {
  const factory TripInviteSearchPage({
    required List<TripInviteFriend> users,
    required bool hasNextPage,
  }) = _TripInviteSearchPage;
}

/// `data` of `POST /trip-invitations/invite`.
@freezed
abstract class TripInviteSent with _$TripInviteSent {
  const factory TripInviteSent({
    required String id,
    required String tripId,
    required String inviteeId,
    required TripInviteStatus status,
  }) = _TripInviteSent;

  factory TripInviteSent.fromJson(Map<String, dynamic> json) =>
      _$TripInviteSentFromJson(json);
}

/// `GET /trips/recommend-friends/{tripId}`: the list plus the trip's own DNA.
class TripInviteFriendsPage {
  const TripInviteFriendsPage({
    required this.candidates,
    this.tripTravelPersona,
  });

  final List<TripInviteCandidate> candidates;

  /// Travel DNA this trip leans toward, used on the "Cùng gu" chip.
  final String? tripTravelPersona;
}

extension TripInviteCandidateRules on TripInviteCandidate {
  /// Pending invitations cannot be sent again. Rejected, cancelled, and
  /// accepted-then-left invitations are reopened by the backend.
  bool get canInvite => invitationStatus != TripInviteStatus.pending;
}

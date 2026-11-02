// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_invite_friends_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripInviteFriend _$TripInviteFriendFromJson(Map<String, dynamic> json) =>
    _TripInviteFriend(
      id: json['id'] as String,
      username: json['username'] as String,
      displayName: json['displayname'] as String,
      avatarId: json['avatarId'] as String?,
    );

Map<String, dynamic> _$TripInviteFriendToJson(_TripInviteFriend instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'displayname': instance.displayName,
      'avatarId': instance.avatarId,
    };

_TripInviteCandidate _$TripInviteCandidateFromJson(Map<String, dynamic> json) =>
    _TripInviteCandidate(
      user: TripInviteFriend.fromJson(json['user'] as Map<String, dynamic>),
      tripsTogetherCount: (json['tripsTogetherCount'] as num?)?.toInt() ?? 0,
      invitationStatus: $enumDecodeNullable(
        _$TripInviteStatusEnumMap,
        json['invitationStatus'],
      ),
      travelPersona: json['travelPersona'] as String?,
      matchScore: (json['matchScore'] as num?)?.toInt(),
      lastInteractionAt: json['lastInteractionAt'] == null
          ? null
          : DateTime.parse(json['lastInteractionAt'] as String),
    );

Map<String, dynamic> _$TripInviteCandidateToJson(
  _TripInviteCandidate instance,
) => <String, dynamic>{
  'user': instance.user,
  'tripsTogetherCount': instance.tripsTogetherCount,
  'invitationStatus': _$TripInviteStatusEnumMap[instance.invitationStatus],
  'travelPersona': instance.travelPersona,
  'matchScore': instance.matchScore,
  'lastInteractionAt': instance.lastInteractionAt?.toIso8601String(),
};

const _$TripInviteStatusEnumMap = {
  TripInviteStatus.pending: 'PENDING',
  TripInviteStatus.accepted: 'ACCEPTED',
  TripInviteStatus.rejected: 'REJECTED',
  TripInviteStatus.cancelled: 'CANCELLED',
};

_TripInviteSent _$TripInviteSentFromJson(Map<String, dynamic> json) =>
    _TripInviteSent(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      inviteeId: json['inviteeId'] as String,
      status: $enumDecode(_$TripInviteStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$TripInviteSentToJson(_TripInviteSent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tripId': instance.tripId,
      'inviteeId': instance.inviteeId,
      'status': _$TripInviteStatusEnumMap[instance.status]!,
    };

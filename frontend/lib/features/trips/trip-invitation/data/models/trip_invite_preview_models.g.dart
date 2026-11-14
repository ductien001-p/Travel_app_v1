// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_invite_preview_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripJoinInvitePreview _$TripJoinInvitePreviewFromJson(
  Map<String, dynamic> json,
) => _TripJoinInvitePreview(
  inviteCode: json['inviteCode'] as String?,
  tripId: json['tripId'] as String,
  name: json['name'] as String,
  coverImageUrl: json['coverImageUrl'] as String?,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  ownerDisplayName: json['ownerDisplayName'] as String,
  memberCount: (json['memberCount'] as num).toInt(),
  maxMembers: (json['maxMembers'] as num).toInt(),
  matchScore: (json['matchScore'] as num?)?.toInt(),
);

Map<String, dynamic> _$TripJoinInvitePreviewToJson(
  _TripJoinInvitePreview instance,
) => <String, dynamic>{
  'inviteCode': instance.inviteCode,
  'tripId': instance.tripId,
  'name': instance.name,
  'coverImageUrl': instance.coverImageUrl,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'ownerDisplayName': instance.ownerDisplayName,
  'memberCount': instance.memberCount,
  'maxMembers': instance.maxMembers,
  'matchScore': instance.matchScore,
};

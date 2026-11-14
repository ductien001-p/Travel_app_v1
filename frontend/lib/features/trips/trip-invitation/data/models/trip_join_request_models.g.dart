// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_join_request_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripJoinRequestsPage _$TripJoinRequestsPageFromJson(
  Map<String, dynamic> json,
) => _TripJoinRequestsPage(
  items:
      (json['data'] as List<dynamic>?)
          ?.map((e) => TripJoinRequest.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TripJoinRequest>[],
  meta: TripJoinRequestsMeta.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TripJoinRequestsPageToJson(
  _TripJoinRequestsPage instance,
) => <String, dynamic>{'data': instance.items, 'meta': instance.meta};

_TripJoinRequestsMeta _$TripJoinRequestsMetaFromJson(
  Map<String, dynamic> json,
) => _TripJoinRequestsMeta(
  nextCursor: json['nextCursor'] as String?,
  hasMore: json['hasMore'] as bool? ?? false,
  counts: json['counts'] == null
      ? const TripJoinRequestCounts()
      : TripJoinRequestCounts.fromJson(json['counts'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TripJoinRequestsMetaToJson(
  _TripJoinRequestsMeta instance,
) => <String, dynamic>{
  'nextCursor': instance.nextCursor,
  'hasMore': instance.hasMore,
  'counts': instance.counts,
};

_TripJoinRequestCounts _$TripJoinRequestCountsFromJson(
  Map<String, dynamic> json,
) => _TripJoinRequestCounts(
  pending: (json['pending'] as num?)?.toInt() ?? 0,
  approved: (json['approved'] as num?)?.toInt() ?? 0,
  rejected: (json['rejected'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TripJoinRequestCountsToJson(
  _TripJoinRequestCounts instance,
) => <String, dynamic>{
  'pending': instance.pending,
  'approved': instance.approved,
  'rejected': instance.rejected,
};

_TripJoinRequest _$TripJoinRequestFromJson(Map<String, dynamic> json) =>
    _TripJoinRequest(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      status: $enumDecode(_$TripJoinRequestStatusEnumMap, json['status']),
      requester: TripJoinRequester.fromJson(
        json['requester'] as Map<String, dynamic>,
      ),
      message: json['message'] as String?,
      travelPersona: json['travelPersona'] as String?,
      personaType: $enumDecodeNullable(
        _$TripJoinRequestPersonaTypeEnumMap,
        json['personaType'],
        unknownValue: JsonKey.nullForUndefinedEnumValue,
      ),
      matchScore: (json['matchScore'] as num?)?.toInt(),
      matchNote: json['matchNote'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      decidedAt: json['decidedAt'] == null
          ? null
          : DateTime.parse(json['decidedAt'] as String),
    );

Map<String, dynamic> _$TripJoinRequestToJson(_TripJoinRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tripId': instance.tripId,
      'status': _$TripJoinRequestStatusEnumMap[instance.status]!,
      'requester': instance.requester,
      'message': instance.message,
      'travelPersona': instance.travelPersona,
      'personaType': _$TripJoinRequestPersonaTypeEnumMap[instance.personaType],
      'matchScore': instance.matchScore,
      'matchNote': instance.matchNote,
      'createdAt': instance.createdAt.toIso8601String(),
      'decidedAt': instance.decidedAt?.toIso8601String(),
    };

const _$TripJoinRequestStatusEnumMap = {
  TripJoinRequestStatus.pending: 'PENDING',
  TripJoinRequestStatus.approved: 'APPROVED',
  TripJoinRequestStatus.rejected: 'REJECTED',
};

const _$TripJoinRequestPersonaTypeEnumMap = {
  TripJoinRequestPersonaType.soloTraveler: 'SOLO_TRAVELER',
  TripJoinRequestPersonaType.familyTraveler: 'FAMILY_TRAVELER',
  TripJoinRequestPersonaType.coupleTraveller: 'COUPLE_TRAVELLER',
  TripJoinRequestPersonaType.groupTraveler: 'GROUP_TRAVELER',
  TripJoinRequestPersonaType.backpacker: 'BACKPACKER',
  TripJoinRequestPersonaType.mountainLover: 'MOUNTAIN_LOVER',
  TripJoinRequestPersonaType.beachLover: 'BEACH_LOVER',
  TripJoinRequestPersonaType.adventureTraveler: 'ADVENTURE_TRAVELER',
  TripJoinRequestPersonaType.foodieTraveler: 'FOODIE_TRAVELER',
  TripJoinRequestPersonaType.cultureTraveler: 'CULTURE_TRAVELER',
  TripJoinRequestPersonaType.entertainmentTraveller: 'ENTERTAINMENT_TRAVELLER',
  TripJoinRequestPersonaType.photographyLover: 'PHOTOGRAPHY_LOVER',
};

_TripJoinRequester _$TripJoinRequesterFromJson(Map<String, dynamic> json) =>
    _TripJoinRequester(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
      isOnline: json['isOnline'] as bool? ?? false,
    );

Map<String, dynamic> _$TripJoinRequesterToJson(_TripJoinRequester instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
      'isVerified': instance.isVerified,
      'isOnline': instance.isOnline,
    };

_TripJoinRequestSettings _$TripJoinRequestSettingsFromJson(
  Map<String, dynamic> json,
) => _TripJoinRequestSettings(
  autoApproveFriends: json['autoApproveFriends'] as bool? ?? false,
);

Map<String, dynamic> _$TripJoinRequestSettingsToJson(
  _TripJoinRequestSettings instance,
) => <String, dynamic>{'autoApproveFriends': instance.autoApproveFriends};

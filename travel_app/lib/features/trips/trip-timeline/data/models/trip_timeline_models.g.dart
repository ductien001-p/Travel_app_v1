// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_timeline_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripTimelinePage _$TripTimelinePageFromJson(Map<String, dynamic> json) =>
    _TripTimelinePage(
      items:
          (json['data'] as List<dynamic>?)
              ?.map(
                (e) => TripTimelineEntry.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <TripTimelineEntry>[],
      meta: TripTimelineCursor.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TripTimelinePageToJson(_TripTimelinePage instance) =>
    <String, dynamic>{'data': instance.items, 'meta': instance.meta};

_TripTimelineCursor _$TripTimelineCursorFromJson(Map<String, dynamic> json) =>
    _TripTimelineCursor(
      nextCursor: json['nextCursor'] as String?,
      hasMore: json['hasMore'] as bool? ?? false,
      counts: json['counts'] == null
          ? null
          : TripTimelineCounts.fromJson(json['counts'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TripTimelineCursorToJson(_TripTimelineCursor instance) =>
    <String, dynamic>{
      'nextCursor': instance.nextCursor,
      'hasMore': instance.hasMore,
      'counts': instance.counts,
    };

_TripTimelineCounts _$TripTimelineCountsFromJson(Map<String, dynamic> json) =>
    _TripTimelineCounts(
      all: (json['all'] as num?)?.toInt() ?? 0,
      checkin: (json['checkin'] as num?)?.toInt() ?? 0,
      expense: (json['expense'] as num?)?.toInt() ?? 0,
      memory: (json['memory'] as num?)?.toInt() ?? 0,
      member: (json['member'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TripTimelineCountsToJson(_TripTimelineCounts instance) =>
    <String, dynamic>{
      'all': instance.all,
      'checkin': instance.checkin,
      'expense': instance.expense,
      'memory': instance.memory,
      'member': instance.member,
    };

_TripTimelineEntry _$TripTimelineEntryFromJson(Map<String, dynamic> json) =>
    _TripTimelineEntry(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      memberId: json['memberId'] as String,
      type: $enumDecode(
        _$TripTimelineEntryTypeEnumMap,
        json['type'],
        unknownValue: TripTimelineEntryType.system,
      ),
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      member: TripTimelineEntryMember.fromJson(
        json['member'] as Map<String, dynamic>,
      ),
      targetType: $enumDecodeNullable(
        _$TripTimelineTargetTypeEnumMap,
        json['targetType'],
        unknownValue: JsonKey.nullForUndefinedEnumValue,
      ),
      targetId: json['targetId'] as String?,
      metadata: json['metadata'] == null
          ? null
          : TripTimelineEntryMetadata.fromJson(
              json['metadata'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$TripTimelineEntryToJson(_TripTimelineEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tripId': instance.tripId,
      'memberId': instance.memberId,
      'type': _$TripTimelineEntryTypeEnumMap[instance.type]!,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'member': instance.member,
      'targetType': _$TripTimelineTargetTypeEnumMap[instance.targetType],
      'targetId': instance.targetId,
      'metadata': instance.metadata,
    };

const _$TripTimelineEntryTypeEnumMap = {
  TripTimelineEntryType.tripCreated: 'TRIP_CREATED',
  TripTimelineEntryType.memberJoined: 'MEMBER_JOINED',
  TripTimelineEntryType.memberLeft: 'MEMBER_LEFT',
  TripTimelineEntryType.memberKicked: 'MEMBER_KICKED',
  TripTimelineEntryType.activityAdded: 'ACTIVITY_ADDED',
  TripTimelineEntryType.activityUpdated: 'ACTIVITY_UPDATED',
  TripTimelineEntryType.activityDeleted: 'ACTIVITY_DELETED',
  TripTimelineEntryType.activityCheckin: 'ACTIVITY_CHECKIN',
  TripTimelineEntryType.expenseCreated: 'EXPENSE_CREATED',
  TripTimelineEntryType.expenseSettled: 'EXPENSE_SETTLED',
  TripTimelineEntryType.photoAdded: 'PHOTO_ADDED',
  TripTimelineEntryType.memoryAdded: 'MEMORY_ADDED',
  TripTimelineEntryType.memoryDeleted: 'MEMORY_DELETED',
  TripTimelineEntryType.system: 'SYSTEM',
};

const _$TripTimelineTargetTypeEnumMap = {
  TripTimelineTargetType.trip: 'TRIP',
  TripTimelineTargetType.member: 'MEMBER',
  TripTimelineTargetType.activity: 'ACTIVITY',
  TripTimelineTargetType.expense: 'EXPENSE',
  TripTimelineTargetType.memory: 'MEMORY',
};

_TripTimelineEntryMember _$TripTimelineEntryMemberFromJson(
  Map<String, dynamic> json,
) => _TripTimelineEntryMember(
  id: json['id'] as String,
  user: TripTimelineEntryUser.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TripTimelineEntryMemberToJson(
  _TripTimelineEntryMember instance,
) => <String, dynamic>{'id': instance.id, 'user': instance.user};

_TripTimelineEntryUser _$TripTimelineEntryUserFromJson(
  Map<String, dynamic> json,
) => _TripTimelineEntryUser(
  id: json['id'] as String,
  username: json['username'] as String,
  displayName: json['displayName'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
);

Map<String, dynamic> _$TripTimelineEntryUserToJson(
  _TripTimelineEntryUser instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'displayName': instance.displayName,
  'avatarUrl': instance.avatarUrl,
};

_TripTimelineEntryMetadata _$TripTimelineEntryMetadataFromJson(
  Map<String, dynamic> json,
) => _TripTimelineEntryMetadata(
  tripName: json['tripName'] as String?,
  startDate: json['startDate'] == null
      ? null
      : DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  destinationCount: (json['destinationCount'] as num?)?.toInt(),
  via: $enumDecodeNullable(
    _$TripTimelineJoinViaEnumMap,
    json['via'],
    unknownValue: JsonKey.nullForUndefinedEnumValue,
  ),
  targetMemberId: json['targetMemberId'] as String?,
  targetName: json['targetName'] as String?,
  activityTitle: json['activityTitle'] as String?,
  placeName: json['placeName'] as String?,
  placeArea: json['placeArea'] as String?,
  dayNumber: (json['dayNumber'] as num?)?.toInt(),
  startTime: json['startTime'] == null
      ? null
      : DateTime.parse(json['startTime'] as String),
  previousStartTime: json['previousStartTime'] == null
      ? null
      : DateTime.parse(json['previousStartTime'] as String),
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  imageUrl: json['imageUrl'] as String?,
  verified: json['verified'] as bool? ?? false,
  pointsEarned: (json['pointsEarned'] as num?)?.toInt(),
  amount: _moneyFromJson(json['amount']),
  currency: json['currency'] as String? ?? 'VND',
  category: json['category'] as String?,
  description: json['description'] as String?,
  splitType: $enumDecodeNullable(
    _$TripTimelineSplitTypeEnumMap,
    json['splitType'],
    unknownValue: JsonKey.nullForUndefinedEnumValue,
  ),
  splitCount: (json['splitCount'] as num?)?.toInt(),
  payerMemberId: json['payerMemberId'] as String?,
  payerName: json['payerName'] as String?,
  debtorMemberId: json['debtorMemberId'] as String?,
  debtorName: json['debtorName'] as String?,
  memoryIds:
      (json['memoryIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  photoUrls:
      (json['photoUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  photoCount: (json['photoCount'] as num?)?.toInt(),
  caption: json['caption'] as String?,
);

Map<String, dynamic> _$TripTimelineEntryMetadataToJson(
  _TripTimelineEntryMetadata instance,
) => <String, dynamic>{
  'tripName': instance.tripName,
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'destinationCount': instance.destinationCount,
  'via': _$TripTimelineJoinViaEnumMap[instance.via],
  'targetMemberId': instance.targetMemberId,
  'targetName': instance.targetName,
  'activityTitle': instance.activityTitle,
  'placeName': instance.placeName,
  'placeArea': instance.placeArea,
  'dayNumber': instance.dayNumber,
  'startTime': instance.startTime?.toIso8601String(),
  'previousStartTime': instance.previousStartTime?.toIso8601String(),
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'imageUrl': instance.imageUrl,
  'verified': instance.verified,
  'pointsEarned': instance.pointsEarned,
  'amount': instance.amount,
  'currency': instance.currency,
  'category': instance.category,
  'description': instance.description,
  'splitType': _$TripTimelineSplitTypeEnumMap[instance.splitType],
  'splitCount': instance.splitCount,
  'payerMemberId': instance.payerMemberId,
  'payerName': instance.payerName,
  'debtorMemberId': instance.debtorMemberId,
  'debtorName': instance.debtorName,
  'memoryIds': instance.memoryIds,
  'photoUrls': instance.photoUrls,
  'photoCount': instance.photoCount,
  'caption': instance.caption,
};

const _$TripTimelineJoinViaEnumMap = {
  TripTimelineJoinVia.inviteCode: 'INVITE_CODE',
  TripTimelineJoinVia.invitation: 'INVITATION',
  TripTimelineJoinVia.joinRequest: 'JOIN_REQUEST',
};

const _$TripTimelineSplitTypeEnumMap = {
  TripTimelineSplitType.equal: 'EQUAL',
  TripTimelineSplitType.custom: 'CUSTOM',
};

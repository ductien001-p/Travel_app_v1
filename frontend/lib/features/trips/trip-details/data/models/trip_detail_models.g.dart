// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_detail_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripDetailOverview _$TripDetailOverviewFromJson(Map<String, dynamic> json) =>
    _TripDetailOverview(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      status: $enumDecode(_$TripDetailStatusEnumMap, json['status']),
      visibility: $enumDecode(
        _$TripDetailVisibilityEnumMap,
        json['visibility'],
      ),
      tripType: $enumDecode(_$TripDetailTypeEnumMap, json['tripType']),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      maxMembers: (json['maxMembers'] as num).toInt(),
      budgetLevel: $enumDecodeNullable(
        _$TripDetailBudgetLevelEnumMap,
        json['budgetLevel'],
      ),
      inviteCode: json['inviteCode'] as String?,
      viewer: TripDetailViewer.fromJson(json['viewer'] as Map<String, dynamic>),
      expenseSummary: json['expenseSummary'] == null
          ? null
          : TripDetailExpenseSummary.fromJson(
              json['expenseSummary'] as Map<String, dynamic>,
            ),
      checkinProgress: TripDetailCheckinProgress.fromJson(
        json['checkinProgress'] as Map<String, dynamic>,
      ),
      members:
          (json['members'] as List<dynamic>?)
              ?.map((e) => TripDetailMember.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TripDetailMember>[],
      destinations:
          (json['destinations'] as List<dynamic>?)
              ?.map(
                (e) =>
                    TripDetailDestination.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <TripDetailDestination>[],
      nextActivity: json['nextActivity'] == null
          ? null
          : TripDetailNextActivity.fromJson(
              json['nextActivity'] as Map<String, dynamic>,
            ),
      requirements: json['requirements'] as String?,
      estimatedBudgetPerPerson: json['estimatedBudgetPerPerson'] as String?,
      slotsRemaining: (json['slotsRemaining'] as num?)?.toInt(),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      memories: json['memories'] == null
          ? null
          : TripDetailMemoriesPreview.fromJson(
              json['memories'] as Map<String, dynamic>,
            ),
      completionReward: json['completionReward'] == null
          ? null
          : TripDetailCompletionReward.fromJson(
              json['completionReward'] as Map<String, dynamic>,
            ),
      timeline: json['timeline'] == null
          ? null
          : TripDetailTimelinePreview.fromJson(
              json['timeline'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$TripDetailOverviewToJson(_TripDetailOverview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'coverImageUrl': instance.coverImageUrl,
      'status': _$TripDetailStatusEnumMap[instance.status]!,
      'visibility': _$TripDetailVisibilityEnumMap[instance.visibility]!,
      'tripType': _$TripDetailTypeEnumMap[instance.tripType]!,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'maxMembers': instance.maxMembers,
      'budgetLevel': _$TripDetailBudgetLevelEnumMap[instance.budgetLevel],
      'inviteCode': instance.inviteCode,
      'viewer': instance.viewer,
      'expenseSummary': instance.expenseSummary,
      'checkinProgress': instance.checkinProgress,
      'members': instance.members,
      'destinations': instance.destinations,
      'nextActivity': instance.nextActivity,
      'requirements': instance.requirements,
      'estimatedBudgetPerPerson': instance.estimatedBudgetPerPerson,
      'slotsRemaining': instance.slotsRemaining,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'memories': instance.memories,
      'completionReward': instance.completionReward,
      'timeline': instance.timeline,
    };

const _$TripDetailStatusEnumMap = {
  TripDetailStatus.draft: 'DRAFT',
  TripDetailStatus.upcoming: 'UPCOMING',
  TripDetailStatus.ongoing: 'ONGOING',
  TripDetailStatus.completed: 'COMPLETED',
  TripDetailStatus.cancelled: 'CANCELLED',
  TripDetailStatus.notCompleted: 'NOTCOMPLETED',
};

const _$TripDetailVisibilityEnumMap = {
  TripDetailVisibility.public: 'PUBLIC',
  TripDetailVisibility.private: 'PRIVATE',
};

const _$TripDetailTypeEnumMap = {
  TripDetailType.solo: 'SOLO',
  TripDetailType.couple: 'COUPLE',
  TripDetailType.family: 'FAMILY',
  TripDetailType.friends: 'FRIENDS',
  TripDetailType.backpacker: 'BACKPACKER',
  TripDetailType.other: 'OTHER',
};

const _$TripDetailBudgetLevelEnumMap = {
  TripDetailBudgetLevel.low: 'LOW',
  TripDetailBudgetLevel.medium: 'MEDIUM',
  TripDetailBudgetLevel.high: 'HIGH',
};

_TripDetailViewer _$TripDetailViewerFromJson(Map<String, dynamic> json) =>
    _TripDetailViewer(
      userId: json['userId'] as String,
      role: $enumDecodeNullable(_$TripDetailMemberRoleEnumMap, json['role']),
    );

Map<String, dynamic> _$TripDetailViewerToJson(_TripDetailViewer instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'role': _$TripDetailMemberRoleEnumMap[instance.role],
    };

const _$TripDetailMemberRoleEnumMap = {
  TripDetailMemberRole.owner: 'OWNER',
  TripDetailMemberRole.admin: 'ADMIN',
  TripDetailMemberRole.member: 'MEMBER',
};

_TripDetailExpenseSummary _$TripDetailExpenseSummaryFromJson(
  Map<String, dynamic> json,
) => _TripDetailExpenseSummary(
  totalAmount: (json['totalAmount'] as num).toDouble(),
  currency: json['currency'] as String? ?? 'VND',
);

Map<String, dynamic> _$TripDetailExpenseSummaryToJson(
  _TripDetailExpenseSummary instance,
) => <String, dynamic>{
  'totalAmount': instance.totalAmount,
  'currency': instance.currency,
};

_TripDetailCheckinProgress _$TripDetailCheckinProgressFromJson(
  Map<String, dynamic> json,
) => _TripDetailCheckinProgress(
  completedCount: (json['completedCount'] as num).toInt(),
  totalCount: (json['totalCount'] as num).toInt(),
  pointsEarned: (json['pointsEarned'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TripDetailCheckinProgressToJson(
  _TripDetailCheckinProgress instance,
) => <String, dynamic>{
  'completedCount': instance.completedCount,
  'totalCount': instance.totalCount,
  'pointsEarned': instance.pointsEarned,
};

_TripDetailMember _$TripDetailMemberFromJson(Map<String, dynamic> json) =>
    _TripDetailMember(
      id: json['id'] as String,
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      role: $enumDecode(_$TripDetailMemberRoleEnumMap, json['role']),
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      travelPersona: json['travelPersona'] as String?,
      activityNote: json['activityNote'] as String?,
      isOnline: json['isOnline'] as bool? ?? false,
      isNewMember: json['isNewMember'] as bool? ?? false,
      amountSpent: (json['amountSpent'] as num?)?.toDouble(),
      memoryCount: (json['memoryCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TripDetailMemberToJson(_TripDetailMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'role': _$TripDetailMemberRoleEnumMap[instance.role]!,
      'joinedAt': instance.joinedAt.toIso8601String(),
      'travelPersona': instance.travelPersona,
      'activityNote': instance.activityNote,
      'isOnline': instance.isOnline,
      'isNewMember': instance.isNewMember,
      'amountSpent': instance.amountSpent,
      'memoryCount': instance.memoryCount,
    };

_TripDetailDestination _$TripDetailDestinationFromJson(
  Map<String, dynamic> json,
) => _TripDetailDestination(
  id: json['id'] as String,
  city: json['city'] as String,
  country: json['country'] as String,
  order: (json['order'] as num).toInt(),
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  isCurrent: json['isCurrent'] as bool? ?? false,
);

Map<String, dynamic> _$TripDetailDestinationToJson(
  _TripDetailDestination instance,
) => <String, dynamic>{
  'id': instance.id,
  'city': instance.city,
  'country': instance.country,
  'order': instance.order,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'isCurrent': instance.isCurrent,
};

_TripDetailNextActivity _$TripDetailNextActivityFromJson(
  Map<String, dynamic> json,
) => _TripDetailNextActivity(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  startTime: DateTime.parse(json['startTime'] as String),
  confirmedCount: (json['confirmedCount'] as num?)?.toInt() ?? 0,
  totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TripDetailNextActivityToJson(
  _TripDetailNextActivity instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'startTime': instance.startTime.toIso8601String(),
  'confirmedCount': instance.confirmedCount,
  'totalCount': instance.totalCount,
};

_TripDetailMemoriesPreview _$TripDetailMemoriesPreviewFromJson(
  Map<String, dynamic> json,
) => _TripDetailMemoriesPreview(
  totalCount: (json['totalCount'] as num).toInt(),
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => TripDetailMemory.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TripDetailMemory>[],
);

Map<String, dynamic> _$TripDetailMemoriesPreviewToJson(
  _TripDetailMemoriesPreview instance,
) => <String, dynamic>{
  'totalCount': instance.totalCount,
  'items': instance.items,
};

_TripDetailMemory _$TripDetailMemoryFromJson(Map<String, dynamic> json) =>
    _TripDetailMemory(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      caption: json['caption'] as String?,
      authorName: json['authorName'] as String?,
    );

Map<String, dynamic> _$TripDetailMemoryToJson(_TripDetailMemory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'caption': instance.caption,
      'authorName': instance.authorName,
    };

_TripDetailCompletionReward _$TripDetailCompletionRewardFromJson(
  Map<String, dynamic> json,
) => _TripDetailCompletionReward(
  points: (json['points'] as num).toInt(),
  canClaim: json['canClaim'] as bool? ?? false,
  claimed: json['claimed'] as bool? ?? false,
);

Map<String, dynamic> _$TripDetailCompletionRewardToJson(
  _TripDetailCompletionReward instance,
) => <String, dynamic>{
  'points': instance.points,
  'canClaim': instance.canClaim,
  'claimed': instance.claimed,
};

_TripDetailTimelinePreview _$TripDetailTimelinePreviewFromJson(
  Map<String, dynamic> json,
) => _TripDetailTimelinePreview(
  totalCount: (json['totalCount'] as num).toInt(),
  items:
      (json['items'] as List<dynamic>?)
          ?.map(
            (e) => TripDetailTimelineEvent.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <TripDetailTimelineEvent>[],
);

Map<String, dynamic> _$TripDetailTimelinePreviewToJson(
  _TripDetailTimelinePreview instance,
) => <String, dynamic>{
  'totalCount': instance.totalCount,
  'items': instance.items,
};

_TripDetailTimelineEvent _$TripDetailTimelineEventFromJson(
  Map<String, dynamic> json,
) => _TripDetailTimelineEvent(
  id: json['id'] as String,
  type: $enumDecode(
    _$TripDetailEventTypeEnumMap,
    json['type'],
    unknownValue: TripDetailEventType.system,
  ),
  actorName: json['actorName'] as String,
  actorAvatarUrl: json['actorAvatarUrl'] as String?,
  content: json['content'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$TripDetailTimelineEventToJson(
  _TripDetailTimelineEvent instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': _$TripDetailEventTypeEnumMap[instance.type]!,
  'actorName': instance.actorName,
  'actorAvatarUrl': instance.actorAvatarUrl,
  'content': instance.content,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$TripDetailEventTypeEnumMap = {
  TripDetailEventType.tripCreated: 'TRIP_CREATED',
  TripDetailEventType.memberJoined: 'MEMBER_JOINED',
  TripDetailEventType.memberLeft: 'MEMBER_LEFT',
  TripDetailEventType.memberKicked: 'MEMBER_KICKED',
  TripDetailEventType.activityAdded: 'ACTIVITY_ADDED',
  TripDetailEventType.activityUpdated: 'ACTIVITY_UPDATED',
  TripDetailEventType.activityDeleted: 'ACTIVITY_DELETED',
  TripDetailEventType.activityCheckin: 'ACTIVITY_CHECKIN',
  TripDetailEventType.expenseCreated: 'EXPENSE_CREATED',
  TripDetailEventType.expenseSettled: 'EXPENSE_SETTLED',
  TripDetailEventType.photoAdded: 'PHOTO_ADDED',
  TripDetailEventType.memoryAdded: 'MEMORY_ADDED',
  TripDetailEventType.memoryDeleted: 'MEMORY_DELETED',
  TripDetailEventType.system: 'SYSTEM',
};

_TripDetailRewardClaim _$TripDetailRewardClaimFromJson(
  Map<String, dynamic> json,
) => _TripDetailRewardClaim(
  tripId: json['tripId'] as String?,
  pointsAwarded: (json['pointsAwarded'] as num).toInt(),
  basePoints: (json['basePoints'] as num?)?.toInt() ?? 0,
  missionPoints: (json['missionPoints'] as num?)?.toInt() ?? 0,
  multiplierUsed: (json['multiplierUsed'] as num?)?.toDouble() ?? 1.0,
  missionsCompleted: (json['missionsCompleted'] as num?)?.toInt() ?? 0,
  totalCheckins: (json['totalCheckins'] as num?)?.toInt() ?? 0,
  totalPlaces: (json['totalPlaces'] as num?)?.toInt() ?? 0,
  completionPercent: (json['completionPercent'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TripDetailRewardClaimToJson(
  _TripDetailRewardClaim instance,
) => <String, dynamic>{
  'tripId': instance.tripId,
  'pointsAwarded': instance.pointsAwarded,
  'basePoints': instance.basePoints,
  'missionPoints': instance.missionPoints,
  'multiplierUsed': instance.multiplierUsed,
  'missionsCompleted': instance.missionsCompleted,
  'totalCheckins': instance.totalCheckins,
  'totalPlaces': instance.totalPlaces,
  'completionPercent': instance.completionPercent,
};

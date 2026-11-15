// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_chat_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripChatThread _$TripChatThreadFromJson(Map<String, dynamic> json) =>
    _TripChatThread(
      tripId: json['tripId'] as String,
      title: json['title'] as String,
      memberSummaryLabel: json['memberSummaryLabel'] as String,
      isLive: json['isLive'] as bool? ?? true,
      pinnedActivity: json['pinnedActivity'] == null
          ? null
          : TripChatPinnedActivity.fromJson(
              json['pinnedActivity'] as Map<String, dynamic>,
            ),
      dateLabel: json['dateLabel'] as String,
      messages:
          (json['messages'] as List<dynamic>?)
              ?.map((e) => TripChatMessage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TripChatMessage>[],
      isSomeoneTyping: json['isSomeoneTyping'] as bool? ?? false,
      typingLabel: json['typingLabel'] as String?,
      typingAvatarUrl: json['typingAvatarUrl'] as String?,
      utilities:
          (json['utilities'] as List<dynamic>?)
              ?.map((e) => TripChatUtility.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TripChatUtility>[],
    );

Map<String, dynamic> _$TripChatThreadToJson(_TripChatThread instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'title': instance.title,
      'memberSummaryLabel': instance.memberSummaryLabel,
      'isLive': instance.isLive,
      'pinnedActivity': instance.pinnedActivity,
      'dateLabel': instance.dateLabel,
      'messages': instance.messages,
      'isSomeoneTyping': instance.isSomeoneTyping,
      'typingLabel': instance.typingLabel,
      'typingAvatarUrl': instance.typingAvatarUrl,
      'utilities': instance.utilities,
    };

_TripChatPinnedActivity _$TripChatPinnedActivityFromJson(
  Map<String, dynamic> json,
) => _TripChatPinnedActivity(
  badgeLabel: json['badgeLabel'] as String,
  dayChipLabel: json['dayChipLabel'] as String?,
  title: json['title'] as String,
  checkInLabel: json['checkInLabel'] as String?,
  itineraryDayId: json['itineraryDayId'] as String?,
);

Map<String, dynamic> _$TripChatPinnedActivityToJson(
  _TripChatPinnedActivity instance,
) => <String, dynamic>{
  'badgeLabel': instance.badgeLabel,
  'dayChipLabel': instance.dayChipLabel,
  'title': instance.title,
  'checkInLabel': instance.checkInLabel,
  'itineraryDayId': instance.itineraryDayId,
};

_TripChatSender _$TripChatSenderFromJson(Map<String, dynamic> json) =>
    _TripChatSender(
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      roleBadge: json['roleBadge'] as String?,
      roleTone:
          $enumDecodeNullable(_$TripChatRoleToneEnumMap, json['roleTone']) ??
          TripChatRoleTone.member,
      isLeader: json['isLeader'] as bool? ?? false,
    );

Map<String, dynamic> _$TripChatSenderToJson(_TripChatSender instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'roleBadge': instance.roleBadge,
      'roleTone': _$TripChatRoleToneEnumMap[instance.roleTone]!,
      'isLeader': instance.isLeader,
    };

const _$TripChatRoleToneEnumMap = {
  TripChatRoleTone.leader: 'LEADER',
  TripChatRoleTone.photographer: 'PHOTOGRAPHER',
  TripChatRoleTone.treasurer: 'TREASURER',
  TripChatRoleTone.member: 'MEMBER',
};

_TripChatMessage _$TripChatMessageFromJson(
  Map<String, dynamic> json,
) => _TripChatMessage(
  id: json['id'] as String,
  kind: $enumDecode(_$TripChatMessageKindEnumMap, json['kind']),
  isMine: json['isMine'] as bool? ?? false,
  text: json['text'] as String?,
  timeLabel: json['timeLabel'] as String,
  readStatus: $enumDecodeNullable(
    _$TripChatReadStatusEnumMap,
    json['readStatus'],
  ),
  showAvatar: json['showAvatar'] as bool? ?? true,
  sender: json['sender'] == null
      ? null
      : TripChatSender.fromJson(json['sender'] as Map<String, dynamic>),
  system: json['system'] == null
      ? null
      : TripChatSystemPayload.fromJson(json['system'] as Map<String, dynamic>),
  photo: json['photo'] == null
      ? null
      : TripChatPhotoPayload.fromJson(json['photo'] as Map<String, dynamic>),
  expense: json['expense'] == null
      ? null
      : TripChatExpensePayload.fromJson(
          json['expense'] as Map<String, dynamic>,
        ),
  reactions:
      (json['reactions'] as List<dynamic>?)
          ?.map((e) => TripChatReaction.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TripChatReaction>[],
);

Map<String, dynamic> _$TripChatMessageToJson(_TripChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': _$TripChatMessageKindEnumMap[instance.kind]!,
      'isMine': instance.isMine,
      'text': instance.text,
      'timeLabel': instance.timeLabel,
      'readStatus': _$TripChatReadStatusEnumMap[instance.readStatus],
      'showAvatar': instance.showAvatar,
      'sender': instance.sender,
      'system': instance.system,
      'photo': instance.photo,
      'expense': instance.expense,
      'reactions': instance.reactions,
    };

const _$TripChatMessageKindEnumMap = {
  TripChatMessageKind.system: 'SYSTEM',
  TripChatMessageKind.text: 'TEXT',
  TripChatMessageKind.photo: 'PHOTO',
  TripChatMessageKind.expense: 'EXPENSE',
};

const _$TripChatReadStatusEnumMap = {
  TripChatReadStatus.sent: 'SENT',
  TripChatReadStatus.delivered: 'DELIVERED',
  TripChatReadStatus.read: 'READ',
};

_TripChatSystemPayload _$TripChatSystemPayloadFromJson(
  Map<String, dynamic> json,
) => _TripChatSystemPayload(
  icon: json['icon'] as String,
  richText: json['richText'] as String,
);

Map<String, dynamic> _$TripChatSystemPayloadToJson(
  _TripChatSystemPayload instance,
) => <String, dynamic>{'icon': instance.icon, 'richText': instance.richText};

_TripChatPhotoPayload _$TripChatPhotoPayloadFromJson(
  Map<String, dynamic> json,
) => _TripChatPhotoPayload(
  imageUrl: json['imageUrl'] as String,
  caption: json['caption'] as String?,
  locationLabel: json['locationLabel'] as String?,
  reactions:
      (json['reactions'] as List<dynamic>?)
          ?.map((e) => TripChatReaction.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TripChatReaction>[],
);

Map<String, dynamic> _$TripChatPhotoPayloadToJson(
  _TripChatPhotoPayload instance,
) => <String, dynamic>{
  'imageUrl': instance.imageUrl,
  'caption': instance.caption,
  'locationLabel': instance.locationLabel,
  'reactions': instance.reactions,
};

_TripChatReaction _$TripChatReactionFromJson(Map<String, dynamic> json) =>
    _TripChatReaction(
      emoji: json['emoji'] as String,
      count: _readInt(json['count']),
    );

Map<String, dynamic> _$TripChatReactionToJson(_TripChatReaction instance) =>
    <String, dynamic>{'emoji': instance.emoji, 'count': instance.count};

_TripChatExpensePayload _$TripChatExpensePayloadFromJson(
  Map<String, dynamic> json,
) => _TripChatExpensePayload(
  expenseId: json['expenseId'] as String,
  title: json['title'] as String,
  subtitle: json['subtitle'] as String,
  amountLabel: json['amountLabel'] as String,
  splitLabel: json['splitLabel'] as String,
  perPersonLabel: json['perPersonLabel'] as String,
  actionLabel: json['actionLabel'] as String?,
);

Map<String, dynamic> _$TripChatExpensePayloadToJson(
  _TripChatExpensePayload instance,
) => <String, dynamic>{
  'expenseId': instance.expenseId,
  'title': instance.title,
  'subtitle': instance.subtitle,
  'amountLabel': instance.amountLabel,
  'splitLabel': instance.splitLabel,
  'perPersonLabel': instance.perPersonLabel,
  'actionLabel': instance.actionLabel,
};

_TripChatUtility _$TripChatUtilityFromJson(Map<String, dynamic> json) =>
    _TripChatUtility(
      kind: $enumDecode(_$TripChatUtilityKindEnumMap, json['kind']),
      label: json['label'] as String,
    );

Map<String, dynamic> _$TripChatUtilityToJson(_TripChatUtility instance) =>
    <String, dynamic>{
      'kind': _$TripChatUtilityKindEnumMap[instance.kind]!,
      'label': instance.label,
    };

const _$TripChatUtilityKindEnumMap = {
  TripChatUtilityKind.liveLocation: 'LIVE_LOCATION',
  TripChatUtilityKind.splitBill: 'SPLIT_BILL',
  TripChatUtilityKind.album: 'ALBUM',
  TripChatUtilityKind.addStop: 'ADD_STOP',
};

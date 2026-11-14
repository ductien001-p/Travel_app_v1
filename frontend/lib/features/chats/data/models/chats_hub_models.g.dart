// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats_hub_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatsHub _$ChatsHubFromJson(Map<String, dynamic> json) => _ChatsHub(
  viewer: ChatsHubViewer.fromJson(json['viewer'] as Map<String, dynamic>),
  totalThreadCount: _readInt(json['totalThreadCount']),
  hasUnread: json['hasUnread'] as bool? ?? false,
  activeTripPulse: json['activeTripPulse'] == null
      ? null
      : ChatsActiveTripPulse.fromJson(
          json['activeTripPulse'] as Map<String, dynamic>,
        ),
  tripThreads:
      (json['tripThreads'] as List<dynamic>?)
          ?.map((e) => ChatsTripThread.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ChatsTripThread>[],
  friendThreads:
      (json['friendThreads'] as List<dynamic>?)
          ?.map((e) => ChatsFriendThread.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ChatsFriendThread>[],
);

Map<String, dynamic> _$ChatsHubToJson(_ChatsHub instance) => <String, dynamic>{
  'viewer': instance.viewer,
  'totalThreadCount': instance.totalThreadCount,
  'hasUnread': instance.hasUnread,
  'activeTripPulse': instance.activeTripPulse,
  'tripThreads': instance.tripThreads,
  'friendThreads': instance.friendThreads,
};

_ChatsHubViewer _$ChatsHubViewerFromJson(Map<String, dynamic> json) =>
    _ChatsHubViewer(
      displayName: json['displayName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      isOnline: json['isOnline'] as bool? ?? false,
    );

Map<String, dynamic> _$ChatsHubViewerToJson(_ChatsHubViewer instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'isOnline': instance.isOnline,
    };

_ChatsActiveTripPulse _$ChatsActiveTripPulseFromJson(
  Map<String, dynamic> json,
) => _ChatsActiveTripPulse(
  tripId: json['tripId'] as String,
  title: json['title'] as String,
  statusLabel: json['statusLabel'] as String,
  onlineMemberCount: _readInt(json['onlineMemberCount']),
  memberCapacity: _readInt(json['memberCapacity']),
  memberAvatars:
      (json['memberAvatars'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  extraMemberCount: json['extraMemberCount'] == null
      ? 0
      : _readInt(json['extraMemberCount']),
  pinnedSenderName: json['pinnedSenderName'] as String,
  pinnedMessage: json['pinnedMessage'] as String,
  pinnedTimeLabel: json['pinnedTimeLabel'] as String,
  newExchangeCount: json['newExchangeCount'] == null
      ? 0
      : _readInt(json['newExchangeCount']),
);

Map<String, dynamic> _$ChatsActiveTripPulseToJson(
  _ChatsActiveTripPulse instance,
) => <String, dynamic>{
  'tripId': instance.tripId,
  'title': instance.title,
  'statusLabel': instance.statusLabel,
  'onlineMemberCount': instance.onlineMemberCount,
  'memberCapacity': instance.memberCapacity,
  'memberAvatars': instance.memberAvatars,
  'extraMemberCount': instance.extraMemberCount,
  'pinnedSenderName': instance.pinnedSenderName,
  'pinnedMessage': instance.pinnedMessage,
  'pinnedTimeLabel': instance.pinnedTimeLabel,
  'newExchangeCount': instance.newExchangeCount,
};

_ChatsTripThread _$ChatsTripThreadFromJson(Map<String, dynamic> json) =>
    _ChatsTripThread(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      title: json['title'] as String,
      coverUrl: json['coverUrl'] as String,
      badgeIcon: json['badgeIcon'] as String,
      status: $enumDecode(_$ChatsTripThreadStatusEnumMap, json['status']),
      memberCount: _readInt(json['memberCount']),
      memberLabel: json['memberLabel'] as String,
      lastSenderName: json['lastSenderName'] as String,
      lastMessage: json['lastMessage'] as String,
      timeLabel: json['timeLabel'] as String,
      unreadCount: json['unreadCount'] == null
          ? 0
          : _readInt(json['unreadCount']),
      isReadReceipt: json['isReadReceipt'] as bool? ?? false,
      emphasize: json['emphasize'] as bool? ?? false,
    );

Map<String, dynamic> _$ChatsTripThreadToJson(_ChatsTripThread instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tripId': instance.tripId,
      'title': instance.title,
      'coverUrl': instance.coverUrl,
      'badgeIcon': instance.badgeIcon,
      'status': _$ChatsTripThreadStatusEnumMap[instance.status]!,
      'memberCount': instance.memberCount,
      'memberLabel': instance.memberLabel,
      'lastSenderName': instance.lastSenderName,
      'lastMessage': instance.lastMessage,
      'timeLabel': instance.timeLabel,
      'unreadCount': instance.unreadCount,
      'isReadReceipt': instance.isReadReceipt,
      'emphasize': instance.emphasize,
    };

const _$ChatsTripThreadStatusEnumMap = {
  ChatsTripThreadStatus.upcoming: 'UPCOMING',
  ChatsTripThreadStatus.ongoing: 'ONGOING',
  ChatsTripThreadStatus.completed: 'COMPLETED',
};

_ChatsFriendThread _$ChatsFriendThreadFromJson(
  Map<String, dynamic> json,
) => _ChatsFriendThread(
  id: json['id'] as String,
  conversationId: json['conversationId'] as String,
  peerUserId: json['peerUserId'] as String,
  displayName: json['displayName'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  roleBadge: json['roleBadge'] as String?,
  roleTone: $enumDecodeNullable(_$ChatsFriendRoleToneEnumMap, json['roleTone']),
  isOnline: json['isOnline'] as bool? ?? false,
  lastMessage: json['lastMessage'] as String,
  timeLabel: json['timeLabel'] as String,
  unreadCount: json['unreadCount'] == null ? 0 : _readInt(json['unreadCount']),
  timeEmphasized: json['timeEmphasized'] as bool? ?? false,
);

Map<String, dynamic> _$ChatsFriendThreadToJson(_ChatsFriendThread instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'peerUserId': instance.peerUserId,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'roleBadge': instance.roleBadge,
      'roleTone': _$ChatsFriendRoleToneEnumMap[instance.roleTone],
      'isOnline': instance.isOnline,
      'lastMessage': instance.lastMessage,
      'timeLabel': instance.timeLabel,
      'unreadCount': instance.unreadCount,
      'timeEmphasized': instance.timeEmphasized,
    };

const _$ChatsFriendRoleToneEnumMap = {
  ChatsFriendRoleTone.primary: 'PRIMARY',
  ChatsFriendRoleTone.secondary: 'SECONDARY',
};

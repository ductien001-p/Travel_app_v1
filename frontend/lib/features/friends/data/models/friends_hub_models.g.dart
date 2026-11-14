// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_hub_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FriendsHubPage _$FriendsHubPageFromJson(
  Map<String, dynamic> json,
) => _FriendsHubPage(
  friendsCount: (json['friendsCount'] as num?)?.toInt() ?? 0,
  friendsCountLabel: json['friendsCountLabel'] as String? ?? 'Bạn bè đồng hành',
  syncNotice:
      json['syncNotice'] as String? ??
      'Đã đồng bộ hóa danh bạ du lịch và chuyến đi chung gần nhất.',
  received:
      (json['received'] as List<dynamic>?)
          ?.map((e) => FriendsHubRequest.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <FriendsHubRequest>[],
  sent:
      (json['sent'] as List<dynamic>?)
          ?.map((e) => FriendsHubRequest.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <FriendsHubRequest>[],
  friends:
      (json['friends'] as List<dynamic>?)
          ?.map((e) => FriendsHubFriend.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <FriendsHubFriend>[],
);

Map<String, dynamic> _$FriendsHubPageToJson(_FriendsHubPage instance) =>
    <String, dynamic>{
      'friendsCount': instance.friendsCount,
      'friendsCountLabel': instance.friendsCountLabel,
      'syncNotice': instance.syncNotice,
      'received': instance.received,
      'sent': instance.sent,
      'friends': instance.friends,
    };

_FriendsHubUser _$FriendsHubUserFromJson(Map<String, dynamic> json) =>
    _FriendsHubUser(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      isOnline: json['isOnline'] as bool? ?? false,
      verified: json['verified'] as bool? ?? false,
      subtitle: json['subtitle'] as String?,
      metaIcon: json['metaIcon'] as String?,
      metaLine: json['metaLine'] as String?,
      badgeLabel: json['badgeLabel'] as String?,
      badgeTone:
          $enumDecodeNullable(
            _$FriendsHubBadgeToneEnumMap,
            json['badgeTone'],
          ) ??
          FriendsHubBadgeTone.subdued,
    );

Map<String, dynamic> _$FriendsHubUserToJson(_FriendsHubUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
      'isOnline': instance.isOnline,
      'verified': instance.verified,
      'subtitle': instance.subtitle,
      'metaIcon': instance.metaIcon,
      'metaLine': instance.metaLine,
      'badgeLabel': instance.badgeLabel,
      'badgeTone': _$FriendsHubBadgeToneEnumMap[instance.badgeTone]!,
    };

const _$FriendsHubBadgeToneEnumMap = {
  FriendsHubBadgeTone.primary: 'PRIMARY',
  FriendsHubBadgeTone.secondary: 'SECONDARY',
  FriendsHubBadgeTone.subdued: 'SUBDUED',
  FriendsHubBadgeTone.info: 'INFO',
};

_FriendsHubRequest _$FriendsHubRequestFromJson(Map<String, dynamic> json) =>
    _FriendsHubRequest(
      id: json['id'] as String,
      user: FriendsHubUser.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$FriendsHubRequestToJson(_FriendsHubRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_FriendsHubFriend _$FriendsHubFriendFromJson(Map<String, dynamic> json) =>
    _FriendsHubFriend(
      friendshipId: json['friendshipId'] as String,
      friendId: json['friendId'] as String,
      user: FriendsHubUser.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      conversationId: json['conversationId'] as String?,
    );

Map<String, dynamic> _$FriendsHubFriendToJson(_FriendsHubFriend instance) =>
    <String, dynamic>{
      'friendshipId': instance.friendshipId,
      'friendId': instance.friendId,
      'user': instance.user,
      'createdAt': instance.createdAt.toIso8601String(),
      'conversationId': instance.conversationId,
    };

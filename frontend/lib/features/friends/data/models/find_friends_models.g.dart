// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_friends_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FindFriendsPage _$FindFriendsPageFromJson(Map<String, dynamic> json) =>
    _FindFriendsPage(
      query: json['query'] as String? ?? '',
      matchCount: json['matchCount'] == null ? 0 : _readInt(json['matchCount']),
      matchCountLabel: json['matchCountLabel'] as String? ?? '',
      recentSearches:
          (json['recentSearches'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      dnaBanner: FindFriendsDnaBanner.fromJson(
        json['dnaBanner'] as Map<String, dynamic>,
      ),
      results:
          (json['results'] as List<dynamic>?)
              ?.map((e) => FindFriendsUser.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FindFriendsUser>[],
      nearbySuggestions:
          (json['nearbySuggestions'] as List<dynamic>?)
              ?.map(
                (e) => FindFriendsNearbySuggestion.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          const <FindFriendsNearbySuggestion>[],
    );

Map<String, dynamic> _$FindFriendsPageToJson(_FindFriendsPage instance) =>
    <String, dynamic>{
      'query': instance.query,
      'matchCount': instance.matchCount,
      'matchCountLabel': instance.matchCountLabel,
      'recentSearches': instance.recentSearches,
      'dnaBanner': instance.dnaBanner,
      'results': instance.results,
      'nearbySuggestions': instance.nearbySuggestions,
    };

_FindFriendsDnaBanner _$FindFriendsDnaBannerFromJson(
  Map<String, dynamic> json,
) => _FindFriendsDnaBanner(
  badgeLabel: json['badgeLabel'] as String,
  title: json['title'] as String,
  subtitle: json['subtitle'] as String,
  ctaLabel: json['ctaLabel'] as String,
  extraCount: json['extraCount'] == null ? 0 : _readInt(json['extraCount']),
  previewAvatars:
      (json['previewAvatars'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
);

Map<String, dynamic> _$FindFriendsDnaBannerToJson(
  _FindFriendsDnaBanner instance,
) => <String, dynamic>{
  'badgeLabel': instance.badgeLabel,
  'title': instance.title,
  'subtitle': instance.subtitle,
  'ctaLabel': instance.ctaLabel,
  'extraCount': instance.extraCount,
  'previewAvatars': instance.previewAvatars,
};

_FindFriendsBadge _$FindFriendsBadgeFromJson(Map<String, dynamic> json) =>
    _FindFriendsBadge(
      label: json['label'] as String,
      tone:
          $enumDecodeNullable(_$FindFriendsBadgeToneEnumMap, json['tone']) ??
          FindFriendsBadgeTone.subdued,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$FindFriendsBadgeToJson(_FindFriendsBadge instance) =>
    <String, dynamic>{
      'label': instance.label,
      'tone': _$FindFriendsBadgeToneEnumMap[instance.tone]!,
      'icon': instance.icon,
    };

const _$FindFriendsBadgeToneEnumMap = {
  FindFriendsBadgeTone.amber: 'AMBER',
  FindFriendsBadgeTone.teal: 'TEAL',
  FindFriendsBadgeTone.indigo: 'INDIGO',
  FindFriendsBadgeTone.rose: 'ROSE',
  FindFriendsBadgeTone.primary: 'PRIMARY',
  FindFriendsBadgeTone.primarySoft: 'PRIMARY_SOFT',
  FindFriendsBadgeTone.subdued: 'SUBDUED',
};

_FindFriendsUser _$FindFriendsUserFromJson(Map<String, dynamic> json) =>
    _FindFriendsUser(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      isOnline: json['isOnline'] as bool? ?? false,
      verified: json['verified'] as bool? ?? false,
      action:
          $enumDecodeNullable(_$FindFriendsActionEnumMap, json['action']) ??
          FindFriendsAction.addFriend,
      friendRequestId: json['friendRequestId'] as String?,
      conversationId: json['conversationId'] as String?,
      badges:
          (json['badges'] as List<dynamic>?)
              ?.map((e) => FindFriendsBadge.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FindFriendsBadge>[],
      metaIcon: json['metaIcon'] as String?,
      metaLine: json['metaLine'] as String?,
      travelPersona: json['travelPersona'] as String?,
      dnaMatchPercent: (json['dnaMatchPercent'] as num?)?.toInt(),
      sharedTripsCount: (json['sharedTripsCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FindFriendsUserToJson(_FindFriendsUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
      'isOnline': instance.isOnline,
      'verified': instance.verified,
      'action': _$FindFriendsActionEnumMap[instance.action]!,
      'friendRequestId': instance.friendRequestId,
      'conversationId': instance.conversationId,
      'badges': instance.badges,
      'metaIcon': instance.metaIcon,
      'metaLine': instance.metaLine,
      'travelPersona': instance.travelPersona,
      'dnaMatchPercent': instance.dnaMatchPercent,
      'sharedTripsCount': instance.sharedTripsCount,
    };

const _$FindFriendsActionEnumMap = {
  FindFriendsAction.addFriend: 'ADD_FRIEND',
  FindFriendsAction.requestSent: 'REQUEST_SENT',
  FindFriendsAction.message: 'MESSAGE',
  FindFriendsAction.follow: 'FOLLOW',
  FindFriendsAction.following: 'FOLLOWING',
};

_FindFriendsNearbySuggestion _$FindFriendsNearbySuggestionFromJson(
  Map<String, dynamic> json,
) => _FindFriendsNearbySuggestion(
  id: json['id'] as String,
  displayName: json['displayName'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  subtitle: json['subtitle'] as String,
  chipLabel: json['chipLabel'] as String,
  chipTone:
      $enumDecodeNullable(
        _$FindFriendsContactChipToneEnumMap,
        json['chipTone'],
      ) ??
      FindFriendsContactChipTone.primary,
  action:
      $enumDecodeNullable(_$FindFriendsActionEnumMap, json['action']) ??
      FindFriendsAction.addFriend,
  friendRequestId: json['friendRequestId'] as String?,
  distanceKm: (json['distanceKm'] as num?)?.toDouble(),
);

Map<String, dynamic> _$FindFriendsNearbySuggestionToJson(
  _FindFriendsNearbySuggestion instance,
) => <String, dynamic>{
  'id': instance.id,
  'displayName': instance.displayName,
  'avatarUrl': instance.avatarUrl,
  'subtitle': instance.subtitle,
  'chipLabel': instance.chipLabel,
  'chipTone': _$FindFriendsContactChipToneEnumMap[instance.chipTone]!,
  'action': _$FindFriendsActionEnumMap[instance.action]!,
  'friendRequestId': instance.friendRequestId,
  'distanceKm': instance.distanceKm,
};

const _$FindFriendsContactChipToneEnumMap = {
  FindFriendsContactChipTone.primary: 'PRIMARY',
  FindFriendsContactChipTone.secondary: 'SECONDARY',
};

_FindFriendsRequestSent _$FindFriendsRequestSentFromJson(
  Map<String, dynamic> json,
) => _FindFriendsRequestSent(
  id: json['id'] as String,
  fromUserId: json['fromUserId'] as String,
  toUserId: json['toUserId'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$FindFriendsRequestSentToJson(
  _FindFriendsRequestSent instance,
) => <String, dynamic>{
  'id': instance.id,
  'fromUserId': instance.fromUserId,
  'toUserId': instance.toUserId,
  'status': instance.status,
};

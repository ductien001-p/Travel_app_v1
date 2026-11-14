import 'package:freezed_annotation/freezed_annotation.dart';

part 'friends_hub_models.freezed.dart';
part 'friends_hub_models.g.dart';

enum FriendsHubTab {
  @JsonValue('FRIENDS')
  friends,
  @JsonValue('RECEIVED')
  received,
  @JsonValue('SENT')
  sent,
}

enum FriendsHubSort {
  @JsonValue('RECENT')
  recent,
  @JsonValue('AZ')
  az,
  @JsonValue('ONLINE')
  online,
}

enum FriendsHubBadgeTone {
  @JsonValue('PRIMARY')
  primary,
  @JsonValue('SECONDARY')
  secondary,
  @JsonValue('SUBDUED')
  subdued,
  @JsonValue('INFO')
  info,
}

/// Composite UI payload for Friends Hub (aggregated from friends APIs).
@freezed
abstract class FriendsHubPage with _$FriendsHubPage {
  const factory FriendsHubPage({
    @Default(0) int friendsCount,
    @Default('Bạn bè đồng hành') String friendsCountLabel,
    @Default('Đã đồng bộ hóa danh bạ du lịch và chuyến đi chung gần nhất.')
    String syncNotice,
    @Default(<FriendsHubRequest>[]) List<FriendsHubRequest> received,
    @Default(<FriendsHubRequest>[]) List<FriendsHubRequest> sent,
    @Default(<FriendsHubFriend>[]) List<FriendsHubFriend> friends,
  }) = _FriendsHubPage;

  factory FriendsHubPage.fromJson(Map<String, dynamic> json) =>
      _$FriendsHubPageFromJson(json);
}

@freezed
abstract class FriendsHubUser with _$FriendsHubUser {
  const factory FriendsHubUser({
    required String id,
    required String displayName,
    required String username,
    String? avatarUrl,
    @Default(false) bool isOnline,
    @Default(false) bool verified,
    String? subtitle,
    String? metaIcon,
    String? metaLine,
    String? badgeLabel,
    @Default(FriendsHubBadgeTone.subdued) FriendsHubBadgeTone badgeTone,
  }) = _FriendsHubUser;

  factory FriendsHubUser.fromJson(Map<String, dynamic> json) =>
      _$FriendsHubUserFromJson(json);
}

@freezed
abstract class FriendsHubRequest with _$FriendsHubRequest {
  const factory FriendsHubRequest({
    required String id,
    required FriendsHubUser user,
    required DateTime createdAt,
  }) = _FriendsHubRequest;

  factory FriendsHubRequest.fromJson(Map<String, dynamic> json) =>
      _$FriendsHubRequestFromJson(json);
}

@freezed
abstract class FriendsHubFriend with _$FriendsHubFriend {
  const factory FriendsHubFriend({
    required String friendshipId,
    required String friendId,
    required FriendsHubUser user,
    required DateTime createdAt,
    String? conversationId,
  }) = _FriendsHubFriend;

  factory FriendsHubFriend.fromJson(Map<String, dynamic> json) =>
      _$FriendsHubFriendFromJson(json);
}

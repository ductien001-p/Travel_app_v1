import 'package:freezed_annotation/freezed_annotation.dart';

part 'find_friends_models.freezed.dart';
part 'find_friends_models.g.dart';

int _readInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

enum FindFriendsAction {
  @JsonValue('ADD_FRIEND')
  addFriend,
  @JsonValue('REQUEST_SENT')
  requestSent,
  @JsonValue('MESSAGE')
  message,
  @JsonValue('FOLLOW')
  follow,
  @JsonValue('FOLLOWING')
  following,
}

enum FindFriendsBadgeTone {
  @JsonValue('AMBER')
  amber,
  @JsonValue('TEAL')
  teal,
  @JsonValue('INDIGO')
  indigo,
  @JsonValue('ROSE')
  rose,
  @JsonValue('PRIMARY')
  primary,
  @JsonValue('PRIMARY_SOFT')
  primarySoft,
  @JsonValue('SUBDUED')
  subdued,
}

enum FindFriendsContactChipTone {
  @JsonValue('PRIMARY')
  primary,
  @JsonValue('SECONDARY')
  secondary,
}

/// Aggregate payload for Find Friends (`GET /friends/find`).
@freezed
abstract class FindFriendsPage with _$FindFriendsPage {
  const factory FindFriendsPage({
    @Default('') String query,
    @JsonKey(fromJson: _readInt) @Default(0) int matchCount,
    @Default('') String matchCountLabel,
    @Default(<String>[]) List<String> recentSearches,
    required FindFriendsDnaBanner dnaBanner,
    @Default(<FindFriendsUser>[]) List<FindFriendsUser> results,
    @Default(<FindFriendsNearbySuggestion>[])
    List<FindFriendsNearbySuggestion> nearbySuggestions,
  }) = _FindFriendsPage;

  factory FindFriendsPage.fromJson(Map<String, dynamic> json) =>
      _$FindFriendsPageFromJson(json);
}

@freezed
abstract class FindFriendsDnaBanner with _$FindFriendsDnaBanner {
  const factory FindFriendsDnaBanner({
    required String badgeLabel,
    required String title,
    required String subtitle,
    required String ctaLabel,
    @JsonKey(fromJson: _readInt) @Default(0) int extraCount,
    @Default(<String>[]) List<String> previewAvatars,
  }) = _FindFriendsDnaBanner;

  factory FindFriendsDnaBanner.fromJson(Map<String, dynamic> json) =>
      _$FindFriendsDnaBannerFromJson(json);
}

@freezed
abstract class FindFriendsBadge with _$FindFriendsBadge {
  const factory FindFriendsBadge({
    required String label,
    @Default(FindFriendsBadgeTone.subdued) FindFriendsBadgeTone tone,
    String? icon,
  }) = _FindFriendsBadge;

  factory FindFriendsBadge.fromJson(Map<String, dynamic> json) =>
      _$FindFriendsBadgeFromJson(json);
}

@freezed
abstract class FindFriendsUser with _$FindFriendsUser {
  const factory FindFriendsUser({
    required String id,
    required String displayName,
    required String username,
    String? avatarUrl,
    @Default(false) bool isOnline,
    @Default(false) bool verified,
    @Default(FindFriendsAction.addFriend) FindFriendsAction action,
    String? friendRequestId,
    String? conversationId,
    @Default(<FindFriendsBadge>[]) List<FindFriendsBadge> badges,
    String? metaIcon,
    String? metaLine,
    String? travelPersona,
    int? dnaMatchPercent,
    int? sharedTripsCount,
  }) = _FindFriendsUser;

  factory FindFriendsUser.fromJson(Map<String, dynamic> json) =>
      _$FindFriendsUserFromJson(json);
}

@freezed
abstract class FindFriendsNearbySuggestion with _$FindFriendsNearbySuggestion {
  const factory FindFriendsNearbySuggestion({
    required String id,
    required String displayName,
    String? avatarUrl,
    required String subtitle,
    required String chipLabel,
    @Default(FindFriendsContactChipTone.primary)
    FindFriendsContactChipTone chipTone,
    @Default(FindFriendsAction.addFriend) FindFriendsAction action,
    String? friendRequestId,
    double? distanceKm,
  }) = _FindFriendsNearbySuggestion;

  factory FindFriendsNearbySuggestion.fromJson(Map<String, dynamic> json) =>
      _$FindFriendsNearbySuggestionFromJson(json);
}

@freezed
abstract class FindFriendsRequestSent with _$FindFriendsRequestSent {
  const factory FindFriendsRequestSent({
    required String id,
    required String fromUserId,
    required String toUserId,
    required String status,
  }) = _FindFriendsRequestSent;

  factory FindFriendsRequestSent.fromJson(Map<String, dynamic> json) =>
      _$FindFriendsRequestSentFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chats_hub_models.freezed.dart';
part 'chats_hub_models.g.dart';

/// Aggregate payload for the Trip Messages Hub screen (`GET /chats/hub`).
@freezed
abstract class ChatsHub with _$ChatsHub {
  const factory ChatsHub({
    required ChatsHubViewer viewer,
    @JsonKey(fromJson: _readInt) required int totalThreadCount,
    @Default(false) bool hasUnread,
    ChatsActiveTripPulse? activeTripPulse,
    @Default(<ChatsTripThread>[]) List<ChatsTripThread> tripThreads,
    @Default(<ChatsFriendThread>[]) List<ChatsFriendThread> friendThreads,
  }) = _ChatsHub;

  factory ChatsHub.fromJson(Map<String, dynamic> json) =>
      _$ChatsHubFromJson(json);
}

@freezed
abstract class ChatsHubViewer with _$ChatsHubViewer {
  const factory ChatsHubViewer({
    required String displayName,
    String? avatarUrl,
    @Default(false) bool isOnline,
  }) = _ChatsHubViewer;

  factory ChatsHubViewer.fromJson(Map<String, dynamic> json) =>
      _$ChatsHubViewerFromJson(json);
}

@freezed
abstract class ChatsActiveTripPulse with _$ChatsActiveTripPulse {
  const factory ChatsActiveTripPulse({
    required String tripId,
    required String title,
    required String statusLabel,
    @JsonKey(fromJson: _readInt) required int onlineMemberCount,
    @JsonKey(fromJson: _readInt) required int memberCapacity,
    @Default(<String>[]) List<String> memberAvatars,
    @JsonKey(fromJson: _readInt) @Default(0) int extraMemberCount,
    required String pinnedSenderName,
    required String pinnedMessage,
    required String pinnedTimeLabel,
    @JsonKey(fromJson: _readInt) @Default(0) int newExchangeCount,
  }) = _ChatsActiveTripPulse;

  factory ChatsActiveTripPulse.fromJson(Map<String, dynamic> json) =>
      _$ChatsActiveTripPulseFromJson(json);
}

enum ChatsTripThreadStatus {
  @JsonValue('UPCOMING')
  upcoming,
  @JsonValue('ONGOING')
  ongoing,
  @JsonValue('COMPLETED')
  completed,
}

@freezed
abstract class ChatsTripThread with _$ChatsTripThread {
  const factory ChatsTripThread({
    required String id,
    required String tripId,
    required String title,
    required String coverUrl,
    required String badgeIcon,
    required ChatsTripThreadStatus status,
    @JsonKey(fromJson: _readInt) required int memberCount,
    required String memberLabel,
    required String lastSenderName,
    required String lastMessage,
    required String timeLabel,
    @JsonKey(fromJson: _readInt) @Default(0) int unreadCount,
    @Default(false) bool isReadReceipt,
    @Default(false) bool emphasize,
  }) = _ChatsTripThread;

  factory ChatsTripThread.fromJson(Map<String, dynamic> json) =>
      _$ChatsTripThreadFromJson(json);
}

enum ChatsFriendRoleTone {
  @JsonValue('PRIMARY')
  primary,
  @JsonValue('SECONDARY')
  secondary,
}

@freezed
abstract class ChatsFriendThread with _$ChatsFriendThread {
  const factory ChatsFriendThread({
    required String id,
    required String conversationId,
    required String peerUserId,
    required String displayName,
    String? avatarUrl,
    String? roleBadge,
    ChatsFriendRoleTone? roleTone,
    @Default(false) bool isOnline,
    required String lastMessage,
    required String timeLabel,
    @JsonKey(fromJson: _readInt) @Default(0) int unreadCount,
    @Default(false) bool timeEmphasized,
  }) = _ChatsFriendThread;

  factory ChatsFriendThread.fromJson(Map<String, dynamic> json) =>
      _$ChatsFriendThreadFromJson(json);
}

int _readInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  throw const FormatException('Expected an integer.');
}

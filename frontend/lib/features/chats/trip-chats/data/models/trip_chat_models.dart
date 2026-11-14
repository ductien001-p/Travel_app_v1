import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_chat_models.freezed.dart';
part 'trip_chat_models.g.dart';

/// Aggregate payload for trip group chat (`GET /trips/{tripId}/chat/thread`).
@freezed
abstract class TripChatThread with _$TripChatThread {
  const factory TripChatThread({
    required String tripId,
    required String title,
    required String memberSummaryLabel,
    @Default(true) bool isLive,
    TripChatPinnedActivity? pinnedActivity,
    required String dateLabel,
    @Default(<TripChatMessage>[]) List<TripChatMessage> messages,
    @Default(false) bool isSomeoneTyping,
    String? typingLabel,
    String? typingAvatarUrl,
    @Default(<TripChatUtility>[]) List<TripChatUtility> utilities,
  }) = _TripChatThread;

  factory TripChatThread.fromJson(Map<String, dynamic> json) =>
      _$TripChatThreadFromJson(json);
}

@freezed
abstract class TripChatPinnedActivity with _$TripChatPinnedActivity {
  const factory TripChatPinnedActivity({
    required String badgeLabel,
    String? dayChipLabel,
    required String title,
    String? checkInLabel,
    String? itineraryDayId,
  }) = _TripChatPinnedActivity;

  factory TripChatPinnedActivity.fromJson(Map<String, dynamic> json) =>
      _$TripChatPinnedActivityFromJson(json);
}

enum TripChatMessageKind {
  @JsonValue('SYSTEM')
  system,
  @JsonValue('TEXT')
  text,
  @JsonValue('PHOTO')
  photo,
  @JsonValue('EXPENSE')
  expense,
}

enum TripChatReadStatus {
  @JsonValue('SENT')
  sent,
  @JsonValue('DELIVERED')
  delivered,
  @JsonValue('READ')
  read,
}

enum TripChatRoleTone {
  @JsonValue('LEADER')
  leader,
  @JsonValue('PHOTOGRAPHER')
  photographer,
  @JsonValue('TREASURER')
  treasurer,
  @JsonValue('MEMBER')
  member,
}

@freezed
abstract class TripChatSender with _$TripChatSender {
  const factory TripChatSender({
    required String userId,
    required String displayName,
    String? avatarUrl,
    String? roleBadge,
    @Default(TripChatRoleTone.member) TripChatRoleTone roleTone,
    @Default(false) bool isLeader,
  }) = _TripChatSender;

  factory TripChatSender.fromJson(Map<String, dynamic> json) =>
      _$TripChatSenderFromJson(json);
}

@freezed
abstract class TripChatMessage with _$TripChatMessage {
  const factory TripChatMessage({
    required String id,
    required TripChatMessageKind kind,
    @Default(false) bool isMine,
    String? text,
    required String timeLabel,
    TripChatReadStatus? readStatus,
    @Default(true) bool showAvatar,
    TripChatSender? sender,
    TripChatSystemPayload? system,
    TripChatPhotoPayload? photo,
    TripChatExpensePayload? expense,
  }) = _TripChatMessage;

  factory TripChatMessage.fromJson(Map<String, dynamic> json) =>
      _$TripChatMessageFromJson(json);
}

@freezed
abstract class TripChatSystemPayload with _$TripChatSystemPayload {
  const factory TripChatSystemPayload({
    required String icon,
    required String richText,
  }) = _TripChatSystemPayload;

  factory TripChatSystemPayload.fromJson(Map<String, dynamic> json) =>
      _$TripChatSystemPayloadFromJson(json);
}

@freezed
abstract class TripChatPhotoPayload with _$TripChatPhotoPayload {
  const factory TripChatPhotoPayload({
    required String imageUrl,
    String? caption,
    String? locationLabel,
    @Default(<TripChatReaction>[]) List<TripChatReaction> reactions,
  }) = _TripChatPhotoPayload;

  factory TripChatPhotoPayload.fromJson(Map<String, dynamic> json) =>
      _$TripChatPhotoPayloadFromJson(json);
}

@freezed
abstract class TripChatReaction with _$TripChatReaction {
  const factory TripChatReaction({
    required String emoji,
    @JsonKey(fromJson: _readInt) required int count,
  }) = _TripChatReaction;

  factory TripChatReaction.fromJson(Map<String, dynamic> json) =>
      _$TripChatReactionFromJson(json);
}

@freezed
abstract class TripChatExpensePayload with _$TripChatExpensePayload {
  const factory TripChatExpensePayload({
    required String expenseId,
    required String title,
    required String subtitle,
    required String amountLabel,
    required String splitLabel,
    required String perPersonLabel,
    String? actionLabel,
  }) = _TripChatExpensePayload;

  factory TripChatExpensePayload.fromJson(Map<String, dynamic> json) =>
      _$TripChatExpensePayloadFromJson(json);
}

enum TripChatUtilityKind {
  @JsonValue('LIVE_LOCATION')
  liveLocation,
  @JsonValue('SPLIT_BILL')
  splitBill,
  @JsonValue('ALBUM')
  album,
  @JsonValue('ADD_STOP')
  addStop,
}

@freezed
abstract class TripChatUtility with _$TripChatUtility {
  const factory TripChatUtility({
    required TripChatUtilityKind kind,
    required String label,
  }) = _TripChatUtility;

  factory TripChatUtility.fromJson(Map<String, dynamic> json) =>
      _$TripChatUtilityFromJson(json);
}

int _readInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  throw const FormatException('Expected an integer.');
}

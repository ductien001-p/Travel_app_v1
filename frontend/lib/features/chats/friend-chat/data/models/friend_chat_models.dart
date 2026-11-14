import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_chat_models.freezed.dart';
part 'friend_chat_models.g.dart';

/// Aggregate payload for the 1-on-1 friend chat screen
/// (`GET /friends/conversations/{conversationId}/thread`).
@freezed
abstract class FriendChatThread with _$FriendChatThread {
  const factory FriendChatThread({
    required String conversationId,
    required FriendChatPeer peer,
    FriendChatSharedTrip? sharedTrip,
    required String dateLabel,
    @Default(<FriendChatMessage>[]) List<FriendChatMessage> messages,
    @Default(false) bool isPeerTyping,
    String? typingLabel,
    @Default(<FriendChatShortcut>[]) List<FriendChatShortcut> shortcuts,
    @Default(<FriendChatInviteCandidate>[])
    List<FriendChatInviteCandidate> inviteCandidates,
  }) = _FriendChatThread;

  factory FriendChatThread.fromJson(Map<String, dynamic> json) =>
      _$FriendChatThreadFromJson(json);
}

@freezed
abstract class FriendChatPeer with _$FriendChatPeer {
  const factory FriendChatPeer({
    required String userId,
    required String displayName,
    String? avatarUrl,
    String? roleBadge,
    @Default(false) bool isOnline,
    String? presenceLabel,
    String? sharedTripsLabel,
  }) = _FriendChatPeer;

  factory FriendChatPeer.fromJson(Map<String, dynamic> json) =>
      _$FriendChatPeerFromJson(json);
}

@freezed
abstract class FriendChatSharedTrip with _$FriendChatSharedTrip {
  const factory FriendChatSharedTrip({
    required String tripId,
    required String title,
    String? destinationHint,
    required String statusLabel,
  }) = _FriendChatSharedTrip;

  factory FriendChatSharedTrip.fromJson(Map<String, dynamic> json) =>
      _$FriendChatSharedTripFromJson(json);
}

enum FriendChatMessageKind {
  @JsonValue('TEXT')
  text,
  @JsonValue('PLACE_CARD')
  placeCard,
  @JsonValue('TRIP_INVITE')
  tripInvite,
}

enum FriendChatReadStatus {
  @JsonValue('SENT')
  sent,
  @JsonValue('DELIVERED')
  delivered,
  @JsonValue('READ')
  read,
}

@freezed
abstract class FriendChatMessage with _$FriendChatMessage {
  const factory FriendChatMessage({
    required String id,
    required FriendChatMessageKind kind,
    @Default(false) bool isMine,
    String? text,
    required String timeLabel,
    FriendChatReadStatus? readStatus,
    @Default(true) bool showAvatar,
    FriendChatPlaceCard? placeCard,
    FriendChatTripInviteCard? tripInvite,
  }) = _FriendChatMessage;

  factory FriendChatMessage.fromJson(Map<String, dynamic> json) =>
      _$FriendChatMessageFromJson(json);
}

@freezed
abstract class FriendChatPlaceCard with _$FriendChatPlaceCard {
  const factory FriendChatPlaceCard({
    required String placeId,
    required String name,
    required String address,
    required String imageUrl,
    @JsonKey(fromJson: _readDouble) required double rating,
    @JsonKey(fromJson: _readInt) required int reviewCount,
    String? badgeLabel,
    String? footerLabel,
    String? actionLabel,
  }) = _FriendChatPlaceCard;

  factory FriendChatPlaceCard.fromJson(Map<String, dynamic> json) =>
      _$FriendChatPlaceCardFromJson(json);
}

@freezed
abstract class FriendChatTripInviteCard with _$FriendChatTripInviteCard {
  const factory FriendChatTripInviteCard({
    required String tripId,
    required String title,
    required String imageUrl,
    required String dateLabel,
    required String priceLabel,
    required String seatsLabel,
    String? badgeLabel,
    String? primaryActionLabel,
    String? secondaryActionLabel,
  }) = _FriendChatTripInviteCard;

  factory FriendChatTripInviteCard.fromJson(Map<String, dynamic> json) =>
      _$FriendChatTripInviteCardFromJson(json);
}

enum FriendChatShortcutKind {
  @JsonValue('INVITE_TRIP')
  inviteTrip,
  @JsonValue('SEND_LOCATION')
  sendLocation,
  @JsonValue('SPLIT_BILL')
  splitBill,
  @JsonValue('SUGGEST_ITINERARY')
  suggestItinerary,
  @JsonValue('SEND_PHOTO')
  sendPhoto,
}

@freezed
abstract class FriendChatShortcut with _$FriendChatShortcut {
  const factory FriendChatShortcut({
    required FriendChatShortcutKind kind,
    required String label,
    @Default(false) bool emphasized,
  }) = _FriendChatShortcut;

  factory FriendChatShortcut.fromJson(Map<String, dynamic> json) =>
      _$FriendChatShortcutFromJson(json);
}

@freezed
abstract class FriendChatInviteCandidate with _$FriendChatInviteCandidate {
  const factory FriendChatInviteCandidate({
    required String tripId,
    required String title,
    required String imageUrl,
    required String metaLabel,
    required String badgeLabel,
    required String actionLabel,
  }) = _FriendChatInviteCandidate;

  factory FriendChatInviteCandidate.fromJson(Map<String, dynamic> json) =>
      _$FriendChatInviteCandidateFromJson(json);
}

int _readInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  throw const FormatException('Expected an integer.');
}

double _readDouble(Object? value) {
  if (value is double) return value;
  if (value is num) return value.toDouble();
  throw const FormatException('Expected a number.');
}

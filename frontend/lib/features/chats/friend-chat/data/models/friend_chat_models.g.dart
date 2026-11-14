// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_chat_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FriendChatThread _$FriendChatThreadFromJson(
  Map<String, dynamic> json,
) => _FriendChatThread(
  conversationId: json['conversationId'] as String,
  peer: FriendChatPeer.fromJson(json['peer'] as Map<String, dynamic>),
  sharedTrip: json['sharedTrip'] == null
      ? null
      : FriendChatSharedTrip.fromJson(
          json['sharedTrip'] as Map<String, dynamic>,
        ),
  dateLabel: json['dateLabel'] as String,
  messages:
      (json['messages'] as List<dynamic>?)
          ?.map((e) => FriendChatMessage.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <FriendChatMessage>[],
  isPeerTyping: json['isPeerTyping'] as bool? ?? false,
  typingLabel: json['typingLabel'] as String?,
  shortcuts:
      (json['shortcuts'] as List<dynamic>?)
          ?.map((e) => FriendChatShortcut.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <FriendChatShortcut>[],
  inviteCandidates:
      (json['inviteCandidates'] as List<dynamic>?)
          ?.map(
            (e) =>
                FriendChatInviteCandidate.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <FriendChatInviteCandidate>[],
);

Map<String, dynamic> _$FriendChatThreadToJson(_FriendChatThread instance) =>
    <String, dynamic>{
      'conversationId': instance.conversationId,
      'peer': instance.peer,
      'sharedTrip': instance.sharedTrip,
      'dateLabel': instance.dateLabel,
      'messages': instance.messages,
      'isPeerTyping': instance.isPeerTyping,
      'typingLabel': instance.typingLabel,
      'shortcuts': instance.shortcuts,
      'inviteCandidates': instance.inviteCandidates,
    };

_FriendChatPeer _$FriendChatPeerFromJson(Map<String, dynamic> json) =>
    _FriendChatPeer(
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      roleBadge: json['roleBadge'] as String?,
      isOnline: json['isOnline'] as bool? ?? false,
      presenceLabel: json['presenceLabel'] as String?,
      sharedTripsLabel: json['sharedTripsLabel'] as String?,
    );

Map<String, dynamic> _$FriendChatPeerToJson(_FriendChatPeer instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'roleBadge': instance.roleBadge,
      'isOnline': instance.isOnline,
      'presenceLabel': instance.presenceLabel,
      'sharedTripsLabel': instance.sharedTripsLabel,
    };

_FriendChatSharedTrip _$FriendChatSharedTripFromJson(
  Map<String, dynamic> json,
) => _FriendChatSharedTrip(
  tripId: json['tripId'] as String,
  title: json['title'] as String,
  destinationHint: json['destinationHint'] as String?,
  statusLabel: json['statusLabel'] as String,
);

Map<String, dynamic> _$FriendChatSharedTripToJson(
  _FriendChatSharedTrip instance,
) => <String, dynamic>{
  'tripId': instance.tripId,
  'title': instance.title,
  'destinationHint': instance.destinationHint,
  'statusLabel': instance.statusLabel,
};

_FriendChatMessage _$FriendChatMessageFromJson(Map<String, dynamic> json) =>
    _FriendChatMessage(
      id: json['id'] as String,
      kind: $enumDecode(_$FriendChatMessageKindEnumMap, json['kind']),
      isMine: json['isMine'] as bool? ?? false,
      text: json['text'] as String?,
      timeLabel: json['timeLabel'] as String,
      readStatus: $enumDecodeNullable(
        _$FriendChatReadStatusEnumMap,
        json['readStatus'],
      ),
      showAvatar: json['showAvatar'] as bool? ?? true,
      placeCard: json['placeCard'] == null
          ? null
          : FriendChatPlaceCard.fromJson(
              json['placeCard'] as Map<String, dynamic>,
            ),
      tripInvite: json['tripInvite'] == null
          ? null
          : FriendChatTripInviteCard.fromJson(
              json['tripInvite'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$FriendChatMessageToJson(_FriendChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': _$FriendChatMessageKindEnumMap[instance.kind]!,
      'isMine': instance.isMine,
      'text': instance.text,
      'timeLabel': instance.timeLabel,
      'readStatus': _$FriendChatReadStatusEnumMap[instance.readStatus],
      'showAvatar': instance.showAvatar,
      'placeCard': instance.placeCard,
      'tripInvite': instance.tripInvite,
    };

const _$FriendChatMessageKindEnumMap = {
  FriendChatMessageKind.text: 'TEXT',
  FriendChatMessageKind.placeCard: 'PLACE_CARD',
  FriendChatMessageKind.tripInvite: 'TRIP_INVITE',
};

const _$FriendChatReadStatusEnumMap = {
  FriendChatReadStatus.sent: 'SENT',
  FriendChatReadStatus.delivered: 'DELIVERED',
  FriendChatReadStatus.read: 'READ',
};

_FriendChatPlaceCard _$FriendChatPlaceCardFromJson(Map<String, dynamic> json) =>
    _FriendChatPlaceCard(
      placeId: json['placeId'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: _readDouble(json['rating']),
      reviewCount: _readInt(json['reviewCount']),
      badgeLabel: json['badgeLabel'] as String?,
      footerLabel: json['footerLabel'] as String?,
      actionLabel: json['actionLabel'] as String?,
    );

Map<String, dynamic> _$FriendChatPlaceCardToJson(
  _FriendChatPlaceCard instance,
) => <String, dynamic>{
  'placeId': instance.placeId,
  'name': instance.name,
  'address': instance.address,
  'imageUrl': instance.imageUrl,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'badgeLabel': instance.badgeLabel,
  'footerLabel': instance.footerLabel,
  'actionLabel': instance.actionLabel,
};

_FriendChatTripInviteCard _$FriendChatTripInviteCardFromJson(
  Map<String, dynamic> json,
) => _FriendChatTripInviteCard(
  tripId: json['tripId'] as String,
  title: json['title'] as String,
  imageUrl: json['imageUrl'] as String,
  dateLabel: json['dateLabel'] as String,
  priceLabel: json['priceLabel'] as String,
  seatsLabel: json['seatsLabel'] as String,
  badgeLabel: json['badgeLabel'] as String?,
  primaryActionLabel: json['primaryActionLabel'] as String?,
  secondaryActionLabel: json['secondaryActionLabel'] as String?,
);

Map<String, dynamic> _$FriendChatTripInviteCardToJson(
  _FriendChatTripInviteCard instance,
) => <String, dynamic>{
  'tripId': instance.tripId,
  'title': instance.title,
  'imageUrl': instance.imageUrl,
  'dateLabel': instance.dateLabel,
  'priceLabel': instance.priceLabel,
  'seatsLabel': instance.seatsLabel,
  'badgeLabel': instance.badgeLabel,
  'primaryActionLabel': instance.primaryActionLabel,
  'secondaryActionLabel': instance.secondaryActionLabel,
};

_FriendChatShortcut _$FriendChatShortcutFromJson(Map<String, dynamic> json) =>
    _FriendChatShortcut(
      kind: $enumDecode(_$FriendChatShortcutKindEnumMap, json['kind']),
      label: json['label'] as String,
      emphasized: json['emphasized'] as bool? ?? false,
    );

Map<String, dynamic> _$FriendChatShortcutToJson(_FriendChatShortcut instance) =>
    <String, dynamic>{
      'kind': _$FriendChatShortcutKindEnumMap[instance.kind]!,
      'label': instance.label,
      'emphasized': instance.emphasized,
    };

const _$FriendChatShortcutKindEnumMap = {
  FriendChatShortcutKind.inviteTrip: 'INVITE_TRIP',
  FriendChatShortcutKind.sendLocation: 'SEND_LOCATION',
  FriendChatShortcutKind.splitBill: 'SPLIT_BILL',
  FriendChatShortcutKind.suggestItinerary: 'SUGGEST_ITINERARY',
  FriendChatShortcutKind.sendPhoto: 'SEND_PHOTO',
};

_FriendChatInviteCandidate _$FriendChatInviteCandidateFromJson(
  Map<String, dynamic> json,
) => _FriendChatInviteCandidate(
  tripId: json['tripId'] as String,
  title: json['title'] as String,
  imageUrl: json['imageUrl'] as String,
  metaLabel: json['metaLabel'] as String,
  badgeLabel: json['badgeLabel'] as String,
  actionLabel: json['actionLabel'] as String,
);

Map<String, dynamic> _$FriendChatInviteCandidateToJson(
  _FriendChatInviteCandidate instance,
) => <String, dynamic>{
  'tripId': instance.tripId,
  'title': instance.title,
  'imageUrl': instance.imageUrl,
  'metaLabel': instance.metaLabel,
  'badgeLabel': instance.badgeLabel,
  'actionLabel': instance.actionLabel,
};

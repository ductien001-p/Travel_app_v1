import 'models/friend_chat_models.dart';

/// Turns a `friend:message:new` payload into a UI message.
///
/// HTTP sends the thread shape (`kind`, `timeLabel`). The socket send path
/// and the join snapshot can still emit the stored row (`messageType`).
FriendChatMessage? friendChatMessageFromSocket(
  Map<String, dynamic> raw, {
  String? peerUserId,
}) {
  if (raw['kind'] is String) {
    try {
      return FriendChatMessage.fromJson(raw);
    } catch (_) {
      return null;
    }
  }

  final type = raw['messageType'];
  if (type is! String) return null;
  final kind = switch (type) {
    'TEXT' => FriendChatMessageKind.text,
    'PLACE_CARD' => FriendChatMessageKind.placeCard,
    'TRIP_INVITE' => FriendChatMessageKind.tripInvite,
    _ => null,
  };
  if (kind == null) return null;

  final id = raw['id'];
  if (id is! String || id.isEmpty) return null;

  final senderId = _senderId(raw);
  final isMine = peerUserId == null
      ? false
      : senderId != null && senderId != peerUserId;
  final metadata = _metadata(raw);

  return FriendChatMessage(
    id: id,
    kind: kind,
    isMine: isMine,
    text: raw['content'] is String ? raw['content'] as String : null,
    timeLabel: _timeLabel(raw['createdAt']),
    readStatus: isMine ? FriendChatReadStatus.delivered : null,
    showAvatar: !isMine,
    placeCard: kind == FriendChatMessageKind.placeCard
        ? _placeCard(metadata)
        : null,
    tripInvite: kind == FriendChatMessageKind.tripInvite
        ? _tripInvite(metadata)
        : null,
  );
}

String? _senderId(Map<String, dynamic> raw) {
  final direct = raw['senderId'];
  if (direct is String && direct.isNotEmpty) return direct;
  final sender = raw['sender'];
  if (sender is Map) {
    final id = sender['id'];
    if (id is String && id.isNotEmpty) return id;
  }
  return null;
}

Map<String, dynamic>? _metadata(Map<String, dynamic> raw) {
  final value = raw['metadata'];
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return Map<String, dynamic>.from(value);
  return null;
}

String _timeLabel(Object? createdAt) {
  if (createdAt is! String) return '';
  final parsed = DateTime.tryParse(createdAt)?.toLocal();
  if (parsed == null) return '';
  final hour = parsed.hour.toString().padLeft(2, '0');
  final minute = parsed.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

FriendChatPlaceCard? _placeCard(Map<String, dynamic>? metadata) {
  if (metadata == null) return null;
  final placeId = metadata['placeId'];
  final name = metadata['name'];
  final address = metadata['address'];
  final imageUrl = metadata['imageUrl'];
  if (placeId is! String ||
      name is! String ||
      address is! String ||
      imageUrl is! String) {
    return null;
  }
  final rating = metadata['rating'];
  final reviewCount = metadata['reviewCount'];
  if (rating is! num || reviewCount is! num) return null;
  return FriendChatPlaceCard(
    placeId: placeId,
    name: name,
    address: address,
    imageUrl: imageUrl,
    rating: rating.toDouble(),
    reviewCount: reviewCount.toInt(),
    badgeLabel: metadata['badgeLabel'] is String
        ? metadata['badgeLabel'] as String
        : null,
    footerLabel: metadata['footerLabel'] is String
        ? metadata['footerLabel'] as String
        : null,
    actionLabel: metadata['actionLabel'] is String
        ? metadata['actionLabel'] as String
        : null,
  );
}

FriendChatTripInviteCard? _tripInvite(Map<String, dynamic>? metadata) {
  if (metadata == null) return null;
  final tripId = metadata['tripId'];
  final title = metadata['title'];
  final imageUrl = metadata['imageUrl'];
  final dateLabel = metadata['dateLabel'];
  final priceLabel = metadata['priceLabel'];
  final seatsLabel = metadata['seatsLabel'];
  if (tripId is! String ||
      title is! String ||
      imageUrl is! String ||
      dateLabel is! String ||
      priceLabel is! String ||
      seatsLabel is! String) {
    return null;
  }
  return FriendChatTripInviteCard(
    tripId: tripId,
    title: title,
    imageUrl: imageUrl,
    dateLabel: dateLabel,
    priceLabel: priceLabel,
    seatsLabel: seatsLabel,
    badgeLabel: metadata['badgeLabel'] is String
        ? metadata['badgeLabel'] as String
        : null,
    primaryActionLabel: metadata['primaryActionLabel'] is String
        ? metadata['primaryActionLabel'] as String
        : null,
    secondaryActionLabel: metadata['secondaryActionLabel'] is String
        ? metadata['secondaryActionLabel'] as String
        : null,
  );
}

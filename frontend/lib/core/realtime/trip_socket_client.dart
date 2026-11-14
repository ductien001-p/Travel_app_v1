import 'dart:async';

import 'trip_socket_channel.dart';

/// What a screen watching one trip room is told.
sealed class TripRoomEvent {
  const TripRoomEvent();
}

/// The server confirmed `trip:join`; sent again after every reconnect.
final class TripRoomJoined extends TripRoomEvent {
  const TripRoomJoined();
}

/// The connection dropped; the room is re-joined automatically.
final class TripRoomLeft extends TripRoomEvent {
  const TripRoomLeft();
}

/// The server refused the room or the session; no retry until the access
/// token is refreshed.
final class TripRoomRejected extends TripRoomEvent {
  const TripRoomRejected();
}

/// A `trip:timeline` payload, shaped like the REST timeline items.
final class TripTimelinePushed extends TripRoomEvent {
  const TripTimelinePushed(this.event);

  final Map<String, dynamic> event;
}

/// A `trip:message` payload for the trip group chat screen.
final class TripChatMessagePushed extends TripRoomEvent {
  const TripChatMessagePushed(this.message);

  final Map<String, dynamic> message;
}

/// A `trip:typing` presence update for the trip group chat screen.
final class TripChatTypingPushed extends TripRoomEvent {
  const TripChatTypingPushed({
    required this.userId,
    required this.isTyping,
    this.typingLabel,
    this.typingAvatarUrl,
  });

  final String userId;
  final bool isTyping;
  final String? typingLabel;
  final String? typingAvatarUrl;
}

/// A `trip:message:reaction` aggregate update.
final class TripChatReactionPushed extends TripRoomEvent {
  const TripChatReactionPushed({
    required this.messageId,
    required this.reactions,
  });

  final String messageId;
  final List<Map<String, dynamic>> reactions;
}

/// One shared Socket.IO connection to `TripGateway`, opened while at least
/// one trip room is watched.
///
/// The handshake reads the access token from secure storage each time. A
/// handshake refused as unauthorized refreshes the session through the shared
/// HTTP refresh flow once, then reconnects; any later token refresh also
/// restarts a stopped connection.
class TripSocketClient {
  TripSocketClient({
    required Future<String?> Function() readAccessToken,
    required Future<String?> Function() refreshSession,
    required Stream<void> tokenRefreshes,
    required TripSocketChannelFactory channelFactory,
    Duration retryDelay = const Duration(seconds: 5),
  }) : _readAccessToken = readAccessToken,
       _refreshSession = refreshSession,
       _channelFactory = channelFactory,
       _retryDelay = retryDelay {
    _tokenRefreshSubscription = tokenRefreshes.listen(
      (_) => _onTokenRefreshed(),
    );
  }

  static const _unauthorizedMessage = 'Unauthorized';
  static const _serverDisconnect = 'io server disconnect';

  final Future<String?> Function() _readAccessToken;
  final Future<String?> Function() _refreshSession;
  final TripSocketChannelFactory _channelFactory;
  final Duration _retryDelay;
  late final StreamSubscription<void> _tokenRefreshSubscription;

  final _events =
      StreamController<({String tripId, TripRoomEvent event})>.broadcast();

  /// Watched trip ids and their listener count.
  final _rooms = <String, int>{};
  final _joined = <String>{};

  TripSocketChannel? _channel;
  bool _connected = false;

  /// One refresh per refused handshake, so a revoked user cannot loop.
  bool _refreshTried = false;

  /// Stopped after the server refused the session.
  bool _stopped = false;
  Timer? _retryTimer;
  bool _disposed = false;

  /// Joins the trip room while the stream is listened to.
  Stream<TripRoomEvent> watchTrip(String tripId) {
    late final StreamController<TripRoomEvent> controller;
    StreamSubscription<TripRoomEvent>? subscription;
    controller = StreamController<TripRoomEvent>(
      onListen: () {
        subscription = _events.stream
            .where((item) => item.tripId == tripId)
            .map((item) => item.event)
            .listen(controller.add);
        if (_joined.contains(tripId)) controller.add(const TripRoomJoined());
        _retain(tripId);
      },
      onCancel: () async {
        await subscription?.cancel();
        _release(tripId);
      },
    );
    return controller.stream;
  }

  /// Broadcasts typing presence to other members in the trip room.
  void emitTyping({required String tripId, required bool isTyping}) {
    if (!_joined.contains(tripId)) return;
    _channel?.emit('trip:typing', {'tripId': tripId, 'isTyping': isTyping});
  }

  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _tokenRefreshSubscription.cancel();
    _closeChannel();
    _rooms.clear();
    _events.close();
  }

  void _retain(String tripId) {
    if (_disposed) return;
    final count = (_rooms[tripId] ?? 0) + 1;
    _rooms[tripId] = count;
    if (count > 1) return;
    final channel = _channel;
    if (channel == null) {
      _openChannel();
    } else if (_connected) {
      _join(channel, tripId);
    }
  }

  void _release(String tripId) {
    final count = (_rooms[tripId] ?? 1) - 1;
    if (count > 0) {
      _rooms[tripId] = count;
      return;
    }
    _rooms.remove(tripId);
    if (_joined.remove(tripId) && _connected) {
      _channel?.emit('trip:leave', {'tripId': tripId});
    }
    if (_rooms.isEmpty) _closeChannel();
  }

  void _openChannel() {
    final channel = _channelFactory(_readAccessToken)
      ..onConnect(_onConnect)
      ..onConnectError(_onConnectError)
      ..onDisconnect(_onDisconnect)
      ..on('trip:joined', _onJoined)
      ..on('trip:error', (_) => _rejectPendingRooms())
      ..on('trip:timeline', _onTimeline)
      ..on('trip:message', _onChatMessage)
      ..on('trip:typing', _onChatTyping)
      ..on('trip:message:reaction', _onChatReaction);
    _channel = channel;
    channel.connect();
  }

  void _closeChannel() {
    _retryTimer?.cancel();
    _retryTimer = null;
    _channel?.dispose();
    _channel = null;
    _connected = false;
    _joined.clear();
    _refreshTried = false;
    _stopped = false;
  }

  void _join(TripSocketChannel channel, String tripId) =>
      channel.emit('trip:join', {'tripId': tripId});

  void _onConnect() {
    _connected = true;
    _refreshTried = false;
    _stopped = false;
    final channel = _channel;
    if (channel == null) return;
    for (final tripId in _rooms.keys) {
      _join(channel, tripId);
    }
  }

  void _onJoined(Object? data) {
    final tripId = _tripIdOf(data);
    if (tripId == null || !_rooms.containsKey(tripId)) return;
    _joined.add(tripId);
    _emit(tripId, const TripRoomJoined());
  }

  void _onTimeline(Object? data) {
    if (data is! Map) return;
    final event = Map<String, dynamic>.from(data);
    final tripId = event['tripId'];
    if (tripId is! String || !_joined.contains(tripId)) return;
    _emit(tripId, TripTimelinePushed(event));
  }

  void _onChatMessage(Object? data) {
    if (data is! Map) return;
    final event = Map<String, dynamic>.from(data);
    final tripId = event['tripId'];
    if (tripId is! String || !_joined.contains(tripId)) return;

    final nested = event['message'];
    final message = nested is Map
        ? Map<String, dynamic>.from(nested)
        : event;
    _emit(tripId, TripChatMessagePushed(message));
  }

  void _onChatTyping(Object? data) {
    if (data is! Map) return;
    final event = Map<String, dynamic>.from(data);
    final tripId = event['tripId'];
    final userId = event['userId'];
    if (tripId is! String || userId is! String || !_joined.contains(tripId)) {
      return;
    }
    _emit(
      tripId,
      TripChatTypingPushed(
        userId: userId,
        isTyping: event['isTyping'] != false,
        typingLabel: event['typingLabel'] is String
            ? event['typingLabel'] as String
            : null,
        typingAvatarUrl: event['typingAvatarUrl'] is String
            ? event['typingAvatarUrl'] as String
            : null,
      ),
    );
  }

  void _onChatReaction(Object? data) {
    if (data is! Map) return;
    final event = Map<String, dynamic>.from(data);
    final tripId = event['tripId'];
    final messageId = event['messageId'];
    if (tripId is! String ||
        messageId is! String ||
        !_joined.contains(tripId)) {
      return;
    }
    final raw = event['reactions'];
    final reactions = <Map<String, dynamic>>[
      if (raw is List)
        for (final item in raw)
          if (item is Map) Map<String, dynamic>.from(item),
    ];
    _emit(
      tripId,
      TripChatReactionPushed(messageId: messageId, reactions: reactions),
    );
  }

  void _onDisconnect(Object? reason) {
    _connected = false;
    final lost = [..._joined];
    _joined.clear();
    for (final tripId in lost) {
      _emit(tripId, const TripRoomLeft());
    }
    // The client does not retry by itself after a server-side disconnect.
    if (reason == _serverDisconnect) _scheduleRetry();
  }

  /// Transport errors are retried by Socket.IO; a refused handshake is not.
  Future<void> _onConnectError(Object? data) async {
    _connected = false;
    if (!_isUnauthorized(data)) return;
    if (_refreshTried) {
      _stop();
      return;
    }
    _refreshTried = true;
    try {
      final token = await _refreshSession();
      if (_channel == null) return;
      if (token == null) {
        _stop();
        return;
      }
      _channel?.connect();
    } catch (_) {
      _refreshTried = false;
      _scheduleRetry();
    }
  }

  void _onTokenRefreshed() {
    final channel = _channel;
    if (!_stopped || channel == null) return;
    _stopped = false;
    _refreshTried = false;
    channel.connect();
  }

  void _stop() {
    _stopped = true;
    for (final tripId in _rooms.keys) {
      _emit(tripId, const TripRoomRejected());
    }
  }

  void _rejectPendingRooms() {
    for (final tripId in _rooms.keys) {
      if (!_joined.contains(tripId)) _emit(tripId, const TripRoomRejected());
    }
  }

  void _scheduleRetry() {
    _retryTimer?.cancel();
    _retryTimer = Timer(_retryDelay, () {
      if (!_connected && !_stopped) _channel?.connect();
    });
  }

  void _emit(String tripId, TripRoomEvent event) {
    if (!_events.isClosed) _events.add((tripId: tripId, event: event));
  }

  static bool _isUnauthorized(Object? data) =>
      data is Map && data['message'] == _unauthorizedMessage;

  static String? _tripIdOf(Object? data) {
    if (data is! Map) return null;
    final tripId = data['tripId'];
    return tripId is String ? tripId : null;
  }
}

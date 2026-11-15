import 'dart:async';

import 'trip_socket_channel.dart';

/// A `friend:message:new` payload for one conversation.
final class FriendMessagePushed {
  const FriendMessagePushed(this.message);

  final Map<String, dynamic> message;
}

/// One Socket.IO connection to the `/friends` namespace.
///
/// Opens while at least one conversation is watched. The handshake reads the
/// access token from secure storage and refreshes the session once if the
/// server refuses it.
class FriendSocketClient {
  FriendSocketClient({
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
      StreamController<({String conversationId, FriendMessagePushed event})>.broadcast();
  final _rooms = <String, int>{};
  final _joined = <String>{};

  TripSocketChannel? _channel;
  bool _connected = false;
  bool _refreshTried = false;
  bool _stopped = false;
  Timer? _retryTimer;
  bool _disposed = false;

  Stream<FriendMessagePushed> watchConversation(String conversationId) {
    late final StreamController<FriendMessagePushed> controller;
    StreamSubscription<FriendMessagePushed>? subscription;
    controller = StreamController<FriendMessagePushed>(
      onListen: () {
        subscription = _events.stream
            .where((item) => item.conversationId == conversationId)
            .map((item) => item.event)
            .listen(controller.add);
        _retain(conversationId);
      },
      onCancel: () async {
        await subscription?.cancel();
        _release(conversationId);
      },
    );
    return controller.stream;
  }

  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _tokenRefreshSubscription.cancel();
    _closeChannel();
    _rooms.clear();
    _events.close();
  }

  void _retain(String conversationId) {
    if (_disposed) return;
    final count = (_rooms[conversationId] ?? 0) + 1;
    _rooms[conversationId] = count;
    if (count > 1) return;
    final channel = _channel;
    if (channel == null) {
      _openChannel();
    } else if (_connected) {
      _join(channel, conversationId);
    }
  }

  void _release(String conversationId) {
    final count = (_rooms[conversationId] ?? 1) - 1;
    if (count > 0) {
      _rooms[conversationId] = count;
      return;
    }
    _rooms.remove(conversationId);
    if (_joined.remove(conversationId) && _connected) {
      _channel?.emit('friend:conversation:leave', {
        'conversationId': conversationId,
      });
    }
    if (_rooms.isEmpty) _closeChannel();
  }

  void _openChannel() {
    final channel = _channelFactory(_readAccessToken)
      ..onConnect(_onConnect)
      ..onConnectError(_onConnectError)
      ..onDisconnect(_onDisconnect)
      ..on('friend:conversation:joined', _onJoined)
      ..on('friend:message:new', _onMessage);
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

  void _join(TripSocketChannel channel, String conversationId) =>
      channel.emit('friend:conversation:join', {
        'conversationId': conversationId,
      });

  void _onConnect() {
    _connected = true;
    _refreshTried = false;
    _stopped = false;
    final channel = _channel;
    if (channel == null) return;
    for (final conversationId in _rooms.keys) {
      _join(channel, conversationId);
    }
  }

  void _onJoined(Object? data) {
    if (data is! Map) return;
    final conversationId = data['conversationId'];
    if (conversationId is! String || !_rooms.containsKey(conversationId)) {
      return;
    }
    _joined.add(conversationId);
  }

  void _onMessage(Object? data) {
    if (data is! Map) return;
    final event = Map<String, dynamic>.from(data);
    final nested = event['message'];
    final message = nested is Map
        ? Map<String, dynamic>.from(nested)
        : event;
    var conversationId = event['conversationId'];
    if (conversationId is! String) {
      conversationId = message['conversationId'];
    }
    if (conversationId is! String && _rooms.length == 1) {
      conversationId = _rooms.keys.first;
    }
    if (conversationId is! String || !_rooms.containsKey(conversationId)) {
      return;
    }
    if (!_events.isClosed) {
      _events.add((
        conversationId: conversationId,
        event: FriendMessagePushed(message),
      ));
    }
  }

  void _onDisconnect(Object? reason) {
    _connected = false;
    _joined.clear();
    if (reason == _serverDisconnect) _scheduleRetry();
  }

  Future<void> _onConnectError(Object? data) async {
    _connected = false;
    if (!_isUnauthorized(data)) return;
    if (_refreshTried) {
      _stopped = true;
      return;
    }
    _refreshTried = true;
    try {
      final token = await _refreshSession();
      if (_channel == null) return;
      if (token == null) {
        _stopped = true;
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

  void _scheduleRetry() {
    _retryTimer?.cancel();
    _retryTimer = Timer(_retryDelay, () {
      if (!_connected && !_stopped) _channel?.connect();
    });
  }

  static bool _isUnauthorized(Object? data) =>
      data is Map && data['message'] == _unauthorizedMessage;
}

import 'dart:async';

import 'package:travel_frontend_v1/core/realtime/trip_socket_channel.dart';
import 'package:travel_frontend_v1/core/realtime/trip_socket_client.dart';

/// In-memory Socket.IO channel: records emits and lets tests play the server.
class FakeTripSocketChannel implements TripSocketChannel {
  FakeTripSocketChannel(this.readToken);

  final Future<String?> Function() readToken;
  final emitted = <({String event, Object? data})>[];
  int connectCalls = 0;
  bool disposed = false;

  void Function()? _onConnect;
  void Function(Object? data)? _onConnectError;
  void Function(Object? reason)? _onDisconnect;
  final _handlers = <String, void Function(Object? data)>{};

  @override
  void onConnect(void Function() handler) => _onConnect = handler;

  @override
  void onConnectError(void Function(Object? data) handler) =>
      _onConnectError = handler;

  @override
  void onDisconnect(void Function(Object? reason) handler) =>
      _onDisconnect = handler;

  @override
  void on(String event, void Function(Object? data) handler) =>
      _handlers[event] = handler;

  @override
  void emit(String event, Object? data) =>
      emitted.add((event: event, data: data));

  @override
  void connect() => connectCalls++;

  @override
  void dispose() => disposed = true;

  void serverConnect() => _onConnect?.call();

  void serverRefuse([Object? data = const {'message': 'Unauthorized'}]) =>
      _onConnectError?.call(data);

  void serverDisconnect([Object? reason = 'transport close']) =>
      _onDisconnect?.call(reason);

  void serverEmit(String event, Object? data) => _handlers[event]?.call(data);

  int _acceptedUpTo = 0;

  /// Accepts the `trip:join`s sent since the last call, like `TripGateway`.
  void acceptJoins() {
    final pending = emitted.sublist(_acceptedUpTo);
    _acceptedUpTo = emitted.length;
    for (final emit in pending.where((item) => item.event == 'trip:join')) {
      serverEmit('trip:joined', emit.data);
    }
  }
}

/// Builds a [TripSocketClient] whose channels are [FakeTripSocketChannel]s.
class FakeTripSocket {
  FakeTripSocket({
    String? token = 'access-1',
    Future<String?> Function()? refreshSession,
  }) : _token = token {
    client = TripSocketClient(
      readAccessToken: () async => _token,
      refreshSession: refreshSession ?? () async => 'access-2',
      tokenRefreshes: tokenRefreshes.stream,
      channelFactory: (readToken) {
        final channel = FakeTripSocketChannel(readToken);
        channels.add(channel);
        return channel;
      },
      retryDelay: const Duration(milliseconds: 10),
    );
  }

  final String? _token;
  final tokenRefreshes = StreamController<void>.broadcast();
  final channels = <FakeTripSocketChannel>[];
  late final TripSocketClient client;

  FakeTripSocketChannel get channel => channels.last;

  void dispose() {
    client.dispose();
    tokenRefreshes.close();
  }
}

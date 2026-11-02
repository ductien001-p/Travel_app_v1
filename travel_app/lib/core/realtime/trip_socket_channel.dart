import 'package:socket_io_client/socket_io_client.dart' as io;

/// Minimal Socket.IO surface used by `TripSocketClient`, so its connection
/// logic can be tested without a server.
abstract interface class TripSocketChannel {
  void onConnect(void Function() handler);
  void onConnectError(void Function(Object? data) handler);
  void onDisconnect(void Function(Object? reason) handler);
  void on(String event, void Function(Object? data) handler);
  void emit(String event, Object? data);
  void connect();
  void dispose();
}

/// [readToken] runs before every handshake, so a reconnect always sends the
/// latest access token.
typedef TripSocketChannelFactory =
    TripSocketChannel Function(Future<String?> Function() readToken);

TripSocketChannelFactory socketIoChannelFactory(String url) =>
    (readToken) => _SocketIoChannel(url, readToken);

class _SocketIoChannel implements TripSocketChannel {
  _SocketIoChannel(String url, Future<String?> Function() readToken)
    : _socket = io.io(
        url,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .enableForceNew()
            .enableReconnection()
            .setReconnectionDelay(1000)
            .setReconnectionDelayMax(10000)
            .setAuthFn((send) {
              readToken().then(
                (token) => send({'token': token ?? ''}),
                onError: (Object _) => send({'token': ''}),
              );
            })
            .build(),
      );

  final io.Socket _socket;

  @override
  void onConnect(void Function() handler) =>
      _socket.onConnect((_) => handler());

  @override
  void onConnectError(void Function(Object? data) handler) =>
      _socket.onConnectError(handler);

  @override
  void onDisconnect(void Function(Object? reason) handler) =>
      _socket.onDisconnect(handler);

  @override
  void on(String event, void Function(Object? data) handler) =>
      _socket.on(event, handler);

  @override
  void emit(String event, Object? data) => _socket.emit(event, data);

  @override
  void connect() => _socket.connect();

  @override
  void dispose() => _socket.dispose();
}

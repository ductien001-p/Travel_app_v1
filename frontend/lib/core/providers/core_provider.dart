import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/config/config.dart';
import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../realtime/friend_socket_client.dart';
import '../realtime/trip_socket_channel.dart';
import '../realtime/trip_socket_client.dart';
import '../session/session_invalidation_provider.dart';
import '../storage/token_storage.dart';

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage();
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final client = ApiClient(
    tokenStorage: ref.watch(tokenStorageProvider),

    onSessionExpired: () {
      /*
         * AuthInterceptor không cần biết
         * AuthController là gì.
         *
         * Nó chỉ báo:
         *
         * "session đã invalid".
         */
      ref.read(sessionInvalidationProvider.notifier).invalidateSession();
    },
  );

  ref.onDispose(client.close);

  return client;
});

/*
 * Kết nối realtime tới các phòng chuyến đi.
 *
 * Token đọc từ TokenStorage; refresh dùng
 * luồng chung của ApiClient.
 */
final tripSocketClientProvider = Provider<TripSocketClient>((ref) {
  final apiClient = ref.watch(apiClientProvider);

  final client = TripSocketClient(
    readAccessToken: ref.watch(tokenStorageProvider).readAccessToken,

    refreshSession: apiClient.refreshSession,

    tokenRefreshes: apiClient.tokenRefreshes,

    channelFactory: socketIoChannelFactory(AppConfig.socketUrl),
  );

  ref.onDispose(client.dispose);

  return client;
});

/// Realtime cho hội thoại bạn bè (namespace `/friends`).
final friendSocketClientProvider = Provider<FriendSocketClient>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final base = AppConfig.socketUrl.replaceFirst(RegExp(r'/+$'), '');
  final client = FriendSocketClient(
    readAccessToken: ref.watch(tokenStorageProvider).readAccessToken,
    refreshSession: apiClient.refreshSession,
    tokenRefreshes: apiClient.tokenRefreshes,
    channelFactory: socketIoChannelFactory('$base/friends'),
  );
  ref.onDispose(client.dispose);
  return client;
});

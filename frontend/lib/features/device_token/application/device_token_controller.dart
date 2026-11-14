import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/features/device_token/provider/device_token_provider.dart';
import 'package:travel_frontend_v1/features/device_token/service/device_messaging_service.dart';

import '../data/repositories/device_token_repository.dart';
import 'device_token_state.dart';

final deviceTokenControllerProvider =
    AsyncNotifierProvider<DeviceTokenController, DeviceTokenState>(
      DeviceTokenController.new,
    );

class DeviceTokenController extends AsyncNotifier<DeviceTokenState> {
  StreamSubscription<String>? _tokenRefreshSubscription;

  StreamSubscription<String>? _installationSubscription;

  bool _authenticatedSession = false;

  bool _syncing = false;

  String? _pendingToken;

  DeviceMessagingService get _messaging =>
      ref.read(deviceMessagingServiceProvider);

  DeviceTokenRepository get _repository =>
      ref.read(deviceTokenRepositoryProvider);

  @override
  FutureOr<DeviceTokenState> build() {
    _listenForTokenChanges();

    ref.onDispose(() {
      _tokenRefreshSubscription?.cancel();
      _installationSubscription?.cancel();
    });

    return const DeviceTokenState.idle();
  }

  void _listenForTokenChanges() {
    _tokenRefreshSubscription?.cancel();

    _tokenRefreshSubscription = _messaging.onTokenRefresh.listen(
      (token) {
        if (!_authenticatedSession) {
          return;
        }

        unawaited(_enqueueTokenSync(token));
      },
      onError: (_) {
        /*
         * Không logout user chỉ vì FCM
         * gặp lỗi.
         */
      },
    );

    _installationSubscription?.cancel();

    _installationSubscription = _messaging.onInstallationIdChange.listen((_) {
      if (!_authenticatedSession) {
        return;
      }

      /*
         * Installation ID đổi thì backend
         * cần biết installation mới.
         */
      unawaited(registerCurrentDevice(requestPermission: false));
    }, onError: (_) {});
  }

  Future<void> registerAfterLogin() {
    _authenticatedSession = true;

    return registerCurrentDevice(requestPermission: true);
  }

  Future<void> registerAfterSessionRestore() {
    _authenticatedSession = true;

    /*
     * Session restore không nên tự bật
     * permission popup mỗi lần app mở.
     */
    return registerCurrentDevice(requestPermission: false);
  }

  Future<void> registerCurrentDevice({required bool requestPermission}) async {
    _authenticatedSession = true;

    state = const AsyncLoading();

    try {
      String? token;

      if (requestPermission) {
        final result = await _messaging.requestToken();

        switch (result.status) {
          case PushTokenAvailability.permissionDenied:
            state = const AsyncData(
              DeviceTokenState(status: DeviceTokenStatus.permissionDenied),
            );
            return;

          case PushTokenAvailability.waitingForApns:
            state = const AsyncData(
              DeviceTokenState(status: DeviceTokenStatus.waitingForApns),
            );
            return;

          case PushTokenAvailability.unavailable:
            state = const AsyncData(
              DeviceTokenState(status: DeviceTokenStatus.unavailable),
            );
            return;

          case PushTokenAvailability.available:
            token = result.token;
        }
      } else {
        token = await _messaging.getTokenWithoutPermissionPrompt();

        if (token == null || token.isEmpty) {
          /*
           * Không có token nhưng không coi
           * đây là lỗi authentication.
           */
          state = const AsyncData(
            DeviceTokenState(status: DeviceTokenStatus.unavailable),
          );

          return;
        }
      }

      if (token == null || token.isEmpty) {
        state = const AsyncData(
          DeviceTokenState(status: DeviceTokenStatus.unavailable),
        );

        return;
      }

      await _enqueueTokenSync(token);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);

      rethrow;
    }
  }

  Future<void> _enqueueTokenSync(String token) async {
    _pendingToken = token;

    if (_syncing) {
      return;
    }

    _syncing = true;

    try {
      while (_pendingToken != null && _authenticatedSession) {
        final tokenToSync = _pendingToken!;

        _pendingToken = null;

        await _syncToken(tokenToSync);
      }
    } finally {
      _syncing = false;
    }
  }

  Future<void> _syncToken(String token) async {
    if (!_authenticatedSession) {
      return;
    }

    final installationId = await _messaging.getInstallationId();

    final platform = _messaging.currentPlatform;

    await _repository.register(
      installationId: installationId,
      token: token,
      platform: platform,
    );

    state = AsyncData(
      DeviceTokenState(
        status: DeviceTokenStatus.registered,
        installationId: installationId,
      ),
    );
  }

  Future<void> unregisterCurrentDevice() async {
    /*
     * Chặn token refresh đăng ký lại
     * trong khi logout.
     */
    _authenticatedSession = false;
    _pendingToken = null;

    try {
      final installationId = await _messaging.getInstallationId();

      await _repository.unregister(installationId: installationId);

      state = AsyncData(
        DeviceTokenState(
          status: DeviceTokenStatus.unregistered,
          installationId: installationId,
        ),
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);

      rethrow;
    }
  }

  void markSessionInactive() {
    _authenticatedSession = false;
    _pendingToken = null;
  }
}

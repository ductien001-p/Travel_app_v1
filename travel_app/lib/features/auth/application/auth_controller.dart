import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import 'package:travel_frontend_v1/features/auth/provider/auth_provider.dart';

import 'package:travel_frontend_v1/features/device_token/application/device_token_controller.dart';

import 'package:travel_frontend_v1/features/device_token/provider/device_token_provider.dart';

import '../../../core/session/session_invalidation_provider.dart';

import 'auth_status.dart';

final authControllerProvider =
    AsyncNotifierProvider<AuthController, AuthStatus>(AuthController.new);

class AuthController extends AsyncNotifier<AuthStatus> {
  @override
  FutureOr<AuthStatus> build() async {
    /*
     * AuthInterceptor báo:
     *
     * refresh token invalid / expired
     *
     * → provider rebuild.
     */
    ref.watch(sessionInvalidationProvider);

    _markDeviceSessionInactive();

    final repository = ref.watch(authRepositoryProvider);

    final restored = await repository.restoreSession();

    if (restored) {
      /*
       * Không request notification popup
       * khi chỉ restore session.
       */
      _registerDeviceAfterSessionRestore();

      return AuthStatus.authenticated;
    }

    return AuthStatus.unauthenticated;
  }

  Future<void> login({required String email, required String password}) async {
    if (state.isLoading) {
      return;
    }

    state = const AsyncLoading();

    final result = await AsyncValue.guard<AuthStatus>(() async {
      await ref
          .read(authRepositoryProvider)
          .login(email: email.trim(), password: password);

      return AuthStatus.authenticated;
    });

    state = result;

    result.whenData((status) {
      if (status == AuthStatus.authenticated) {
        _registerDeviceAfterLogin();
      }
    });
  }

  /*
   * ======================================================
   * GOOGLE LOGIN
   * ======================================================
   */

  Future<void> googleLogin() async {
    if (state.isLoading) {
      return;
    }

    state = const AsyncLoading();

    final result = await AsyncValue.guard<AuthStatus>(() async {
      final authenticated = await ref
          .read(authRepositoryProvider)
          .googleLogin();

      /*
         * User đóng Google account chooser.
         *
         * Không phải error.
         */
      if (!authenticated) {
        return AuthStatus.unauthenticated;
      }

      return AuthStatus.authenticated;
    });

    state = result;

    result.whenData((status) {
      if (status == AuthStatus.authenticated) {
        /*
           * Google login sử dụng cùng DeviceToken
           * flow với email/password login.
           */
        _registerDeviceAfterLogin();
      }
    });
  }

  /*
   * ======================================================
   * LOGOUT
   * ======================================================
   */

  Future<void> logout() async {
    if (state.isLoading) {
      return;
    }

    state = const AsyncLoading();

    state = await AsyncValue.guard<AuthStatus>(() async {
      final tokenStorage = ref.read(tokenStorageProvider);

      final refreshToken = await tokenStorage.readRefreshToken();

      /*
         * Ngăn FCM token refresh
         * đăng ký lại device trong lúc logout.
         */
      _markDeviceSessionInactive();

      if (refreshToken == null || refreshToken.isEmpty) {
        await tokenStorage.clearTokens();

        await ref.read(authRepositoryProvider).signOutGoogle();

        return AuthStatus.unauthenticated;
      }

      /*
         * installationId chính là identifier
         * mà backend LogoutDto yêu cầu.
         */
      final installationId = await ref
          .read(deviceMessagingServiceProvider)
          .getInstallationId();

      try {
        await ref
            .read(authRepositoryProvider)
            .logout(refreshToken: refreshToken, installationId: installationId);
      } finally {
        /*
           * Google SDK local session cũng logout.
           *
           * Nếu đây là LOCAL account thì
           * signOut() cũng không làm hỏng Travel auth.
           */
        await ref.read(authRepositoryProvider).signOutGoogle();

        _markDeviceSessionInactive();
      }

      return AuthStatus.unauthenticated;
    });
  }

  /*
   * ======================================================
   * RETRY SESSION
   * ======================================================
   */

  Future<void> retrySessionRestore() async {
    if (state.isLoading) {
      return;
    }

    state = const AsyncLoading();

    _markDeviceSessionInactive();

    final result = await AsyncValue.guard<AuthStatus>(() async {
      final restored = await ref.read(authRepositoryProvider).restoreSession();

      return restored ? AuthStatus.authenticated : AuthStatus.unauthenticated;
    });

    state = result;

    result.whenData((status) {
      if (status == AuthStatus.authenticated) {
        _registerDeviceAfterSessionRestore();
      }
    });
  }

  /*
   * ======================================================
   * DEVICE TOKEN
   * ======================================================
   */

  void _registerDeviceAfterLogin() {
    unawaited(
      ref
          .read(deviceTokenControllerProvider.notifier)
          .registerAfterLogin()
          .catchError((Object error, StackTrace stackTrace) {
            /*
           * Firebase fail
           * != login fail.
           */
          }),
    );
  }

  void _registerDeviceAfterSessionRestore() {
    unawaited(
      ref
          .read(deviceTokenControllerProvider.notifier)
          .registerAfterSessionRestore()
          .catchError((Object error, StackTrace stackTrace) {}),
    );
  }

  void _markDeviceSessionInactive() {
    ref.read(deviceTokenControllerProvider.notifier).markSessionInactive();
  }
}

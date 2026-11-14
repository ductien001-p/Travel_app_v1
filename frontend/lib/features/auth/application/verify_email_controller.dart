import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/features/auth/provider/auth_provider.dart';

import 'auth_controller.dart';

final verifyEmailControllerProvider =
    AsyncNotifierProvider<VerifyEmailController, void>(
      VerifyEmailController.new,
    );

class VerifyEmailController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<bool> verify({required String email, required String token}) async {
    if (state.isLoading) {
      return false;
    }

    state = const AsyncLoading();

    try {
      await ref
          .read(authRepositoryProvider)
          .verifyEmail(email: email.trim(), token: token.trim());

      /*
       * verifyEmail() của Repository
       * phải lưu accessToken +
       * refreshToken nếu backend trả token.
       *
       * Sau đó rebuild AuthController.
       */
      ref.invalidate(authControllerProvider);

      state = const AsyncData(null);

      return true;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);

      return false;
    }
  }

  Future<bool> resend({required String email}) async {
    if (state.isLoading) {
      return false;
    }

    state = const AsyncLoading();

    try {
      await ref
          .read(authRepositoryProvider)
          .resendVerification(email: email.trim());

      state = const AsyncData(null);

      return true;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);

      return false;
    }
  }

  void reset() {
    state = const AsyncData(null);
  }
}

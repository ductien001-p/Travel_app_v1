import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/features/auth/provider/auth_provider.dart';

final resetPasswordControllerProvider =
    AsyncNotifierProvider<ResetPasswordController, void>(
      ResetPasswordController.new,
    );

class ResetPasswordController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<bool> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    if (state.isLoading) {
      return false;
    }

    state = const AsyncLoading();

    try {
      await ref
          .read(authRepositoryProvider)
          .resetPassword(
            email: email.trim(),
            token: token.trim(),
            newPassword: newPassword,
          );

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

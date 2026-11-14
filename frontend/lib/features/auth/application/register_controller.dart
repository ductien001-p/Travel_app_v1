import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/features/auth/provider/auth_provider.dart';

final registerControllerProvider =
    AsyncNotifierProvider<RegisterController, void>(RegisterController.new);

class RegisterController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<bool> register({
    required String email,
    required String username,
    required String password,
  }) async {
    /*
     * Chặn double submit.
     */
    if (state.isLoading) {
      return false;
    }

    state = const AsyncLoading();

    try {
      await ref
          .read(authRepositoryProvider)
          .register(
            email: email.trim(),
            username: username.trim(),
            password: password,
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

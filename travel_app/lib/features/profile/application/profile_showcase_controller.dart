import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/profile_showcase_models.dart';
import '../provider/profile_provider.dart';

final profileShowcaseControllerProvider =
    AsyncNotifierProvider<ProfileShowcaseController, ProfileShowcase>(
      ProfileShowcaseController.new,
    );

class ProfileShowcaseController extends AsyncNotifier<ProfileShowcase> {
  @override
  FutureOr<ProfileShowcase> build() =>
      ref.watch(profileShowcaseRepositoryProvider).getProfileShowcase();

  Future<void> refresh() async {
    if (state.isLoading) return;
    state = const AsyncLoading<ProfileShowcase>();
    state = await AsyncValue.guard(
      () => ref.read(profileShowcaseRepositoryProvider).getProfileShowcase(),
    );
  }
}

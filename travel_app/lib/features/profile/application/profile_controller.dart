import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/profile_model.dart';
import '../provider/profile_provider.dart';

final profileControllerProvider =
    AsyncNotifierProvider<ProfileController, ProfileModel>(
      ProfileController.new,
    );

class ProfileController extends AsyncNotifier<ProfileModel> {
  @override
  FutureOr<ProfileModel> build() =>
      ref.watch(profileRepositoryProvider).getProfile();
  Future<void> refreshProfile() async {
    if (state.isLoading) return;
    state = const AsyncLoading<ProfileModel>();
    state = await AsyncValue.guard(
      ref.read(profileRepositoryProvider).getProfile,
    );
  }
}

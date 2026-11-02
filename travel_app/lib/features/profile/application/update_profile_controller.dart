import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/profile_model.dart';
import '../data/models/update_profile_request.dart';
import '../provider/profile_provider.dart';
import 'profile_controller.dart';

final updateProfileControllerProvider =
    NotifierProvider<UpdateProfileController, AsyncValue<ProfileModel?>>(
      UpdateProfileController.new,
    );

class UpdateProfileController extends Notifier<AsyncValue<ProfileModel?>> {
  @override
  AsyncValue<ProfileModel?> build() => const AsyncData(null);
  Future<bool> submit(UpdateProfileRequest request) async {
    if (state.isLoading || request.isEmpty) return false;
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => ref.read(profileRepositoryProvider).updateProfile(request),
    );
    state = result;
    if (result.hasValue) {
      ref.invalidate(profileControllerProvider);
      return true;
    }
    return false;
  }

  void reset() => state = const AsyncData(null);
}

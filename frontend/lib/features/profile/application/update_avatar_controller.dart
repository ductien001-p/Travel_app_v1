import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_frontend_v1/features/media/data/models/media_upload_folder.dart';
import 'package:travel_frontend_v1/features/media/providers/media_providers.dart';

import '../data/models/profile_model.dart';
import '../data/models/update_profile_request.dart';
import '../provider/profile_provider.dart';
import 'profile_controller.dart';

final updateAvatarControllerProvider =
    NotifierProvider<UpdateAvatarController, AsyncValue<ProfileModel?>>(
      UpdateAvatarController.new,
    );

class UpdateAvatarController extends Notifier<AsyncValue<ProfileModel?>> {
  @override
  AsyncValue<ProfileModel?> build() => const AsyncData(null);

  Future<bool> updateAvatar(XFile file) async {
    if (state.isLoading) return false;
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      final uploaded = await ref
          .read(mediaUploadRepositoryProvider)
          .uploadFiles(
            folder: MediaUploadFolder.avatars,
            files: [file],
            maxConcurrentUploads: 1,
          );
      if (uploaded.length != 1) {
        throw StateError(
          'Avatar upload did not return exactly one media item.',
        );
      }
      return ref
          .read(profileRepositoryProvider)
          .updateProfile(UpdateProfileRequest(avatarId: uploaded.single.id));
    });
    state = result;
    if (result.hasValue) {
      ref.invalidate(profileControllerProvider);
      return true;
    }
    return false;
  }
}

import 'package:travel_frontend_v1/features/media/data/repository/media_upload_repository.dart';

import '../datasources/profile_remote_datasource.dart';
import '../models/profile_model.dart';
import '../models/update_profile_request.dart';

class ProfileRepository {
  const ProfileRepository({
    required ProfileRemoteDataSource remoteDataSource,
    required MediaUploadRepository mediaRepository,
  }) : _remoteDataSource = remoteDataSource,
       _mediaRepository = mediaRepository;
  final ProfileRemoteDataSource _remoteDataSource;
  final MediaUploadRepository _mediaRepository;
  Future<ProfileModel> getProfile() async =>
      _resolveAvatar(await _remoteDataSource.getProfile());
  Future<ProfileModel> updateProfile(UpdateProfileRequest request) async {
    if (request.isEmpty) {
      throw ArgumentError('At least one supported profile field is required.');
    }
    return _resolveAvatar(await _remoteDataSource.updateProfile(request));
  }

  Future<void> deleteAccount() => _remoteDataSource.deleteAccount();

  Future<ProfileModel> _resolveAvatar(ProfileModel profile) async {
    final avatarId = profile.avatarId;
    if (avatarId == null) return profile;
    try {
      return profile.withAvatarUrl(
        await _mediaRepository.getOwnMediaUrl(avatarId),
      );
    } on Object {
      return profile;
    }
  }
}

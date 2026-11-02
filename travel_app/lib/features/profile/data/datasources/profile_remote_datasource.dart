import 'package:travel_frontend_v1/core/networks/api_client.dart';
import '../models/profile_model.dart';
import '../models/update_profile_request.dart';

class ProfileRemoteDataSource {
  const ProfileRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;
  final ApiClient _apiClient;
  Future<ProfileModel> getProfile() async {
    final response = await _apiClient.get<Map<String, dynamic>>('/users/me');
    return ProfileModel.fromJson(_dataFromEnvelope(response));
  }

  Future<ProfileModel> updateProfile(UpdateProfileRequest request) async {
    final response = await _apiClient.patch<Map<String, dynamic>>(
      '/users/update',
      data: request.toJson(),
    );
    return ProfileModel.fromJson(_dataFromEnvelope(response));
  }

  Map<String, dynamic> _dataFromEnvelope(Map<String, dynamic> response) {
    final data = response['data'];
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    throw const FormatException(
      'Profile response does not contain a valid data object.',
    );
  }
}

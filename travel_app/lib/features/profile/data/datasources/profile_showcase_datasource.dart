import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/profile_showcase_models.dart';

class ProfileShowcaseDataSource {
  const ProfileShowcaseDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<ProfileShowcase> getProfileShowcase() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/users/me/showcase',
    );
    return ProfileShowcase.fromJson(_dataFromEnvelope(response));
  }

  Map<String, dynamic> _dataFromEnvelope(Map<String, dynamic> response) {
    final data = response['data'];
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    throw const FormatException(
      'Profile showcase response does not contain a valid data object.',
    );
  }
}

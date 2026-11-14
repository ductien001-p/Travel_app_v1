import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/chats_hub_models.dart';

abstract class ChatsHubDataSource {
  Future<ChatsHub> getHub();
}

class ChatsHubRemoteDataSource implements ChatsHubDataSource {
  const ChatsHubRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<ChatsHub> getHub() async {
    final response = await _apiClient.get<Map<String, dynamic>>('/chats/hub');
    return ChatsHub.fromJson(_dataFromEnvelope(response));
  }

  Map<String, dynamic> _dataFromEnvelope(Map<String, dynamic> response) {
    final data = response['data'];
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    throw const FormatException(
      'Chat hub response does not contain a valid data object.',
    );
  }
}

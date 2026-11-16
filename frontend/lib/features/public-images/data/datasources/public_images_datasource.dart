import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/public_image_models.dart';

abstract class PublicImagesDataSource {
  Future<PublicImageAlbum> getAlbum(String albumId);
}

class PublicImagesRemoteDataSource implements PublicImagesDataSource {
  const PublicImagesRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<PublicImageAlbum> getAlbum(String albumId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/public-images/albums/${Uri.encodeComponent(albumId)}',
    );
    return PublicImageAlbum.fromJson(_dataFromEnvelope(response));
  }

  Map<String, dynamic> _dataFromEnvelope(Map<String, dynamic> response) {
    final data = response['data'];
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    throw const FormatException(
      'Public images response does not contain a valid data object.',
    );
  }
}

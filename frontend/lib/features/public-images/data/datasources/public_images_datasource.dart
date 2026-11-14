import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/public_image_models.dart';

abstract class PublicImagesDataSource {
  Future<PublicImageAlbum> getAlbum(String albumId);

  Future<void> setAsCover({required String albumId, required String imageId});

  Future<void> deleteImage({required String albumId, required String imageId});

  Future<PublicImageItem> toggleLike({
    required String albumId,
    required String imageId,
  });
}

class PublicImagesRemoteDataSource implements PublicImagesDataSource {
  const PublicImagesRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<PublicImageAlbum> getAlbum(String albumId) async {
    // TODO(backend): API demo — thay bằng endpoint thật khi backend xong
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/public-images/albums/${Uri.encodeComponent(albumId)}',
    );
    return PublicImageAlbum.fromJson(_dataFromEnvelope(response));
  }

  @override
  Future<void> setAsCover({
    required String albumId,
    required String imageId,
  }) async {
    // TODO(backend): API demo — thay bằng endpoint thật khi backend xong
    await _apiClient.post<Map<String, dynamic>>(
      '/public-images/albums/${Uri.encodeComponent(albumId)}/cover',
      data: <String, dynamic>{'imageId': imageId},
    );
  }

  @override
  Future<void> deleteImage({
    required String albumId,
    required String imageId,
  }) async {
    // TODO(backend): API demo — thay bằng endpoint thật khi backend xong
    await _apiClient.delete<Map<String, dynamic>>(
      '/public-images/albums/${Uri.encodeComponent(albumId)}/images/${Uri.encodeComponent(imageId)}',
    );
  }

  @override
  Future<PublicImageItem> toggleLike({
    required String albumId,
    required String imageId,
  }) async {
    // TODO(backend): API demo — thay bằng endpoint thật khi backend xong
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/public-images/albums/${Uri.encodeComponent(albumId)}/images/${Uri.encodeComponent(imageId)}/like',
    );
    return PublicImageItem.fromJson(_dataFromEnvelope(response));
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

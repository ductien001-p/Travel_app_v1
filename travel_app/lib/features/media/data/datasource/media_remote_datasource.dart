import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../media_backend_contract.dart';

import '../models/complete_upload_item.dart';
import '../models/media_upload_folder.dart';
import '../models/presign_multiple_response.dart';
import '../models/upload_source.dart';
import '../models/uploaded_media.dart';

class MediaRemoteDataSource {
  MediaRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<PresignMultipleResponse> presignMultiple({
    required MediaUploadFolder folder,

    required List<UploadSource> sources,
  }) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      MediaBackendContract.presignMultiplePath,

      data: MediaBackendContract.buildPresignMultipleBody(
        folder: folder,
        sources: sources,
      ),
    );

    return MediaBackendContract.parsePresignResponse(body);
  }

  Future<List<UploadedMedia>> completeMultiple({
    required List<CompleteUploadItem> items,
  }) async {
    final body = await _apiClient.post<Object?>(
      MediaBackendContract.completeMultiplePath,

      data: MediaBackendContract.buildCompleteBody(items: items),
    );

    return MediaBackendContract.parseCompleteResponse(body);
  }

  Future<String> getMediaUrl(String mediaId) async {
    final body = await _apiClient.get<Map<String, dynamic>>('/media/$mediaId');

    final data = body['data'] as Map<String, dynamic>;

    return data['url'] as String;
  }

  Future<String> getOwnMediaUrl(String mediaId) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/media/own/$mediaId',
    );

    final data = body['data'] as Map<String, dynamic>;

    return data['url'] as String;
  }
}

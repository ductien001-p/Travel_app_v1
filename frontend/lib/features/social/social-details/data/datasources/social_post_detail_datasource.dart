import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/social_post_detail_models.dart';

abstract class SocialPostDetailDataSource {
  Future<SocialPostDetail> getPost(String postId);

  Future<SocialPostDetailCommentsPage> getComments({
    required String postId,
    int page = 1,
    int limit = 20,
  });

  Future<SocialPostDetailComment> createComment({
    required String postId,
    required String content,
  });

  Future<void> likePost(String postId);

  Future<void> unlikePost(String postId);

  Future<void> savePost(String postId);

  Future<void> unsavePost(String postId);

  Future<void> sharePost(String postId);
}

class SocialPostDetailRemoteDataSource implements SocialPostDetailDataSource {
  const SocialPostDetailRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<SocialPostDetail> getPost(String postId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/social/posts/${Uri.encodeComponent(postId)}',
    );
    return SocialPostDetail.fromJson(_dataFromEnvelope(response));
  }

  @override
  Future<SocialPostDetailCommentsPage> getComments({
    required String postId,
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/social/posts/${Uri.encodeComponent(postId)}/comments',
      queryParameters: <String, dynamic>{'page': page, 'limit': limit},
    );
    return SocialPostDetailCommentsPage.fromJson(response);
  }

  @override
  Future<SocialPostDetailComment> createComment({
    required String postId,
    required String content,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/social/posts/${Uri.encodeComponent(postId)}/comments',
      data: <String, dynamic>{'content': content},
    );
    return SocialPostDetailComment.fromJson(_dataFromEnvelope(response));
  }

  @override
  Future<void> likePost(String postId) async {
    await _apiClient.post<Map<String, dynamic>>(
      '/social/posts/${Uri.encodeComponent(postId)}/like',
    );
  }

  @override
  Future<void> unlikePost(String postId) async {
    await _apiClient.delete<Map<String, dynamic>>(
      '/social/posts/${Uri.encodeComponent(postId)}/like',
    );
  }

  @override
  Future<void> savePost(String postId) async {
    await _apiClient.post<Map<String, dynamic>>(
      '/social/posts/${Uri.encodeComponent(postId)}/save',
    );
  }

  @override
  Future<void> unsavePost(String postId) async {
    await _apiClient.delete<Map<String, dynamic>>(
      '/social/posts/${Uri.encodeComponent(postId)}/save',
    );
  }

  @override
  Future<void> sharePost(String postId) async {
    await _apiClient.post<Map<String, dynamic>>(
      '/social/posts/${Uri.encodeComponent(postId)}/share',
    );
  }

  Map<String, dynamic> _dataFromEnvelope(Map<String, dynamic> response) {
    final data = response['data'];
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    throw const FormatException(
      'Social post detail response does not contain a valid data object.',
    );
  }
}

import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/social_feed_models.dart';
import '../models/social_post_comment.dart';
import '../models/social_post_detail_mapper.dart';

class SocialFeedQuery {
  const SocialFeedQuery({
    this.tab = 'explore',
    this.topic,
    this.page = 1,
    this.limit = 10,
    this.lat,
    this.lng,
  });

  final String tab;
  final String? topic;
  final int page;
  final int limit;
  final double? lat;
  final double? lng;
}

abstract class SocialFeedDataSource {
  Future<SocialFeed> getFeed(SocialFeedQuery query);

  Future<void> likePost(String postId);

  Future<void> unlikePost(String postId);

  Future<void> savePost(String postId);

  Future<void> unsavePost(String postId);

  Future<void> sharePost(String postId);

  Future<SocialPostCommentsPage> getComments({
    required String postId,
    int page = 1,
    int limit = 20,
  });

  Future<SocialPostComment> createComment({
    required String postId,
    required String content,
  });

  Future<SocialFeedChallenge> joinChallenge(String challengeId);

  Future<void> createPost({
    required String caption,
    required List<String> mediaIds,
    String? tipTitle,
    String? tipBody,
    String? topic,
    String? placeDetail,
  });

  Future<SocialFeedStory> createStory({
    required String mediaId,
    required String label,
    bool isLive = false,
  });

  Future<SocialFeedReviewPost> getPost(String postId);
}

class SocialFeedRemoteDataSource implements SocialFeedDataSource {
  const SocialFeedRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<SocialFeed> getFeed(SocialFeedQuery query) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/social/feed',
      queryParameters: <String, dynamic>{
        'tab': query.tab,
        'page': query.page,
        'limit': query.limit,
        if (query.topic != null && query.topic!.isNotEmpty)
          'topic': query.topic,
        if (query.lat != null) 'lat': query.lat,
        if (query.lng != null) 'lng': query.lng,
      },
    );
    return SocialFeed.fromJson(_dataFromEnvelope(response));
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

  @override
  Future<SocialPostCommentsPage> getComments({
    required String postId,
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/social/posts/${Uri.encodeComponent(postId)}/comments',
      queryParameters: <String, dynamic>{'page': page, 'limit': limit},
    );
    return SocialPostCommentsPage.fromJson(response);
  }

  @override
  Future<SocialPostComment> createComment({
    required String postId,
    required String content,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/social/posts/${Uri.encodeComponent(postId)}/comments',
      data: <String, dynamic>{'content': content},
    );
    return SocialPostComment.fromJson(_dataFromEnvelope(response));
  }

  @override
  Future<SocialFeedChallenge> joinChallenge(String challengeId) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/social/challenges/${Uri.encodeComponent(challengeId)}/join',
    );
    return SocialFeedChallenge.fromJson(_dataFromEnvelope(response));
  }

  @override
  Future<void> createPost({
    required String caption,
    required List<String> mediaIds,
    String? tipTitle,
    String? tipBody,
    String? topic,
    String? placeDetail,
  }) async {
    await _apiClient.post<Map<String, dynamic>>(
      '/social/posts',
      data: <String, dynamic>{
        'caption': caption,
        'mediaIds': mediaIds,
        if (tipTitle != null && tipTitle.isNotEmpty) 'tipTitle': tipTitle,
        if (tipBody != null && tipBody.isNotEmpty) 'tipBody': tipBody,
        if (topic != null && topic.isNotEmpty) 'topic': topic,
        if (placeDetail != null && placeDetail.isNotEmpty)
          'placeDetail': placeDetail,
      },
    );
  }

  @override
  Future<SocialFeedStory> createStory({
    required String mediaId,
    required String label,
    bool isLive = false,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/social/stories',
      data: <String, dynamic>{
        'mediaId': mediaId,
        'label': label,
        'isLive': isLive,
      },
    );
    return SocialFeedStory.fromJson(_dataFromEnvelope(response));
  }

  @override
  Future<SocialFeedReviewPost> getPost(String postId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/social/posts/${Uri.encodeComponent(postId)}',
    );
    return socialPostDetailToReview(_dataFromEnvelope(response));
  }

  Map<String, dynamic> _dataFromEnvelope(Map<String, dynamic> response) {
    final data = response['data'];
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    throw const FormatException(
      'Social feed response does not contain a valid data object.',
    );
  }
}

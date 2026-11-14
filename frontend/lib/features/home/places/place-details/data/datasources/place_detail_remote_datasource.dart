import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/place_detail_models.dart';

abstract class PlaceDetailDataSource {
  Future<PlaceDetailApi> getPlace(String placeId);

  Future<PlaceRatingSummaryApi> getSummary(String placeId);

  Future<PlaceReviewsPage> getReviews(
    String placeId, {
    required int page,
    int limit = 10,
  });

  Future<PlaceReviewApi?> getMyReview(String placeId);

  Future<PlaceReviewApi> createReview(
    String placeId, {
    required int rating,
    String? comment,
  });

  Future<void> deleteReview(String reviewId);

  Future<bool> getSaveStatus(String placeId);

  Future<PlacePostsPage> getPosts(
    String placeId, {
    required int page,
    int limit = 8,
  });
}

class PlaceDetailRemoteDataSource implements PlaceDetailDataSource {
  const PlaceDetailRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<PlaceDetailApi> getPlace(String placeId) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/places/${Uri.encodeComponent(placeId)}',
    );
    return _object(body, PlaceDetailApi.fromJson);
  }

  @override
  Future<PlaceRatingSummaryApi> getSummary(String placeId) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/places/${Uri.encodeComponent(placeId)}/reviews/summary',
    );
    return _object(body, PlaceRatingSummaryApi.fromJson);
  }

  @override
  Future<PlaceReviewsPage> getReviews(
    String placeId, {
    required int page,
    int limit = 10,
  }) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/places/${Uri.encodeComponent(placeId)}/reviews',
      queryParameters: {'page': page, 'limit': limit},
    );
    return PlaceReviewsPage.fromJson(body);
  }

  @override
  Future<PlaceReviewApi?> getMyReview(String placeId) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/places/${Uri.encodeComponent(placeId)}/reviews/me',
    );
    final data = body['data'];
    if (data == null) return null;
    if (data is! Map) {
      throw const FormatException('Invalid my review response.');
    }
    return PlaceReviewApi.fromJson(Map<String, dynamic>.from(data));
  }

  @override
  Future<PlaceReviewApi> createReview(
    String placeId, {
    required int rating,
    String? comment,
  }) async {
    final trimmed = comment?.trim();
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/places/${Uri.encodeComponent(placeId)}/reviews',
      data: {
        'rating': rating,
        if (trimmed != null && trimmed.isNotEmpty) 'comment': trimmed,
      },
    );
    return _object(body, PlaceReviewApi.fromJson);
  }

  @override
  Future<void> deleteReview(String reviewId) async {
    final body = await _apiClient.delete<Map<String, dynamic>>(
      '/places/reviews/${Uri.encodeComponent(reviewId)}',
    );
    if (body['success'] != true) {
      throw const FormatException('Invalid delete review response.');
    }
  }

  @override
  Future<bool> getSaveStatus(String placeId) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/places/${Uri.encodeComponent(placeId)}/save/status',
    );
    return _object(body, PlaceSaveStatusApi.fromJson).saved;
  }

  @override
  Future<PlacePostsPage> getPosts(
    String placeId, {
    required int page,
    int limit = 8,
  }) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/social/posts/place/${Uri.encodeComponent(placeId)}',
      queryParameters: {'page': page, 'limit': limit},
    );
    return PlacePostsPage.fromJson(body);
  }
}

T _object<T>(
  Map<String, dynamic> body,
  T Function(Map<String, dynamic> json) parse,
) {
  final data = body['data'];
  if (data is! Map) {
    throw const FormatException('Invalid place detail response.');
  }
  return parse(Map<String, dynamic>.from(data));
}

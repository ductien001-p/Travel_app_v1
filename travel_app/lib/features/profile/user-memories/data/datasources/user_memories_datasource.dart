import 'package:flutter/foundation.dart';
import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/user_memories_models.dart';

class UserMemoriesDataSource {
  const UserMemoriesDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  /// Lets tests subclass the source without a live client. Production always
  /// uses [UserMemoriesDataSource.new].
  @visibleForTesting
  const UserMemoriesDataSource.testing() : _apiClient = null;

  final ApiClient? _apiClient;

  ApiClient get _client {
    final client = _apiClient;
    if (client == null) {
      throw StateError('ApiClient is required');
    }
    return client;
  }

  /// `GET /trips/memories/mine`. [year] and [month] are the viewer's calendar
  /// month; [utcOffsetMinutes] is the device offset east of UTC.
  Future<UserMemoriesPage> getMine({
    String? tripId,
    required int year,
    required int month,
    required int utcOffsetMinutes,
    String? cursor,
    int limit = 20,
    String? q,
  }) async {
    final body = await _client.get<Map<String, dynamic>>(
      '/trips/memories/mine',
      queryParameters: {
        'limit': limit,
        'year': year,
        'month': month,
        'utcOffsetMinutes': utcOffsetMinutes,
        'tripId': ?tripId,
        'cursor': ?cursor,
        'q': ?q,
      },
    );
    if (body['data'] is! List || body['meta'] is! Map) {
      throw const FormatException('Invalid memories response.');
    }
    return UserMemoriesPage.fromJson(body);
  }

  /// `POST /trips/memories/{memoryId}/like`.
  Future<UserMemoryLike> like(String memoryId) {
    return _like(memoryId, unlike: false);
  }

  /// `DELETE /trips/memories/{memoryId}/like`.
  Future<UserMemoryLike> unlike(String memoryId) {
    return _like(memoryId, unlike: true);
  }

  Future<UserMemoryLike> _like(String memoryId, {required bool unlike}) async {
    final path = '/trips/memories/${Uri.encodeComponent(memoryId)}/like';
    final body = unlike
        ? await _client.delete<Map<String, dynamic>>(path)
        : await _client.post<Map<String, dynamic>>(path);
    if (body['likeCount'] is! num || body['liked'] is! bool) {
      throw const FormatException('Invalid memory like response.');
    }
    return UserMemoryLike.fromJson(body);
  }
}

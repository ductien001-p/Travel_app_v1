import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/trip_memory_models.dart';

/// Method names follow `TripsController` in the backend.
class TripMemoriesRemoteDataSource {
  const TripMemoriesRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// `GET /trips/memories/{tripId}` — cursor paging, newest first.
  ///
  /// [day] is the 1-based trip day (UTC) and [uploaderId] the user who posted
  /// the photo; omit them for every memory. A cursor is only valid with the
  /// filters it was issued for, and the totals only come with the first page.
  Future<TripMemoriesPage> getMemories(
    String tripId, {
    required int limit,
    String? cursor,
    int? day,
    String? uploaderId,
  }) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/memories/${Uri.encodeComponent(tripId)}',
      queryParameters: {
        'limit': limit,
        'cursor': ?cursor,
        'day': ?day,
        'userId': ?uploaderId,
      },
    );
    if (body['data'] is! List || body['meta'] is! Map) {
      throw const FormatException('Invalid trip memories response.');
    }
    return TripMemoriesPage.fromJson(body);
  }

  /// `POST /trips/memories/{tripId}/batch` — at most
  /// [maxBatchSize] photos, announced by one timeline event.
  Future<List<TripMemoryEntry>> createTripMemories(
    String tripId,
    List<NewTripMemory> items,
  ) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trips/memories/${Uri.encodeComponent(tripId)}/batch',
      data: {'items': items.map((item) => item.toJson()).toList()},
    );
    final data = body['data'];
    if (data is! List) {
      throw const FormatException('Invalid create memories response.');
    }
    return data
        .map(
          (item) =>
              TripMemoryEntry.fromJson(Map<String, dynamic>.from(item as Map)),
        )
        .toList(growable: false);
  }

  /// `PATCH /trips/memories/{memoryId}` — caption only; uploader only.
  Future<TripMemoryEntry> updateMemory(
    String memoryId, {
    required String? caption,
  }) async {
    final body = await _apiClient.patch<Map<String, dynamic>>(
      '/trips/memories/${Uri.encodeComponent(memoryId)}',
      data: {'caption': caption},
    );
    final data = body['data'];
    if (data is! Map) {
      throw const FormatException('Invalid update memory response.');
    }
    return TripMemoryEntry.fromJson(Map<String, dynamic>.from(data));
  }

  /// `DELETE /trips/memories/{memoryId}` — the uploader, or an owner/admin.
  Future<void> deleteMemory(String memoryId) async {
    await _apiClient.delete<Map<String, dynamic>>(
      '/trips/memories/${Uri.encodeComponent(memoryId)}',
    );
  }

  /// `CreateMemoriesBatchDto.items` accepts 1..20 photos.
  /// Single-photo create uses this batch endpoint with one item.
  static const maxBatchSize = 20;
}

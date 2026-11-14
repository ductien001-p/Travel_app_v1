import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/trip_timeline_models.dart';

class TripTimelineRemoteDataSource {
  const TripTimelineRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// `GET /trips/timeline/{tripId}` — cursor paging, newest first.
  ///
  /// [category] is one of `checkin`, `expense`, `memory`, `member`; omit it for
  /// every event. A cursor is only valid with the category it was issued for.
  Future<TripTimelinePage> getTripTimeline(
    String tripId, {
    required int limit,
    String? cursor,
    String? category,
  }) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/timeline/${Uri.encodeComponent(tripId)}',
      queryParameters: {
        'limit': limit,
        'cursor': ?cursor,
        'category': ?category,
      },
    );
    if (body['data'] is! List || body['meta'] is! Map) {
      throw const FormatException('Invalid trip timeline response.');
    }
    return TripTimelinePage.fromJson(body);
  }
}

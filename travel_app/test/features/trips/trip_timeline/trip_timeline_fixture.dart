import 'package:travel_frontend_v1/core/networks/api_client.dart';
import 'package:travel_frontend_v1/core/storage/token_storage.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/data/datamock/trip_timeline_datamock.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/data/datasources/trip_timeline_remote_datasource.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/data/models/trip_timeline_models.dart';

/// "Today" of the datamock, so its events group as Hôm nay / Hôm qua.
final timelineNow = DateTime.utc(2025, 7, 21, 18);

/// A device on UTC, so expectations do not depend on the test machine.
DateTime utcWallClock(DateTime instant) => instant.toUtc();

/// A device in Vietnam (UTC+7).
DateTime vietnamWallClock(DateTime instant) =>
    instant.toUtc().add(const Duration(hours: 7));

Map<String, dynamic> timelineDatamockPage() =>
    Map<String, dynamic>.from(tripTimelineDatamock['tripTimelinePage'] as Map);

Map<String, dynamic> timelineEventJson({
  required String id,
  String tripId = 'trip-1',
  String type = 'ACTIVITY_ADDED',
  String content = 'Đã thêm một hoạt động mới',
  String createdAt = '2025-07-21T10:00:00.000Z',
  String memberId = 'member-1',
  String displayName = 'Alex Nguyễn',
  String? targetType,
  String? targetId,
  Map<String, dynamic>? metadata,
}) => {
  'id': id,
  'tripId': tripId,
  'memberId': memberId,
  'type': type,
  'content': content,
  'createdAt': createdAt,
  'targetType': targetType,
  'targetId': targetId,
  'member': {
    'id': memberId,
    'user': {
      'id': 'user-1',
      'username': 'alex',
      'displayName': displayName,
      'avatarUrl': null,
    },
  },
  'metadata': metadata,
};

TripTimelineEntry timelineEntry({
  required String id,
  String tripId = 'trip-1',
  String type = 'ACTIVITY_ADDED',
  String createdAt = '2025-07-21T10:00:00.000Z',
}) => TripTimelineEntry.fromJson(
  timelineEventJson(id: id, tripId: tripId, type: type, createdAt: createdAt),
);

Map<String, dynamic> timelinePageJson(
  List<Map<String, dynamic>> events, {
  String? nextCursor,
  Map<String, int>? counts,
}) => {
  'data': events,
  'meta': {
    'nextCursor': nextCursor,
    'hasMore': nextCursor != null,
    'counts': counts,
  },
};

/// Serves pages keyed by category and cursor (`null` = all / first page). A
/// value that is not a map is thrown instead of returned.
class FakeTripTimelineDataSource extends TripTimelineRemoteDataSource {
  FakeTripTimelineDataSource(
    Map<String?, Object> pages, {
    Map<String, Map<String?, Object>> categoryPages = const {},
  }) : pagesByCategory = {null: pages, ...categoryPages},
       super(
         apiClient: ApiClient(
           tokenStorage: TokenStorage(),
           onSessionExpired: () {},
         ),
       );

  final Map<String?, Map<String?, Object>> pagesByCategory;
  final requests = <({String? category, String? cursor})>[];

  /// Pages of the unfiltered timeline.
  Map<String?, Object> get pages => pagesByCategory[null]!;

  List<String?> get requestedCursors => [
    for (final request in requests) request.cursor,
  ];

  @override
  Future<TripTimelinePage> getTripTimeline(
    String tripId, {
    required int limit,
    String? cursor,
    String? category,
  }) async {
    requests.add((category: category, cursor: cursor));
    final result = pagesByCategory[category]?[cursor];
    if (result is Map<String, dynamic>) {
      return TripTimelinePage.fromJson(result);
    }
    throw result ?? StateError('No page for $category / $cursor');
  }
}

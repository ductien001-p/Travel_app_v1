import '../datasources/trip_timeline_remote_datasource.dart';
import '../models/trip_timeline_models.dart';

class TripTimelineRepository {
  const TripTimelineRepository({
    required TripTimelineRemoteDataSource remoteDataSource,
  }) : _remote = remoteDataSource;

  /// Backend accepts 1..100; 30 is its default page size.
  static const pageSize = 30;

  final TripTimelineRemoteDataSource _remote;

  Future<TripTimelinePage> getTripTimeline(
    String tripId, {
    String? cursor,
    String? category,
  }) => _remote.getTripTimeline(
    tripId,
    limit: pageSize,
    cursor: cursor,
    category: category,
  );
}

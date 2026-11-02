import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/trip_timeline_remote_datasource.dart';
import '../data/repositories/trip_timeline_repository.dart';

final tripTimelineRemoteDataSourceProvider =
    Provider<TripTimelineRemoteDataSource>(
      (ref) =>
          TripTimelineRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
    );

final tripTimelineRepositoryProvider = Provider<TripTimelineRepository>(
  (ref) => TripTimelineRepository(
    remoteDataSource: ref.watch(tripTimelineRemoteDataSourceProvider),
  ),
);

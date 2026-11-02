import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/trip_join_requests_datasource.dart';
import '../data/datasources/trip_join_requests_remote_datasource.dart';
import '../data/repositories/trip_join_requests_repository.dart';

final tripJoinRequestsDataSourceProvider = Provider<TripJoinRequestsDataSource>(
  (ref) =>
      TripJoinRequestsRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
);

final tripJoinRequestsRepositoryProvider = Provider<TripJoinRequestsRepository>(
  (ref) => TripJoinRequestsRepository(
    dataSource: ref.watch(tripJoinRequestsDataSourceProvider),
  ),
);

/// Current time, overridable so relative times are stable in tests.
final tripJoinRequestsClockProvider = Provider<DateTime Function()>(
  (ref) => DateTime.now,
);

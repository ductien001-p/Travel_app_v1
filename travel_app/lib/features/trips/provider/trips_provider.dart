import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/trip_remote_datasource.dart';
import '../data/repositories/trip_repository.dart';

final tripRemoteDataSourceProvider = Provider<TripRemoteDataSource>(
  (ref) => TripRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
);

final tripRepositoryProvider = Provider<TripRepository>(
  (ref) =>
      TripRepository(remoteDataSource: ref.watch(tripRemoteDataSourceProvider)),
);

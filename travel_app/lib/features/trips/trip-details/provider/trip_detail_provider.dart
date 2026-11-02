import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/trip_detail_remote_datasource.dart';
import '../data/repositories/trip_detail_repository.dart';

final tripDetailRemoteDataSourceProvider = Provider<TripDetailRemoteDataSource>(
  (ref) => TripDetailRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
);

final tripDetailRepositoryProvider = Provider<TripDetailRepository>(
  (ref) => TripDetailRepository(
    remoteDataSource: ref.watch(tripDetailRemoteDataSourceProvider),
  ),
);

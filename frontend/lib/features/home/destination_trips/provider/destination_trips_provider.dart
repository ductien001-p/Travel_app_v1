import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/destination_trips_datasource.dart';
import '../data/datasources/destination_trips_remote_datasource.dart';
import '../data/repositories/destination_trips_repository.dart';

final destinationTripsDataSourceProvider = Provider<DestinationTripsDataSource>(
  (ref) =>
      DestinationTripsRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
);

final destinationTripsRepositoryProvider = Provider<DestinationTripsRepository>(
  (ref) => DestinationTripsRepository(
    dataSource: ref.watch(destinationTripsDataSourceProvider),
  ),
);

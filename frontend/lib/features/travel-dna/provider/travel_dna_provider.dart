import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/travel_dna_remote_datasource.dart';
import '../data/repositories/travel_dna_repository.dart';

final travelDnaRemoteDataSourceProvider = Provider<TravelDnaRemoteDataSource>(
  (ref) => TravelDnaRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
);

final travelDnaRepositoryProvider = Provider<TravelDnaRepository>(
  (ref) => TravelDnaRepository(
    dataSource: ref.watch(travelDnaRemoteDataSourceProvider),
  ),
);

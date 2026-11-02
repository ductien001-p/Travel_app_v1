import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/explore_home_datasource.dart';
import '../data/datasources/explore_home_remote_datasource.dart';
import '../data/repositories/explore_home_repository.dart';

final exploreHomeDataSourceProvider = Provider<ExploreHomeDataSource>(
  (ref) => ExploreHomeRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
);

final exploreHomeRepositoryProvider = Provider<ExploreHomeRepository>(
  (ref) => ExploreHomeRepository(
    dataSource: ref.watch(exploreHomeDataSourceProvider),
  ),
);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/explore_places_datasource.dart';
import '../data/datasources/explore_places_remote_datasource.dart';
import '../data/repositories/explore_places_repository.dart';

final explorePlacesDataSourceProvider = Provider<ExplorePlacesDataSource>(
  (ref) =>
      ExplorePlacesRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
);

final explorePlacesRepositoryProvider = Provider<ExplorePlacesRepository>(
  (ref) => ExplorePlacesRepository(
    dataSource: ref.watch(explorePlacesDataSourceProvider),
  ),
);

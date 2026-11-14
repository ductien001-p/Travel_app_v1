import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/saved_places_datasource.dart';
import '../data/repositories/saved_places_repository.dart';

final savedPlacesDataSourceProvider = Provider<SavedPlacesDataSource>(
  (ref) => SavedPlacesDataSource(apiClient: ref.watch(apiClientProvider)),
);

final savedPlacesRepositoryProvider = Provider<SavedPlacesRepository>(
  (ref) => SavedPlacesRepository(
    dataSource: ref.watch(savedPlacesDataSourceProvider),
  ),
);

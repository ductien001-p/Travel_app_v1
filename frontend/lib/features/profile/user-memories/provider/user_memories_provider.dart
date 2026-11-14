import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/user_memories_datasource.dart';
import '../data/repositories/user_memories_repository.dart';

final userMemoriesDataSourceProvider = Provider<UserMemoriesDataSource>(
  (ref) => UserMemoriesDataSource(apiClient: ref.watch(apiClientProvider)),
);

final userMemoriesRepositoryProvider = Provider<UserMemoriesRepository>(
  (ref) => UserMemoriesRepository(
    dataSource: ref.watch(userMemoriesDataSourceProvider),
  ),
);

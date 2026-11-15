import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/achivement_datasource.dart';
import '../data/repositories/achivement_repository.dart';

final achivementDataSourceProvider = Provider<AchivementDataSource>(
  (ref) => AchivementRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
);

final achivementRepositoryProvider = Provider<AchivementRepository>(
  (ref) =>
      AchivementRepository(dataSource: ref.watch(achivementDataSourceProvider)),
);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/ranking_datasource.dart';
import '../data/repositories/ranking_repository.dart';

final rankingDataSourceProvider = Provider<RankingDataSource>(
  (ref) => RankingRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
);

final rankingRepositoryProvider = Provider<RankingRepository>(
  (ref) => RankingRepository(dataSource: ref.watch(rankingDataSourceProvider)),
);

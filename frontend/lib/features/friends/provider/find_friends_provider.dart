import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/find_friends_datasource.dart';
import '../data/repositories/find_friends_repository.dart';

final findFriendsDataSourceProvider = Provider<FindFriendsDataSource>(
  (ref) => FindFriendsRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
);

final findFriendsRepositoryProvider = Provider<FindFriendsRepository>(
  (ref) => FindFriendsRepository(
    dataSource: ref.watch(findFriendsDataSourceProvider),
  ),
);

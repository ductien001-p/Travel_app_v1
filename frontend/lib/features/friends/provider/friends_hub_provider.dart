import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/friends_hub_datasource.dart';
import '../data/repositories/friends_hub_repository.dart';

final friendsHubDataSourceProvider = Provider<FriendsHubDataSource>(
  (ref) => FriendsHubRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
);

final friendsHubRepositoryProvider = Provider<FriendsHubRepository>(
  (ref) =>
      FriendsHubRepository(dataSource: ref.watch(friendsHubDataSourceProvider)),
);

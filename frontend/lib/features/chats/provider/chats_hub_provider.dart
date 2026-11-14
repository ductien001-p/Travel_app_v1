import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/chats_hub_datasource.dart';
import '../data/repositories/chats_hub_repository.dart';

final chatsHubDataSourceProvider = Provider<ChatsHubDataSource>(
  (ref) => ChatsHubRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
);

final chatsHubRepositoryProvider = Provider<ChatsHubRepository>(
  (ref) =>
      ChatsHubRepository(dataSource: ref.watch(chatsHubDataSourceProvider)),
);

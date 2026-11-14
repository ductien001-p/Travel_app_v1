import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/friend_chat_datasource.dart';
import '../data/repositories/friend_chat_repository.dart';

final friendChatDataSourceProvider = Provider<FriendChatDataSource>(
  (ref) => FriendChatRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
);

final friendChatRepositoryProvider = Provider<FriendChatRepository>(
  (ref) =>
      FriendChatRepository(dataSource: ref.watch(friendChatDataSourceProvider)),
);

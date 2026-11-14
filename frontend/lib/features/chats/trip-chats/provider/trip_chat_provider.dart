import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/trip_chat_datasource.dart';
import '../data/repositories/trip_chat_repository.dart';

final tripChatDataSourceProvider = Provider<TripChatDataSource>(
  (ref) => TripChatRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
);

final tripChatRepositoryProvider = Provider<TripChatRepository>(
  (ref) =>
      TripChatRepository(dataSource: ref.watch(tripChatDataSourceProvider)),
);

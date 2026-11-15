import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/notifications_datasource.dart';
import '../data/repositories/notifications_repository.dart';

final notificationsDataSourceProvider = Provider<NotificationsDataSource>(
  (ref) => NotificationsRemoteDataSource(
    apiClient: ref.watch(apiClientProvider),
  ),
);

final notificationsRepositoryProvider = Provider<NotificationsRepository>(
  (ref) => NotificationsRepository(
    dataSource: ref.watch(notificationsDataSourceProvider),
  ),
);

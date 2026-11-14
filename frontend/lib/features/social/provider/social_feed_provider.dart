import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/social_feed_datasource.dart';
import '../data/repositories/social_feed_repository.dart';

final socialFeedDataSourceProvider = Provider<SocialFeedDataSource>(
  (ref) => SocialFeedRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
);

final socialFeedRepositoryProvider = Provider<SocialFeedRepository>(
  (ref) =>
      SocialFeedRepository(dataSource: ref.watch(socialFeedDataSourceProvider)),
);

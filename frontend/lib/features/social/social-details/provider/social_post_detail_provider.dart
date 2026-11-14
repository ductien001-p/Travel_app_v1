import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/social_post_detail_datasource.dart';
import '../data/repositories/social_post_detail_repository.dart';

final socialPostDetailDataSourceProvider = Provider<SocialPostDetailDataSource>(
  (ref) =>
      SocialPostDetailRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
);

final socialPostDetailRepositoryProvider = Provider<SocialPostDetailRepository>(
  (ref) => SocialPostDetailRepository(
    dataSource: ref.watch(socialPostDetailDataSourceProvider),
  ),
);

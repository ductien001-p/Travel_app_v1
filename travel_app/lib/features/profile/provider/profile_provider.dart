import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';
import 'package:travel_frontend_v1/features/media/providers/media_providers.dart';
import '../data/datasources/profile_remote_datasource.dart';
import '../data/datasources/profile_showcase_datasource.dart';
import '../data/repositories/profile_repository.dart';
import '../data/repositories/profile_showcase_repository.dart';

final profileRemoteDataSourceProvider = Provider<ProfileRemoteDataSource>(
  (ref) => ProfileRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
);
final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepository(
    remoteDataSource: ref.watch(profileRemoteDataSourceProvider),
    mediaRepository: ref.watch(mediaUploadRepositoryProvider),
  ),
);

final profileShowcaseDataSourceProvider = Provider<ProfileShowcaseDataSource>(
  (ref) => ProfileShowcaseDataSource(apiClient: ref.watch(apiClientProvider)),
);

final profileShowcaseRepositoryProvider = Provider<ProfileShowcaseRepository>(
  (ref) => ProfileShowcaseRepository(
    dataSource: ref.watch(profileShowcaseDataSourceProvider),
  ),
);

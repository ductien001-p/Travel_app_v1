import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/public_images_datasource.dart';
import '../data/repositories/public_images_repository.dart';

final publicImagesDataSourceProvider = Provider<PublicImagesDataSource>(
  (ref) =>
      PublicImagesRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
);

final publicImagesRepositoryProvider = Provider<PublicImagesRepository>(
  (ref) => PublicImagesRepository(
    dataSource: ref.watch(publicImagesDataSourceProvider),
  ),
);

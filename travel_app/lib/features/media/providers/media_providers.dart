import 'package:dio/dio.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';
import 'package:travel_frontend_v1/features/media/data/datasource/media_remote_datasource.dart';
import 'package:travel_frontend_v1/features/media/data/datasource/r2_upload_datasource.dart';
import 'package:travel_frontend_v1/features/media/data/repository/media_upload_repository.dart';

final mediaRemoteDataSourceProvider = Provider<MediaRemoteDataSource>((ref) {
  return MediaRemoteDataSource(apiClient: ref.watch(apiClientProvider));
});

final r2UploadDioProvider = Provider<Dio>((ref) {
  /*
     * CỰC KỲ QUAN TRỌNG:
     *
     * Dio này:
     *
     * - không NestJS baseUrl
     * - không JWT interceptor
     * - không access-token refresh
     */
  final dio = Dio();

  ref.onDispose(() {
    dio.close(force: true);
  });

  return dio;
});

final r2UploadDataSourceProvider = Provider<R2UploadDataSource>((ref) {
  return R2UploadDataSource(dio: ref.watch(r2UploadDioProvider));
});

final mediaUploadRepositoryProvider = Provider<MediaUploadRepository>((ref) {
  return MediaUploadRepository(
    remoteDataSource: ref.watch(mediaRemoteDataSourceProvider),

    r2UploadDataSource: ref.watch(r2UploadDataSourceProvider),
  );
});

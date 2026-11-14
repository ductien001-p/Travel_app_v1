import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/config/config.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';
import 'package:travel_frontend_v1/features/auth/data/repositories/auth_respository.dart';
import 'package:travel_frontend_v1/features/auth/services/google_auth_service.dart';

import '../data/datasources/auth_remote_datasource.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(apiClient: ref.watch(apiClientProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    tokenStorage: ref.watch(tokenStorageProvider),
    googleAuthService: ref.watch(googleAuthServiceProvider),
  );
});
final googleAuthServiceProvider = Provider<GoogleAuthService>((ref) {
  return GoogleAuthService(
    webClientId: AppConfig.googleWebClientId,

    iosClientId: AppConfig.googleIosClientId,
  );
});

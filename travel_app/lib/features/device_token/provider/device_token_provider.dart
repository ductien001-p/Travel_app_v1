import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';
import 'package:travel_frontend_v1/features/device_token/data/datasource/device_token_remote_datasource.dart';
import 'package:travel_frontend_v1/features/device_token/service/device_messaging_service.dart';
import '../data/repositories/device_token_repository.dart';

final firebaseMessagingProvider = Provider<FirebaseMessaging>((ref) {
  return FirebaseMessaging.instance;
});

final firebaseInstallationsProvider = Provider<FirebaseInstallations>((ref) {
  return FirebaseInstallations.instance;
});

final deviceMessagingServiceProvider = Provider<DeviceMessagingService>((ref) {
  return DeviceMessagingService(
    messaging: ref.watch(firebaseMessagingProvider),
    installations: ref.watch(firebaseInstallationsProvider),
  );
});

final deviceTokenRemoteDataSourceProvider =
    Provider<DeviceTokenRemoteDataSource>((ref) {
      return DeviceTokenRemoteDataSource(ref.watch(apiClientProvider));
    });

final deviceTokenRepositoryProvider = Provider<DeviceTokenRepository>((ref) {
  return DeviceTokenRepository(ref.watch(deviceTokenRemoteDataSourceProvider));
});

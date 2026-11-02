import 'package:travel_frontend_v1/features/device_token/data/datasource/device_token_remote_datasource.dart';
import 'package:travel_frontend_v1/features/device_token/data/model/device_platform.dart';
import 'package:travel_frontend_v1/features/device_token/data/model/register_device_token_request.dart';

class DeviceTokenRepository {
  const DeviceTokenRepository(this._remoteDataSource);

  final DeviceTokenRemoteDataSource _remoteDataSource;

  Future<void> register({
    required String installationId,
    required String token,
    required DevicePlatform platform,
  }) {
    return _remoteDataSource.register(
      RegisterDeviceTokenRequest(
        installationId: installationId,
        token: token,
        platform: platform,
      ),
    );
  }

  Future<void> unregister({required String installationId}) {
    return _remoteDataSource.unregister(installationId: installationId);
  }
}

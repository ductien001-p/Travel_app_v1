import 'package:travel_frontend_v1/core/networks/api_client.dart';
import 'package:travel_frontend_v1/features/device_token/data/model/register_device_token_request.dart';

class DeviceTokenRemoteDataSource {
  const DeviceTokenRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<void> register(RegisterDeviceTokenRequest request) async {
    await _apiClient.post<Object?>('/device-tokens', data: request.toJson());
  }

  Future<void> unregister({required String installationId}) async {
    await _apiClient.delete<Object?>(
      '/device-tokens/current',
      data: {'installationId': installationId},
    );
  }
}

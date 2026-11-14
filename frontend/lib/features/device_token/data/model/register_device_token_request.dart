import 'device_platform.dart';

class RegisterDeviceTokenRequest {
  const RegisterDeviceTokenRequest({
    required this.installationId,
    required this.token,
    required this.platform,
  });

  final String installationId;
  final String token;
  final DevicePlatform platform;

  Map<String, dynamic> toJson() {
    return {
      'installationId': installationId,
      'token': token,
      'platform': platform.apiValue,
    };
  }
}

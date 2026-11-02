import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:travel_frontend_v1/features/device_token/data/model/device_platform.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';

enum PushTokenAvailability {
  available,
  permissionDenied,
  waitingForApns,
  unavailable,
}

class PushTokenResult {
  const PushTokenResult({required this.status, this.token});

  final PushTokenAvailability status;
  final String? token;

  bool get hasToken =>
      status == PushTokenAvailability.available &&
      token != null &&
      token!.isNotEmpty;
}

class DeviceMessagingService {
  DeviceMessagingService({
    required FirebaseMessaging messaging,
    required FirebaseInstallations installations,
  }) : _messaging = messaging,
       _installations = installations;

  final FirebaseMessaging _messaging;
  final FirebaseInstallations _installations;

  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;

  Stream<String> get onInstallationIdChange => _installations.onIdChange;

  Future<String> getInstallationId() {
    return _installations.getId();
  }

  DevicePlatform get currentPlatform {
    if (Platform.isAndroid) {
      return DevicePlatform.android;
    }

    if (Platform.isIOS) {
      return DevicePlatform.ios;
    }

    throw UnsupportedError('DeviceToken only supports Android and iOS.');
  }

  Future<PushTokenResult> requestToken() async {
    if (!Platform.isAndroid && !Platform.isIOS) {
      throw UnsupportedError('FCM DeviceToken only supports Android and iOS.');
    }

    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      return const PushTokenResult(
        status: PushTokenAvailability.permissionDenied,
      );
    }

    if (Platform.isIOS) {
      final apnsToken = await _messaging.getAPNSToken();

      if (apnsToken == null || apnsToken.isEmpty) {
        /*
         * Không gọi getToken() khi APNs token
         * chưa sẵn sàng.
         *
         * onTokenRefresh sẽ xử lý tiếp khi
         * Firebase tạo được FCM token.
         */
        return const PushTokenResult(
          status: PushTokenAvailability.waitingForApns,
        );
      }
    }

    final token = await _messaging.getToken();

    if (token == null || token.isEmpty) {
      return const PushTokenResult(status: PushTokenAvailability.unavailable);
    }

    return PushTokenResult(
      status: PushTokenAvailability.available,
      token: token,
    );
  }

  Future<String?> getTokenWithoutPermissionPrompt() async {
    if (Platform.isIOS) {
      final apnsToken = await _messaging.getAPNSToken();

      if (apnsToken == null || apnsToken.isEmpty) {
        return null;
      }
    }

    return _messaging.getToken();
  }
}

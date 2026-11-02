import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _messaging;

  NotificationService({FirebaseMessaging? messaging})
    : _messaging = messaging ?? FirebaseMessaging.instance;

  Future<bool> requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );

    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  Future<String?> getFcmToken() async {
    try {
      await requestPermission();

      /*
       * iOS cần APNs token trước khi FCM token
       * được sử dụng ổn định.
       */
      if (Platform.isIOS) {
        final apnsToken = await _messaging.getAPNSToken();

        if (apnsToken == null) {
          return null;
        }
      }

      return await _messaging.getToken();
    } catch (e) {
      return null;
    }
  }

  Stream<String> get onTokenRefresh {
    return _messaging.onTokenRefresh;
  }

  Future<void> deleteFcmToken() async {
    await _messaging.deleteToken();
  }

  String getPlatform() {
    if (Platform.isAndroid) {
      return 'ANDROID';
    }

    if (Platform.isIOS) {
      return 'IOS';
    }

    return 'UNKNOWN';
  }
}

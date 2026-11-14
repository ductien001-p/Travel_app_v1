abstract final class AppConfig {
  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3001',
  );

  /// Socket.IO server of the trip rooms (`TripGateway`).
  static const socketUrl = String.fromEnvironment(
    'SOCKET_URL',
    defaultValue: 'http://localhost:3002',
  );
  static const googleWebClientId = String.fromEnvironment(
    'GOOGLE_WEB_CLIENT_ID',
    defaultValue:
        '271029663990-f3d5mqaf9js08m9mkuv2mscoidfo97t1.apps.googleusercontent.com',
  );

  static const googleIosClientId = String.fromEnvironment(
    'GOOGLE_IOS_CLIENT_ID',
    defaultValue:
        '271029663990-bmrus9rpnchb4g83ods7vo0vur61pr3s.apps.googleusercontent.com',
  );

  /// Host of shared itinerary links (`https://<host>/s/<token>`); empty
  /// disables incoming share links.
  static const shareHost = String.fromEnvironment('SHARE_HOST');
}

//lenh chay flutter run --dart-define-from-file=lib/core/config/dev.json

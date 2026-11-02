import 'package:flutter_driver/driver_extension.dart';
import 'package:travel_frontend_v1/main.dart' as app;

/// Debug-only entry point that lets Flutter Driver (and the Dart MCP server)
/// tap, scroll and read text in the running app. Never ship this target.
///
/// flutter run -t test_driver/app.dart --dart-define-from-file=lib/core/config/dev.json
void main() {
  enableFlutterDriverExtension();
  app.main();
}

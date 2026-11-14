import 'package:flutter_test/flutter_test.dart';

/// Credentials and toggles for live UI E2E runs.
///
/// Pass via `--dart-define-from-file=integration_test/e2e.json` (see
/// `e2e.example.json`). Call [ensureCredentialsOrSkip] at the start of each
/// test so missing secrets skip instead of hanging on login.
abstract final class E2eConfig {
  static const email = String.fromEnvironment('E2E_EMAIL');
  static const password = String.fromEnvironment('E2E_PASSWORD');

  /// Soft timeout for network-backed screens (login, lists, detail).
  static const settleTimeout = Duration(seconds: 45);

  static bool get hasCredentials =>
      email.trim().isNotEmpty && password.isNotEmpty;

  /// Returns false when credentials are missing (test already marked skipped).
  static bool ensureCredentialsOrSkip() {
    if (hasCredentials) return true;
    markTestSkipped(
      'Set E2E_EMAIL and E2E_PASSWORD via '
      '--dart-define-from-file=integration_test/e2e.json',
    );
    return false;
  }
}

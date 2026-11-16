import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:travel_frontend_v1/core/testing/e2e_keys.dart';

import '../support/e2e_config.dart';
import '../support/e2e_harness.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('inbox: Explore bell opens the notification screen', (
    tester,
  ) async {
    if (!E2eConfig.ensureCredentialsOrSkip()) return;
    await launchE2eApp(tester);
    await loginWithE2eUser(tester);

    await waitForFinder(
      tester,
      find.byKey(E2eKeys.homeNotifications),
      timeout: E2eConfig.settleTimeout,
    );
    await tester.tap(find.byKey(E2eKeys.homeNotifications));
    await tester.pump();

    await waitForFinder(
      tester,
      find.byKey(E2eKeys.notificationsScreenTitle),
      timeout: E2eConfig.settleTimeout,
    );
    expect(find.byKey(E2eKeys.notificationsScreenTitle), findsOneWidget);
  });
}

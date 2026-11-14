import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../support/e2e_config.dart';
import '../support/e2e_harness.dart';
import '../support/e2e_robots.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('profile: open profile → edit → back → saved places', (
    tester,
  ) async {
    if (!E2eConfig.ensureCredentialsOrSkip()) return;
    await launchE2eApp(tester);
    await loginWithE2eUser(tester);

    final shell = ShellRobot(tester);
    final profile = ProfileRobot(tester);

    await shell.openProfile();
    await profile.expectProfileScreen();
    await pumpQuietly(tester, duration: const Duration(seconds: 2));

    await profile.openEditProfile();
    await profile.expectEditProfileScreen();

    await tester.pageBack();
    await tester.pump();
    await profile.expectProfileScreen();

    await profile.openSavedTab();
    await pumpQuietly(tester, duration: const Duration(seconds: 1));
    await profile.openSavedPlacesSeeAll();
    await profile.expectSavedPlacesScreen();
  });
}

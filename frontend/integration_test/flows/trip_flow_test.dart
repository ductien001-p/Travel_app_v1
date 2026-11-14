import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../support/e2e_config.dart';
import '../support/e2e_harness.dart';
import '../support/e2e_robots.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('trip: Trips tab loads and opens create-trip step 1', (
    tester,
  ) async {
    if (!E2eConfig.ensureCredentialsOrSkip()) return;
    await launchE2eApp(tester);
    await loginWithE2eUser(tester);

    final shell = ShellRobot(tester);
    final trips = TripRobot(tester);

    await shell.openTrips();
    await trips.expectTripsScreen();
    await pumpQuietly(tester, duration: const Duration(seconds: 2));

    await trips.openCreateTripFromListFab();
    await trips.expectCreateTripScreen();
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:travel_frontend_v1/core/testing/e2e_keys.dart';

import 'support/e2e_config.dart';
import 'support/e2e_harness.dart';
import 'support/e2e_robots.dart';

/// Single-suite smoke: login then touch place / trip / profile surfaces.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('smoke: login → place segment → trips → profile', (tester) async {
    if (!E2eConfig.ensureCredentialsOrSkip()) return;
    await launchE2eApp(tester);
    await loginWithE2eUser(tester);

    final shell = ShellRobot(tester);
    final places = PlaceRobot(tester);
    final trips = TripRobot(tester);
    final profile = ProfileRobot(tester);

    await shell.openExplore();
    await places.selectPlacesSegment();
    expect(find.byKey(E2eKeys.homeSegmentPlaces), findsOneWidget);

    await shell.openTrips();
    await trips.expectTripsScreen();

    await shell.openProfile();
    await profile.expectProfileScreen();
  });
}

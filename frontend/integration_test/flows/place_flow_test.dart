import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../support/e2e_config.dart';
import '../support/e2e_harness.dart';
import '../support/e2e_robots.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('place: Explore → Địa Điểm → featured → place detail', (
    tester,
  ) async {
    if (!E2eConfig.ensureCredentialsOrSkip()) return;
    await launchE2eApp(tester);
    await loginWithE2eUser(tester);

    final shell = ShellRobot(tester);
    final places = PlaceRobot(tester);

    await shell.openExplore();
    await places.selectPlacesSegment();
    await pumpQuietly(tester, duration: const Duration(seconds: 3));

    // Prefer a card on Home; fall back to "see all" list if feed is empty.
    final hasFeatured = find
        .byWidgetPredicate(
          (widget) =>
              widget.key is ValueKey<String> &&
              (widget.key! as ValueKey<String>).value.startsWith(
                'featured-place-',
              ),
        )
        .evaluate()
        .isNotEmpty;

    if (hasFeatured) {
      await places.openFirstFeaturedPlace();
    } else {
      await places.openFeaturedSeeAll();
      await pumpQuietly(tester, duration: const Duration(seconds: 3));
      await places.openFirstFeaturedPlace();
    }

    await places.expectPlaceDetailVisible();
  });
}

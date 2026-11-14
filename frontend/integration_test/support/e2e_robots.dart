import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/testing/e2e_keys.dart';

import 'e2e_config.dart';
import 'e2e_harness.dart';

final class ShellRobot {
  ShellRobot(this.tester);

  final WidgetTester tester;

  Future<void> openExplore() => tapKey(tester, E2eKeys.navExplore);

  Future<void> openSocial() => tapKey(tester, E2eKeys.navSocial);

  Future<void> openTrips() => tapKey(tester, E2eKeys.navTrips);

  Future<void> openChat() => tapKey(tester, E2eKeys.navChat);

  Future<void> openProfile() => tapKey(tester, E2eKeys.navProfile);
}

final class PlaceRobot {
  PlaceRobot(this.tester);

  final WidgetTester tester;

  Future<void> selectPlacesSegment() =>
      tapKey(tester, E2eKeys.homeSegmentPlaces);

  Future<void> openFeaturedSeeAll() => tapKey(tester, E2eKeys.featuredSeeAll);

  Future<void> openFirstFeaturedPlace() async {
    final card = find.byWidgetPredicate((widget) {
      final key = widget.key;
      return key is ValueKey<String> &&
          key.value.startsWith('featured-place-');
    });
    await waitForFinder(tester, card, timeout: E2eConfig.settleTimeout);
    await tester.ensureVisible(card.first);
    await tester.tap(card.first);
    await tester.pump();
  }

  Future<void> expectPlaceDetailVisible() async {
    await waitForFinder(
      tester,
      find.byKey(E2eKeys.placeDetailName),
      timeout: E2eConfig.settleTimeout,
    );
    expect(find.byKey(E2eKeys.placeDetailName), findsOneWidget);
  }
}

final class TripRobot {
  TripRobot(this.tester);

  final WidgetTester tester;

  Future<void> expectTripsScreen() async {
    await waitForFinder(
      tester,
      find.byKey(E2eKeys.tripsScreenRoot),
      timeout: E2eConfig.settleTimeout,
    );
  }

  Future<void> openCreateTripFromListFab() =>
      tapKey(tester, E2eKeys.tripsCreateFab);

  Future<void> expectCreateTripScreen() async {
    await waitForFinder(
      tester,
      find.byKey(E2eKeys.createTripScreenRoot),
      timeout: E2eConfig.settleTimeout,
    );
    expect(find.textContaining('Thông tin chung'), findsWidgets);
  }
}

final class ProfileRobot {
  ProfileRobot(this.tester);

  final WidgetTester tester;

  Future<void> expectProfileScreen() async {
    await waitForFinder(
      tester,
      find.byKey(E2eKeys.profileScreenRoot),
      timeout: E2eConfig.settleTimeout,
    );
    expect(find.text('Hồ Sơ Cá Nhân'), findsOneWidget);
  }

  Future<void> openEditProfile() => tapKey(tester, E2eKeys.profileEditButton);

  Future<void> expectEditProfileScreen() async {
    await waitForFinder(
      tester,
      find.text('Chỉnh sửa hồ sơ'),
      timeout: E2eConfig.settleTimeout,
    );
  }

  Future<void> openSavedTab() => tapKey(tester, E2eKeys.profileSavedTab);

  Future<void> openSavedPlacesSeeAll() async {
    final seeAll = find.text('Xem tất cả');
    await waitForFinder(tester, seeAll, timeout: E2eConfig.settleTimeout);
    await tester.ensureVisible(seeAll.first);
    await tester.tap(seeAll.first);
    await tester.pump();
  }

  Future<void> expectSavedPlacesScreen() async {
    await waitForFinder(
      tester,
      find.byKey(E2eKeys.savedPlacesScreenRoot),
      timeout: E2eConfig.settleTimeout,
    );
  }
}

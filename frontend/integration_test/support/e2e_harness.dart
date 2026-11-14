import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/app/app.dart';
import 'package:travel_frontend_v1/core/deep_link/deep_link_service.dart';
import 'package:travel_frontend_v1/core/testing/e2e_keys.dart';
import 'package:travel_frontend_v1/features/device_token/application/device_token_controller.dart';
import 'package:travel_frontend_v1/features/device_token/application/device_token_state.dart';
import 'package:travel_frontend_v1/firebase_options.dart';

import 'e2e_config.dart';

bool _firebaseReady = false;

Future<void> ensureFirebaseForE2e() async {
  if (_firebaseReady) return;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  _firebaseReady = true;
}

/// Boots [TravelSocialApp] against the real API with flaky plugins muted.
Future<ProviderContainer> launchE2eApp(WidgetTester tester) async {
  await ensureFirebaseForE2e();

  final container = ProviderContainer(
    overrides: [
      deepLinkServiceProvider.overrideWithValue(
        const DeepLinkService(source: _SilentDeepLinks(), shareHost: ''),
      ),
      deviceTokenControllerProvider.overrideWith(_QuietDeviceToken.new),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const TravelSocialApp(),
    ),
  );
  await tester.pump();
  return container;
}

/// Login using [E2eConfig] credentials; leaves the shell on Explore.
Future<void> loginWithE2eUser(WidgetTester tester) async {
  if (!E2eConfig.ensureCredentialsOrSkip()) {
    throw StateError('E2E credentials missing');
  }

  await waitForFinder(
    tester,
    find.byKey(E2eKeys.loginEmail),
    timeout: E2eConfig.settleTimeout,
  );

  await tester.enterText(find.byKey(E2eKeys.loginEmail), E2eConfig.email);
  await tester.enterText(find.byKey(E2eKeys.loginPassword), E2eConfig.password);
  await tester.pump();
  await tester.tap(find.byKey(E2eKeys.loginSubmit));
  await tester.pump();

  await waitForFinder(
    tester,
    find.byKey(E2eKeys.navExplore),
    timeout: E2eConfig.settleTimeout,
  );
}

Future<void> waitForFinder(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 30),
  Duration step = const Duration(milliseconds: 200),
}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(step);
    if (finder.evaluate().isNotEmpty) return;
  }
  throw TestFailure('Timed out after $timeout waiting for $finder');
}

Future<void> tapKey(WidgetTester tester, Key key) async {
  final finder = find.byKey(key);
  await waitForFinder(tester, finder, timeout: E2eConfig.settleTimeout);
  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pump();
}

Future<void> pumpQuietly(
  WidgetTester tester, {
  Duration duration = const Duration(seconds: 2),
}) async {
  final end = DateTime.now().add(duration);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

class _SilentDeepLinks implements DeepLinkSource {
  const _SilentDeepLinks();

  @override
  Stream<Uri> get links => const Stream<Uri>.empty();
}

class _QuietDeviceToken extends DeviceTokenController {
  @override
  DeviceTokenState build() => const DeviceTokenState.idle();

  @override
  Future<void> registerAfterLogin() async {}

  @override
  Future<void> registerAfterSessionRestore() async {}

  @override
  Future<void> registerCurrentDevice({required bool requestPermission}) async {}

  @override
  void markSessionInactive() {}
}

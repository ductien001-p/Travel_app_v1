import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';
import 'package:travel_frontend_v1/features/profile/application/profile_controller.dart';
import 'package:travel_frontend_v1/features/profile/application/profile_showcase_controller.dart';
import 'package:travel_frontend_v1/features/profile/data/models/profile_model.dart';
import 'package:travel_frontend_v1/features/profile/data/models/profile_showcase_models.dart';
import 'package:travel_frontend_v1/features/profile/presentation/screens/profile_screen.dart';

import 'profile_showcase_fixture.dart';

void main() {
  testWidgets('shows Travel DNA profile and switches to the DNA tab', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 2200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final showcase = sampleProfileShowcase();
    final container = ProviderContainer(
      overrides: [
        profileControllerProvider.overrideWith(_FakeProfileController.new),
        profileShowcaseControllerProvider.overrideWith(
          () => _FakeShowcaseController(showcase),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: ProfileScreen()),
      ),
    );
    await tester.pump();

    expect(find.text('Hồ Sơ Cá Nhân'), findsOneWidget);
    expect(find.text('Alex Nguyễn'), findsOneWidget);
    expect(find.text('@alex_wander'), findsOneWidget);
    expect(find.text('Đà Nẵng, Việt Nam'), findsOneWidget);
    expect(find.text('Top 5% • Hạng Thám hiểm'), findsOneWidget);
    expect(find.text('Food Explorer'), findsOneWidget);
    expect(find.text('Chuyến đi (12)'), findsOneWidget);
    expect(find.text('1.250'), findsOneWidget);
    expect(find.text('Đường dài'), findsNothing);

    await tester.ensureVisible(find.text('Chỉ số DNA'));
    await tester.pump();
    await tester.tap(find.text('Chỉ số DNA'));
    await tester.pump();
    expect(find.text('Đường dài'), findsOneWidget);
    expect(find.text('Mùa Thu Tây Bắc & Săn Mây Y Tý'), findsNothing);

    await tester.tap(find.text('Đã lưu (24)'));
    await tester.pump();
    expect(find.text('Phố đèn lồng Hội An'), findsOneWidget);
  });

  testWidgets('Travel DNA button opens the signed-in user radar route', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final router = GoRouter(
      initialLocation: '/profile',
      routes: [
        GoRoute(
          path: '/profile',
          name: RouteNames.profile,
          builder: (context, state) => const ProfileScreen(),
          routes: [
            GoRoute(
              path: 'travel-dna',
              name: RouteNames.travelDnaRadar,
              builder: (context, state) =>
                  const Scaffold(body: Text('Travel DNA của tôi')),
            ),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);

    final container = ProviderContainer(
      overrides: [
        profileControllerProvider.overrideWith(_FakeProfileController.new),
        profileShowcaseControllerProvider.overrideWith(
          () => _FakeShowcaseController(sampleProfileShowcase()),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pump();

    expect(find.byIcon(Icons.share_outlined), findsNothing);
    final dnaButton = find.byWidgetPredicate(
      (widget) =>
          widget is AppIconButton && widget.semanticLabel == 'Xem Travel DNA',
    );
    expect(dnaButton, findsOneWidget);

    await tester.tap(dnaButton);
    await tester.pumpAndSettle();

    expect(router.state.uri.path, '/profile/travel-dna');
    expect(find.text('Travel DNA của tôi'), findsOneWidget);
  });

  testWidgets('Khoảnh khắc hành trình opens the memories gallery route', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final router = GoRouter(
      initialLocation: '/profile',
      routes: [
        GoRoute(
          path: '/profile',
          name: RouteNames.profile,
          builder: (context, state) => const ProfileScreen(),
          routes: [
            GoRoute(
              path: 'memories',
              name: RouteNames.userMemories,
              builder: (context, state) =>
                  const Scaffold(body: Text('Khoảnh khắc của tôi')),
            ),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);

    final container = ProviderContainer(
      overrides: [
        profileControllerProvider.overrideWith(_FakeProfileController.new),
        profileShowcaseControllerProvider.overrideWith(
          () => _FakeShowcaseController(sampleProfileShowcase()),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pump();

    await tester.ensureVisible(find.text('Khoảnh Khắc Hành Trình'));
    await tester.pump();
    await tester.tap(find.text('Khoảnh Khắc Hành Trình'));
    await tester.pumpAndSettle();

    expect(router.state.uri.path, '/profile/memories');
    expect(find.text('Khoảnh khắc của tôi'), findsOneWidget);
  });

  testWidgets('Đã lưu opens the saved places route', (tester) async {
    tester.view.physicalSize = const Size(390, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final router = GoRouter(
      initialLocation: '/profile',
      routes: [
        GoRoute(
          path: '/profile',
          name: RouteNames.profile,
          builder: (context, state) => const ProfileScreen(),
          routes: [
            GoRoute(
              path: 'saved-places',
              name: RouteNames.savedPlaces,
              builder: (context, state) =>
                  const Scaffold(body: Text('Địa điểm đã lưu của tôi')),
            ),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);

    final container = ProviderContainer(
      overrides: [
        profileControllerProvider.overrideWith(_FakeProfileController.new),
        profileShowcaseControllerProvider.overrideWith(
          () => _FakeShowcaseController(sampleProfileShowcase()),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pump();

    await tester.ensureVisible(find.text('Đã lưu (24)'));
    await tester.pump();
    await tester.tap(find.text('Đã lưu (24)'));
    await tester.pump();
    await tester.ensureVisible(find.text('Xem tất cả'));
    await tester.pump();
    await tester.tap(find.text('Xem tất cả'));
    await tester.pumpAndSettle();

    expect(router.state.uri.path, '/profile/saved-places');
    expect(find.text('Địa điểm đã lưu của tôi'), findsOneWidget);
  });
}

class _FakeProfileController extends ProfileController {
  @override
  Future<ProfileModel> build() async => const ProfileModel(
    id: 'user-1',
    displayName: 'Alex Nguyễn',
    username: 'alex_wander',
    email: 'alex@example.com',
    avatarId: null,
    bio:
        'Đam mê khám phá văn hóa bản địa, ẩm thực đường phố và chụp ảnh phong cảnh',
    phone: null,
    address: null,
    location: 'Đà Nẵng, Việt Nam',
    gender: null,
    dateOfBirth: null,
    budgetLevel: null,
    travelStyle: [],
    languages: [],
    interests: [],
    notificationEnabled: true,
    visitedCount: 18,
  );
}

class _FakeShowcaseController extends ProfileShowcaseController {
  _FakeShowcaseController(this.showcase);

  final ProfileShowcase showcase;

  @override
  Future<ProfileShowcase> build() async => showcase;
}

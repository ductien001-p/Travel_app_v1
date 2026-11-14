import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/application/trip_join_by_code_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/datamock/trip_join_by_code_datamock.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/models/trip_invite_preview_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/models/trip_join_request_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/presentation/screen/trip_join_by_code_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/provider/trip_join_requests_provider.dart';

import '../trip_join_requests/in_memory_trip_join_requests_datasource.dart';

/// Controllable join/preview backend for production-shaped UI cases.
class _ScriptedJoinDataSource extends InMemoryTripJoinRequestsDataSource {
  _ScriptedJoinDataSource({
    this.previewError,
    this.joinError,
    this.joinStatus = TripJoinRequestStatus.pending,
    this.previewDelay = Duration.zero,
    this.joinDelay = Duration.zero,
  }) : super(now: () => DateTime.utc(2025, 7, 10, 8));

  Object? previewError;
  Object? joinError;
  TripJoinRequestStatus joinStatus;
  Duration previewDelay;
  Duration joinDelay;

  @override
  Future<TripJoinInvitePreview> previewByInviteCode(String inviteCode) async {
    if (previewDelay > Duration.zero) {
      await Future<void>.delayed(previewDelay);
    }
    final error = previewError;
    if (error != null) throw error;
    return super.previewByInviteCode(inviteCode);
  }

  @override
  Future<TripJoinRequest> requestToJoin(
    String inviteCode, {
    String? message,
  }) async {
    if (joinDelay > Duration.zero) {
      await Future<void>.delayed(joinDelay);
    }
    final error = joinError;
    if (error != null) throw error;
    final request = await super.requestToJoin(inviteCode, message: message);
    return request.copyWith(status: joinStatus);
  }
}

void main() {
  Finder codeSlots(WidgetTester tester) => find.descendant(
    of: find.byType(TripJoinByCodeScreen),
    matching: find.byType(TextField),
  );

  Future<void> enterInviteCode(WidgetTester tester, String code) async {
    final slots = codeSlots(tester);
    await tester.enterText(slots.first, code);
    await tester.pump();
  }

  Future<void> tapVisible(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pump();
  }

  Future<ProviderContainer> pumpScreen(
    WidgetTester tester, {
    required _ScriptedJoinDataSource dataSource,
  }) async {
    tester.view.physicalSize = const Size(390, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    late ProviderContainer container;
    final router = GoRouter(
      initialLocation: '/trips/join',
      routes: [
        GoRoute(
          path: '/trips',
          name: RouteNames.trips,
          builder: (context, state) => const Scaffold(body: Text('Trips Tab')),
        ),
        GoRoute(
          path: '/trips/join',
          name: RouteNames.tripJoinByCode,
          builder: (context, state) => const TripJoinByCodeScreen(),
        ),
        GoRoute(
          path: '/trips/:tripId',
          name: RouteNames.tripDetail,
          builder: (context, state) =>
              Scaffold(body: Text('Detail ${state.pathParameters['tripId']}')),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tripJoinRequestsDataSourceProvider.overrideWithValue(dataSource),
        ],
        child: Builder(
          builder: (context) {
            container = ProviderScope.containerOf(context);
            return MaterialApp.router(routerConfig: router);
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    return container;
  }

  testWidgets('incomplete code keeps submit disabled and hides preview', (
    tester,
  ) async {
    await pumpScreen(tester, dataSource: _ScriptedJoinDataSource());

    await enterInviteCode(tester, 'HE20');
    await tester.pumpAndSettle();

    expect(find.text('Mã chuyến đi hợp lệ'), findsNothing);
    expect(find.textContaining('Mùa Hè'), findsNothing);
    final submit = tester.widgetList<AppButton>(find.byType(AppButton)).first;
    expect(submit.onPressed, isNull);
  });

  testWidgets('unknown invite code shows preview 404 error', (tester) async {
    await pumpScreen(
      tester,
      dataSource: _ScriptedJoinDataSource(
        previewError: const ApiException(
          message: 'Mã mời không hợp lệ',
          statusCode: 404,
        ),
        previewDelay: const Duration(milliseconds: 50),
      ),
    );

    await enterInviteCode(tester, 'ZZZZZZZZ');
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsWidgets);

    await tester.pumpAndSettle();

    expect(find.text('Mã mời không hợp lệ.'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Mã chuyến đi hợp lệ'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('network failure on preview shows offline message', (
    tester,
  ) async {
    await pumpScreen(
      tester,
      dataSource: _ScriptedJoinDataSource(
        previewError: const ApiException(
          message: 'Failed host lookup',
          statusCode: null,
        ),
      ),
    );

    await enterInviteCode(tester, tripJoinByCodeDemoInviteCode);
    await tester.pumpAndSettle();

    expect(find.textContaining('Không thể kết nối máy chủ'), findsOneWidget);
  });

  testWidgets('valid preview then pending submit pops to trips', (
    tester,
  ) async {
    await pumpScreen(tester, dataSource: _ScriptedJoinDataSource());

    await enterInviteCode(tester, 'he2025-vn');
    await tester.pumpAndSettle();

    expect(find.text('Mã chuyến đi hợp lệ'), findsOneWidget);
    expect(find.textContaining('Mùa Hè Rực Rỡ'), findsOneWidget);
    expect(find.text(tripJoinByCodeDemoInviteCode), findsOneWidget);

    final messageField = codeSlots(tester).last;
    await tester.enterText(messageField, 'Xin chào nhóm MCP');
    await tester.pump();

    await tapVisible(tester, find.textContaining('Gửi Yêu Cầu'));
    await tester.pumpAndSettle();

    expect(find.text('Trips Tab'), findsOneWidget);
    expect(find.textContaining('Đã gửi yêu cầu'), findsOneWidget);
  });

  testWidgets('approved join navigates to trip detail', (tester) async {
    await pumpScreen(
      tester,
      dataSource: _ScriptedJoinDataSource(
        joinStatus: TripJoinRequestStatus.approved,
      ),
    );

    await enterInviteCode(tester, tripJoinByCodeDemoInviteCode);
    await tester.pumpAndSettle();
    await tapVisible(tester, find.textContaining('Gửi Yêu Cầu'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Detail trip-demo-summer-2025'), findsOneWidget);
    expect(find.textContaining('đã tham gia'), findsOneWidget);
  });

  testWidgets('join API conflict keeps screen and shows error', (tester) async {
    await pumpScreen(
      tester,
      dataSource: _ScriptedJoinDataSource(
        joinError: const ApiException(
          message: 'Join request is already pending',
          statusCode: 409,
        ),
      ),
    );

    await enterInviteCode(tester, tripJoinByCodeDemoInviteCode);
    await tester.pumpAndSettle();
    await tapVisible(tester, find.textContaining('Gửi Yêu Cầu'));
    await tester.pumpAndSettle();

    expect(find.byType(TripJoinByCodeScreen), findsOneWidget);
    expect(
      find.text('Bạn đã gửi yêu cầu và đang chờ trưởng nhóm duyệt.'),
      findsOneWidget,
    );
  });

  testWidgets('submit loading disables double tap', (tester) async {
    final dataSource = _ScriptedJoinDataSource(
      joinDelay: const Duration(milliseconds: 300),
    );
    final container = await pumpScreen(tester, dataSource: dataSource);
    container.listen(tripJoinByCodeControllerProvider, (_, _) {});

    await enterInviteCode(tester, tripJoinByCodeDemoInviteCode);
    await tester.pumpAndSettle();
    await tapVisible(tester, find.textContaining('Gửi Yêu Cầu'));
    await tester.pump();

    // AppButton hides label and shows a spinner while isLoading.
    expect(find.byType(CircularProgressIndicator), findsWidgets);
    expect(
      container.read(tripJoinByCodeControllerProvider).isSubmitting,
      isTrue,
    );

    await tester.pumpAndSettle();
    expect(find.text('Trips Tab'), findsOneWidget);
  });

  testWidgets('QR secondary action shows coming soon snackbar', (tester) async {
    await pumpScreen(tester, dataSource: _ScriptedJoinDataSource());

    await tapVisible(tester, find.textContaining('Quét Mã QR'));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('sẽ được bổ sung khi luồng sẵn sàng'),
      findsOneWidget,
    );
  });

  testWidgets('back button returns to trips when stack is empty', (
    tester,
  ) async {
    await pumpScreen(tester, dataSource: _ScriptedJoinDataSource());

    await tester.tap(find.byIcon(Icons.arrow_back_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Trips Tab'), findsOneWidget);
  });
}

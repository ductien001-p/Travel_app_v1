import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_client.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';
import 'package:travel_frontend_v1/core/storage/token_storage.dart';
import 'package:travel_frontend_v1/features/auth/application/auth_controller.dart';
import 'package:travel_frontend_v1/features/auth/application/auth_status.dart';
import 'package:travel_frontend_v1/features/auth/data/repositories/auth_respository.dart';
import 'package:travel_frontend_v1/features/auth/provider/auth_provider.dart';
import 'package:travel_frontend_v1/features/device_token/application/device_token_controller.dart';
import 'package:travel_frontend_v1/features/device_token/application/device_token_state.dart';
import 'package:travel_frontend_v1/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:travel_frontend_v1/features/profile/data/models/profile_model.dart';
import 'package:travel_frontend_v1/features/profile/data/repositories/profile_repository.dart';
import 'package:travel_frontend_v1/features/profile/presentation/screens/setting_screen.dart';
import 'package:travel_frontend_v1/features/profile/provider/profile_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('delete rejects a response that is not success', () async {
    final api = _Api({'success': false, 'message': 'no'});
    final source = ProfileRemoteDataSource(apiClient: api);

    await expectLater(source.deleteAccount(), throwsFormatException);
    expect(api.paths, ['/users/delete']);
  });

  test('delete accepts success true', () async {
    final api = _Api({'success': true});
    final source = ProfileRemoteDataSource(apiClient: api);

    await source.deleteAccount();
    expect(api.paths, ['/users/delete']);
  });

  testWidgets('a failed delete keeps the session and does not call logout', (
    tester,
  ) async {
    final harness = _Harness(
      onDelete: () async => throw const ApiException(message: 'no'),
    );
    await tester.pumpWidget(harness.app);
    await tester.pumpAndSettle();
    final before = harness.container.read(authControllerProvider).value;

    await _confirmDelete(tester);

    expect(harness.tokens.cleared, isFalse);
    expect(harness.auth.logoutCalls, 0);
    expect(find.text('no'), findsOneWidget);
    expect(harness.container.read(authControllerProvider).value, before);
  });

  testWidgets('a successful delete ends the local session without logout', (
    tester,
  ) async {
    final harness = _Harness(onDelete: () async {});
    await tester.pumpWidget(harness.app);
    await tester.pumpAndSettle();
    harness.container.read(authControllerProvider.notifier).state =
        const AsyncData(AuthStatus.authenticated);

    await _confirmDelete(tester);

    expect(harness.tokens.cleared, isTrue);
    expect(harness.auth.logoutCalls, 0);
    expect(harness.auth.signOutCalls, 1);
    expect(
      harness.container.read(authControllerProvider).value,
      AuthStatus.unauthenticated,
    );
  });
}

Future<void> _confirmDelete(WidgetTester tester) async {
  await tester.scrollUntilVisible(
    find.text('Yêu cầu xóa toàn bộ dữ liệu & tài khoản'),
    200,
  );
  await tester.tap(find.text('Yêu cầu xóa toàn bộ dữ liệu & tài khoản'));
  await tester.pumpAndSettle();
  await tester.tap(find.widgetWithText(TextButton, 'Xóa tài khoản'));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
}

class _Harness {
  _Harness({required Future<void> Function() onDelete})
    : tokens = _Tokens(),
      auth = _Auth() {
    container = ProviderContainer(
      overrides: [
        tokenStorageProvider.overrideWithValue(tokens),
        authRepositoryProvider.overrideWithValue(auth),
        deviceTokenControllerProvider.overrideWith(_QuietDevice.new),
        profileRepositoryProvider.overrideWithValue(_Profiles(onDelete)),
      ],
    );
    app = UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        home: SettingScreen(
          profile: ProfileModel(
            id: 'me',
            displayName: 'Lan',
            username: 'lan',
            email: 'lan@example.com',
            avatarId: null,
            bio: null,
            phone: null,
            address: null,
            location: null,
            gender: null,
            dateOfBirth: null,
            budgetLevel: null,
            travelStyle: const [],
            languages: const [],
            interests: const [],
            notificationEnabled: true,
            visitedCount: 0,
          ),
        ),
      ),
    );
  }

  final _Tokens tokens;
  final _Auth auth;
  late final ProviderContainer container;
  late final Widget app;
}

class _Tokens extends TokenStorage {
  _Tokens() : super(storage: const FlutterSecureStorage());

  var cleared = false;

  @override
  Future<void> clearTokens() async {
    cleared = true;
  }
}

class _QuietDevice extends DeviceTokenController {
  @override
  DeviceTokenState build() => const DeviceTokenState.idle();

  @override
  void markSessionInactive() {}
}

class _Profiles implements ProfileRepository {
  _Profiles(this.onDelete);

  final Future<void> Function() onDelete;

  @override
  Future<void> deleteAccount() => onDelete();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Auth implements AuthRepository {
  var logoutCalls = 0;
  var signOutCalls = 0;

  @override
  Future<bool> restoreSession() async => false;

  @override
  Future<void> signOutGoogle() async {
    signOutCalls++;
  }

  @override
  Future<void> logout({
    required String refreshToken,
    required String installationId,
  }) async {
    logoutCalls++;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Api extends ApiClient {
  _Api(this.payload)
    : super(tokenStorage: _Tokens(), onSessionExpired: () {});

  final Map<String, dynamic> payload;
  final paths = <String>[];

  @override
  Future<T> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) async {
    paths.add(path);
    return payload as T;
  }
}

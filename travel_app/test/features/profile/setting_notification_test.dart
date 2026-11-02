import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/auth/application/auth_controller.dart';
import 'package:travel_frontend_v1/features/auth/application/auth_status.dart';
import 'package:travel_frontend_v1/features/profile/application/update_profile_controller.dart';
import 'package:travel_frontend_v1/features/profile/data/models/profile_model.dart';
import 'package:travel_frontend_v1/features/profile/data/models/update_profile_request.dart';
import 'package:travel_frontend_v1/features/profile/presentation/screens/setting_screen.dart';

void main() {
  testWidgets(
    'saves the push notification switch with PATCH notificationEnabled',
    (tester) async {
      tester.view.physicalSize = const Size(390, 1600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      _CaptureUpdate.requests.clear();

      final container = ProviderContainer(
        overrides: [
          authControllerProvider.overrideWith(_FakeAuthController.new),
          updateProfileControllerProvider.overrideWith(_CaptureUpdate.new),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(home: SettingScreen(profile: _profile)),
        ),
      );
      await tester.pump();

      await tester.ensureVisible(find.text('Thông báo đẩy'));
      await tester.tap(find.byType(Switch).at(1));
      await tester.pump();

      expect(_CaptureUpdate.requests, hasLength(1));
      expect(_CaptureUpdate.requests.single.toJson(), {
        'notificationEnabled': false,
      });
    },
  );
}

const _profile = ProfileModel(
  id: 'user-1',
  displayName: 'Alex Nguyễn',
  username: 'alex_wander',
  email: 'alex@example.com',
  avatarId: null,
  bio: null,
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
  visitedCount: 1,
);

class _FakeAuthController extends AuthController {
  @override
  Future<AuthStatus> build() async => AuthStatus.authenticated;
}

class _CaptureUpdate extends UpdateProfileController {
  static final requests = <UpdateProfileRequest>[];

  @override
  Future<bool> submit(UpdateProfileRequest request) async {
    requests.add(request);
    return true;
  }
}

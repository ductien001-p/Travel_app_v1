import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/profile/application/profile_controller.dart';
import 'package:travel_frontend_v1/features/profile/data/models/profile_model.dart';
import 'package:travel_frontend_v1/features/profile/presentation/screens/edit_profile_screen.dart';

void main() {
  testWidgets('shows the Stitch edit profile form and edits preferences', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 2600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final container = ProviderContainer(
      overrides: [
        profileControllerProvider.overrideWith(_FakeProfileController.new),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: EditProfileScreen()),
      ),
    );
    await tester.pump();

    expect(find.text('Chỉnh sửa hồ sơ'), findsOneWidget);
    expect(find.text('Đổi bìa'), findsNothing);
    expect(find.text('Đổi ảnh đại diện'), findsOneWidget);
    expect(find.text('Alex Nguyễn'), findsOneWidget);
    expect(find.textContaining('tealhorizon.app/@alex_wander'), findsOneWidget);
    expect(find.text('alex.traveler@horizon.io'), findsOneWidget);
    expect(find.text('Đã xác thực'), findsOneWidget);
    expect(find.text('(+84) 987 ••• 678'), findsOneWidget);
    expect(find.text('15/08/1996'), findsOneWidget);
    expect(find.text('Vừa phải'), findsOneWidget);
    expect(find.text('Tiếng Việt'), findsOneWidget);
    expect(find.text('Nhiếp ảnh'), findsOneWidget);
    expect(find.text('Lưu thay đổi hồ sơ'), findsOneWidget);
    expect(find.textContaining('PATCH /users/update'), findsOneWidget);

    await tester.ensureVisible(find.byTooltip('Bỏ English'));
    await tester.tap(find.byTooltip('Bỏ English'));
    await tester.pump();
    expect(find.text('English'), findsNothing);

    await tester.ensureVisible(find.text('Thêm'));
    await tester.tap(find.text('Thêm'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('日本語'));
    await tester.pumpAndSettle();
    expect(find.text('日本語'), findsOneWidget);

    await tester.ensureVisible(find.text('Cao cấp'));
    await tester.tap(find.text('Cao cấp'));
    await tester.pump();
    expect(find.text('High'), findsOneWidget);

    await tester.ensureVisible(find.text('Thay đổi'));
    await tester.tap(find.text('Thay đổi'));
    await tester.pump();
    expect(find.text('0987654678'), findsOneWidget);
  });
}

class _FakeProfileController extends ProfileController {
  @override
  Future<ProfileModel> build() async => const ProfileModel(
    id: 'user-1',
    displayName: 'Alex Nguyễn',
    username: 'alex_wander',
    email: 'alex.traveler@horizon.io',
    avatarId: null,
    bio:
        'Đam mê khám phá văn hóa bản địa, ẩm thực đường phố và săn ảnh bình minh',
    phone: '0987654678',
    address: null,
    location: 'Đà Nẵng, Việt Nam',
    gender: 'male',
    dateOfBirth: '1996-08-15',
    budgetLevel: BudgetLevel.medium,
    travelStyle: [],
    languages: ['vi', 'en', 'fr'],
    interests: ['photography', 'food', 'beach'],
    notificationEnabled: true,
    visitedCount: 18,
  );
}

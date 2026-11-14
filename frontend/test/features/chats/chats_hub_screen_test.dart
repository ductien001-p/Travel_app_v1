import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/chats/data/datamock/chats_hub_datamock.dart';
import 'package:travel_frontend_v1/features/chats/data/datasources/chats_hub_datasource.dart';
import 'package:travel_frontend_v1/features/chats/data/models/chats_hub_models.dart';
import 'package:travel_frontend_v1/features/chats/data/repositories/chats_hub_repository.dart';
import 'package:travel_frontend_v1/features/chats/presentation/screen/chats_hub_screen.dart';
import 'package:travel_frontend_v1/features/chats/provider/chats_hub_provider.dart';

void main() {
  testWidgets('renders Trip Messages Hub chrome from Stitch', (tester) async {
    tester.view.physicalSize = const Size(390, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final container = ProviderContainer(
      overrides: [
        chatsHubRepositoryProvider.overrideWithValue(
          ChatsHubRepository(dataSource: _HubSource()),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: ChatsHubScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Tin Nhắn'), findsOneWidget);
    expect(find.text('Teal Horizon Hub'), findsOneWidget);
    expect(find.text('Chuyến đi (Trip Chats)'), findsOneWidget);
    expect(find.text('Kênh Chat Chuyến Đi'), findsOneWidget);
    expect(find.textContaining('Săn Mây Tà Xùa'), findsOneWidget);
    expect(find.text('Vào chat ngay'), findsOneWidget);

    await tester.dragUntilVisible(
      find.text('Bạn bè (1-on-1)'),
      find.byType(ListView).first,
      const Offset(-120, 0),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bạn bè (1-on-1)'));
    await tester.pumpAndSettle();

    expect(find.text('Bạn Đồng Hành (1-on-1)'), findsOneWidget);
    expect(find.text('Alex Nguyễn'), findsWidgets);
    expect(find.textContaining('Săn Mây Tà Xùa'), findsNothing);
  });
}

class _HubSource implements ChatsHubDataSource {
  @override
  Future<ChatsHub> getHub() async => ChatsHub.fromJson(chatsHubDatamock);
}

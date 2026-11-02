import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/profile/user-memories/data/datasources/user_memories_datasource.dart';
import 'package:travel_frontend_v1/features/profile/user-memories/data/models/user_memories_models.dart';
import 'package:travel_frontend_v1/features/profile/user-memories/data/repositories/user_memories_repository.dart';
import 'package:travel_frontend_v1/features/profile/user-memories/presentation/screen/user_memories_screen.dart';
import 'package:travel_frontend_v1/features/profile/user-memories/provider/user_memories_provider.dart';

void main() {
  testWidgets('hides the highlight when the month has no photo', (
    tester,
  ) async {
    final source = _EmptyHighlightSource();
    final container = ProviderContainer(
      overrides: [
        userMemoriesRepositoryProvider.overrideWithValue(
          UserMemoriesRepository(dataSource: source),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: UserMemoriesScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Khoảnh Khắc Hành Trình'), findsOneWidget);
    expect(find.text('0 kỷ niệm'), findsOneWidget);
    expect(find.text('Điểm Nhấn Kỷ Niệm'), findsNothing);
    expect(find.text('Photo Hunter Cấp 2'), findsNothing);
    expect(find.textContaining('Teal Cloud'), findsNothing);
    expect(find.text('Tất cả ảnh (0)'), findsOneWidget);
    expect(find.text('Chưa có ảnh trong bộ này'), findsOneWidget);
  });
}

class _EmptyHighlightSource extends UserMemoriesDataSource {
  _EmptyHighlightSource() : super.testing();

  @override
  Future<UserMemoriesPage> getMine({
    String? tripId,
    required int year,
    required int month,
    required int utcOffsetMinutes,
    String? cursor,
    int limit = 20,
    String? q,
  }) async {
    return const UserMemoriesPage(
      items: [],
      collections: [],
      highlight: null,
      meta: UserMemoriesMeta(totalCount: 0),
    );
  }

  @override
  Future<UserMemoryLike> like(String memoryId) async {
    return const UserMemoryLike(likeCount: 0, liked: false);
  }

  @override
  Future<UserMemoryLike> unlike(String memoryId) async {
    return const UserMemoryLike(likeCount: 0, liked: false);
  }
}

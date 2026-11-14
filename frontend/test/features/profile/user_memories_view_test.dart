import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/profile/user-memories/application/user_memories_controller.dart';
import 'package:travel_frontend_v1/features/profile/user-memories/data/datasources/user_memories_datasource.dart';
import 'package:travel_frontend_v1/features/profile/user-memories/data/models/user_memories_models.dart';
import 'package:travel_frontend_v1/features/profile/user-memories/data/repositories/user_memories_repository.dart';
import 'package:travel_frontend_v1/features/profile/user-memories/provider/user_memories_provider.dart';

void main() {
  test('selecting a trip chip reloads that trip', () async {
    final source = _FakeMemoriesSource(_page(highlight: _photo()));
    final container = _container(source);
    addTearDown(container.dispose);
    container.listen(userMemoriesControllerProvider, (_, _) {});

    await container.read(userMemoriesControllerProvider.future);
    expect(source.calls.single.tripId, isNull);

    container
        .read(userMemoriesFilterProvider.notifier)
        .selectTrip('trip-hoi-an');
    await container.read(userMemoriesControllerProvider.future);

    expect(source.calls.last.tripId, 'trip-hoi-an');
  });

  test('like writes the count returned by the API', () async {
    final source = _FakeMemoriesSource(_page(highlight: _photo()));
    final container = _container(source);
    addTearDown(container.dispose);
    container.listen(userMemoriesControllerProvider, (_, _) {});

    await container.read(userMemoriesControllerProvider.future);
    await container
        .read(userMemoriesControllerProvider.notifier)
        .toggleLike('photo-1');

    final gallery = container.read(userMemoriesControllerProvider).requireValue;
    expect(source.liked, ['photo-1']);
    expect(gallery.highlight?.liked, isTrue);
    expect(gallery.highlight?.likeCount, 2);
    expect(gallery.items.single.likeCount, 2);
  });
}

ProviderContainer _container(_FakeMemoriesSource source) {
  return ProviderContainer(
    overrides: [
      userMemoriesRepositoryProvider.overrideWithValue(
        UserMemoriesRepository(dataSource: source),
      ),
    ],
  );
}

UserMemoryPhoto _photo() {
  return UserMemoryPhoto(
    id: 'photo-1',
    tripId: 'trip-hoi-an',
    tripName: 'Hội An',
    caption: 'Phố cổ',
    createdAt: DateTime.utc(2026, 10, 2),
    imageUrl: 'https://cdn.test/photo-1.jpg',
    likeCount: 1,
  );
}

UserMemoriesPage _page({UserMemoryPhoto? highlight}) {
  return UserMemoriesPage(
    items: [?highlight],
    collections: const [
      UserMemoryCollection(
        tripId: 'trip-hoi-an',
        name: 'Hội An',
        status: 'ONGOING',
        memoryCount: 1,
      ),
    ],
    highlight: highlight,
    meta: const UserMemoriesMeta(totalCount: 1),
  );
}

class _FakeMemoriesSource extends UserMemoriesDataSource {
  _FakeMemoriesSource(this.page) : super.testing();

  final UserMemoriesPage page;
  final calls = <({String? tripId, String? q})>[];
  final liked = <String>[];

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
    calls.add((tripId: tripId, q: q));
    return page;
  }

  @override
  Future<UserMemoryLike> like(String memoryId) async {
    liked.add(memoryId);
    return const UserMemoryLike(likeCount: 2, liked: true);
  }

  @override
  Future<UserMemoryLike> unlike(String memoryId) async {
    liked.add(memoryId);
    return const UserMemoryLike(likeCount: 0, liked: false);
  }
}

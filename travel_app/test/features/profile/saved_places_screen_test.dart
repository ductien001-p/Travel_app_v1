import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/home/places/data/models/place_explore_api_models.dart';
import 'package:travel_frontend_v1/features/profile/user-saved-trip/data/datasources/saved_places_datasource.dart';
import 'package:travel_frontend_v1/features/profile/user-saved-trip/data/models/saved_places_models.dart';
import 'package:travel_frontend_v1/features/profile/user-saved-trip/data/repositories/saved_places_repository.dart';
import 'package:travel_frontend_v1/features/profile/user-saved-trip/presentation/screen/saved_places_screen.dart';
import 'package:travel_frontend_v1/features/profile/user-saved-trip/provider/saved_places_provider.dart';

void main() {
  testWidgets('shows saved places and filters the visible cards', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 2200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final container = ProviderContainer(
      overrides: [
        savedPlacesRepositoryProvider.overrideWithValue(
          SavedPlacesRepository(dataSource: _ScreenSource()),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: SavedPlacesScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Điểm Đến Đã Lưu'), findsOneWidget);
    expect(find.text('Hồ sơ cá nhân • Saved Bucket List'), findsOneWidget);
    expect(find.text('2 địa điểm đã lưu trong bộ sưu tập'), findsOneWidget);
    expect(find.text('Phố Cổ Hội An'), findsOneWidget);
    expect(find.text('Bánh Mì Phượng'), findsOneWidget);
    expect(find.text('Ẩm thực & Cà phê (1)'), findsOneWidget);
    expect(find.text('Mới lưu nhất'), findsOneWidget);
    expect(find.text('Tạo Tour'), findsNothing);
    expect(find.text('Lên lịch trình tự động AI'), findsNothing);
    expect(find.textContaining('1.2k'), findsNothing);

    await tester.tap(find.text('Ẩm thực & Cà phê (1)'));
    await tester.pumpAndSettle();

    expect(find.text('Bánh Mì Phượng'), findsOneWidget);
    expect(find.text('Phố Cổ Hội An'), findsNothing);
  });

  testWidgets('shows an empty collection when nothing is saved', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [
        savedPlacesRepositoryProvider.overrideWithValue(
          SavedPlacesRepository(dataSource: _EmptySource()),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: SavedPlacesScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Chưa lưu địa điểm'), findsOneWidget);
    expect(find.text('Bộ Sưu Tập Thông Minh'), findsOneWidget);
    expect(
      find.text('Tạo bộ sưu tập mới (+ New Folder / List)'),
      findsOneWidget,
    );
    expect(find.text('Tìm trong danh sách đã lưu...'), findsOneWidget);
  });

  testWidgets('creating a collection keeps the screen and shows the folder', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final source = _CreateSource();
    final container = ProviderContainer(
      overrides: [
        savedPlacesRepositoryProvider.overrideWithValue(
          SavedPlacesRepository(dataSource: source),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: SavedPlacesScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tạo bộ sưu tập mới (+ New Folder / List)'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'Kế hoạch Hè');
    await tester.tap(find.text('Tạo'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Điểm Đến Đã Lưu'), findsOneWidget);
    expect(find.text('Kế hoạch Hè'), findsOneWidget);
    expect(find.text('Bộ sưu tập mới'), findsNothing);
  });
}

class _ScreenSource extends SavedPlacesDataSource {
  _ScreenSource() : super.testing();

  @override
  Future<SavedPlacesPage> getMine({int page = 1, int limit = 20}) async {
    return SavedPlacesPage(
      items: [
        _place(
          id: 'old-town',
          name: 'Phố Cổ Hội An',
          category: 'OLD_TOWN',
          address: 'TP. Hội An, Quảng Nam',
          rating: 4.9,
        ),
        _place(
          id: 'banh-mi',
          name: 'Bánh Mì Phượng',
          category: 'FOOD',
          address: 'Trần Phú, TP. Hội An',
          rating: 4.7,
        ),
      ],
      meta: const SavedPlacesPageMeta(
        page: 1,
        limit: 20,
        total: 2,
        totalPages: 1,
        hasNextPage: false,
        hasPreviousPage: false,
      ),
    );
  }

  @override
  Future<int> getCount() async => 2;

  @override
  Future<void> unsave(String placeId) async {}

  @override
  Future<List<OwnedPlaceCollection>> listCollections() async => const [];
}

class _EmptySource extends SavedPlacesDataSource {
  _EmptySource() : super.testing();

  @override
  Future<SavedPlacesPage> getMine({int page = 1, int limit = 20}) async {
    return const SavedPlacesPage(
      items: [],
      meta: SavedPlacesPageMeta(
        page: 1,
        limit: 20,
        total: 0,
        totalPages: 0,
        hasNextPage: false,
        hasPreviousPage: false,
      ),
    );
  }

  @override
  Future<int> getCount() async => 0;

  @override
  Future<void> unsave(String placeId) async {}

  @override
  Future<List<OwnedPlaceCollection>> listCollections() async => const [];
}

class _CreateSource extends SavedPlacesDataSource {
  _CreateSource() : super.testing();

  final created = <OwnedPlaceCollection>[];

  @override
  Future<SavedPlacesPage> getMine({int page = 1, int limit = 20}) async {
    return const SavedPlacesPage(
      items: [],
      meta: SavedPlacesPageMeta(
        page: 1,
        limit: 20,
        total: 0,
        totalPages: 0,
        hasNextPage: false,
        hasPreviousPage: false,
      ),
    );
  }

  @override
  Future<int> getCount() async => 0;

  @override
  Future<void> unsave(String placeId) async {}

  @override
  Future<List<OwnedPlaceCollection>> listCollections() async => created;

  @override
  Future<OwnedPlaceCollection> createCollection(String title) async {
    final collection = OwnedPlaceCollection(
      id: 'col-${created.length}',
      title: title,
      visibility: 'PRIVATE',
      placeCount: 0,
    );
    created.add(collection);
    return collection;
  }
}

SavedPlace _place({
  required String id,
  required String name,
  required String category,
  required String address,
  required double rating,
}) {
  return SavedPlace(
    id: 'saved-$id',
    userId: 'user-1',
    placeId: id,
    createdAt: DateTime.utc(2026, 10, 20),
    place: SavedPlaceDetails(
      id: id,
      name: name,
      category: category,
      city: 'Hội An',
      country: 'Việt Nam',
      address: address,
      latitude: 15.88,
      longitude: 108.33,
      averageRating: rating,
    ),
  );
}

import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/home/places/data/models/place_explore_api_models.dart';
import 'package:travel_frontend_v1/features/profile/user-saved-trip/application/saved_places_view.dart';
import 'package:travel_frontend_v1/features/profile/user-saved-trip/data/models/saved_places_models.dart';

void main() {
  test('maps place categories onto the screen groups', () {
    expect(savedPlaceGroupOf('FOOD'), SavedPlaceGroup.food);
    expect(savedPlaceGroupOf('cafe'), SavedPlaceGroup.food);
    expect(savedPlaceGroupOf('BEACH'), SavedPlaceGroup.coast);
    expect(savedPlaceGroupOf('OLD_TOWN'), SavedPlaceGroup.culture);
    expect(savedPlaceGroupOf('CAMPING'), SavedPlaceGroup.mountain);
    expect(savedPlaceGroupOf(null), isNull);
    expect(savedPlaceGroupOf('UNKNOWN'), isNull);
  });

  test('filters by group and search text without dropping other pages', () {
    final items = [
      _place(
        id: 'food',
        name: 'Bánh Mì Phượng',
        category: 'FOOD',
        city: 'Hội An',
      ),
      _place(
        id: 'mountain',
        name: 'Sơn Trà',
        category: 'MOUNTAIN',
        city: 'Đà Nẵng',
      ),
      _place(id: 'plain', name: 'Quán không nhóm', category: null, city: 'Huế'),
    ];

    final food = filterSavedPlaces(
      items: items,
      group: SavedPlaceGroup.food,
      query: '',
    );
    expect(food.map((item) => item.placeId), ['food']);

    final searched = filterSavedPlaces(
      items: items,
      group: SavedPlaceGroup.all,
      query: 'huế',
    );
    expect(searched.single.place.name, 'Quán không nhóm');
    expect(savedPlaceLocation(searched.single.place), 'Huế, Việt Nam');
  });

  test('builds smart collections from loaded categories', () {
    final items = [
      _place(id: 'a', name: 'A', category: 'FOOD', city: 'Hội An'),
      _place(id: 'b', name: 'B', category: 'CAFE', city: 'Đà Nẵng'),
      _place(id: 'c', name: 'C', category: 'BEACH', city: 'Hội An'),
    ];

    final collections = savedPlaceCollections(items);
    expect(collections, hasLength(2));
    expect(collections.first.group, SavedPlaceGroup.food);
    expect(collections.first.count, 2);
    expect(collections.first.subtitle, 'Hội An • Đà Nẵng');
    expect(collections.last.group, SavedPlaceGroup.coast);
    expect(savedPlaceGroupCount(items, SavedPlaceGroup.food), 2);
  });

  test('builds folder cards from owned collections', () {
    final items = [
      _place(id: 'a', name: 'A', category: 'BEACH', city: 'Đà Nẵng'),
      _place(id: 'b', name: 'B', category: 'FOOD', city: 'Hội An'),
    ];
    final cards = savedCollectionCards(
      collections: [
        OwnedPlaceCollection(
          id: 'summer',
          title: 'Kế hoạch Hè',
          visibility: 'PRIVATE',
          placeCount: 2,
          placeIds: const ['a', 'b'],
        ),
      ],
      items: items,
    );
    expect(cards.single.subtitle, 'Đà Nẵng • Hội An');
    expect(cards.single.group, SavedPlaceGroup.food);
    final visible = filterSavedPlaces(
      items: items,
      group: SavedPlaceGroup.all,
      query: '',
      collectionPlaceIds: cards.single.placeIds,
    );
    expect(visible.map((item) => item.placeId), ['a', 'b']);
  });

  test('filters a collection detail independently of loaded saved pages', () {
    final places = [
      CollectionPlaceItem(
        id: 'cafe',
        name: 'Cafe',
        category: 'CAFE',
        city: 'Hội An',
        averageRating: 4,
      ),
      CollectionPlaceItem(
        id: 'beach',
        name: 'Biển',
        category: 'BEACH',
        city: 'Đà Nẵng',
        averageRating: 5,
      ),
    ];
    final food = filterCollectionPlaces(
      places: places,
      group: SavedPlaceGroup.food,
      query: '',
    );
    expect(food.single.id, 'cafe');
    expect(collectionPlaceGroupCount(places, SavedPlaceGroup.coast), 1);

    final saved = _place(
      id: 'cafe',
      name: 'Cafe',
      category: 'CAFE',
      city: 'Hội An',
      address: 'Nguyễn Thái Học',
    );
    final row = collectionPlaceRow(food.single, saved);
    expect(row.canUnsave, isTrue);
    expect(row.location, 'Nguyễn Thái Học');
    expect(
      savedPlaceShareText(row),
      'Cafe\nNguyễn Thái Học\n'
      'https://www.google.com/maps/search/?api=1&query=16.0,108.0',
    );

    final unsaved = collectionPlaceRow(places.last, null);
    expect(unsaved.canUnsave, isFalse);
    expect(unsaved.latitude, isNull);
    final pins = savedPlaceMapPins(
      items: [saved],
      group: SavedPlaceGroup.all,
      query: '',
      onlyPlaceIds: places.map((item) => item.id).toSet(),
    );
    expect(pins.single.placeId, 'cafe');
  });
}

SavedPlace _place({
  required String id,
  required String name,
  required String? category,
  required String city,
  String? address,
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
      city: city,
      country: 'Việt Nam',
      address: address,
      latitude: 16,
      longitude: 108,
      averageRating: 4.5,
    ),
  );
}

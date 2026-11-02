import 'package:flutter/material.dart';

import 'package:travel_frontend_v1/features/home/places/data/models/place_explore_api_models.dart';

import '../data/models/saved_places_models.dart';

/// Filter groups on the saved-places screen. They map [PLACE_CATEGORY] values
/// that the list endpoint already returns. The API has no category query.
enum SavedPlaceGroup { all, food, coast, culture, mountain }

const _keep = Object();

class SavedPlacesFilterState {
  const SavedPlacesFilterState({
    this.group = SavedPlaceGroup.all,
    this.query = '',
    this.collectionId,
  });

  final SavedPlaceGroup group;
  final String query;
  final String? collectionId;

  SavedPlacesFilterState copyWith({
    SavedPlaceGroup? group,
    String? query,
    Object? collectionId = _keep,
  }) {
    return SavedPlacesFilterState(
      group: group ?? this.group,
      query: query ?? this.query,
      collectionId: identical(collectionId, _keep)
          ? this.collectionId
          : collectionId as String?,
    );
  }
}

class SavedPlacesState {
  const SavedPlacesState({
    required this.items,
    required this.total,
    required this.page,
    required this.hasNextPage,
    this.loadingMore = false,
    this.loadMoreError,
    this.ownedCollections = const [],
    this.selectedCollection,
    this.loadingCollection = false,
    this.collectionError,
  });

  final List<SavedPlace> items;
  final int total;
  final int page;
  final bool hasNextPage;
  final bool loadingMore;
  final Object? loadMoreError;
  final List<OwnedPlaceCollection> ownedCollections;
  final PlaceCollectionDetail? selectedCollection;
  final bool loadingCollection;
  final Object? collectionError;

  SavedPlacesState copyWith({
    List<SavedPlace>? items,
    int? total,
    int? page,
    bool? hasNextPage,
    bool? loadingMore,
    Object? loadMoreError = _keep,
    List<OwnedPlaceCollection>? ownedCollections,
    Object? selectedCollection = _keep,
    bool? loadingCollection,
    Object? collectionError = _keep,
  }) {
    return SavedPlacesState(
      items: items ?? this.items,
      total: total ?? this.total,
      page: page ?? this.page,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      loadingMore: loadingMore ?? this.loadingMore,
      loadMoreError: identical(loadMoreError, _keep)
          ? this.loadMoreError
          : loadMoreError,
      ownedCollections: ownedCollections ?? this.ownedCollections,
      selectedCollection: identical(selectedCollection, _keep)
          ? this.selectedCollection
          : selectedCollection as PlaceCollectionDetail?,
      loadingCollection: loadingCollection ?? this.loadingCollection,
      collectionError: identical(collectionError, _keep)
          ? this.collectionError
          : collectionError,
    );
  }
}

/// One row in the saved-place list or inside an open collection.
class SavedPlaceRow {
  const SavedPlaceRow({
    required this.placeId,
    required this.name,
    required this.location,
    required this.rating,
    required this.canUnsave,
    this.category,
    this.latitude,
    this.longitude,
  });

  final String placeId;
  final String name;
  final String location;
  final double rating;
  final bool canUnsave;
  final String? category;
  final double? latitude;
  final double? longitude;
}

class SavedPlacePin {
  const SavedPlacePin({
    required this.placeId,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  final String placeId;
  final String name;
  final double latitude;
  final double longitude;
}

class SavedPlaceCollection {
  const SavedPlaceCollection({
    required this.group,
    required this.title,
    required this.subtitle,
    required this.count,
  });

  final SavedPlaceGroup group;
  final String title;
  final String subtitle;
  final int count;
}

const _foodCategories = {'FOOD', 'CAFE', 'MARKET', 'NIGHT_MARKET'};

const _coastCategories = {
  'BEACH',
  'RESORT',
  'HOTEL',
  'HOSTEL',
  'HOMESTAY',
  'VILLA',
  'LAKE',
  'WATER_PARK',
};

const _cultureCategories = {
  'MUSEUM',
  'TEMPLES',
  'CHURCH',
  'HISTORICAL_SITE',
  'MONUMENT',
  'PALACE',
  'CASTLE',
  'OLD_TOWN',
  'THEATER',
  'CINEMA',
  'PARK',
  'ZOO',
  'WALKING_STREET',
  'SHOPPING_MALL',
};

const _mountainCategories = {
  'MOUNTAIN',
  'CAMPING',
  'CAVE',
  'WATERFALL',
  'ZIPLINE',
};

const savedPlaceGroupOrder = <SavedPlaceGroup>[
  SavedPlaceGroup.food,
  SavedPlaceGroup.coast,
  SavedPlaceGroup.culture,
  SavedPlaceGroup.mountain,
];

/// Null when the category is missing or outside the four screen groups.
SavedPlaceGroup? savedPlaceGroupOf(String? category) {
  final value = category?.trim().toUpperCase();
  if (value == null || value.isEmpty) return null;
  if (_foodCategories.contains(value)) return SavedPlaceGroup.food;
  if (_coastCategories.contains(value)) return SavedPlaceGroup.coast;
  if (_cultureCategories.contains(value)) return SavedPlaceGroup.culture;
  if (_mountainCategories.contains(value)) return SavedPlaceGroup.mountain;
  return null;
}

String savedPlaceGroupLabel(SavedPlaceGroup group) {
  return switch (group) {
    SavedPlaceGroup.all => 'Tất cả',
    SavedPlaceGroup.food => 'Ẩm thực & Cà phê',
    SavedPlaceGroup.coast => 'Biển đảo & Nghỉ dưỡng',
    SavedPlaceGroup.culture => 'Văn hóa & Di tích',
    SavedPlaceGroup.mountain => 'Cắm trại & Núi',
  };
}

IconData savedPlaceGroupIcon(SavedPlaceGroup group) {
  return switch (group) {
    SavedPlaceGroup.all => Icons.auto_awesome,
    SavedPlaceGroup.food => Icons.ramen_dining,
    SavedPlaceGroup.coast => Icons.beach_access,
    SavedPlaceGroup.culture => Icons.account_balance_outlined,
    SavedPlaceGroup.mountain => Icons.terrain,
  };
}

String savedPlaceLocation(SavedPlaceDetails place) {
  final address = place.address?.trim();
  if (address != null && address.isNotEmpty) return address;
  return '${place.city}, ${place.country}';
}

String savedPlaceRatingLabel(double rating) => rating.toStringAsFixed(1);

String savedPlaceCountLabel(int total) {
  return '$total địa điểm đã lưu trong bộ sưu tập';
}

List<SavedPlace> filterSavedPlaces({
  required List<SavedPlace> items,
  required SavedPlaceGroup group,
  required String query,
  Set<String>? collectionPlaceIds,
}) {
  final needle = query.trim().toLowerCase();
  return [
    for (final item in items)
      if (_matchesGroup(item, group) &&
          _matchesQuery(item, needle) &&
          (collectionPlaceIds == null ||
              collectionPlaceIds.contains(item.placeId)))
        item,
  ];
}

int savedPlaceGroupCount(List<SavedPlace> items, SavedPlaceGroup group) {
  if (group == SavedPlaceGroup.all) return items.length;
  return items
      .where((item) => savedPlaceGroupOf(item.place.category) == group)
      .length;
}

/// Groups already present in the loaded pages, busiest first.
List<SavedPlaceCollection> savedPlaceCollections(List<SavedPlace> items) {
  final grouped = <SavedPlaceGroup, List<SavedPlace>>{};
  for (final item in items) {
    final group = savedPlaceGroupOf(item.place.category);
    if (group == null) continue;
    grouped.putIfAbsent(group, () => []).add(item);
  }
  final groups = grouped.keys.toList()
    ..sort((a, b) {
      final byCount = grouped[b]!.length.compareTo(grouped[a]!.length);
      if (byCount != 0) return byCount;
      return savedPlaceGroupOrder
          .indexOf(a)
          .compareTo(savedPlaceGroupOrder.indexOf(b));
    });
  return [
    for (final group in groups)
      SavedPlaceCollection(
        group: group,
        title: savedPlaceGroupLabel(group),
        subtitle: _citySubtitle(grouped[group]!),
        count: grouped[group]!.length,
      ),
  ];
}

bool _matchesGroup(SavedPlace item, SavedPlaceGroup group) {
  if (group == SavedPlaceGroup.all) return true;
  return savedPlaceGroupOf(item.place.category) == group;
}

bool _matchesQuery(SavedPlace item, String needle) {
  if (needle.isEmpty) return true;
  final place = item.place;
  final haystack = [
    place.name,
    place.city,
    place.country,
    place.address ?? '',
    place.category ?? '',
    place.description ?? '',
  ].join(' ').toLowerCase();
  return haystack.contains(needle);
}

class SavedCollectionCardData {
  const SavedCollectionCardData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.count,
    required this.placeIds,
    required this.group,
  });

  final String id;
  final String title;
  final String subtitle;
  final int count;
  final Set<String> placeIds;
  final SavedPlaceGroup? group;
}

/// User folders from `GET /place-collections/mine`. Subtitles use cities of
/// member places that are already on the loaded saved-place pages.
List<SavedCollectionCardData> savedCollectionCards({
  required List<OwnedPlaceCollection> collections,
  required List<SavedPlace> items,
}) {
  final byId = {for (final item in items) item.placeId: item};
  return [
    for (final collection in collections)
      SavedCollectionCardData(
        id: collection.id,
        title: collection.title,
        subtitle: _collectionSubtitle(collection.placeIds, byId),
        count: collection.placeCount,
        placeIds: collection.placeIds.toSet(),
        group: _dominantGroup(collection.placeIds, byId),
      ),
  ];
}

SavedPlaceGroup? _dominantGroup(
  List<String> placeIds,
  Map<String, SavedPlace> byId,
) {
  final counts = <SavedPlaceGroup, int>{};
  for (final id in placeIds) {
    final group = savedPlaceGroupOf(byId[id]?.place.category);
    if (group == null) continue;
    counts[group] = (counts[group] ?? 0) + 1;
  }
  if (counts.isEmpty) return null;
  final ranked = counts.entries.toList()
    ..sort((a, b) {
      final byCount = b.value.compareTo(a.value);
      if (byCount != 0) return byCount;
      return savedPlaceGroupOrder
          .indexOf(a.key)
          .compareTo(savedPlaceGroupOrder.indexOf(b.key));
    });
  return ranked.first.key;
}

String _collectionSubtitle(
  List<String> placeIds,
  Map<String, SavedPlace> byId,
) {
  final cities = <String>[];
  for (final id in placeIds) {
    final city = byId[id]?.place.city.trim() ?? '';
    if (city.isEmpty || cities.contains(city)) continue;
    cities.add(city);
    if (cities.length == 3) break;
  }
  if (cities.isNotEmpty) return cities.join(' • ');
  if (placeIds.isEmpty) return 'Chưa có địa điểm';
  return '';
}

String _citySubtitle(List<SavedPlace> items) {
  final cities = <String>[];
  for (final item in items) {
    final city = item.place.city.trim();
    if (city.isEmpty || cities.contains(city)) continue;
    cities.add(city);
    if (cities.length == 3) break;
  }
  return cities.join(' • ');
}

SavedPlaceRow savedPlaceRow(SavedPlace item) {
  return SavedPlaceRow(
    placeId: item.placeId,
    name: item.place.name,
    location: savedPlaceLocation(item.place),
    rating: item.place.averageRating,
    category: item.place.category,
    latitude: item.place.latitude,
    longitude: item.place.longitude,
    canUnsave: true,
  );
}

SavedPlaceRow collectionPlaceRow(CollectionPlaceItem item, SavedPlace? saved) {
  final savedPlace = saved?.place;
  return SavedPlaceRow(
    placeId: item.id,
    name: item.name,
    location: savedPlace == null ? item.city : savedPlaceLocation(savedPlace),
    rating: item.averageRating,
    category: item.category,
    latitude: savedPlace?.latitude,
    longitude: savedPlace?.longitude,
    canUnsave: saved != null,
  );
}

List<CollectionPlaceItem> filterCollectionPlaces({
  required List<CollectionPlaceItem> places,
  required SavedPlaceGroup group,
  required String query,
}) {
  final needle = query.trim().toLowerCase();
  return [
    for (final item in places)
      if (_matchesCollectionGroup(item, group) &&
          _matchesCollectionQuery(item, needle))
        item,
  ];
}

int collectionPlaceGroupCount(
  List<CollectionPlaceItem> places,
  SavedPlaceGroup group,
) {
  if (group == SavedPlaceGroup.all) return places.length;
  return places
      .where((item) => savedPlaceGroupOf(item.category) == group)
      .length;
}

List<SavedPlacePin> savedPlaceMapPins({
  required List<SavedPlace> items,
  required SavedPlaceGroup group,
  required String query,
  Set<String>? onlyPlaceIds,
}) {
  return [
    for (final item in filterSavedPlaces(
      items: items,
      group: group,
      query: query,
    ))
      if (onlyPlaceIds == null || onlyPlaceIds.contains(item.placeId))
        SavedPlacePin(
          placeId: item.placeId,
          name: item.place.name,
          latitude: item.place.latitude,
          longitude: item.place.longitude,
        ),
  ];
}

String savedPlaceShareText(SavedPlaceRow row) {
  final lines = <String>[row.name, row.location];
  final latitude = row.latitude;
  final longitude = row.longitude;
  if (latitude != null && longitude != null) {
    lines.add(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );
  }
  return lines.join('\n');
}

bool _matchesCollectionGroup(CollectionPlaceItem item, SavedPlaceGroup group) {
  if (group == SavedPlaceGroup.all) return true;
  return savedPlaceGroupOf(item.category) == group;
}

bool _matchesCollectionQuery(CollectionPlaceItem item, String needle) {
  if (needle.isEmpty) return true;
  final haystack = [
    item.name,
    item.city,
    item.category,
  ].join(' ').toLowerCase();
  return haystack.contains(needle);
}

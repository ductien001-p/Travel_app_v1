import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/location/device_location_service.dart';
import 'package:travel_frontend_v1/features/trips/application/device_location_controller.dart';

import '../data/models/explore_places_models.dart';
import '../data/repositories/explore_places_repository.dart';
import '../provider/explore_places_provider.dart';

const exploreNearbySubtitle = 'Dựa trên vị trí của bạn';
const exploreCollectionsSubtitle = 'Bộ công khai được đánh giá cao';
const exploreLocationDeniedMessage = 'Bật định vị để xem địa điểm gần bạn.';
const exploreNearbyEmptyMessage = 'Không có địa điểm trong bán kính này.';

class ExplorePlacesViewState {
  const ExplorePlacesViewState({
    required this.feed,
    this.bookmarkedPlaceIds = const <String>{},
    this.radiusKm = 10,
    this.latitude,
    this.longitude,
    this.nearbyMessage,
  });

  final ExplorePlacesFeed feed;
  final Set<String> bookmarkedPlaceIds;
  final int radiusKm;
  final double? latitude;
  final double? longitude;
  final String? nearbyMessage;

  bool isBookmarked(String placeId) => bookmarkedPlaceIds.contains(placeId);

  bool get isEmpty =>
      feed.featured.isEmpty &&
      feed.nearby.isEmpty &&
      feed.collections.isEmpty &&
      nearbyMessage == null;

  ExplorePlacesViewState copyWith({
    ExplorePlacesFeed? feed,
    Set<String>? bookmarkedPlaceIds,
    int? radiusKm,
    double? latitude,
    double? longitude,
    Object? nearbyMessage = _keepMessage,
    bool clearLocation = false,
  }) {
    return ExplorePlacesViewState(
      feed: feed ?? this.feed,
      bookmarkedPlaceIds: bookmarkedPlaceIds ?? this.bookmarkedPlaceIds,
      radiusKm: radiusKm ?? this.radiusKm,
      latitude: clearLocation ? null : latitude ?? this.latitude,
      longitude: clearLocation ? null : longitude ?? this.longitude,
      nearbyMessage: identical(nearbyMessage, _keepMessage)
          ? this.nearbyMessage
          : nearbyMessage as String?,
    );
  }
}

const _keepMessage = Object();

final explorePlacesControllerProvider =
    AsyncNotifierProvider<ExplorePlacesController, ExplorePlacesViewState>(
      ExplorePlacesController.new,
    );

class ExplorePlacesController extends AsyncNotifier<ExplorePlacesViewState> {
  @override
  FutureOr<ExplorePlacesViewState> build() => _load(radiusKm: 10);

  Future<void> refresh() async {
    final previous = state.asData?.value;
    try {
      state = AsyncData(await _load(radiusKm: previous?.radiusKm ?? 10));
    } catch (error, stackTrace) {
      if (previous == null) {
        state = AsyncError(error, stackTrace);
      }
    }
  }

  Future<void> setRadius(int radiusKm) async {
    final current = state.asData?.value;
    if (current == null || radiusKm == current.radiusKm) return;
    final latitude = current.latitude;
    final longitude = current.longitude;
    if (latitude == null || longitude == null) {
      state = AsyncData(current.copyWith(radiusKm: radiusKm));
      return;
    }
    try {
      final nearby = await ref
          .read(explorePlacesRepositoryProvider)
          .getNearby(
            latitude: latitude,
            longitude: longitude,
            radiusKm: radiusKm,
          );
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(
          radiusKm: radiusKm,
          feed: latest.feed.copyWith(
            nearby: nearby,
            nearbyRadiusLabel: '$radiusKm km',
          ),
          nearbyMessage: nearby.isEmpty ? exploreNearbyEmptyMessage : null,
        ),
      );
    } catch (_) {
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(nearbyMessage: 'Không tìm được địa điểm quanh bạn.'),
      );
    }
  }

  Future<bool> saveToCollections({
    required String placeId,
    required List<String> collectionIds,
  }) async {
    final current = state.asData?.value;
    if (current == null || collectionIds.isEmpty) return false;
    try {
      await ref
          .read(explorePlacesRepositoryProvider)
          .setMembership(placeId: placeId, collectionIds: collectionIds);
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(
          bookmarkedPlaceIds: {...latest.bookmarkedPlaceIds, placeId},
        ),
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> unsave(String placeId) async {
    final current = state.asData?.value;
    if (current == null) return false;
    try {
      await ref.read(explorePlacesRepositoryProvider).unsave(placeId);
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(
          bookmarkedPlaceIds: {...latest.bookmarkedPlaceIds}..remove(placeId),
        ),
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<ExplorePlacesViewState> _load({required int radiusKm}) async {
    final repository = ref.read(explorePlacesRepositoryProvider);
    final offset = DateTime.now().timeZoneOffset.inMinutes;
    final featuredFuture = repository.getFeatured(utcOffsetMinutes: offset);
    final collectionsFuture = repository.getFeaturedCollections();
    final featured = await featuredFuture;
    final collections = await collectionsFuture;
    final location = await _location();
    final nearby = location.coordinate == null
        ? const <NearbyPlace>[]
        : await repository.getNearby(
            latitude: location.coordinate!.latitude,
            longitude: location.coordinate!.longitude,
            radiusKm: radiusKm,
          );
    final nearbyMessage = location.denied
        ? exploreLocationDeniedMessage
        : nearby.isEmpty
        ? exploreNearbyEmptyMessage
        : null;
    return ExplorePlacesViewState(
      feed: ExplorePlacesFeed(
        featuredSubtitle: featured.subtitle,
        featured: mapFeaturedPlaces(featured),
        nearbySubtitle: exploreNearbySubtitle,
        nearbyRadiusLabel: '$radiusKm km',
        nearby: nearby,
        collectionsSubtitle: exploreCollectionsSubtitle,
        collections: collections,
      ),
      bookmarkedPlaceIds: {
        for (final place in featured.places)
          if (place.bookmarked) place.id,
      },
      radiusKm: radiusKm,
      latitude: location.coordinate?.latitude,
      longitude: location.coordinate?.longitude,
      nearbyMessage: nearbyMessage,
    );
  }

  Future<({DeviceCoordinate? coordinate, bool denied})> _location() async {
    try {
      final coordinate = await ref
          .read(deviceLocationServiceProvider)
          .current();
      return (coordinate: coordinate, denied: false);
    } on DeviceLocationException {
      return (coordinate: null, denied: true);
    }
  }
}

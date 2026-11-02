import 'dart:async';

import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/application/add_itinerary_activity_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/application/add_itinerary_activity_state.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/data/models/itinerary_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/data/models/itinerary_requests.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/data/repositories/trip_itinerary_repository.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/provider/trip_itinerary_provider.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';

void main() {
  late _FakeTripItineraryRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = _FakeTripItineraryRepository();
    container = ProviderContainer(
      overrides: [
        tripItineraryRepositoryProvider.overrideWithValue(repository),
      ],
    );
  });

  tearDown(() => container.dispose());

  test('selection seeds untouched title and enables submit', () {
    final notifier = container.read(_provider.notifier);
    notifier.selectPlace(_place);

    final state = container.read(_provider);
    expect(state.selectedPlace?.id, 'place-1');
    expect(state.title, 'Bãi biển');
    expect(state.canSubmit, isTrue);
  });

  test('blank query clears results without calling repository', () async {
    final notifier = container.read(_provider.notifier);
    notifier.setSearchQuery('   ');
    await notifier.searchPlaces();

    expect(repository.searchCalls, 0);
    expect(container.read(_provider).searchResults, isEmpty);
  });

  test('search trims query and forwards trip destination id', () async {
    repository.searchResults = const [_place];
    final notifier = container.read(_provider.notifier);
    notifier.setSearchQuery('  biển  ');
    await notifier.searchPlaces();

    expect(repository.searchCalls, 1);
    expect(repository.lastDestinationId, 'destination-1');
    expect(repository.lastQuery, 'biển');
    expect(container.read(_provider).searchResults, const [_place]);
  });

  test(
    'changing query immediately invalidates in-flight search state',
    () async {
      final completer = Completer<List<PlaceSearchResult>>();
      repository.searchCompleter = completer;
      final notifier = container.read(_provider.notifier);
      notifier.setSearchQuery('biển');
      final firstSearch = notifier.searchPlaces();
      expect(container.read(_provider).isSearchingPlaces, isTrue);

      notifier.setSearchQuery('núi');
      expect(container.read(_provider).searchResults, isEmpty);
      expect(container.read(_provider).isSearchingPlaces, isFalse);

      completer.complete(const [_place]);
      await firstSearch;
      expect(container.read(_provider).searchResults, isEmpty);
      expect(container.read(_provider).query, 'núi');
    },
  );

  test('route context rejects insertion choices from another trip', () {
    final invalidArgs = AddItineraryActivityArgs(
      tripId: 'trip-1',
      dayId: 'day-1',
      destinationId: 'destination-1',
      dayNumber: 1,
      dayDate: DateTime(2026, 10, 5),
      city: 'Đà Nẵng',
      country: 'Việt Nam',
      insertionChoices: [_activityFor(tripId: 'trip-2')],
      canManageItinerary: true,
    );

    expect(invalidArgs.hasValidContext, isFalse);
  });

  test('invalid insertion id is rejected locally', () {
    final notifier = container.read(_provider.notifier);
    notifier.setInsertAfterActivityId('missing');

    expect(
      container.read(_provider).fieldErrors['insertAfterActivityId'],
      isNotNull,
    );
  });

  test('search error preserves query and exposes safe retry message', () async {
    repository.searchError = const ApiException(
      message: 'internal details',
      statusCode: 503,
    );
    final notifier = container.read(_provider.notifier);
    notifier.setSearchQuery('biển');
    await notifier.searchPlaces();

    final state = container.read(_provider);
    expect(state.query, 'biển');
    expect(state.searchError, 'Máy chủ đang gặp sự cố. Vui lòng thử lại.');
  });

  test('submit maps only supported request fields and refreshes', () async {
    final notifier = container.read(_provider.notifier);
    notifier.selectPlace(_place);
    notifier.setTitle('  Hoàng hôn  ');
    notifier.setDurationMinutes(120);
    notifier.setEstimatedCost(100000);

    final result = await notifier.submit();

    expect(result?.id, 'created-1');
    expect(repository.createCalls, 1);
    expect(repository.lastDayId, 'day-1');
    expect(repository.lastRequest?.toJson(), {
      'placeId': 'place-1',
      'title': 'Hoàng hôn',
      'estimatedDuration': 120,
      'estimatedCost': 100000,
    });
    expect(repository.itineraryCalls, greaterThanOrEqualTo(1));
  });

  test('submit sends the start time as UTC on the itinerary day', () async {
    final notifier = container.read(_provider.notifier);
    notifier.selectPlace(_place);
    notifier.setStartTime(const TimeOfDay(hour: 9, minute: 5));

    await notifier.submit();

    expect(
      repository.lastRequest?.toJson()['startTime'],
      '2026-10-05T09:05:00Z',
    );
  });

  test('submit without a place stays local and preserves form', () async {
    final notifier = container.read(_provider.notifier);
    notifier.setTitle('Tên đã nhập');

    expect(await notifier.submit(), isNull);
    expect(repository.createCalls, 0);
    expect(container.read(_provider).title, 'Tên đã nhập');
    expect(container.read(_provider).fieldErrors['placeId'], isNotNull);
  });

  test('unauthorized route context cannot submit', () async {
    final args = AddItineraryActivityArgs(
      tripId: 'trip-1',
      dayId: 'day-1',
      destinationId: 'destination-1',
      dayNumber: 1,
      dayDate: DateTime(2026, 10, 5),
      city: 'Đà Nẵng',
      country: 'Việt Nam',
      insertionChoices: const [],
      canManageItinerary: false,
    );
    final provider = addItineraryActivityControllerProvider(args);
    final notifier = container.read(provider.notifier);
    notifier.selectPlace(_place);

    expect(container.read(provider).canSubmit, isFalse);
    expect(await notifier.submit(), isNull);
    expect(repository.createCalls, 0);
    expect(container.read(provider).fieldErrors['permission'], isNotNull);
  });

  test(
    'backend validation maps recognized field and preserves input',
    () async {
      repository.createError = const ApiException(
        message: 'Validation failed',
        statusCode: 400,
        code: 'VALIDATION_ERROR',
        details: {
          'details': [
            {'field': 'estimatedCost', 'message': 'must not be negative'},
            {'field': 'unknown', 'message': 'ignored'},
          ],
        },
      );
      final notifier = container.read(_provider.notifier);
      notifier.selectPlace(_place);
      notifier.setTitle('Tên giữ lại');

      expect(await notifier.submit(), isNull);
      final state = container.read(_provider);
      expect(state.title, 'Tên giữ lại');
      expect(state.fieldErrors, {'estimatedCost': 'must not be negative'});
      expect(state.isSubmitting, isFalse);
    },
  );
}

final _args = AddItineraryActivityArgs(
  tripId: 'trip-1',
  dayId: 'day-1',
  destinationId: 'destination-1',
  dayNumber: 1,
  dayDate: DateTime(2026, 10, 5),
  city: 'Đà Nẵng',
  country: 'Việt Nam',
  insertionChoices: const [],
  canManageItinerary: true,
);

final _provider = addItineraryActivityControllerProvider(_args);

const _place = PlaceSearchResult(
  id: 'place-1',
  name: 'Bãi biển',
  latitude: 16.0,
  longitude: 108.0,
  similarity: 0.9,
  distanceKm: 1.2,
);

class _FakeTripItineraryRepository implements TripItineraryRepository {
  List<PlaceSearchResult> searchResults = const [];
  int searchCalls = 0;
  int createCalls = 0;
  int itineraryCalls = 0;
  String? lastDestinationId;
  String? lastQuery;
  String? lastDayId;
  CreateActivityRequest? lastRequest;
  Object? searchError;
  Object? createError;
  Completer<List<PlaceSearchResult>>? searchCompleter;

  @override
  Future<TripItineraryData> getItinerary(String tripId) async {
    itineraryCalls++;
    return const TripItineraryData(destinations: [], canManageItinerary: true);
  }

  @override
  Future<DestinationItinerary> getDestination(
    String tripId,
    String destinationId,
  ) => throw UnimplementedError();

  @override
  Future<List<PlaceSearchResult>> searchPlaces({
    required String destinationId,
    required String query,
    double radiusKm = 20,
    List<String>? categories,
  }) async {
    if (searchError != null) throw searchError!;
    searchCalls++;
    lastDestinationId = destinationId;
    lastQuery = query;
    if (searchCompleter != null) return searchCompleter!.future;
    return searchResults;
  }

  @override
  Future<ItineraryActivity> createActivity(
    String tripId,
    String dayId,
    CreateActivityRequest request,
  ) async {
    if (createError != null) throw createError!;
    createCalls++;
    lastDayId = dayId;
    lastRequest = request;
    return _activity;
  }

  @override
  Future<void> deleteActivity(String tripId, String activityId) async {}

  @override
  Future<void> deleteDestination(
    String tripId,
    String destinationId, {
    bool acknowledgeRecruitmentImpact = false,
  }) async {}

  @override
  Future<TripItineraryCompletion> getCompletion(String tripId) =>
      throw UnimplementedError();

  @override
  Future<List<ItineraryActivity>> reorderItems(
    String tripId,
    String dayId,
    List<String> orderedItemIds,
  ) async => const [];

  @override
  Future<ItineraryActivity> updateActivity(
    String tripId,
    String activityId,
    UpdateActivityRequest request,
  ) => throw UnimplementedError();

  @override
  Future<TripCheckin> checkin(
    String tripId,
    String activityId,
    CheckinActivityRequest request,
  ) => throw UnimplementedError();

  @override
  Future<void> uncheckin(String tripId, String activityId) async {}

  @override
  Future<CreateItineraryItemsBatchResult> createItemsBatch(
    String tripId,
    CreateItineraryItemsBatchRequest request,
  ) => throw UnimplementedError();
}

final _activity = ItineraryActivity(
  id: 'created-1',
  tripId: 'trip-1',
  dayId: 'day-1',
  placeId: 'place-1',
  title: 'Hoàng hôn',
  isCheckin: false,
  orderIndex: 1,
  createdAt: DateTime(2026, 10, 5),
  updatedAt: DateTime(2026, 10, 5),
);

ItineraryActivity _activityFor({required String tripId}) => ItineraryActivity(
  id: 'activity-1',
  tripId: tripId,
  dayId: 'day-1',
  placeId: 'place-1',
  title: 'Hoạt động',
  isCheckin: false,
  orderIndex: 1,
  createdAt: DateTime(2026, 10, 5),
  updatedAt: DateTime(2026, 10, 5),
);

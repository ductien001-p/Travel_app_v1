import 'dart:convert';
import 'dart:ui';

import 'package:travel_frontend_v1/core/location/device_location_service.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_itinerary_share_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/datamock/trip_itinerary_datamock.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/models/trip_detail_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/models/trip_itinerary_checkin_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/models/trip_itinerary_route_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/models/trip_share_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/data/datasources/trip_itinerary_remote_datasource.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/data/models/itinerary_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/data/models/itinerary_requests.dart';

import 'trip_detail_fixture.dart';

/// "Now" inside the datamock trip: day 2, between the lunch and the pagoda.
final itineraryNow = DateTime.utc(2026, 7, 16, 13);

Map<String, dynamic> _deepCopy(Object? json) =>
    Map<String, dynamic>.from(jsonDecode(jsonEncode(json)) as Map);

TripItineraryData datamockItinerary() => TripItineraryData.fromEnvelope(
  _deepCopy(tripItineraryDatamock['itinerary']),
);

Set<String> datamockViewerPlaceIds() => {
  for (final item
      in (tripItineraryDatamock['viewerCheckins'] as Map)['data'] as List)
    (item as Map)['placeId'] as String,
};

/// In-memory backend shared by the itinerary and trip-detail fakes so a
/// check-in is visible to the next read of either.
class FakeItineraryBackend {
  FakeItineraryBackend({
    Map<String, dynamic>? itineraryEnvelope,
    this.viewerCheckinsError,
    this.itineraryError,
  }) : itineraryEnvelope =
           itineraryEnvelope ?? _deepCopy(tripItineraryDatamock['itinerary']),
       viewerCheckins = [
         for (final item
             in (tripItineraryDatamock['viewerCheckins'] as Map)['data']
                 as List)
           TripItineraryViewerCheckin.fromJson(
             Map<String, dynamic>.from(item as Map),
           ),
       ];

  final Map<String, dynamic> itineraryEnvelope;
  final List<TripItineraryViewerCheckin> viewerCheckins;
  Object? viewerCheckinsError;
  Object? itineraryError;
  Object? dayRouteError;

  Object? updateError;
  Object? shareError;
  Object? sharedItineraryError;
  bool sharedViewerIsMember = false;
  int revokableLinks = 2;
  int shareLinkRequests = 0;
  final sharedTokens = <String>[];

  final checkinRequests = <(String, CheckinActivityRequest)>[];
  final deletedActivityIds = <String>[];
  final updateRequests = <(String, Map<String, dynamic>)>[];
  final dayRouteRequests = <String>[];

  /// Road route from the datamock for its day; other days have no legs.
  TripDayRoute dayRoute(String dayId) {
    final mock = TripDayRoute.fromJson(
      _deepCopy((tripItineraryDatamock['dayRoute'] as Map)['data']),
    );
    if (mock.dayId == dayId) return mock;
    return TripDayRoute(
      dayId: dayId,
      available: false,
      totalDistanceMeters: 0,
      totalDurationSeconds: 0,
      legs: const [],
    );
  }

  Iterable<Map<String, dynamic>> get _activities sync* {
    for (final destination in itineraryEnvelope['data'] as List) {
      for (final day in (destination as Map)['itineraryDays'] as List) {
        for (final activity in (day as Map)['activities'] as List) {
          yield activity as Map<String, dynamic>;
        }
      }
    }
  }

  Map<String, dynamic> activity(String id) =>
      _activities.firstWhere((activity) => activity['id'] == id);
}

class FakeTripItineraryRemoteDataSource extends TripItineraryRemoteDataSource {
  FakeTripItineraryRemoteDataSource(this.backend)
    : super(apiClient: unusedApiClient());

  final FakeItineraryBackend backend;

  @override
  Future<TripItineraryData> getItinerary(String tripId) async {
    final error = backend.itineraryError;
    if (error != null) throw error;
    return TripItineraryData.fromEnvelope(_deepCopy(backend.itineraryEnvelope));
  }

  @override
  Future<DestinationItinerary> getDestination(
    String tripId,
    String destinationId,
  ) async {
    final error = backend.itineraryError;
    if (error != null) throw error;
    final data = backend.itineraryEnvelope['data'] as List;
    final match = data.cast<Map>().firstWhere(
      (item) => item['id'] == destinationId,
      orElse: () => throw StateError('Missing destination $destinationId'),
    );
    return DestinationItinerary.fromJson(
      Map<String, dynamic>.from(_deepCopy(Map<String, dynamic>.from(match))),
    );
  }

  @override
  Future<TripCheckin> checkin(
    String tripId,
    String activityId,
    CheckinActivityRequest request,
  ) async {
    backend.checkinRequests.add((activityId, request));
    final placeId = backend.activity(activityId)['placeId'] as String;
    if (backend.viewerCheckins.any((c) => c.placeId == placeId)) {
      throw const ApiException(
        message: 'You already checked in to this place',
        statusCode: 409,
      );
    }
    final now = DateTime.utc(2026, 7, 16, 15, 5);
    backend.viewerCheckins.add(
      TripItineraryViewerCheckin(
        activityId: activityId,
        placeId: placeId,
        visitedAt: now,
      ),
    );
    return TripCheckin(
      id: 'checkin-$activityId',
      memberId: 'member-alex',
      activityId: activityId,
      latitude: request.latitude,
      longitude: request.longitude,
      visitedAt: now,
      createdAt: now,
    );
  }

  @override
  Future<void> uncheckin(String tripId, String activityId) async {
    final placeId = backend.activity(activityId)['placeId'];
    backend.viewerCheckins.removeWhere((c) => c.placeId == placeId);
  }

  @override
  Future<ItineraryActivity> updateActivity(
    String tripId,
    String activityId,
    UpdateActivityRequest request,
  ) async {
    final body = request.toJson();
    backend.updateRequests.add((activityId, body));
    final error = backend.updateError;
    if (error != null) throw error;
    final activity = backend.activity(activityId);
    for (final MapEntry(:key, :value) in body.entries) {
      activity[key] = value is DateTime ? value.toIso8601String() : value;
    }
    return ItineraryActivity.fromJson(_deepCopy(activity));
  }

  @override
  Future<void> deleteActivity(String tripId, String activityId) async {
    backend.deletedActivityIds.add(activityId);
    for (final destination in backend.itineraryEnvelope['data'] as List) {
      for (final day in (destination as Map)['itineraryDays'] as List) {
        ((day as Map)['activities'] as List).removeWhere(
          (activity) => (activity as Map)['id'] == activityId,
        );
      }
    }
  }
}

class FakeItineraryTripDetailDataSource extends FakeTripDetailRemoteDataSource {
  FakeItineraryTripDetailDataSource(this.backend, [super.json]);

  final FakeItineraryBackend backend;

  /// Align destination tabs with the itinerary envelope (city names / dates).
  @override
  Future<TripDetailOverview> getTripDetail(String tripId) async {
    final trip = await super.getTripDetail(tripId);
    final raw = backend.itineraryEnvelope['data'];
    if (raw is! List || raw.isEmpty) {
      return trip.copyWith(destinations: const []);
    }
    return trip.copyWith(
      destinations: [
        for (final item in raw)
          TripDetailDestination(
            id: (item as Map)['id'] as String,
            city: item['city'] as String,
            country: item['country'] as String,
            order: (item['order'] as num).toInt(),
            startDate: DateTime.parse(item['startDate'] as String),
            endDate: DateTime.parse(item['endDate'] as String),
            isCurrent: false,
          ),
      ],
    );
  }

  @override
  Future<List<TripItineraryViewerCheckin>> getMyItineraryCheckins(
    String tripId,
  ) async {
    final error = backend.viewerCheckinsError;
    if (error != null) throw error;
    return List.of(backend.viewerCheckins);
  }

  @override
  Future<TripShareLink> createShareLink(String tripId) async {
    backend.shareLinkRequests++;
    final error = backend.shareError;
    if (error != null) throw error;
    return TripShareLink(
      url: 'https://share.travel.test/s/${'a' * 43}',
      expiresAt: DateTime.utc(2026, 11, 11),
    );
  }

  @override
  Future<int> revokeShareLinks(String tripId) async {
    final error = backend.shareError;
    if (error != null) throw error;
    final count = backend.revokableLinks;
    backend.revokableLinks = 0;
    return count;
  }

  @override
  Future<SharedItinerary> getSharedItinerary(String token) async {
    backend.sharedTokens.add(token);
    final error = backend.sharedItineraryError;
    if (error != null) throw error;
    return SharedItinerary.parse({
      'trip': {
        'id': 'trip-1',
        'name': 'Mùa hè rực rỡ xuyên miền Trung 2025',
        'startDate': '2026-07-15T00:00:00.000Z',
        'endDate': '2026-07-20T00:00:00.000Z',
        'status': 'ONGOING',
      },
      'destinations': _deepCopy(backend.itineraryEnvelope)['data'],
      'permissions': {'canManageItinerary': false},
      'viewer': {'isMember': backend.sharedViewerIsMember},
    });
  }

  @override
  Future<TripDayRoute> getDayRoute(String tripId, String dayId) async {
    backend.dayRouteRequests.add(dayId);
    final error = backend.dayRouteError;
    if (error != null) throw error;
    return backend.dayRoute(dayId);
  }
}

class RecordingShareSheet implements TripShareSheet {
  final shared = <({String text, String subject})>[];

  @override
  Future<void> share(
    String text, {
    required String subject,
    Rect? origin,
  }) async => shared.add((text: text, subject: subject));
}

class FakeDeviceLocationService implements DeviceLocationService {
  FakeDeviceLocationService({this.failure});

  final DeviceLocationFailure? failure;
  static const coordinate = DeviceCoordinate(
    latitude: 16.1003,
    longitude: 108.2779,
  );

  @override
  Future<DeviceCoordinate> current() async {
    final failure = this.failure;
    if (failure != null) throw DeviceLocationException(failure);
    return coordinate;
  }
}

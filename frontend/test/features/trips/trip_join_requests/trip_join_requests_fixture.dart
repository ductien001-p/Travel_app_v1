import 'package:travel_frontend_v1/features/trips/trip-details/data/models/trip_detail_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/datamock/trip_join_requests_datamock.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/models/trip_join_request_models.dart';

import '../trip_details/trip_detail_fixture.dart';
import 'in_memory_trip_join_requests_datasource.dart';

/// The moment the datamock was written for.
final fixtureNow = DateTime.parse(tripJoinRequestsDatamockNow);

/// `tripDetailJson()` (4 members) seen by [role], with [maxMembers] seats.
Map<String, dynamic> joinRequestsTripJson({
  String? role = 'OWNER',
  int maxMembers = 6,
  String status = 'UPCOMING',
}) => {
  ...tripDetailJson(),
  'status': status,
  'maxMembers': maxMembers,
  'inviteCode': role == 'OWNER' ? 'HE2025-VN' : null,
  'viewer': {'userId': 'user-alex', 'role': role},
};

/// In-memory backend recording calls and failing on demand.
class FakeTripJoinRequestsDataSource
    extends InMemoryTripJoinRequestsDataSource {
  FakeTripJoinRequestsDataSource() : super(now: () => fixtureNow);

  final joinCodes = <String>[];
  final pageRequests = <({TripJoinRequestStatus status, String? cursor})>[];
  final decisions = <({String requestId, TripJoinRequestStatus decision})>[];
  final savedSettings = <TripJoinRequestSettings>[];

  /// Thrown by every `getJoinRequests` while set.
  Object? listError;
  Object? decisionError;
  Object? settingsSaveError;

  /// Tabs answered with no request at all.
  final emptyTabs = <TripJoinRequestStatus>{};

  @override
  Future<TripJoinRequest> requestToJoin(String inviteCode, {String? message}) {
    joinCodes.add(inviteCode);
    return super.requestToJoin(inviteCode, message: message);
  }

  @override
  Future<TripJoinRequestsPage> getJoinRequests(
    String tripId, {
    required TripJoinRequestStatus status,
    required int limit,
    String? cursor,
  }) async {
    pageRequests.add((status: status, cursor: cursor));
    final error = listError;
    if (error != null) throw error;
    if (emptyTabs.contains(status)) {
      return const TripJoinRequestsPage(meta: TripJoinRequestsMeta());
    }
    return super.getJoinRequests(
      tripId,
      status: status,
      limit: limit,
      cursor: cursor,
    );
  }

  @override
  Future<TripJoinRequest> approveJoinRequest(String tripId, String requestId) {
    decisions.add((
      requestId: requestId,
      decision: TripJoinRequestStatus.approved,
    ));
    final error = decisionError;
    if (error != null) throw error;
    return super.approveJoinRequest(tripId, requestId);
  }

  @override
  Future<TripJoinRequest> rejectJoinRequest(String tripId, String requestId) {
    decisions.add((
      requestId: requestId,
      decision: TripJoinRequestStatus.rejected,
    ));
    final error = decisionError;
    if (error != null) throw error;
    return super.rejectJoinRequest(tripId, requestId);
  }

  @override
  Future<TripJoinRequestSettings> updateJoinRequestSettings(
    String tripId,
    TripJoinRequestSettings settings,
  ) {
    savedSettings.add(settings);
    final error = settingsSaveError;
    if (error != null) throw error;
    return super.updateJoinRequestSettings(tripId, settings);
  }
}

/// Counts `GET /trips/{id}` to check what a decision reloads.
class CountingTripDetailDataSource extends FakeTripDetailRemoteDataSource {
  CountingTripDetailDataSource([super.json]);

  int loads = 0;

  @override
  Future<TripDetailOverview> getTripDetail(String tripId) {
    loads++;
    return super.getTripDetail(tripId);
  }
}

import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/datamock/trip_join_by_code_datamock.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/datamock/trip_join_requests_datamock.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/datasources/trip_join_requests_datasource.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/models/trip_invite_preview_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/models/trip_join_request_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/utils/trip_join_by_code_formatters.dart';

/// Join request backend seeded from the datamock, answering for every trip id
/// with the status codes of `TripJoinRequestsController`.
class InMemoryTripJoinRequestsDataSource implements TripJoinRequestsDataSource {
  InMemoryTripJoinRequestsDataSource({required DateTime Function() now})
    : _now = now;

  final DateTime Function() _now;

  final List<TripJoinRequest> _requests = [
    for (final json in tripJoinRequestsDatamock['joinRequests'] as List)
      TripJoinRequest.fromJson(Map<String, dynamic>.from(json as Map)),
  ];
  TripJoinRequestSettings _settings = TripJoinRequestSettings.fromJson(
    Map<String, dynamic>.from(
      tripJoinRequestsDatamock['joinRequestSettings'] as Map,
    ),
  );

  final TripJoinInvitePreview _preview = TripJoinInvitePreview.fromJson(
    Map<String, dynamic>.from(tripJoinByCodeDatamock['invitePreview'] as Map),
  );

  @override
  Future<TripJoinInvitePreview> previewByInviteCode(String inviteCode) async {
    final code = normalizeInviteCode(inviteCode);
    if (code != _preview.inviteCode) {
      throw const ApiException(message: 'Mã mời không hợp lệ', statusCode: 404);
    }
    return _preview;
  }

  @override
  Future<TripJoinRequest> requestToJoin(
    String inviteCode, {
    String? message,
  }) async {
    final template = _requests.first;
    final request = template.copyWith(
      id: 'join-request-${_requests.length + 1}',
      status: TripJoinRequestStatus.pending,
      message: message,
      createdAt: _now().toUtc(),
      decidedAt: null,
    );
    _requests.add(request);
    return request;
  }

  @override
  Future<TripJoinInvitePreview> previewByTripId(String tripId) async {
    if (tripId.trim().isEmpty) {
      throw const ApiException(message: 'Trip not found', statusCode: 404);
    }
    return _preview.copyWith(tripId: tripId);
  }

  @override
  Future<TripJoinRequest> requestToJoinByTripId(
    String tripId, {
    String? message,
  }) async {
    if (tripId.trim().isEmpty) {
      throw const ApiException(message: 'Trip not found', statusCode: 404);
    }
    final template = _requests.first;
    final request = template.copyWith(
      id: 'join-request-${_requests.length + 1}',
      tripId: tripId,
      status: TripJoinRequestStatus.pending,
      message: message,
      createdAt: _now().toUtc(),
      decidedAt: null,
    );
    _requests.add(request);
    return request;
  }

  @override
  Future<TripJoinRequestsPage> getJoinRequests(
    String tripId, {
    required TripJoinRequestStatus status,
    required int limit,
    String? cursor,
  }) async {
    final matching =
        _requests.where((request) => request.status == status).toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final start = cursor == null ? 0 : int.tryParse(cursor);
    if (start == null || start < 0 || start > matching.length) {
      throw const ApiException(message: 'Invalid cursor', statusCode: 400);
    }
    final end = (start + limit).clamp(start, matching.length);
    final hasMore = end < matching.length;
    return TripJoinRequestsPage(
      items: [
        for (final request in matching.sublist(start, end))
          request.copyWith(tripId: tripId),
      ],
      meta: TripJoinRequestsMeta(
        nextCursor: hasMore ? '$end' : null,
        hasMore: hasMore,
        counts: TripJoinRequestCounts(
          pending: _count(TripJoinRequestStatus.pending),
          approved: _count(TripJoinRequestStatus.approved),
          rejected: _count(TripJoinRequestStatus.rejected),
        ),
      ),
    );
  }

  @override
  Future<TripJoinRequest> approveJoinRequest(String tripId, String requestId) =>
      _decide(tripId, requestId, TripJoinRequestStatus.approved);

  @override
  Future<TripJoinRequest> rejectJoinRequest(String tripId, String requestId) =>
      _decide(tripId, requestId, TripJoinRequestStatus.rejected);

  @override
  Future<TripJoinRequestSettings> getJoinRequestSettings(String tripId) async =>
      _settings;

  @override
  Future<TripJoinRequestSettings> updateJoinRequestSettings(
    String tripId,
    TripJoinRequestSettings settings,
  ) async => _settings = settings;

  Future<TripJoinRequest> _decide(
    String tripId,
    String requestId,
    TripJoinRequestStatus decision,
  ) async {
    final index = _requests.indexWhere((request) => request.id == requestId);
    if (index < 0) {
      throw const ApiException(
        message: 'Join request not found',
        statusCode: 404,
      );
    }
    if (_requests[index].status != TripJoinRequestStatus.pending) {
      throw const ApiException(
        message: 'Join request is no longer pending',
        statusCode: 409,
      );
    }
    final decided = _requests[index].copyWith(
      status: decision,
      decidedAt: _now().toUtc(),
    );
    _requests[index] = decided;
    return decided.copyWith(tripId: tripId);
  }

  int _count(TripJoinRequestStatus status) =>
      _requests.where((request) => request.status == status).length;
}

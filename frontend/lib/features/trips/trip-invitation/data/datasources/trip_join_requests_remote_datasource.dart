import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/trip_invite_preview_models.dart';
import '../models/trip_join_request_models.dart';
import 'trip_join_requests_datasource.dart';

/// Join-request + invite-code endpoints of the trips API.
class TripJoinRequestsRemoteDataSource implements TripJoinRequestsDataSource {
  const TripJoinRequestsRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  static String _basePath(String tripId) =>
      '/trips/${Uri.encodeComponent(tripId)}/join-requests';

  @override
  Future<TripJoinInvitePreview> previewByInviteCode(String inviteCode) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/join/${Uri.encodeComponent(inviteCode)}',
    );
    return TripJoinInvitePreview.fromJson(_dataOf(body, 'invite preview'));
  }

  @override
  Future<TripJoinRequest> requestToJoin(
    String inviteCode, {
    String? message,
  }) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trips/join/${Uri.encodeComponent(inviteCode)}',
      data: {'message': ?message},
    );
    return TripJoinRequest.fromJson(_dataOf(body, 'join request'));
  }

  @override
  Future<TripJoinInvitePreview> previewByTripId(String tripId) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/join/preview',
    );
    return TripJoinInvitePreview.fromJson(_dataOf(body, 'join preview'));
  }

  @override
  Future<TripJoinRequest> requestToJoinByTripId(
    String tripId, {
    String? message,
  }) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/join',
      data: {'message': ?message},
    );
    return TripJoinRequest.fromJson(_dataOf(body, 'join request'));
  }

  @override
  Future<TripJoinRequestsPage> getJoinRequests(
    String tripId, {
    required TripJoinRequestStatus status,
    required int limit,
    String? cursor,
  }) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      _basePath(tripId),
      queryParameters: {
        'status': _statusParam(status),
        'limit': limit,
        'cursor': ?cursor,
      },
    );
    if (body['data'] is! List || body['meta'] is! Map) {
      throw const FormatException('Invalid join requests response.');
    }
    return TripJoinRequestsPage.fromJson(body);
  }

  @override
  Future<TripJoinRequest> approveJoinRequest(String tripId, String requestId) =>
      _decide(tripId, requestId, 'approve');

  @override
  Future<TripJoinRequest> rejectJoinRequest(String tripId, String requestId) =>
      _decide(tripId, requestId, 'reject');

  @override
  Future<TripJoinRequestSettings> getJoinRequestSettings(String tripId) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '${_basePath(tripId)}/settings',
    );
    return TripJoinRequestSettings.fromJson(_dataOf(body, 'settings'));
  }

  @override
  Future<TripJoinRequestSettings> updateJoinRequestSettings(
    String tripId,
    TripJoinRequestSettings settings,
  ) async {
    final body = await _apiClient.patch<Map<String, dynamic>>(
      '${_basePath(tripId)}/settings',
      data: settings.toJson(),
    );
    return TripJoinRequestSettings.fromJson(_dataOf(body, 'settings'));
  }

  Future<TripJoinRequest> _decide(
    String tripId,
    String requestId,
    String action,
  ) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '${_basePath(tripId)}/${Uri.encodeComponent(requestId)}/$action',
    );
    return TripJoinRequest.fromJson(_dataOf(body, 'join request'));
  }

  static String _statusParam(TripJoinRequestStatus status) => switch (status) {
    TripJoinRequestStatus.pending => 'PENDING',
    TripJoinRequestStatus.approved => 'APPROVED',
    TripJoinRequestStatus.rejected => 'REJECTED',
  };

  static Map<String, dynamic> _dataOf(Map<String, dynamic> body, String what) {
    final data = body['data'];
    if (data is! Map) throw FormatException('Invalid $what response.');
    return Map<String, dynamic>.from(data);
  }
}

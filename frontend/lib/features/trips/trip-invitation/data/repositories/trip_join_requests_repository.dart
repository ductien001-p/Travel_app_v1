import '../datasources/trip_join_requests_datasource.dart';
import '../models/trip_invite_preview_models.dart';
import '../models/trip_join_request_models.dart';
import '../../utils/trip_join_by_code_formatters.dart';

class TripJoinRequestsRepository {
  const TripJoinRequestsRepository({
    required TripJoinRequestsDataSource dataSource,
  }) : _dataSource = dataSource;

  static const pageSize = 20;

  /// Mirrors `@MaxLength` of the backend `RequestToJoinDto`.
  static const maxMessageLength = 500;

  final TripJoinRequestsDataSource _dataSource;

  /// `GET /trips/join/{inviteCode}` — requires a complete invite code.
  Future<TripJoinInvitePreview> previewByInviteCode(String inviteCode) {
    final code = normalizeInviteCode(inviteCode);
    if (!isInviteCodeComplete(code)) {
      throw ArgumentError.value(
        inviteCode,
        'inviteCode',
        'Must be a complete invite code',
      );
    }
    return _dataSource.previewByInviteCode(code);
  }

  Future<TripJoinRequest> requestToJoin(String inviteCode, {String? message}) {
    final code = normalizeInviteCode(inviteCode);
    if (code.isEmpty) {
      throw ArgumentError.value(inviteCode, 'inviteCode', 'Must not be empty');
    }
    return _dataSource.requestToJoin(
      code,
      message: _normalizedMessage(message),
    );
  }

  Future<TripJoinInvitePreview> previewByTripId(String tripId) {
    final id = tripId.trim();
    if (id.isEmpty) {
      throw ArgumentError.value(tripId, 'tripId', 'Must not be empty');
    }
    return _dataSource.previewByTripId(id);
  }

  Future<TripJoinRequest> requestToJoinByTripId(
    String tripId, {
    String? message,
  }) {
    final id = tripId.trim();
    if (id.isEmpty) {
      throw ArgumentError.value(tripId, 'tripId', 'Must not be empty');
    }
    return _dataSource.requestToJoinByTripId(
      id,
      message: _normalizedMessage(message),
    );
  }

  String? _normalizedMessage(String? message) {
    final note = message?.trim();
    if (note != null && note.length > maxMessageLength) {
      throw ArgumentError.value(
        message,
        'message',
        'Must be at most $maxMessageLength characters',
      );
    }
    return note == null || note.isEmpty ? null : note;
  }

  Future<TripJoinRequestsPage> getJoinRequests(
    String tripId, {
    required TripJoinRequestStatus status,
    String? cursor,
  }) => _dataSource.getJoinRequests(
    tripId,
    status: status,
    limit: pageSize,
    cursor: cursor,
  );

  /// Applies [decision] to a pending request and returns it as reviewed.
  Future<TripJoinRequest> decide(
    String tripId,
    String requestId,
    TripJoinRequestStatus decision,
  ) => switch (decision) {
    TripJoinRequestStatus.approved => _dataSource.approveJoinRequest(
      tripId,
      requestId,
    ),
    TripJoinRequestStatus.rejected => _dataSource.rejectJoinRequest(
      tripId,
      requestId,
    ),
    TripJoinRequestStatus.pending => throw ArgumentError.value(
      decision,
      'decision',
      'A request can only be approved or rejected',
    ),
  };

  Future<TripJoinRequestSettings> getSettings(String tripId) =>
      _dataSource.getJoinRequestSettings(tripId);

  Future<TripJoinRequestSettings> updateSettings(
    String tripId,
    TripJoinRequestSettings settings,
  ) => _dataSource.updateJoinRequestSettings(tripId, settings);
}

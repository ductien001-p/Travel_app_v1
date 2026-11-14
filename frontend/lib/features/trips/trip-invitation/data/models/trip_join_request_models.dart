import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_join_request_models.freezed.dart';
part 'trip_join_request_models.g.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TripJoinRequestStatus { pending, approved, rejected }

/// Mirrors `TRAVEL_DNA_TYPE` of the backend.
@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TripJoinRequestPersonaType {
  soloTraveler,
  familyTraveler,
  coupleTraveller,
  groupTraveler,
  backpacker,
  mountainLover,
  beachLover,
  adventureTraveler,
  foodieTraveler,
  cultureTraveler,
  entertainmentTraveller,
  photographyLover,
}

/// One page of `getJoinRequests`, newest request first.
@freezed
abstract class TripJoinRequestsPage with _$TripJoinRequestsPage {
  const factory TripJoinRequestsPage({
    @JsonKey(name: 'data')
    @Default(<TripJoinRequest>[])
    List<TripJoinRequest> items,
    required TripJoinRequestsMeta meta,
  }) = _TripJoinRequestsPage;

  factory TripJoinRequestsPage.fromJson(Map<String, dynamic> json) =>
      _$TripJoinRequestsPageFromJson(json);
}

@freezed
abstract class TripJoinRequestsMeta with _$TripJoinRequestsMeta {
  const factory TripJoinRequestsMeta({
    String? nextCursor,
    @Default(false) bool hasMore,

    /// Requests of the whole trip per status, ignoring the `status` filter so
    /// every tab keeps its count.
    @Default(TripJoinRequestCounts()) TripJoinRequestCounts counts,
  }) = _TripJoinRequestsMeta;

  factory TripJoinRequestsMeta.fromJson(Map<String, dynamic> json) =>
      _$TripJoinRequestsMetaFromJson(json);
}

@freezed
abstract class TripJoinRequestCounts with _$TripJoinRequestCounts {
  const TripJoinRequestCounts._();

  const factory TripJoinRequestCounts({
    @Default(0) int pending,
    @Default(0) int approved,
    @Default(0) int rejected,
  }) = _TripJoinRequestCounts;

  factory TripJoinRequestCounts.fromJson(Map<String, dynamic> json) =>
      _$TripJoinRequestCountsFromJson(json);

  int of(TripJoinRequestStatus status) => switch (status) {
    TripJoinRequestStatus.pending => pending,
    TripJoinRequestStatus.approved => approved,
    TripJoinRequestStatus.rejected => rejected,
  };

  /// Moves one pending request to [decision].
  TripJoinRequestCounts decided(TripJoinRequestStatus decision) =>
      switch (decision) {
        TripJoinRequestStatus.pending => this,
        TripJoinRequestStatus.approved => copyWith(
          pending: pending > 0 ? pending - 1 : 0,
          approved: approved + 1,
        ),
        TripJoinRequestStatus.rejected => copyWith(
          pending: pending > 0 ? pending - 1 : 0,
          rejected: rejected + 1,
        ),
      };
}

@freezed
abstract class TripJoinRequest with _$TripJoinRequest {
  const factory TripJoinRequest({
    required String id,
    required String tripId,
    required TripJoinRequestStatus status,
    required TripJoinRequester requester,

    /// Note the requester wrote to the trip.
    String? message,

    /// Highest travel DNA of the requester, as a display label.
    String? travelPersona,
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    TripJoinRequestPersonaType? personaType,

    /// 0..100 fit between the requester and the trip; null when unknown.
    int? matchScore,

    /// Why the requester fits the trip, written by the matchmaker.
    String? matchNote,
    required DateTime createdAt,
    DateTime? decidedAt,
  }) = _TripJoinRequest;

  factory TripJoinRequest.fromJson(Map<String, dynamic> json) =>
      _$TripJoinRequestFromJson(json);
}

@freezed
abstract class TripJoinRequester with _$TripJoinRequester {
  const factory TripJoinRequester({
    required String id,
    required String displayName,
    required String username,
    String? avatarUrl,
    @Default(false) bool isVerified,
    @Default(false) bool isOnline,
  }) = _TripJoinRequester;

  factory TripJoinRequester.fromJson(Map<String, dynamic> json) =>
      _$TripJoinRequesterFromJson(json);
}

@freezed
abstract class TripJoinRequestSettings with _$TripJoinRequestSettings {
  const factory TripJoinRequestSettings({
    /// Approves requests of the owner's friends without review.
    @Default(false) bool autoApproveFriends,
  }) = _TripJoinRequestSettings;

  factory TripJoinRequestSettings.fromJson(Map<String, dynamic> json) =>
      _$TripJoinRequestSettingsFromJson(json);
}

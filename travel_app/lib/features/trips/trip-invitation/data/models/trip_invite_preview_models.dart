import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_invite_preview_models.freezed.dart';
part 'trip_invite_preview_models.g.dart';

/// Mirrors backend `TripJoinInvitePreviewResponseDto`
/// (`GET /trips/join/{inviteCode}` → `data`).
@freezed
abstract class TripJoinInvitePreview with _$TripJoinInvitePreview {
  const factory TripJoinInvitePreview({
    required String inviteCode,
    required String tripId,
    required String name,
    String? coverImageUrl,
    required DateTime startDate,
    required DateTime endDate,
    required String ownerDisplayName,
    required int memberCount,
    required int maxMembers,

    /// 0..100; null when either side has nothing to compare.
    int? matchScore,
  }) = _TripJoinInvitePreview;

  factory TripJoinInvitePreview.fromJson(Map<String, dynamic> json) =>
      _$TripJoinInvitePreviewFromJson(json);
}

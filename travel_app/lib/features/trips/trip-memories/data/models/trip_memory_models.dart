import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_memory_models.freezed.dart';
part 'trip_memory_models.g.dart';

/// One page of `GET /trips/memories/{tripId}`, newest memory first.
@freezed
abstract class TripMemoriesPage with _$TripMemoriesPage {
  const factory TripMemoriesPage({
    @JsonKey(name: 'data')
    @Default(<TripMemoryEntry>[])
    List<TripMemoryEntry> items,
    required TripMemoriesCursor meta,
  }) = _TripMemoriesPage;

  factory TripMemoriesPage.fromJson(Map<String, dynamic> json) =>
      _$TripMemoriesPageFromJson(json);
}

/// `MemoriesCursorMetaDto`.
@freezed
abstract class TripMemoriesCursor with _$TripMemoriesCursor {
  const factory TripMemoriesCursor({
    String? nextCursor,
    @Default(false) bool hasMore,

    /// Memories of the whole trip matching the request filters; only sent
    /// with the first page (no cursor).
    int? totalCount,

    /// Memories per trip day (1-based, UTC) of the whole trip, ignoring the
    /// `day` filter so every day chip keeps its count. Days without memories
    /// are left out; only sent with the first page.
    List<TripMemoriesDayCount>? dayCounts,
  }) = _TripMemoriesCursor;

  factory TripMemoriesCursor.fromJson(Map<String, dynamic> json) =>
      _$TripMemoriesCursorFromJson(json);
}

/// `MemoryDayCountResponseDto`.
@freezed
abstract class TripMemoriesDayCount with _$TripMemoriesDayCount {
  const factory TripMemoriesDayCount({required int day, required int count}) =
      _TripMemoriesDayCount;

  factory TripMemoriesDayCount.fromJson(Map<String, dynamic> json) =>
      _$TripMemoriesDayCountFromJson(json);
}

/// `MemoryResponseDto`.
@freezed
abstract class TripMemoryEntry with _$TripMemoryEntry {
  const factory TripMemoryEntry({
    required String id,
    required String tripId,
    String? caption,
    required DateTime createdAt,
    required String imageUrl,

    /// Null when the uploader deleted their account.
    TripMemoryUploader? user,
    required TripMemoryAsset media,

    /// Label the backend suggests from the photo content ("Khoảnh khắc đêm",
    /// "Khoảnh khắc nổi bật"...); null while unclassified or when none fits.
    String? badge,
  }) = _TripMemoryEntry;

  factory TripMemoryEntry.fromJson(Map<String, dynamic> json) =>
      _$TripMemoryEntryFromJson(json);
}

@freezed
abstract class TripMemoryUploader with _$TripMemoryUploader {
  const factory TripMemoryUploader({
    required String id,
    required String username,
    String? avatarId,
  }) = _TripMemoryUploader;

  factory TripMemoryUploader.fromJson(Map<String, dynamic> json) =>
      _$TripMemoryUploaderFromJson(json);
}

@freezed
abstract class TripMemoryAsset with _$TripMemoryAsset {
  const factory TripMemoryAsset({
    required String id,
    @Default('application/octet-stream') String mimeType,
    int? width,
    int? height,
  }) = _TripMemoryAsset;

  factory TripMemoryAsset.fromJson(Map<String, dynamic> json) =>
      _$TripMemoryAssetFromJson(json);
}

/// Item of `CreateMemoriesBatchDto`: an uploaded image owned by the viewer.
@freezed
abstract class NewTripMemory with _$NewTripMemory {
  const factory NewTripMemory({
    required String mediaId,
    @JsonKey(includeIfNull: false) String? caption,
  }) = _NewTripMemory;

  factory NewTripMemory.fromJson(Map<String, dynamic> json) =>
      _$NewTripMemoryFromJson(json);
}

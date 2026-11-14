import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_places_models.freezed.dart';
part 'saved_places_models.g.dart';

/// `GET /places/saved/me`.
@freezed
abstract class SavedPlacesPage with _$SavedPlacesPage {
  const factory SavedPlacesPage({
    @JsonKey(name: 'data') @Default(<SavedPlace>[]) List<SavedPlace> items,
    required SavedPlacesPageMeta meta,
  }) = _SavedPlacesPage;

  factory SavedPlacesPage.fromJson(Map<String, dynamic> json) =>
      _$SavedPlacesPageFromJson(json);
}

@freezed
abstract class SavedPlacesPageMeta with _$SavedPlacesPageMeta {
  const factory SavedPlacesPageMeta({
    @JsonKey(fromJson: _readInt) required int page,
    @JsonKey(fromJson: _readInt) required int limit,
    @JsonKey(fromJson: _readInt) required int total,
    @JsonKey(fromJson: _readInt) required int totalPages,
    required bool hasNextPage,
    required bool hasPreviousPage,
  }) = _SavedPlacesPageMeta;

  factory SavedPlacesPageMeta.fromJson(Map<String, dynamic> json) =>
      _$SavedPlacesPageMetaFromJson(json);
}

/// `GET /places/saved/count` envelope `{ data: { count }, message }`.
@freezed
abstract class SavedPlacesCountEnvelope with _$SavedPlacesCountEnvelope {
  const factory SavedPlacesCountEnvelope({required SavedPlacesCount data}) =
      _SavedPlacesCountEnvelope;

  factory SavedPlacesCountEnvelope.fromJson(Map<String, dynamic> json) =>
      _$SavedPlacesCountEnvelopeFromJson(json);
}

@freezed
abstract class SavedPlacesCount with _$SavedPlacesCount {
  const factory SavedPlacesCount({
    @JsonKey(fromJson: _readInt) required int count,
  }) = _SavedPlacesCount;

  factory SavedPlacesCount.fromJson(Map<String, dynamic> json) =>
      _$SavedPlacesCountFromJson(json);
}

@freezed
abstract class SavedPlace with _$SavedPlace {
  const factory SavedPlace({
    required String id,
    required String userId,
    required String placeId,
    required DateTime createdAt,
    required SavedPlaceDetails place,
  }) = _SavedPlace;

  factory SavedPlace.fromJson(Map<String, dynamic> json) =>
      _$SavedPlaceFromJson(json);
}

/// Place fields returned inside a saved-place row (`SavedPlacePlaceResponseDto`).
@freezed
abstract class SavedPlaceDetails with _$SavedPlaceDetails {
  const factory SavedPlaceDetails({
    required String id,
    required String name,
    String? description,
    String? category,
    required String city,
    required String country,
    String? address,
    @JsonKey(fromJson: _readDouble) required double latitude,
    @JsonKey(fromJson: _readDouble) required double longitude,
    @JsonKey(fromJson: _readDouble) required double averageRating,
  }) = _SavedPlaceDetails;

  factory SavedPlaceDetails.fromJson(Map<String, dynamic> json) =>
      _$SavedPlaceDetailsFromJson(json);
}

int _readInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  throw const FormatException('Expected an integer.');
}

double _readDouble(Object? value) {
  if (value is num) return value.toDouble();
  throw const FormatException('Expected a number.');
}

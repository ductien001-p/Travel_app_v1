import 'package:freezed_annotation/freezed_annotation.dart';

import 'travel_dna_json.dart';

part 'travel_dna_models.freezed.dart';
part 'travel_dna_models.g.dart';

@freezed
abstract class TravelDnaRadar with _$TravelDnaRadar {
  const factory TravelDnaRadar({
    required TravelDnaSnapshot dna,
    required List<TravelDnaCommunityScore> community,
    int? dominantPercentile,
    required List<TravelDnaFitPlaces> fitPlaces,
    TravelDnaJourney? journey,
    required List<TravelDnaCompanion> companions,
  }) = _TravelDnaRadar;

  factory TravelDnaRadar.fromJson(Map<String, dynamic> json) =>
      _$TravelDnaRadarFromJson(json);
}

@freezed
abstract class TravelDnaSnapshot with _$TravelDnaSnapshot {
  const factory TravelDnaSnapshot({
    TravelDnaBadge? dominant,
    required List<TravelDnaBadge> topBadges,
    required List<TravelDnaBadge> all,
  }) = _TravelDnaSnapshot;

  factory TravelDnaSnapshot.fromJson(Map<String, dynamic> json) =>
      _$TravelDnaSnapshotFromJson(json);
}

@freezed
abstract class TravelDnaBadge with _$TravelDnaBadge {
  const factory TravelDnaBadge({
    required String type,
    required String name,
    required String icon,
    required String description,
    @JsonKey(fromJson: travelDnaJsonInt) required int score,
    @JsonKey(fromJson: travelDnaJsonInt) required int tripTypeCount,
    @JsonKey(fromJson: travelDnaJsonInt) required int activityCount,
    required String createdAt,
    required String updatedAt,
    required String shortLabel,
    required String badgeTitle,
  }) = _TravelDnaBadge;

  factory TravelDnaBadge.fromJson(Map<String, dynamic> json) =>
      _$TravelDnaBadgeFromJson(json);
}

@freezed
abstract class TravelDnaCommunityScore with _$TravelDnaCommunityScore {
  const factory TravelDnaCommunityScore({
    required String type,
    @JsonKey(fromJson: travelDnaJsonInt) required int averageScore,
    @JsonKey(fromJson: travelDnaJsonInt) required int sampleCount,
  }) = _TravelDnaCommunityScore;

  factory TravelDnaCommunityScore.fromJson(Map<String, dynamic> json) =>
      _$TravelDnaCommunityScoreFromJson(json);
}

@freezed
abstract class TravelDnaFitPlaces with _$TravelDnaFitPlaces {
  const factory TravelDnaFitPlaces({
    required String type,
    required List<TravelDnaPlace> places,
  }) = _TravelDnaFitPlaces;

  factory TravelDnaFitPlaces.fromJson(Map<String, dynamic> json) =>
      _$TravelDnaFitPlacesFromJson(json);
}

@freezed
abstract class TravelDnaPlace with _$TravelDnaPlace {
  const factory TravelDnaPlace({
    required String id,
    required String name,
    required String city,
  }) = _TravelDnaPlace;

  factory TravelDnaPlace.fromJson(Map<String, dynamic> json) =>
      _$TravelDnaPlaceFromJson(json);
}

@freezed
abstract class TravelDnaJourney with _$TravelDnaJourney {
  const factory TravelDnaJourney({
    required String tripId,
    required String name,
    @JsonKey(fromJson: travelDnaJsonInt) required int matchPercent,
    required String startDate,
    required String endDate,
    String? coverImageUrl,
    @JsonKey(fromJson: travelDnaJsonInt) required int activityCount,
  }) = _TravelDnaJourney;

  factory TravelDnaJourney.fromJson(Map<String, dynamic> json) =>
      _$TravelDnaJourneyFromJson(json);
}

@freezed
abstract class TravelDnaCompanion with _$TravelDnaCompanion {
  const factory TravelDnaCompanion({
    required String userId,
    required String displayName,
    required String username,
    String? avatarUrl,
    @JsonKey(fromJson: travelDnaJsonInt) required int matchPercent,
    required TravelDnaPersona persona,
  }) = _TravelDnaCompanion;

  factory TravelDnaCompanion.fromJson(Map<String, dynamic> json) =>
      _$TravelDnaCompanionFromJson(json);
}

@freezed
abstract class TravelDnaPersona with _$TravelDnaPersona {
  const factory TravelDnaPersona({required String name, required String icon}) =
      _TravelDnaPersona;

  factory TravelDnaPersona.fromJson(Map<String, dynamic> json) =>
      _$TravelDnaPersonaFromJson(json);
}

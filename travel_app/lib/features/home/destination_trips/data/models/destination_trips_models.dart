import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel_frontend_v1/features/home/data/models/explore_home_models.dart';

part 'destination_trips_models.freezed.dart';
part 'destination_trips_models.g.dart';

@freezed
abstract class DestinationTripsPage with _$DestinationTripsPage {
  const factory DestinationTripsPage({
    required DestinationProfile profile,
    required List<CommunityTripCard> trips,
    @Default(<String, String>{}) Map<String, String> tripTypesById,
    required List<DestinationSpot> spots,
    required int openTripCount,
    @Default(0) int spotsTotal,
  }) = _DestinationTripsPage;

  factory DestinationTripsPage.fromJson(Map<String, dynamic> json) =>
      _$DestinationTripsPageFromJson(json);
}

@freezed
abstract class DestinationProfile with _$DestinationProfile {
  const factory DestinationProfile({
    required String catalogId,
    required String name,
    required String regionLabel,
    required String coverImageUrl,
    required String tagline,
    required String summary,
    String? weatherLabel,
    String? altitudeLabel,
    String? seasonLabel,
    String? averageCostLabel,
  }) = _DestinationProfile;

  factory DestinationProfile.fromJson(Map<String, dynamic> json) =>
      _$DestinationProfileFromJson(json);
}

@freezed
abstract class DestinationSpot with _$DestinationSpot {
  const factory DestinationSpot({
    required String id,
    required String name,
    required String imageUrl,
    double? rating,
    required String categoryLabel,
    required String note,
  }) = _DestinationSpot;

  factory DestinationSpot.fromJson(Map<String, dynamic> json) =>
      _$DestinationSpotFromJson(json);
}

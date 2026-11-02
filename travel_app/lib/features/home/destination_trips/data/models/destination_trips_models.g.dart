// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination_trips_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DestinationTripsPage _$DestinationTripsPageFromJson(
  Map<String, dynamic> json,
) => _DestinationTripsPage(
  profile: DestinationProfile.fromJson(json['profile'] as Map<String, dynamic>),
  trips: (json['trips'] as List<dynamic>)
      .map((e) => CommunityTripCard.fromJson(e as Map<String, dynamic>))
      .toList(),
  tripTypesById:
      (json['tripTypesById'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
  spots: (json['spots'] as List<dynamic>)
      .map((e) => DestinationSpot.fromJson(e as Map<String, dynamic>))
      .toList(),
  openTripCount: (json['openTripCount'] as num).toInt(),
  spotsTotal: (json['spotsTotal'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$DestinationTripsPageToJson(
  _DestinationTripsPage instance,
) => <String, dynamic>{
  'profile': instance.profile,
  'trips': instance.trips,
  'tripTypesById': instance.tripTypesById,
  'spots': instance.spots,
  'openTripCount': instance.openTripCount,
  'spotsTotal': instance.spotsTotal,
};

_DestinationProfile _$DestinationProfileFromJson(Map<String, dynamic> json) =>
    _DestinationProfile(
      catalogId: json['catalogId'] as String,
      name: json['name'] as String,
      regionLabel: json['regionLabel'] as String,
      coverImageUrl: json['coverImageUrl'] as String,
      tagline: json['tagline'] as String,
      summary: json['summary'] as String,
      weatherLabel: json['weatherLabel'] as String?,
      altitudeLabel: json['altitudeLabel'] as String?,
      seasonLabel: json['seasonLabel'] as String?,
      averageCostLabel: json['averageCostLabel'] as String?,
    );

Map<String, dynamic> _$DestinationProfileToJson(_DestinationProfile instance) =>
    <String, dynamic>{
      'catalogId': instance.catalogId,
      'name': instance.name,
      'regionLabel': instance.regionLabel,
      'coverImageUrl': instance.coverImageUrl,
      'tagline': instance.tagline,
      'summary': instance.summary,
      'weatherLabel': instance.weatherLabel,
      'altitudeLabel': instance.altitudeLabel,
      'seasonLabel': instance.seasonLabel,
      'averageCostLabel': instance.averageCostLabel,
    };

_DestinationSpot _$DestinationSpotFromJson(Map<String, dynamic> json) =>
    _DestinationSpot(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num?)?.toDouble(),
      categoryLabel: json['categoryLabel'] as String,
      note: json['note'] as String,
    );

Map<String, dynamic> _$DestinationSpotToJson(_DestinationSpot instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'rating': instance.rating,
      'categoryLabel': instance.categoryLabel,
      'note': instance.note,
    };

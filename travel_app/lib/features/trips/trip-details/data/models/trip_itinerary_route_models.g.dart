// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_itinerary_route_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripRouteLeg _$TripRouteLegFromJson(Map<String, dynamic> json) =>
    _TripRouteLeg(
      fromActivityId: json['fromActivityId'] as String,
      toActivityId: json['toActivityId'] as String,
      available: json['available'] as bool,
      distanceMeters: (json['distanceMeters'] as num?)?.toInt(),
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
      polyline: json['polyline'] as String?,
      unavailableReason: $enumDecodeNullable(
        _$TripRouteUnavailableReasonEnumMap,
        json['unavailableReason'],
        unknownValue: TripRouteUnavailableReason.unknown,
      ),
    );

Map<String, dynamic> _$TripRouteLegToJson(_TripRouteLeg instance) =>
    <String, dynamic>{
      'fromActivityId': instance.fromActivityId,
      'toActivityId': instance.toActivityId,
      'available': instance.available,
      'distanceMeters': instance.distanceMeters,
      'durationSeconds': instance.durationSeconds,
      'polyline': instance.polyline,
      'unavailableReason':
          _$TripRouteUnavailableReasonEnumMap[instance.unavailableReason],
    };

const _$TripRouteUnavailableReasonEnumMap = {
  TripRouteUnavailableReason.missingCoordinates: 'MISSING_COORDINATES',
  TripRouteUnavailableReason.providerUnavailable: 'PROVIDER_UNAVAILABLE',
  TripRouteUnavailableReason.stopLimitExceeded: 'STOP_LIMIT_EXCEEDED',
  TripRouteUnavailableReason.unknown: 'UNKNOWN',
};

_TripDayRoute _$TripDayRouteFromJson(Map<String, dynamic> json) =>
    _TripDayRoute(
      dayId: json['dayId'] as String,
      available: json['available'] as bool,
      totalDistanceMeters: (json['totalDistanceMeters'] as num).toInt(),
      totalDurationSeconds: (json['totalDurationSeconds'] as num).toInt(),
      legs: (json['legs'] as List<dynamic>)
          .map((e) => TripRouteLeg.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripDayRouteToJson(_TripDayRoute instance) =>
    <String, dynamic>{
      'dayId': instance.dayId,
      'available': instance.available,
      'totalDistanceMeters': instance.totalDistanceMeters,
      'totalDurationSeconds': instance.totalDurationSeconds,
      'legs': instance.legs,
    };

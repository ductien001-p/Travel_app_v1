// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_itinerary_checkin_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripItineraryViewerCheckin _$TripItineraryViewerCheckinFromJson(
  Map<String, dynamic> json,
) => _TripItineraryViewerCheckin(
  activityId: json['activityId'] as String?,
  placeId: json['placeId'] as String,
  visitedAt: DateTime.parse(json['visitedAt'] as String),
);

Map<String, dynamic> _$TripItineraryViewerCheckinToJson(
  _TripItineraryViewerCheckin instance,
) => <String, dynamic>{
  'activityId': instance.activityId,
  'placeId': instance.placeId,
  'visitedAt': instance.visitedAt.toIso8601String(),
};

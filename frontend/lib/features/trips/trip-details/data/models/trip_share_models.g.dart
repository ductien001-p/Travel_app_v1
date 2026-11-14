// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_share_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripShareLink _$TripShareLinkFromJson(Map<String, dynamic> json) =>
    _TripShareLink(
      url: json['url'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$TripShareLinkToJson(_TripShareLink instance) =>
    <String, dynamic>{
      'url': instance.url,
      'expiresAt': instance.expiresAt.toIso8601String(),
    };

_SharedTripSummary _$SharedTripSummaryFromJson(Map<String, dynamic> json) =>
    _SharedTripSummary(
      id: json['id'] as String,
      name: json['name'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      status: $enumDecode(_$TripDetailStatusEnumMap, json['status']),
      coverImageUrl: json['coverImageUrl'] as String?,
    );

Map<String, dynamic> _$SharedTripSummaryToJson(_SharedTripSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'status': _$TripDetailStatusEnumMap[instance.status]!,
      'coverImageUrl': instance.coverImageUrl,
    };

const _$TripDetailStatusEnumMap = {
  TripDetailStatus.draft: 'DRAFT',
  TripDetailStatus.upcoming: 'UPCOMING',
  TripDetailStatus.ongoing: 'ONGOING',
  TripDetailStatus.completed: 'COMPLETED',
  TripDetailStatus.cancelled: 'CANCELLED',
  TripDetailStatus.notCompleted: 'NOTCOMPLETED',
};

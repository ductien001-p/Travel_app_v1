// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travel_dna_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TravelDnaRadar _$TravelDnaRadarFromJson(Map<String, dynamic> json) =>
    _TravelDnaRadar(
      dna: TravelDnaSnapshot.fromJson(json['dna'] as Map<String, dynamic>),
      community: (json['community'] as List<dynamic>)
          .map(
            (e) => TravelDnaCommunityScore.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      dominantPercentile: (json['dominantPercentile'] as num?)?.toInt(),
      fitPlaces: (json['fitPlaces'] as List<dynamic>)
          .map((e) => TravelDnaFitPlaces.fromJson(e as Map<String, dynamic>))
          .toList(),
      journey: json['journey'] == null
          ? null
          : TravelDnaJourney.fromJson(json['journey'] as Map<String, dynamic>),
      companions: (json['companions'] as List<dynamic>)
          .map((e) => TravelDnaCompanion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TravelDnaRadarToJson(_TravelDnaRadar instance) =>
    <String, dynamic>{
      'dna': instance.dna,
      'community': instance.community,
      'dominantPercentile': instance.dominantPercentile,
      'fitPlaces': instance.fitPlaces,
      'journey': instance.journey,
      'companions': instance.companions,
    };

_TravelDnaSnapshot _$TravelDnaSnapshotFromJson(Map<String, dynamic> json) =>
    _TravelDnaSnapshot(
      dominant: json['dominant'] == null
          ? null
          : TravelDnaBadge.fromJson(json['dominant'] as Map<String, dynamic>),
      topBadges: (json['topBadges'] as List<dynamic>)
          .map((e) => TravelDnaBadge.fromJson(e as Map<String, dynamic>))
          .toList(),
      all: (json['all'] as List<dynamic>)
          .map((e) => TravelDnaBadge.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TravelDnaSnapshotToJson(_TravelDnaSnapshot instance) =>
    <String, dynamic>{
      'dominant': instance.dominant,
      'topBadges': instance.topBadges,
      'all': instance.all,
    };

_TravelDnaBadge _$TravelDnaBadgeFromJson(Map<String, dynamic> json) =>
    _TravelDnaBadge(
      type: json['type'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      description: json['description'] as String,
      score: travelDnaJsonInt(json['score']),
      tripTypeCount: travelDnaJsonInt(json['tripTypeCount']),
      activityCount: travelDnaJsonInt(json['activityCount']),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      shortLabel: json['shortLabel'] as String,
      badgeTitle: json['badgeTitle'] as String,
    );

Map<String, dynamic> _$TravelDnaBadgeToJson(_TravelDnaBadge instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'icon': instance.icon,
      'description': instance.description,
      'score': instance.score,
      'tripTypeCount': instance.tripTypeCount,
      'activityCount': instance.activityCount,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'shortLabel': instance.shortLabel,
      'badgeTitle': instance.badgeTitle,
    };

_TravelDnaCommunityScore _$TravelDnaCommunityScoreFromJson(
  Map<String, dynamic> json,
) => _TravelDnaCommunityScore(
  type: json['type'] as String,
  averageScore: travelDnaJsonInt(json['averageScore']),
  sampleCount: travelDnaJsonInt(json['sampleCount']),
);

Map<String, dynamic> _$TravelDnaCommunityScoreToJson(
  _TravelDnaCommunityScore instance,
) => <String, dynamic>{
  'type': instance.type,
  'averageScore': instance.averageScore,
  'sampleCount': instance.sampleCount,
};

_TravelDnaFitPlaces _$TravelDnaFitPlacesFromJson(Map<String, dynamic> json) =>
    _TravelDnaFitPlaces(
      type: json['type'] as String,
      places: (json['places'] as List<dynamic>)
          .map((e) => TravelDnaPlace.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TravelDnaFitPlacesToJson(_TravelDnaFitPlaces instance) =>
    <String, dynamic>{'type': instance.type, 'places': instance.places};

_TravelDnaPlace _$TravelDnaPlaceFromJson(Map<String, dynamic> json) =>
    _TravelDnaPlace(
      id: json['id'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
    );

Map<String, dynamic> _$TravelDnaPlaceToJson(_TravelDnaPlace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
    };

_TravelDnaJourney _$TravelDnaJourneyFromJson(Map<String, dynamic> json) =>
    _TravelDnaJourney(
      tripId: json['tripId'] as String,
      name: json['name'] as String,
      matchPercent: travelDnaJsonInt(json['matchPercent']),
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      coverImageUrl: json['coverImageUrl'] as String?,
      activityCount: travelDnaJsonInt(json['activityCount']),
    );

Map<String, dynamic> _$TravelDnaJourneyToJson(_TravelDnaJourney instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'name': instance.name,
      'matchPercent': instance.matchPercent,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'coverImageUrl': instance.coverImageUrl,
      'activityCount': instance.activityCount,
    };

_TravelDnaCompanion _$TravelDnaCompanionFromJson(Map<String, dynamic> json) =>
    _TravelDnaCompanion(
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      matchPercent: travelDnaJsonInt(json['matchPercent']),
      persona: TravelDnaPersona.fromJson(
        json['persona'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$TravelDnaCompanionToJson(_TravelDnaCompanion instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'displayName': instance.displayName,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
      'matchPercent': instance.matchPercent,
      'persona': instance.persona,
    };

_TravelDnaPersona _$TravelDnaPersonaFromJson(Map<String, dynamic> json) =>
    _TravelDnaPersona(
      name: json['name'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$TravelDnaPersonaToJson(_TravelDnaPersona instance) =>
    <String, dynamic>{'name': instance.name, 'icon': instance.icon};

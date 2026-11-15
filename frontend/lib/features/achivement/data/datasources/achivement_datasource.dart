import 'package:travel_frontend_v1/core/networks/api_client.dart';
import 'package:travel_frontend_v1/core/networks/api_response_parser.dart';

import '../models/achivement_models.dart';

abstract class AchivementDataSource {
  Future<TripMissionsPage> getTripMissions(String tripId);

  Future<AchivementProgressPage> getProgress({String period = 'ALL_TIME'});

  Future<AchivementCompletionResult> claimCompletion(
    String tripId, {
    String? tripName,
  });
}

class AchivementRemoteDataSource implements AchivementDataSource {
  const AchivementRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<TripMissionsPage> getTripMissions(String tripId) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/missions',
    );
    return TripMissionsPage.fromJson(ApiResponseParser.dataMap(body));
  }

  @override
  Future<AchivementProgressPage> getProgress({
    String period = 'ALL_TIME',
  }) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/ranking/me',
      queryParameters: <String, dynamic>{'period': period},
    );
    final data = ApiResponseParser.dataMap(body);
    final tierRaw = data['travelTier'];
    final achievementsRaw = data['achievements'];

    return AchivementProgressPage(
      travelTier: tierRaw is Map
          ? TravelTier.fromJson(Map<String, dynamic>.from(tierRaw))
          : null,
      achievements: achievementsRaw is List
          ? achievementsRaw
                .whereType<Map>()
                .map(
                  (row) => AchievementProgress.fromJson(
                    Map<String, dynamic>.from(row),
                  ),
                )
                .toList(growable: false)
          : const <AchievementProgress>[],
    );
  }

  @override
  Future<AchivementCompletionResult> claimCompletion(
    String tripId, {
    String? tripName,
  }) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/completion',
    );
    final data = ApiResponseParser.dataMap(body);
    return AchivementCompletionResult(
      tripId: data['tripId']?.toString() ?? tripId,
      tripName: tripName ?? '',
      pointsAwarded: _asInt(data['pointsAwarded']) ?? 0,
      basePoints: _asInt(data['basePoints']) ?? 0,
      missionPoints: _asInt(data['missionPoints']) ?? 0,
      multiplierUsed: _asDouble(data['multiplierUsed']) ?? 1,
      missionsCompleted: _asInt(data['missionsCompleted']) ?? 0,
      totalCheckins: _asInt(data['totalCheckins']) ?? 0,
      totalPlaces: _asInt(data['totalPlaces']) ?? 0,
      completionPercent: _asInt(data['completionPercent']) ?? 0,
    );
  }

  int? _asInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  double? _asDouble(Object? value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}

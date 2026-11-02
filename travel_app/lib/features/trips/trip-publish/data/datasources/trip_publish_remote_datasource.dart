import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/trip_publish_models.dart';
import 'trip_publish_datasource.dart';

class TripPublishRemoteDataSource implements TripPublishDataSource {
  const TripPublishRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<RecruitmentSummary> summary() async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/mine/summary',
    );
    return RecruitmentSummary.fromJson(_data(body));
  }

  @override
  Future<RecruitmentMine> mine() async {
    final body = await _apiClient.get<Map<String, dynamic>>('/trips/mine');
    return RecruitmentMine.fromJson(_data(body));
  }

  @override
  Future<RecruitmentPublishResult> patch(
    String tripId,
    Map<String, dynamic> body,
  ) async {
    final response = await _apiClient.patch<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/recruitment',
      data: body,
    );
    return RecruitmentPublishResult.fromJson(_data(response));
  }

  @override
  Future<RecruitmentPublishResult> publish(
    String tripId,
    String idempotencyKey,
  ) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/recruitment/publish',
      headers: {'Idempotency-Key': idempotencyKey},
    );
    return RecruitmentPublishResult.fromJson(_data(response));
  }

  @override
  Future<RecruitmentPublishResult> close(String tripId) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/recruitment/close',
    );
    return RecruitmentPublishResult.fromJson(_data(response));
  }

  @override
  Future<RecruitmentPublishResult> reopen(String tripId) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/recruitment/reopen',
    );
    return RecruitmentPublishResult.fromJson(_data(response));
  }

  Map<String, dynamic> _data(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is Map) return Map<String, dynamic>.from(data);
    throw const FormatException('Response does not contain a data object.');
  }
}

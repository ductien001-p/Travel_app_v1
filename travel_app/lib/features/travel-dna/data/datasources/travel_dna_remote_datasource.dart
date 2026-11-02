import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/travel_dna_models.dart';

class TravelDnaRemoteDataSource {
  const TravelDnaRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<TravelDnaRadar> getRadar() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/travel-dna/radar',
    );
    return TravelDnaRadar.fromJson(_dataFromEnvelope(response));
  }

  Map<String, dynamic> _dataFromEnvelope(Map<String, dynamic> response) {
    final data = response['data'];
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    throw const FormatException(
      'Travel DNA response does not contain a valid data object.',
    );
  }
}

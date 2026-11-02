import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/trip_expenses_models.dart';
import 'trip_expenses_datasource.dart';

class TripExpensesRemoteDataSource implements TripExpensesDataSource {
  const TripExpensesRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// `GET /trips/{tripId}/expenses` — `TripExpenseController_getExpenses`.
  @override
  Future<TripExpensesOverview> getExpenses(String tripId) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/expenses',
    );
    return TripExpensesOverview.fromJson(_envelopeData(body));
  }

  /// `POST /trips/{tripId}/expenses` — `TripExpenseController_createExpense`.
  @override
  Future<TripExpenseCreated> createExpense(
    String tripId,
    CreateTripExpenseRequest request,
  ) async {
    final payload = Map<String, dynamic>.from(request.toJson())
      ..removeWhere((_, value) => value == null);
    if (payload['spentAt'] is String == false && request.spentAt != null) {
      payload['spentAt'] = request.spentAt!.toUtc().toIso8601String();
    }
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/expenses',
      data: payload,
    );
    return TripExpenseCreated.fromJson(_envelopeData(body));
  }

  /// `POST /trips/{tripId}/expenses/{expenseId}/splits/{splitId}/settle`.
  @override
  Future<TripExpenseCreatedSplit> settleSplit({
    required String tripId,
    required String expenseId,
    required String splitId,
  }) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/expenses/'
      '${Uri.encodeComponent(expenseId)}/splits/'
      '${Uri.encodeComponent(splitId)}/settle',
    );
    return TripExpenseCreatedSplit.fromJson(_envelopeData(body));
  }

  Map<String, dynamic> _envelopeData(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is Map) return Map<String, dynamic>.from(data);
    throw const FormatException('Response does not contain a data object.');
  }
}

import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/trip_chat_models.dart';

abstract class TripChatDataSource {
  Future<TripChatThread> getThread(String tripId);

  Future<void> markRead(String tripId);

  Future<TripChatMessage> sendText({
    required String tripId,
    required String text,
  });

  Future<List<TripChatReaction>> addReaction({
    required String tripId,
    required String messageId,
    required String emoji,
  });

  Future<List<TripChatReaction>> removeReaction({
    required String tripId,
    required String messageId,
    required String emoji,
  });
}

class TripChatRemoteDataSource implements TripChatDataSource {
  const TripChatRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<TripChatThread> getThread(String tripId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/chat/thread',
    );
    return TripChatThread.fromJson(_dataFromEnvelope(response));
  }

  @override
  Future<void> markRead(String tripId) async {
    await _apiClient.post<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/messages/read',
    );
  }

  @override
  Future<TripChatMessage> sendText({
    required String tripId,
    required String text,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/messages',
      data: <String, dynamic>{'content': text, 'messageType': 'TEXT'},
    );
    return TripChatMessage.fromJson(_dataFromEnvelope(response));
  }

  @override
  Future<List<TripChatReaction>> addReaction({
    required String tripId,
    required String messageId,
    required String emoji,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/messages/${Uri.encodeComponent(messageId)}/reactions',
      data: <String, dynamic>{'emoji': emoji},
    );
    return _reactionsFromEnvelope(response);
  }

  @override
  Future<List<TripChatReaction>> removeReaction({
    required String tripId,
    required String messageId,
    required String emoji,
  }) async {
    final response = await _apiClient.delete<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/messages/${Uri.encodeComponent(messageId)}/reactions',
      data: <String, dynamic>{'emoji': emoji},
    );
    return _reactionsFromEnvelope(response);
  }

  Map<String, dynamic> _dataFromEnvelope(Map<String, dynamic> response) {
    final data = response['data'];
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    throw const FormatException(
      'Trip chat response does not contain a valid data object.',
    );
  }

  List<TripChatReaction> _reactionsFromEnvelope(
    Map<String, dynamic> response,
  ) {
    final data = _dataFromEnvelope(response);
    final raw = data['reactions'];
    if (raw is! List) return const <TripChatReaction>[];
    return [
      for (final item in raw)
        if (item is Map<String, dynamic>)
          TripChatReaction.fromJson(item)
        else if (item is Map)
          TripChatReaction.fromJson(Map<String, dynamic>.from(item)),
    ];
  }
}

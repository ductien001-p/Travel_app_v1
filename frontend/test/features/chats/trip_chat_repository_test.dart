import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/chats/trip-chats/data/datamock/trip_chat_datamock.dart';
import 'package:travel_frontend_v1/features/chats/trip-chats/data/datasources/trip_chat_datasource.dart';
import 'package:travel_frontend_v1/features/chats/trip-chats/data/models/trip_chat_models.dart';
import 'package:travel_frontend_v1/features/chats/trip-chats/data/repositories/trip_chat_repository.dart';

void main() {
  test('returns the remote thread without falling back to datamock', () async {
    final repository = TripChatRepository(dataSource: _OkSource());

    final thread = await repository.getThread('trip-real-123');

    expect(thread.tripId, 'trip-real-123');
    expect(thread.title, contains('Mùa hè rực rỡ'));
  });

  test('propagates API failures so the screen can show an error', () async {
    final repository = TripChatRepository(dataSource: _FailingSource());

    expect(
      () => repository.getThread('trip-real-123'),
      throwsA(
        isA<ApiException>().having((e) => e.statusCode, 'statusCode', 404),
      ),
    );
  });

  test('rethrows unauthorized so screen can show login expired', () async {
    final repository = TripChatRepository(dataSource: _UnauthorizedSource());

    expect(
      () => repository.getThread('trip-real-123'),
      throwsA(
        isA<ApiException>().having((e) => e.statusCode, 'statusCode', 401),
      ),
    );
  });
}

class _OkSource implements TripChatDataSource {
  @override
  Future<TripChatThread> getThread(String tripId) async {
    final payload = Map<String, dynamic>.from(tripChatDatamock);
    payload['tripId'] = tripId;
    return TripChatThread.fromJson(payload);
  }

  @override
  Future<void> markRead(String tripId) async {}

  @override
  Future<TripChatMessage> sendText({
    required String tripId,
    required String text,
  }) async {
    return TripChatMessage(
      id: 'sent-1',
      kind: TripChatMessageKind.text,
      isMine: true,
      text: text,
      timeLabel: '15:00',
      readStatus: TripChatReadStatus.sent,
    );
  }

  @override
  Future<List<TripChatReaction>> addReaction({
    required String tripId,
    required String messageId,
    required String emoji,
  }) async => const <TripChatReaction>[];

  @override
  Future<List<TripChatReaction>> removeReaction({
    required String tripId,
    required String messageId,
    required String emoji,
  }) async => const <TripChatReaction>[];
}

class _FailingSource implements TripChatDataSource {
  @override
  Future<TripChatThread> getThread(String tripId) async {
    throw const ApiException(message: 'Not Found', statusCode: 404);
  }

  @override
  Future<void> markRead(String tripId) async {}

  @override
  Future<TripChatMessage> sendText({
    required String tripId,
    required String text,
  }) async {
    throw const ApiException(message: 'Not Found', statusCode: 404);
  }

  @override
  Future<List<TripChatReaction>> addReaction({
    required String tripId,
    required String messageId,
    required String emoji,
  }) async {
    throw const ApiException(message: 'Not Found', statusCode: 404);
  }

  @override
  Future<List<TripChatReaction>> removeReaction({
    required String tripId,
    required String messageId,
    required String emoji,
  }) async {
    throw const ApiException(message: 'Not Found', statusCode: 404);
  }
}

class _UnauthorizedSource implements TripChatDataSource {
  @override
  Future<TripChatThread> getThread(String tripId) async {
    throw const ApiException(message: 'Unauthorized', statusCode: 401);
  }

  @override
  Future<void> markRead(String tripId) async {}

  @override
  Future<TripChatMessage> sendText({
    required String tripId,
    required String text,
  }) async {
    throw const ApiException(message: 'Unauthorized', statusCode: 401);
  }

  @override
  Future<List<TripChatReaction>> addReaction({
    required String tripId,
    required String messageId,
    required String emoji,
  }) async {
    throw const ApiException(message: 'Unauthorized', statusCode: 401);
  }

  @override
  Future<List<TripChatReaction>> removeReaction({
    required String tripId,
    required String messageId,
    required String emoji,
  }) async {
    throw const ApiException(message: 'Unauthorized', statusCode: 401);
  }
}

import '../datasources/trip_chat_datasource.dart';
import '../models/trip_chat_models.dart';

class TripChatRepository {
  const TripChatRepository({required TripChatDataSource dataSource})
    : _dataSource = dataSource;

  final TripChatDataSource _dataSource;

  Future<TripChatThread> getThread(String tripId) =>
      _dataSource.getThread(tripId);

  Future<void> markRead(String tripId) => _dataSource.markRead(tripId);

  Future<TripChatMessage> sendText({
    required String tripId,
    required String text,
  }) => _dataSource.sendText(tripId: tripId, text: text);

  Future<TripChatMessage> sendImage({
    required String tripId,
    required String mediaId,
  }) => _dataSource.sendImage(tripId: tripId, mediaId: mediaId);

  Future<List<TripChatReaction>> addReaction({
    required String tripId,
    required String messageId,
    required String emoji,
  }) => _dataSource.addReaction(
    tripId: tripId,
    messageId: messageId,
    emoji: emoji,
  );

  Future<List<TripChatReaction>> removeReaction({
    required String tripId,
    required String messageId,
    required String emoji,
  }) => _dataSource.removeReaction(
    tripId: tripId,
    messageId: messageId,
    emoji: emoji,
  );
}

import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/chats/trip-chats/data/datamock/trip_chat_datamock.dart';
import 'package:travel_frontend_v1/features/chats/trip-chats/data/models/trip_chat_models.dart';

void main() {
  test('parses Stitch trip-group-chat datamock into freezed models', () {
    final thread = TripChatThread.fromJson(tripChatDatamock);

    expect(thread.tripId, 'trip-mien-trung-2025');
    expect(thread.title, contains('Mùa hè rực rỡ'));
    expect(thread.memberSummaryLabel, contains('đang online'));
    expect(thread.pinnedActivity?.checkInLabel, 'Check-in');
    expect(thread.messages, isNotEmpty);
    expect(
      thread.messages.where((m) => m.kind == TripChatMessageKind.system),
      isNotEmpty,
    );
    expect(
      thread.messages.where((m) => m.kind == TripChatMessageKind.photo),
      isNotEmpty,
    );
    expect(
      thread.messages.where((m) => m.kind == TripChatMessageKind.expense),
      isNotEmpty,
    );
    expect(thread.utilities.first.kind, TripChatUtilityKind.liveLocation);
    expect(thread.isSomeoneTyping, isTrue);
  });
}

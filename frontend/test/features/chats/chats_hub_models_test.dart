import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/chats/application/chats_hub_view.dart';
import 'package:travel_frontend_v1/features/chats/data/datamock/chats_hub_datamock.dart';
import 'package:travel_frontend_v1/features/chats/data/models/chats_hub_models.dart';

void main() {
  test('ChatsHub parses Stitch datamock', () {
    final hub = ChatsHub.fromJson(chatsHubDatamock);

    expect(hub.viewer.displayName, 'Lan Phương');
    expect(hub.totalThreadCount, 8);
    expect(hub.hasUnread, isTrue);
    expect(hub.activeTripPulse?.title, contains('miền Trung'));
    expect(hub.tripThreads, hasLength(4));
    expect(hub.friendThreads, hasLength(3));
    expect(hub.tripThreads.first.unreadCount, 3);
    expect(hub.tripThreads.first.status, ChatsTripThreadStatus.upcoming);
    expect(hub.friendThreads.first.roleBadge, 'Trưởng nhóm');
  });

  test('ChatsHubViewState filters trips by default and by unread/search', () {
    final hub = ChatsHub.fromJson(chatsHubDatamock);
    final tripsOnly = ChatsHubViewState(hub: hub);

    expect(tripsOnly.visibleTripThreads, hasLength(4));
    expect(tripsOnly.visibleFriendThreads, isEmpty);
    expect(tripsOnly.showActivePulse, isTrue);

    final unread = tripsOnly.copyWith(filter: ChatsHubFilter.unread);
    expect(unread.visibleTripThreads, hasLength(1));
    expect(unread.visibleTripThreads.single.title, contains('Tà Xùa'));

    final search = tripsOnly.copyWith(searchQuery: 'Fansipan');
    expect(search.visibleTripThreads, hasLength(1));
    expect(search.visibleTripThreads.single.lastSenderName, 'Quốc Bảo');

    final friends = tripsOnly.copyWith(filter: ChatsHubFilter.friends);
    expect(friends.visibleTripThreads, isEmpty);
    expect(friends.visibleFriendThreads, hasLength(3));
    expect(friends.showActivePulse, isFalse);
  });
}

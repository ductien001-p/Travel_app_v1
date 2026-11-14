import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/friends/application/friends_hub_controller.dart';
import 'package:travel_frontend_v1/features/friends/data/datamock/friends_hub_datamock.dart';
import 'package:travel_frontend_v1/features/friends/data/datasources/friends_hub_datasource.dart';
import 'package:travel_frontend_v1/features/friends/data/models/friends_hub_models.dart';
import 'package:travel_frontend_v1/features/friends/provider/friends_hub_provider.dart';

class _FakeHubDataSource implements FriendsHubDataSource {
  _FakeHubDataSource(this._page);

  FriendsHubPage _page;
  int getHubCalls = 0;

  @override
  Future<FriendsHubPage> getHub() async {
    getHubCalls += 1;
    return _page;
  }

  @override
  Future<void> acceptRequest(String requestId) async {
    final accepted = _page.received.firstWhere((r) => r.id == requestId);
    _page = _page.copyWith(
      received: _page.received
          .where((r) => r.id != requestId)
          .toList(growable: false),
      friends: [
        ..._page.friends,
        FriendsHubFriend(
          friendshipId: 'fs-${accepted.user.id}',
          friendId: accepted.user.id,
          user: accepted.user,
          createdAt: DateTime.now().toUtc(),
        ),
      ],
      friendsCount: _page.friendsCount + 1,
      friendsCountLabel: '${_page.friendsCount + 1} bạn bè đồng hành',
    );
  }

  @override
  Future<void> rejectRequest(String requestId) async {
    _page = _page.copyWith(
      received: _page.received
          .where((r) => r.id != requestId)
          .toList(growable: false),
    );
  }

  @override
  Future<void> cancelRequest(String requestId) async {
    _page = _page.copyWith(
      sent: _page.sent.where((r) => r.id != requestId).toList(growable: false),
    );
  }

  @override
  Future<void> removeFriend(String friendId) async {
    final next = _page.friends
        .where((f) => f.friendId != friendId)
        .toList(growable: false);
    _page = _page.copyWith(
      friends: next,
      friendsCount: next.length,
      friendsCountLabel: '${next.length} bạn bè đồng hành',
    );
  }

  @override
  Future<String> getOrCreateConversation(String friendId) async =>
      'conv-$friendId';
}

void main() {
  late _FakeHubDataSource fake;
  late ProviderContainer container;

  setUp(() {
    fake = _FakeHubDataSource(FriendsHubPage.fromJson(friendsHubDatamock));
    container = ProviderContainer(
      overrides: [friendsHubDataSourceProvider.overrideWithValue(fake)],
    );
  });

  tearDown(() => container.dispose());

  test(
    'loads hub and soft refresh keeps data without clearing first',
    () async {
      final notifier = container.read(friendsHubControllerProvider.notifier);
      await container.read(friendsHubControllerProvider.future);

      final before = container.read(friendsHubControllerProvider).requireValue;
      expect(before.friendsCount, 128);
      expect(fake.getHubCalls, 1);

      final ok = await notifier.refresh();
      expect(ok, isTrue);
      expect(fake.getHubCalls, 2);
      expect(container.read(friendsHubControllerProvider).hasValue, isTrue);
    },
  );

  test('cancelRequest refreshes counts from repository', () async {
    final notifier = container.read(friendsHubControllerProvider.notifier);
    await container.read(friendsHubControllerProvider.future);

    expect(
      container.read(friendsHubControllerProvider).requireValue.sentCount,
      5,
    );

    final ok = await notifier.cancelRequest('sent-1');
    expect(ok, isTrue);
    expect(
      container.read(friendsHubControllerProvider).requireValue.sentCount,
      4,
    );
  });

  test('acceptRequest moves request into friends list', () async {
    final notifier = container.read(friendsHubControllerProvider.notifier);
    await container.read(friendsHubControllerProvider.future);

    final before = container.read(friendsHubControllerProvider).requireValue;
    expect(before.receivedCount, 3);

    final ok = await notifier.acceptRequest('req-lan');
    expect(ok, isTrue);

    final after = container.read(friendsHubControllerProvider).requireValue;
    expect(after.receivedCount, 2);
    expect(after.friendsCount, 129);
  });

  test('online sort puts online friends first', () async {
    final notifier = container.read(friendsHubControllerProvider.notifier);
    await container.read(friendsHubControllerProvider.future);
    notifier.setSort(FriendsHubSort.online);

    final view = container.read(friendsHubControllerProvider).requireValue;
    final friends = view.filteredFriends;
    expect(friends.first.user.isOnline, isTrue);
  });
}

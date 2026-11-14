import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/friends/application/friends_hub_view.dart';
import 'package:travel_frontend_v1/features/friends/data/datamock/friends_hub_datamock.dart';
import 'package:travel_frontend_v1/features/friends/data/models/friends_hub_models.dart';

void main() {
  test('parses Stitch friends-hub datamock', () {
    final page = FriendsHubPage.fromJson(friendsHubDatamock);

    expect(page.friendsCount, 128);
    expect(page.friendsCountLabel, contains('128'));
    expect(page.received, hasLength(3));
    expect(page.sent, hasLength(5));
    expect(page.friends, hasLength(4));

    expect(page.received.first.user.displayName, 'Lan Phương');
    expect(page.received.first.user.isOnline, isTrue);
    expect(page.received.first.user.metaLine, contains('Trekking'));
    expect(page.friends.first.user.verified, isTrue);
    expect(page.friends.first.user.badgeLabel, contains('Travel Buddy'));
    expect(page.friends.first.user.avatarUrl, isNotEmpty);
    expect(page.friends.first.conversationId, 'conv-alex-nguyen');
  });

  test('view filters and sorts friends', () {
    final page = FriendsHubPage.fromJson(friendsHubDatamock);
    final view = FriendsHubViewState(
      page: page,
      query: 'linh',
      sort: FriendsHubSort.az,
    );

    expect(view.filteredFriends, hasLength(1));
    expect(view.filteredFriends.single.user.username, 'linh_le');
    expect(view.receivedPreview, hasLength(2));
  });

  test('relative time labels', () {
    final now = DateTime(2026, 11, 13, 12);
    expect(
      friendsHubRelativeTime(DateTime(2026, 11, 13, 10), now: now),
      '2 giờ trước',
    );
    expect(
      friendsHubRelativeTime(DateTime(2026, 11, 12, 12), now: now),
      'Hôm qua',
    );
  });
}

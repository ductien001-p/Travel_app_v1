import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/friends/application/find_friends_view.dart';
import 'package:travel_frontend_v1/features/friends/data/datamock/find_friends_datamock.dart';
import 'package:travel_frontend_v1/features/friends/data/models/find_friends_models.dart';

void main() {
  test('parses Stitch find-friends datamock with nearbySuggestions', () {
    final page = FindFriendsPage.fromJson(findFriendsDatamock);

    expect(page.query, 'Nam');
    expect(page.matchCount, 4);
    expect(page.dnaBanner.title, contains('95%'));
    expect(page.results, hasLength(4));
    expect(page.nearbySuggestions, hasLength(1));
    expect(page.nearbySuggestions.single.subtitle, contains('Đang ở gần bạn'));

    final nam = page.results.first;
    expect(nam.displayName, 'Hoàng Nam');
    expect(nam.action, FindFriendsAction.addFriend);

    final linh = page.results[1];
    expect(linh.verified, isTrue);
    expect(linh.action, FindFriendsAction.requestSent);
    expect(linh.friendRequestId, 'req-linh');

    final alex = page.results[2];
    expect(alex.action, FindFriendsAction.message);
    expect(alex.conversationId, 'conv-alex-nguyen');

    final triet = page.results[3];
    expect(triet.action, FindFriendsAction.follow);
  });

  test('filters datamock by query', () {
    final filtered = FindFriendsPage.fromJson(
      findFriendsDatamockForQuery('linh'),
    );
    expect(filtered.results, hasLength(1));
    expect(filtered.results.single.username, 'linh_le');
    expect(filtered.matchCountLabel, '1 tìm kiếm khớp');
  });

  test('action labels match cancel and following states', () {
    expect(findFriendsActionLabel(FindFriendsAction.addFriend), 'Kết bạn');
    expect(
      findFriendsActionLabel(FindFriendsAction.requestSent),
      'Hủy yêu cầu',
    );
    expect(findFriendsActionLabel(FindFriendsAction.message), 'Nhắn tin');
    expect(findFriendsActionLabel(FindFriendsAction.follow), 'Theo dõi');
    expect(
      findFriendsActionLabel(FindFriendsAction.following),
      'Đang theo dõi',
    );
  });
}

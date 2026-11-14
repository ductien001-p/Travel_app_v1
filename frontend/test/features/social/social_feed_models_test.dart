import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/social/application/social_feed_view.dart';
import 'package:travel_frontend_v1/features/social/data/datamock/social_feed_datamock.dart';
import 'package:travel_frontend_v1/features/social/data/models/social_feed_models.dart';

void main() {
  test('SocialFeed parses Stitch datamock', () {
    final feed = SocialFeed.fromJson(socialFeedDatamock);

    expect(feed.header.title, 'Bảng Tin');
    expect(feed.header.streakLabel, contains('7 ngày'));
    expect(feed.composer.displayName, 'Alex');
    expect(feed.stories, hasLength(6));
    expect(feed.stories.first.isSelf, isTrue);
    expect(feed.stories[1].badge, SocialFeedStoryBadge.live);
    expect(feed.tabs.where((t) => t.selected), hasLength(1));
    expect(feed.topicChips, hasLength(4));
    expect(feed.items, hasLength(3));
    expect(feed.items[0].type, SocialFeedItemType.review);
    expect(feed.items[0].review?.author.displayName, 'Lan Phương');
    expect(feed.items[0].review?.liked, isTrue);
    expect(feed.items[1].type, SocialFeedItemType.challenge);
    expect(feed.items[1].challenge?.title, contains('Sơn Trà'));
    expect(feed.items[2].type, SocialFeedItemType.tripRecruit);
    expect(feed.items[2].tripRecruit?.tripId, 'trip-mien-trung-2025');
  });

  test('SocialFeedViewState tracks tab and topic selection', () {
    final feed = SocialFeed.fromJson(socialFeedDatamock);
    final view = SocialFeedViewState(feed: feed);

    expect(view.selectedTabId, 'explore');
    expect(view.tabs.first.selected, isTrue);

    final following = view.copyWith(selectedTabId: 'following');
    expect(
      following.tabs.firstWhere((t) => t.id == 'following').selected,
      isTrue,
    );
    expect(
      following.tabs.firstWhere((t) => t.id == 'explore').selected,
      isFalse,
    );

    final withTopic = following.copyWith(selectedTopicId: 'PHOTO_SPOTS');
    expect(
      withTopic.topicChips.firstWhere((c) => c.id == 'PHOTO_SPOTS').selected,
      isTrue,
    );

    final cleared = withTopic.copyWith(clearTopic: true);
    expect(cleared.selectedTopicId, isNull);
  });
}

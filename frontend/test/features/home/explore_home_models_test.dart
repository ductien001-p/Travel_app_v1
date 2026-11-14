import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/home/data/datamock/explore_home_datamock.dart';
import 'package:travel_frontend_v1/features/home/data/models/explore_home_models.dart';

void main() {
  test('ExploreHomeFeed parses datamock', () {
    final feed = ExploreHomeFeed.fromJson(exploreHomeDatamock);
    expect(feed.header.displayName, 'Alex');
    expect(feed.filters.first.id, 'all');
    expect(feed.hotTrips, hasLength(2));
    expect(feed.destinations, hasLength(4));
    expect(feed.liveTrips.single.placeLabel, 'Đèo Hải Vân');
    expect(feed.hotTrips.first.memberCount, 3);
    expect(feed.hotTrips.first.capacity, 6);
  });
}

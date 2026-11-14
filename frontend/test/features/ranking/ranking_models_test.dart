import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/ranking/application/ranking_view.dart';
import 'package:travel_frontend_v1/features/ranking/data/datamock/ranking_datamock.dart';
import 'package:travel_frontend_v1/features/ranking/data/datasources/ranking_datasource.dart';
import 'package:travel_frontend_v1/features/ranking/data/models/ranking_models.dart';

void main() {
  test('parses Stitch ranking datamock fixture', () {
    final page = RankingPage.fromJson(rankingDatamock);

    expect(page.seasonLabel, contains('Mùa Hè 2025'));
    expect(page.selectedPeriod, RankingPeriod.season);
    expect(page.periods, hasLength(4));
    expect(page.podium, hasLength(3));
    expect(page.entries, hasLength(4));
    expect(page.quests, hasLength(3));
    expect(page.questsTotal, 6);

    expect(page.podium[1].displayName, 'Hoàng Nam');
    expect(page.podium[1].rank, 1);
    expect(page.podium[1].points, 3850);
    expect(page.me?.rank, 14);
    expect(page.me?.tierLabel, 'Gold Tier');
    expect(page.me?.nextTierPoints, 1500);
    expect(page.quests.first.action, RankingQuestAction.start);
    expect(page.quests.first.code, 'COMPLETE_TRIP');
    expect(page.quests.last.claimable, isTrue);
    expect(page.me?.nextTierLabel, contains('Top 10'));
  });

  test('view orders podium as second-first-third', () {
    final page = RankingPage.fromJson(rankingDatamock);
    final view = RankingViewState(page: page);

    expect(view.podiumOrdered.map((e) => e.rank), [2, 1, 3]);
    expect(view.meProgress, closeTo(1450 / 1500, 0.001));
  });

  test('formats points with Vietnamese thousand separators', () {
    expect(rankingPointsLabel(3850), '3.850');
    expect(rankingPointsLabel(1450, withUnit: true), '1.450 pts');
    expect(rankingRankDeltaLabel(3), '+3 bậc');
    expect(rankingRankDeltaLabel(0), 'Ổn định');
  });

  test('maps RANK enum to tier labels', () {
    expect(rankingTierLabel('ADVENTURER'), 'Adventurer');
    expect(rankingTierLabel('LEGEND'), 'Legend');
    expect(rankingTierLabel(null), 'Explorer');
  });
}

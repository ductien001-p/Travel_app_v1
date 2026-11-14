import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/ranking/application/ranking_controller.dart';
import 'package:travel_frontend_v1/features/ranking/data/datamock/ranking_datamock.dart';
import 'package:travel_frontend_v1/features/ranking/data/datasources/ranking_datasource.dart';
import 'package:travel_frontend_v1/features/ranking/data/models/ranking_models.dart';
import 'package:travel_frontend_v1/features/ranking/data/repositories/ranking_repository.dart';
import 'package:travel_frontend_v1/features/ranking/provider/ranking_provider.dart';

class _FakeRankingDataSource implements RankingDataSource {
  int calls = 0;
  RankingPeriod? lastPeriod;

  @override
  Future<RankingPage> getPage(RankingPeriod period) async {
    calls += 1;
    lastPeriod = period;
    return RankingPage.fromJson(
      rankingDatamockForPeriod(_query(period)),
    );
  }

  @override
  Future<RankingQuest> claimQuest(String questId) async {
    return RankingQuest(
      id: questId,
      code: 'COMPLETE_TRIP',
      title: 'Hoàn thành 1 chuyến đi mới',
      subtitle: 'Done',
      icon: 'luggage',
      pointsReward: 100,
      claimed: true,
      claimable: false,
    );
  }

  String _query(RankingPeriod period) => switch (period) {
    RankingPeriod.week => 'WEEK',
    RankingPeriod.month => 'MONTH',
    RankingPeriod.season => 'SEASON',
    RankingPeriod.allTime => 'ALL_TIME',
  };
}

void main() {
  test('loads ranking and switches period', () async {
    final fake = _FakeRankingDataSource();
    final container = ProviderContainer(
      overrides: [
        rankingRepositoryProvider.overrideWith(
          (ref) => RankingRepository(dataSource: fake),
        ),
      ],
    );
    addTearDown(container.dispose);

    final first = await container.read(rankingControllerProvider.future);
    expect(first.page.podium, hasLength(3));
    expect(fake.calls, 1);

    final ok = await container
        .read(rankingControllerProvider.notifier)
        .setPeriod(RankingPeriod.week);
    expect(ok, isTrue);
    expect(fake.lastPeriod, RankingPeriod.week);
  });

  test('claimQuest marks quest claimed then refreshes', () async {
    final fake = _FakeRankingDataSource();
    final container = ProviderContainer(
      overrides: [
        rankingRepositoryProvider.overrideWith(
          (ref) => RankingRepository(dataSource: fake),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(rankingControllerProvider.future);
    final beforeCalls = fake.calls;
    final ok = await container
        .read(rankingControllerProvider.notifier)
        .claimQuest('quest-complete-trip');
    expect(ok, isTrue);
    expect(fake.calls, greaterThan(beforeCalls));
  });
}

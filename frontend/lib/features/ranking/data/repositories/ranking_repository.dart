import '../datasources/ranking_datasource.dart';
import '../models/ranking_models.dart';

class RankingRepository {
  const RankingRepository({required RankingDataSource dataSource})
    : _dataSource = dataSource;

  final RankingDataSource _dataSource;

  Future<RankingPage> getPage(RankingPeriod period) =>
      _dataSource.getPage(period);

  Future<RankingQuest> claimQuest(String questId) =>
      _dataSource.claimQuest(questId);
}

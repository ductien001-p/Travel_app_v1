import '../datasources/explore_home_datasource.dart';
import '../models/explore_home_models.dart';

class ExploreHomeRepository {
  const ExploreHomeRepository({required ExploreHomeDataSource dataSource})
    : _dataSource = dataSource;

  final ExploreHomeDataSource _dataSource;

  Future<ExploreHomeFeed> getCommunityExploreFeed([ExploreHomeQuery? query]) =>
      _dataSource.getCommunityExploreFeed(query);
}

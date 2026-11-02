import '../models/explore_home_models.dart';

class ExploreHomeQuery {
  const ExploreHomeQuery({
    this.category = 'all',
    this.destinationCatalogId,
    this.search,
    this.seed,
    this.timezoneOffsetMinutes,
    this.page = 1,
    this.limit = 20,
    this.includeCatalog = true,
  });

  final String category;
  final String? destinationCatalogId;
  final String? search;
  final String? seed;
  final int? timezoneOffsetMinutes;
  final int page;
  final int limit;

  /// Page 2+ skips the catalog call and keeps the rail already on screen.
  final bool includeCatalog;
}

abstract class ExploreHomeDataSource {
  Future<ExploreHomeFeed> getCommunityExploreFeed([ExploreHomeQuery? query]);
}

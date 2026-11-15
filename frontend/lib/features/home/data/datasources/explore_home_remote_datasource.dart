import 'package:travel_frontend_v1/core/networks/api_client.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_creation_models.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_list_item.dart';

import '../mappers/explore_home_trip_mapper.dart';
import '../models/explore_home_models.dart';
import 'explore_home_datasource.dart';

class ExploreHomeRemoteDataSource implements ExploreHomeDataSource {
  const ExploreHomeRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<ExploreHomeFeed> getCommunityExploreFeed([
    ExploreHomeQuery? query,
  ]) async {
    final q = query ?? const ExploreHomeQuery();
    final discoverFuture = _apiClient.get<Map<String, dynamic>>(
      '/trips/discover',
      queryParameters: {
        'category': q.category,
        'page': q.page,
        'limit': q.limit,
        if (q.seed != null) 'seed': q.seed,
        if (q.timezoneOffsetMinutes != null)
          'timezoneOffsetMinutes': q.timezoneOffsetMinutes,
        if (q.destinationCatalogId != null)
          'destinationCatalogId': q.destinationCatalogId,
        if (q.search != null) 'search': q.search,
      },
    );
    final catalogFuture = q.includeCatalog
        ? _destinationCatalog()
        : Future<List<DestinationCatalogItem>?>.value(const []);
    final body = await discoverFuture;
    final catalog = await catalogFuture;
    final unread = await _hasUnreadNotifications();
    final data = body['data'];
    if (data is! List) {
      throw const FormatException('Discover data is not a list.');
    }
    final trips = [
      for (final item in data)
        TripListItem.fromJson(Map<String, dynamic>.from(item as Map)),
    ];
    final meta = _readPage(body['meta'], fallbackPage: q.page);
    return buildExploreHomeFeed(
      trips: trips,
      displayName: 'Bạn',
      catalog: catalog ?? const [],
      page: meta.page,
      hasNextPage: meta.hasNextPage,
      catalogUnavailable: catalog == null,
      hasUnreadNotifications: unread,
    );
  }

  Future<bool> _hasUnreadNotifications() async {
    try {
      final body = await _apiClient.get<Map<String, dynamic>>(
        '/notifications',
        queryParameters: const {'limit': 1},
      );
      final meta = body['meta'];
      if (meta is! Map) return false;
      final count = meta['unreadCount'];
      if (count is num) return count > 0;
      return false;
    } on ApiException catch (error) {
      if (error.statusCode == 401) rethrow;
      return false;
    } catch (_) {
      return false;
    }
  }

  /// `null` means the catalog request failed. A 401 is rethrown.
  /// An empty list is a successful catalog with no cities.
  Future<List<DestinationCatalogItem>?> _destinationCatalog() async {
    try {
      final body = await _apiClient.get<Map<String, dynamic>>(
        '/trips/destinations/catalog',
      );
      final data = body['data'];
      if (data is! List) return const [];
      return [
        for (final item in data)
          DestinationCatalogItem.fromJson(
            Map<String, dynamic>.from(item as Map),
          ),
      ];
    } on ApiException catch (error) {
      if (error.statusCode == 401) rethrow;
      return null;
    } catch (_) {
      return null;
    }
  }
}

({int page, bool hasNextPage}) _readPage(
  Object? meta, {
  required int fallbackPage,
}) {
  if (meta is! Map) return (page: fallbackPage, hasNextPage: false);
  final page = meta['page'];
  final hasNext = meta['hasNextPage'] == true;
  return (
    page: page is num ? page.toInt() : fallbackPage,
    hasNextPage: hasNext,
  );
}

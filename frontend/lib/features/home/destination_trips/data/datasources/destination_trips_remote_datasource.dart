import 'package:travel_frontend_v1/core/networks/api_client.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/home/data/mappers/explore_home_trip_mapper.dart';
import 'package:travel_frontend_v1/features/home/data/models/explore_home_models.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_creation_models.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_list_item.dart';

import '../mappers/destination_place_labels.dart';
import '../mappers/destination_trips_editorial.dart';
import '../models/destination_trips_models.dart';
import 'destination_trips_datasource.dart';

class DestinationTripsRemoteDataSource implements DestinationTripsDataSource {
  const DestinationTripsRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<DestinationTripsPage> load(DestinationTripsQuery query) async {
    final catalog = await _findCatalog(query);
    final discover = _discover(query, catalog);
    final places = catalog == null
        ? Future<({List<DestinationSpot> spots, int total})>.value((
            spots: const <DestinationSpot>[],
            total: 0,
          ))
        : _places(catalog.id, query.placesLimit);

    final trips = await discover;
    final spotResult = await _spotsOrEmpty(places);
    final highlights = catalog?.highlights ?? const <String>[];
    return DestinationTripsPage(
      profile: DestinationProfile(
        catalogId: catalog?.id ?? query.catalogId ?? '',
        name: catalog?.name ?? query.cityName,
        regionLabel: catalog?.country ?? '',
        coverImageUrl: catalog?.coverImageUrl ?? '',
        tagline: highlights.isEmpty ? '' : highlights.first,
        summary: highlights.join(', '),
      ),
      trips: trips.trips,
      tripTypesById: trips.tripTypesById,
      spots: spotResult.spots,
      openTripCount: trips.total,
      spotsTotal: spotResult.total,
    );
  }

  Future<DestinationCatalogItem?> _findCatalog(
    DestinationTripsQuery query,
  ) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/destinations/catalog',
      queryParameters: {'q': query.cityName},
    );
    final data = body['data'];
    if (data is! List) {
      throw const FormatException('Destination catalog data is not a list.');
    }
    final items = [
      for (final item in data)
        DestinationCatalogItem.fromJson(Map<String, dynamic>.from(item as Map)),
    ];
    final catalogId = query.catalogId?.trim();
    if (catalogId != null && catalogId.isNotEmpty) {
      for (final item in items) {
        if (item.id == catalogId) return item;
      }
    }
    final cityKey = foldCityKey(query.cityName);
    for (final item in items) {
      if (foldCityKey(item.name) == cityKey) return item;
    }
    return null;
  }

  Future<
    ({
      List<CommunityTripCard> trips,
      Map<String, String> tripTypesById,
      int total,
    })
  >
  _discover(
    DestinationTripsQuery query,
    DestinationCatalogItem? catalog,
  ) async {
    final extra = query.search?.trim();
    final resolved = catalog;
    final search = resolved != null
        ? ((extra == null || extra.isEmpty) ? null : extra)
        : ((extra == null || extra.isEmpty)
              ? query.cityName
              : '${query.cityName} $extra');
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/discover',
      queryParameters: {
        'category': query.category,
        'page': 1,
        'limit': 20,
        if (query.seed != null) 'seed': query.seed,
        if (query.timezoneOffsetMinutes != null)
          'timezoneOffsetMinutes': query.timezoneOffsetMinutes,
        if (resolved != null) 'destinationCatalogId': resolved.id,
        if (search != null && search.isNotEmpty) 'search': search,
      },
    );
    final data = body['data'];
    if (data is! List) {
      throw const FormatException('Discover data is not a list.');
    }
    final items = [
      for (final item in data)
        TripListItem.fromJson(Map<String, dynamic>.from(item as Map)),
    ];
    final meta = body['meta'];
    final total = meta is Map && meta['total'] is num
        ? (meta['total'] as num).toInt()
        : items.length;
    return (
      trips: [for (final item in items) mapTripListItemToCommunityCard(item)],
      tripTypesById: {for (final item in items) item.id: item.tripType.name},
      total: total,
    );
  }

  Future<({List<DestinationSpot> spots, int total})> _places(
    String catalogId,
    int limit,
  ) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/destinations/catalog/${Uri.encodeComponent(catalogId)}/places',
      queryParameters: {'sort': 'POPULAR', 'limit': limit},
    );
    final data = body['data'];
    if (data is! Map) {
      throw const FormatException('Catalog places data is not an object.');
    }
    final result = CatalogPlacesResult.fromJson(
      Map<String, dynamic>.from(data),
    );
    return (
      spots: [for (final place in result.items) spotFromPlace(place)],
      total: result.total,
    );
  }

  Future<({List<DestinationSpot> spots, int total})> _spotsOrEmpty(
    Future<({List<DestinationSpot> spots, int total})> places,
  ) async {
    try {
      return await places;
    } on ApiException catch (error) {
      if (error.statusCode == 401) rethrow;
      return (spots: const <DestinationSpot>[], total: 0);
    }
  }
}

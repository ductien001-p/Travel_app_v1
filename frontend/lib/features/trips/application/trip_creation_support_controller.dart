import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/trip.dart';
import '../data/models/trip_creation_models.dart';
import '../data/models/trip_pagination.dart';
import '../provider/trips_provider.dart';

final tripDraftsProvider = FutureProvider<List<Trip>>(
  (ref) => ref.watch(tripRepositoryProvider).getDrafts(),
);

final destinationCatalogProvider = FutureProvider.autoDispose
    .family<List<DestinationCatalogItem>, String?>(
      (ref, query) =>
          ref.watch(tripRepositoryProvider).getDestinationCatalog(query: query),
    );

typedef CatalogPlacesQuery = ({String catalogId, String? category});

final catalogPlacesProvider = FutureProvider.autoDispose
    .family<CatalogPlacesResult, CatalogPlacesQuery>(
      (ref, query) => ref
          .watch(tripRepositoryProvider)
          .getCatalogPlaces(
            query.catalogId,
            category: query.category,
            sort: 'POPULAR',
          ),
    );

typedef RoutePreviewQuery = ({
  double originLat,
  double originLng,
  double destinationLat,
  double destinationLng,
});

final routePreviewProvider = FutureProvider.autoDispose
    .family<RoutePreviewResult, RoutePreviewQuery>(
      (ref, query) => ref
          .watch(tripRepositoryProvider)
          .previewRoute(
            originLat: query.originLat,
            originLng: query.originLng,
            destinationLat: query.destinationLat,
            destinationLng: query.destinationLng,
          ),
    );

final companionRecommendationsProvider = FutureProvider.autoDispose
    .family<List<CompanionRecommendation>, String>(
      (ref, tripId) =>
          ref.watch(tripRepositoryProvider).getCompanionRecommendations(tripId),
    );

final tripUserSearchProvider = FutureProvider.autoDispose
    .family<PageResult<TripCreationUser>, String>((ref, query) {
      final normalized = query.trim();
      if (normalized.isEmpty) {
        return Future.value(
          const PageResult(
            items: [],
            meta: PageMeta(
              page: 1,
              limit: 20,
              total: 0,
              totalPages: 0,
              hasNextPage: false,
              hasPreviousPage: false,
            ),
          ),
        );
      }
      return ref.watch(tripRepositoryProvider).searchUsers(normalized);
    });

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';
import 'package:travel_frontend_v1/features/home/places/provider/explore_places_provider.dart';
import 'package:travel_frontend_v1/features/media/providers/media_providers.dart';

import '../data/datasources/place_detail_remote_datasource.dart';
import '../data/repositories/place_detail_repository.dart';

final placeDetailDataSourceProvider = Provider<PlaceDetailDataSource>(
  (ref) => PlaceDetailRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
);

final placeDetailRepositoryProvider = Provider<PlaceDetailRepository>((ref) {
  final media = ref.watch(mediaUploadRepositoryProvider);
  final collections = ref.watch(explorePlacesRepositoryProvider);
  return PlaceDetailRepository(
    dataSource: ref.watch(placeDetailDataSourceProvider),
    resolveMediaUrl: (mediaId) async {
      try {
        final url = (await media.getMediaUrl(mediaId)).trim();
        return url.isEmpty ? null : url;
      } catch (_) {
        return null;
      }
    },
    savedInCollection: (placeId) async {
      final mine = await collections.listMine();
      return mine.any((collection) => collection.placeIds.contains(placeId));
    },
  );
});

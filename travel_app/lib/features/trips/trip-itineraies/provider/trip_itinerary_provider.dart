import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';

import '../data/datasources/activity_draft_local_datasource.dart';
import '../data/datasources/trip_itinerary_remote_datasource.dart';
import '../data/repositories/trip_itinerary_repository.dart';

final tripItineraryRemoteDataSourceProvider =
    Provider<TripItineraryRemoteDataSource>(
      (ref) => TripItineraryRemoteDataSource(
        apiClient: ref.watch(apiClientProvider),
      ),
    );

final tripItineraryRepositoryProvider = Provider<TripItineraryRepository>(
  (ref) => TripItineraryRepository(
    remoteDataSource: ref.watch(tripItineraryRemoteDataSourceProvider),
  ),
);

final activityDraftLocalDataSourceProvider =
    Provider<ActivityDraftLocalDataSource>(
      (ref) => InMemoryActivityDraftLocalDataSource(),
    );

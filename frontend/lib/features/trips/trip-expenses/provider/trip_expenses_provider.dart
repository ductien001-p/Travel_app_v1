import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';
import 'package:travel_frontend_v1/features/media/providers/media_providers.dart';

import '../data/datasources/trip_expenses_remote_datasource.dart';
import '../data/repositories/trip_expenses_repository.dart';

final tripExpensesRemoteDataSourceProvider =
    Provider<TripExpensesRemoteDataSource>(
      (ref) =>
          TripExpensesRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
    );

final tripExpensesRepositoryProvider = Provider<TripExpensesRepository>(
  (ref) => TripExpensesRepository(
    dataSource: ref.watch(tripExpensesRemoteDataSourceProvider),
    mediaUploadRepository: ref.watch(mediaUploadRepositoryProvider),
  ),
);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';
import 'package:travel_frontend_v1/features/media/providers/media_providers.dart';

import '../data/datasources/trip_memories_remote_datasource.dart';
import '../data/repositories/trip_memories_repository.dart';

final tripMemoriesRemoteDataSourceProvider =
    Provider<TripMemoriesRemoteDataSource>(
      (ref) =>
          TripMemoriesRemoteDataSource(apiClient: ref.watch(apiClientProvider)),
    );

final tripMemoriesRepositoryProvider = Provider<TripMemoriesRepository>(
  (ref) => TripMemoriesRepository(
    remoteDataSource: ref.watch(tripMemoriesRemoteDataSourceProvider),
    mediaUploadRepository: ref.watch(mediaUploadRepositoryProvider),
  ),
);

/// Opens the system gallery; returns an empty list when the user cancels.
typedef TripMemoryPhotoPicker = Future<List<XFile>> Function({int limit});

/// Overridable so the album can be tested without the platform picker.
final tripMemoryPhotoPickerProvider = Provider<TripMemoryPhotoPicker>(
  (ref) =>
      ({int limit = TripMemoriesRepository.maxPhotosPerPost}) =>
          ImagePicker().pickMultiImage(
            limit: limit,
            maxWidth: 2048,
            maxHeight: 2048,
            imageQuality: 85,
          ),
);

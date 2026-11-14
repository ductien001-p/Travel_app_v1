import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_frontend_v1/features/media/data/models/media_upload_folder.dart';
import 'package:travel_frontend_v1/features/media/data/repository/media_upload_repository.dart';

import '../datasources/trip_expenses_datasource.dart';
import '../models/trip_expenses_models.dart';

class TripExpensesRepository {
  const TripExpensesRepository({
    required TripExpensesDataSource dataSource,
    MediaUploadRepository? mediaUploadRepository,
  }) : _dataSource = dataSource,
       _media = mediaUploadRepository;

  final TripExpensesDataSource _dataSource;
  final MediaUploadRepository? _media;

  Future<TripExpensesPage> getExpenses(
    String tripId, {
    int page = 1,
    int limit = 20,
  }) => _dataSource.getExpenses(tripId, page: page, limit: limit);

  Future<TripExpenseCreated> createExpense(
    String tripId,
    CreateTripExpenseRequest request,
  ) => _dataSource.createExpense(tripId, request);

  /// Upload receipt images then create the expense with their media ids.
  Future<TripExpenseCreated> createExpenseWithReceiptUploads({
    required String tripId,
    required CreateTripExpenseRequest request,
    required List<XFile> pendingReceipts,
    MediaUploadProgressCallback? onProgress,
    CancelToken? cancelToken,
  }) async {
    final mediaIds = List<String>.from(request.receiptMediaIds);
    if (pendingReceipts.isNotEmpty) {
      final media = _media;
      if (media == null) {
        throw StateError('Media upload is not configured for expenses.');
      }
      final uploaded = await media.uploadFiles(
        folder: MediaUploadFolder.trips,
        files: pendingReceipts,
        onProgress: onProgress,
        cancelToken: cancelToken,
      );
      mediaIds.addAll(uploaded.map((item) => item.id));
    }

    return _dataSource.createExpense(
      tripId,
      request.copyWith(receiptMediaIds: mediaIds),
    );
  }

  Future<TripExpenseCreatedSplit> settleSplit({
    required String tripId,
    required String expenseId,
    required String splitId,
  }) => _dataSource.settleSplit(
    tripId: tripId,
    expenseId: expenseId,
    splitId: splitId,
  );
}

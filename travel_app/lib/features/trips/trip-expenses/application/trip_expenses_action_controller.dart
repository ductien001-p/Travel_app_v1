import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../data/models/trip_expenses_models.dart';
import '../provider/trip_expenses_provider.dart';
import 'trip_expenses_controller.dart';

/// Mutations for create expense / settle split. One action at a time.
final tripExpensesActionControllerProvider = NotifierProvider.autoDispose
    .family<TripExpensesActionController, TripExpensesActionState, String>(
      TripExpensesActionController.new,
    );

class TripExpensesActionState {
  const TripExpensesActionState({
    this.isBusy = false,
    this.error,
    this.lastSettledSplitId,
  });

  final bool isBusy;
  final Object? error;
  final String? lastSettledSplitId;

  TripExpensesActionState copyWith({
    bool? isBusy,
    Object? error,
    String? lastSettledSplitId,
    bool clearError = false,
  }) => TripExpensesActionState(
    isBusy: isBusy ?? this.isBusy,
    error: clearError ? null : (error ?? this.error),
    lastSettledSplitId: lastSettledSplitId ?? this.lastSettledSplitId,
  );
}

class TripExpensesActionController extends Notifier<TripExpensesActionState> {
  TripExpensesActionController(this.tripId);

  final String tripId;
  bool _busy = false;

  @override
  TripExpensesActionState build() => const TripExpensesActionState();

  Future<TripExpenseCreated> createExpense(CreateTripExpenseRequest request) =>
      _run(() async {
        final created = await ref
            .read(tripExpensesRepositoryProvider)
            .createExpense(tripId, request);
        ref.invalidate(tripExpensesControllerProvider(tripId));
        return created;
      });

  Future<TripExpenseCreated> createExpenseWithReceipts({
    required CreateTripExpenseRequest request,
    required List<XFile> pendingReceipts,
  }) => _run(() async {
    final created = await ref
        .read(tripExpensesRepositoryProvider)
        .createExpenseWithReceiptUploads(
          tripId: tripId,
          request: request,
          pendingReceipts: pendingReceipts,
        );
    ref.invalidate(tripExpensesControllerProvider(tripId));
    return created;
  });

  Future<TripExpenseCreatedSplit> settleSplit({
    required String expenseId,
    required String splitId,
  }) => _run(() async {
    final split = await ref
        .read(tripExpensesRepositoryProvider)
        .settleSplit(tripId: tripId, expenseId: expenseId, splitId: splitId);
    state = state.copyWith(lastSettledSplitId: split.id, clearError: true);
    ref.invalidate(tripExpensesControllerProvider(tripId));
    return split;
  });

  Future<T> _run<T>(Future<T> Function() action) async {
    if (_busy) throw StateError('An expense action is already in progress.');
    _busy = true;
    state = state.copyWith(isBusy: true, clearError: true);
    try {
      return await action();
    } catch (error) {
      state = state.copyWith(isBusy: false, error: error);
      rethrow;
    } finally {
      _busy = false;
      if (state.isBusy) {
        state = state.copyWith(isBusy: false);
      }
    }
  }
}

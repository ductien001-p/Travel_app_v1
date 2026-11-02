import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/trip_list_controller.dart';
import '../data/models/trip_invite_preview_models.dart';
import '../data/models/trip_join_request_models.dart';
import '../provider/trip_join_requests_provider.dart';
import '../utils/trip_join_by_code_formatters.dart';

/// Kết quả sau khi gửi yêu cầu tham gia bằng mã mời.
class TripJoinByCodeResult {
  const TripJoinByCodeResult(this.request);

  final TripJoinRequest request;

  bool get isApproved => request.status == TripJoinRequestStatus.approved;
}

class TripJoinByCodeState {
  const TripJoinByCodeState({this.isSubmitting = false, this.error});

  final bool isSubmitting;
  final Object? error;

  TripJoinByCodeState copyWith({
    bool? isSubmitting,
    Object? error,
    bool clearError = false,
  }) => TripJoinByCodeState(
    isSubmitting: isSubmitting ?? this.isSubmitting,
    error: clearError ? null : error ?? this.error,
  );
}

final tripJoinByCodeControllerProvider =
    NotifierProvider.autoDispose<TripJoinByCodeController, TripJoinByCodeState>(
      TripJoinByCodeController.new,
    );

/// `GET /trips/join/{inviteCode}` for a complete code; empty when incomplete.
///
/// No automatic retry: 404 (invalid code) never recovers by itself, and the
/// screen already shows the error under the code slots.
final tripJoinInvitePreviewProvider = FutureProvider.autoDispose
    .family<TripJoinInvitePreview?, String>((ref, rawCode) async {
      final code = normalizeInviteCode(rawCode);
      if (!isInviteCodeComplete(code)) return null;
      return ref
          .watch(tripJoinRequestsRepositoryProvider)
          .previewByInviteCode(code);
    }, retry: (_, _) => null);

class TripJoinByCodeController extends Notifier<TripJoinByCodeState> {
  @override
  TripJoinByCodeState build() => const TripJoinByCodeState();

  /// Gửi `POST /trips/join/{inviteCode}`. Trả về kết quả khi thành công.
  Future<TripJoinByCodeResult?> submit({
    required String inviteCode,
    String? message,
  }) async {
    if (state.isSubmitting) return null;

    final code = normalizeInviteCode(inviteCode);
    if (!isInviteCodeComplete(code)) {
      state = TripJoinByCodeState(
        error: ArgumentError.value(
          inviteCode,
          'inviteCode',
          'Incomplete invite code',
        ),
      );
      return null;
    }

    state = const TripJoinByCodeState(isSubmitting: true);
    try {
      final request = await ref
          .read(tripJoinRequestsRepositoryProvider)
          .requestToJoin(code, message: message);
      if (request.status == TripJoinRequestStatus.approved) {
        ref
          ..invalidate(tripListControllerProvider)
          ..invalidate(tripDashboardControllerProvider);
      }
      if (ref.mounted) state = const TripJoinByCodeState();
      return TripJoinByCodeResult(request);
    } catch (error) {
      if (ref.mounted) state = TripJoinByCodeState(error: error);
      return null;
    }
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(clearError: true);
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';

import '../../trip-itineraies/application/trip_itinerary_controller.dart';
import '../../trip-itineraies/data/models/itinerary_models.dart';
import '../../trip-itineraies/data/models/itinerary_requests.dart';
import 'trip_detail_overview_controller.dart';

/// Mirrors the backend `UpdateActivityDto` limits.
abstract final class TripActivityEditLimits {
  static const titleMaxLength = 300;
  static const notesMaxLength = 300;
  static const maxDurationMinutes = 24 * 60;
  static const maxCost = 9999999999;
}

enum TripActivityEditField { title, startTime, duration, cost, notes }

/// Raw values typed in the edit sheet; parsed and checked here, not trusted.
class TripActivityEditInput {
  const TripActivityEditInput({
    required this.title,
    required this.startMinutes,
    required this.duration,
    required this.cost,
    required this.notes,
  });

  final String title;

  /// Minutes after midnight (UTC wall clock), null when unscheduled.
  final int? startMinutes;
  final String duration;
  final String cost;
  final String notes;

  factory TripActivityEditInput.of(ItineraryActivity activity) {
    final start = activity.startTime?.toUtc();
    return TripActivityEditInput(
      title: activity.title,
      startMinutes: start == null ? null : start.hour * 60 + start.minute,
      duration: activity.estimatedDuration?.toString() ?? '',
      cost: activity.estimatedCost?.round().toString() ?? '',
      notes: activity.notes ?? '',
    );
  }
}

typedef TripActivityEditValidation = ({
  Map<TripActivityEditField, String> errors,
  UpdateActivityRequest? request,
});

/// Validates [input] and builds a request holding only the changed fields.
///
/// A null request with no errors means nothing changed.
TripActivityEditValidation validateTripActivityEdit({
  required ItineraryActivity original,
  required DateTime dayDate,
  required TripActivityEditInput input,
}) {
  final errors = <TripActivityEditField, String>{};
  final title = input.title.trim();
  final notes = input.notes.trim();
  final duration = _parseAmount(input.duration);
  final cost = _parseAmount(input.cost);
  final startMinutes = input.startMinutes;

  if (title.isEmpty) {
    errors[TripActivityEditField.title] = 'Vui lòng nhập tên hoạt động.';
  } else if (title.length > TripActivityEditLimits.titleMaxLength) {
    errors[TripActivityEditField.title] =
        'Tên tối đa ${TripActivityEditLimits.titleMaxLength} ký tự.';
  }
  if (notes.length > TripActivityEditLimits.notesMaxLength) {
    errors[TripActivityEditField.notes] =
        'Ghi chú tối đa ${TripActivityEditLimits.notesMaxLength} ký tự.';
  }
  if (duration case _AmountInvalid()) {
    errors[TripActivityEditField.duration] = 'Thời lượng phải là số phút ≥ 0.';
  } else if (duration case _AmountValue(
    :final value,
  ) when value > TripActivityEditLimits.maxDurationMinutes) {
    errors[TripActivityEditField.duration] = 'Thời lượng tối đa 24 giờ.';
  }
  if (cost case _AmountInvalid()) {
    errors[TripActivityEditField.cost] = 'Chi phí phải là số ≥ 0.';
  } else if (cost case _AmountValue(
    :final value,
  ) when value > TripActivityEditLimits.maxCost) {
    errors[TripActivityEditField.cost] = 'Chi phí quá lớn.';
  }
  if (startMinutes != null && (startMinutes < 0 || startMinutes >= 24 * 60)) {
    errors[TripActivityEditField.startTime] = 'Giờ bắt đầu không hợp lệ.';
  }

  final durationValue = duration is _AmountValue ? duration.value : null;
  if (!errors.containsKey(TripActivityEditField.startTime) &&
      !errors.containsKey(TripActivityEditField.duration)) {
    if ((startMinutes == null) != (durationValue == null)) {
      errors[startMinutes == null
              ? TripActivityEditField.startTime
              : TripActivityEditField.duration] =
          'Cần nhập cả giờ bắt đầu và thời lượng, hoặc bỏ trống cả hai.';
    } else if (startMinutes != null &&
        durationValue != null &&
        startMinutes + durationValue > 24 * 60) {
      errors[TripActivityEditField.duration] =
          'Hoạt động phải kết thúc trong ngày.';
    }
  }
  if (errors.isNotEmpty) return (errors: errors, request: null);

  final day = dayDate.toUtc();
  final startTime = startMinutes == null
      ? null
      : DateTime.utc(
          day.year,
          day.month,
          day.day,
        ).add(Duration(minutes: startMinutes));
  final costValue = cost is _AmountValue ? cost.value : null;
  final originalNotes = original.notes?.trim() ?? '';
  // The sheet shows whole VND, so an untouched fractional cost is not a change.
  final originalCost = original.estimatedCost?.round();

  final request = UpdateActivityRequest(
    title: title == original.title ? null : title,
    startTime: startTime != null && !_sameInstant(startTime, original.startTime)
        ? startTime
        : null,
    clearStartTime: startTime == null && original.startTime != null,
    estimatedDuration:
        durationValue != null && durationValue != original.estimatedDuration
        ? durationValue
        : null,
    clearEstimatedDuration:
        durationValue == null && original.estimatedDuration != null,
    estimatedCost: costValue != null && costValue != originalCost
        ? costValue
        : null,
    clearEstimatedCost: costValue == null && originalCost != null,
    notes: notes.isNotEmpty && notes != originalNotes ? notes : null,
    clearNotes: notes.isEmpty && originalNotes.isNotEmpty,
  );
  return (errors: const {}, request: request.isEmpty ? null : request);
}

bool _sameInstant(DateTime a, DateTime? b) =>
    b != null && a.isAtSameMomentAs(b);

sealed class _Amount {
  const _Amount();
}

class _AmountEmpty extends _Amount {
  const _AmountEmpty();
}

class _AmountInvalid extends _Amount {
  const _AmountInvalid();
}

class _AmountValue extends _Amount {
  const _AmountValue(this.value);
  final int value;
}

final _digitsOnly = RegExp(r'^\d{1,13}$');

_Amount _parseAmount(String raw) {
  final value = raw.trim();
  if (value.isEmpty) return const _AmountEmpty();
  if (!_digitsOnly.hasMatch(value)) return const _AmountInvalid();
  return _AmountValue(int.parse(value));
}

/// Safe message for a failed update; never echoes raw server text.
String tripActivityEditErrorMessage(Object error) {
  if (error is! ApiException) {
    return 'Không thể lưu thay đổi. Vui lòng thử lại.';
  }
  return switch ((error.statusCode, error.code)) {
    (_, 'ACTIVITY_OVERLAP') => 'Khung giờ này trùng với hoạt động khác.',
    (_, 'OUTSIDE_DESTINATION') =>
      'Giờ hoạt động nằm ngoài thời gian ở điểm đến này.',
    (_, 'ACTIVITY_OVERNIGHT_NOT_ALLOWED') =>
      'Hoạt động phải kết thúc trong ngày.',
    (_, 'ACTIVITY_TIME_INCOMPLETE') =>
      'Cần nhập cả giờ bắt đầu và thời lượng, hoặc bỏ trống cả hai.',
    (400, _) => 'Thông tin chưa hợp lệ. Vui lòng kiểm tra lại.',
    (403, _) => 'Bạn không có quyền sửa lịch trình này.',
    (404, _) => 'Hoạt động không còn tồn tại.',
    (409, _) =>
      'Chuyến đi hiện không cho phép sửa lịch trình. Vui lòng tải lại.',
    _ => 'Không thể lưu thay đổi. Vui lòng thử lại.',
  };
}

enum TripActivityEditOutcome { saved, unchanged, rejected }

class TripItineraryEditActivityState {
  const TripItineraryEditActivityState({
    this.isSubmitting = false,
    this.fieldErrors = const {},
    this.errorMessage,
  });

  final bool isSubmitting;
  final Map<TripActivityEditField, String> fieldErrors;
  final String? errorMessage;
}

final tripItineraryEditActivityControllerProvider = NotifierProvider.autoDispose
    .family<
      TripItineraryEditActivityController,
      TripItineraryEditActivityState,
      String
    >(TripItineraryEditActivityController.new);

class TripItineraryEditActivityController
    extends Notifier<TripItineraryEditActivityState> {
  TripItineraryEditActivityController(this.tripId);

  final String tripId;

  @override
  TripItineraryEditActivityState build() =>
      const TripItineraryEditActivityState();

  Future<TripActivityEditOutcome> submit({
    required ItineraryActivity original,
    required DateTime dayDate,
    required TripActivityEditInput input,
  }) async {
    if (state.isSubmitting) return TripActivityEditOutcome.rejected;

    final (:errors, :request) = validateTripActivityEdit(
      original: original,
      dayDate: dayDate,
      input: input,
    );
    if (errors.isNotEmpty) {
      state = TripItineraryEditActivityState(fieldErrors: errors);
      return TripActivityEditOutcome.rejected;
    }
    if (request == null) {
      state = const TripItineraryEditActivityState();
      return TripActivityEditOutcome.unchanged;
    }

    state = const TripItineraryEditActivityState(isSubmitting: true);
    try {
      await ref
          .read(tripItineraryControllerProvider(tripId).notifier)
          .updateActivity(original.id, request);
      if (!ref.mounted) return TripActivityEditOutcome.saved;
      ref.invalidate(tripDetailOverviewControllerProvider(tripId));
      state = const TripItineraryEditActivityState();
      return TripActivityEditOutcome.saved;
    } catch (error) {
      if (ref.mounted) {
        state = TripItineraryEditActivityState(
          errorMessage: tripActivityEditErrorMessage(error),
        );
      }
      return TripActivityEditOutcome.rejected;
    }
  }

  void clearFieldError(TripActivityEditField field) {
    if (!state.fieldErrors.containsKey(field) && state.errorMessage == null) {
      return;
    }
    state = TripItineraryEditActivityState(
      isSubmitting: state.isSubmitting,
      fieldErrors: Map.of(state.fieldErrors)..remove(field),
    );
  }
}

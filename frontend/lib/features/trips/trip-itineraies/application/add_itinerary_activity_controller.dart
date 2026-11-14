import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/networks/api_exception.dart';
import '../data/models/activity_draft_model.dart';
import '../data/models/itinerary_models.dart';
import '../data/models/itinerary_requests.dart';
import '../provider/trip_itinerary_provider.dart';
import '../utils/destination_time_converter.dart';
import 'add_itinerary_activity_state.dart';
import 'trip_itinerary_controller.dart';

final addItineraryActivityControllerProvider =
    NotifierProvider.family<
      AddItineraryActivityController,
      AddItineraryActivityState,
      AddItineraryActivityArgs
    >(AddItineraryActivityController.new);

class AddItineraryActivityController
    extends Notifier<AddItineraryActivityState> {
  AddItineraryActivityController(this.args);

  final AddItineraryActivityArgs args;
  int _searchSerial = 0;

  @override
  AddItineraryActivityState build() {
    Future.microtask(_restoreDraft);
    return AddItineraryActivityState(args: args);
  }

  Future<void> _restoreDraft() async {
    try {
      final draft = await ref
          .read(activityDraftLocalDataSourceProvider)
          .getDraft(tripId: args.tripId, dayId: args.dayId);
      if (draft == null) return;

      TimeOfDay? time;
      if (draft.startTimeIso != null && draft.startTimeIso!.isNotEmpty) {
        try {
          final dt = DateTime.parse(draft.startTimeIso!);
          time = TimeOfDay(hour: dt.hour, minute: dt.minute);
        } catch (_) {}
      }

      state = state.copyWith(
        title: draft.title ?? '',
        isTitleManual: draft.isTitleManual,
        selectedTime: time,
        estimatedDurationMinutes: draft.durationMinutes,
        estimatedCost: draft.estimatedCost,
        notes: draft.notes ?? '',
        insertAfterActivityId: draft.insertAfterActivityId,
        initialDraftSnapshot: draft,
      );
    } catch (_) {}
  }

  void setSearchQuery(String value) {
    if (value != state.query) {
      _searchSerial++;
    }
    if (value.trim().isEmpty) {
      state = state.copyWith(
        query: value,
        searchResults: const [],
        searchError: null,
        isSearchingPlaces: false,
      );
      return;
    }
    state = state.copyWith(
      query: value,
      searchResults: const [],
      searchError: null,
      isSearchingPlaces: false,
    );
  }

  void setCategory(PlaceCategoryGroup group) {
    if (group == state.selectedCategory) return;
    state = state.copyWith(selectedCategory: group);
    searchPlaces();
  }

  Future<void> searchPlaces() async {
    final query = state.query.trim();
    if (query.isEmpty || !args.hasValidContext) return;
    final serial = ++_searchSerial;
    state = state.copyWith(isSearchingPlaces: true, searchError: null);
    try {
      final results = await ref
          .read(tripItineraryRepositoryProvider)
          .searchPlaces(
            destinationId: args.destinationId,
            query: query,
            categories: state.selectedCategory.backendCodes.isEmpty
                ? null
                : state.selectedCategory.backendCodes,
          );
      if (serial != _searchSerial || query != state.query.trim()) return;
      state = state.copyWith(searchResults: results, isSearchingPlaces: false);
    } catch (error) {
      if (serial != _searchSerial) return;
      state = state.copyWith(
        isSearchingPlaces: false,
        searchError: _safeMessage(error, search: true),
      );
    }
  }

  Future<void> retrySearchPlaces() => searchPlaces();

  void clearSearch() {
    _searchSerial++;
    state = state.copyWith(
      query: '',
      searchResults: const [],
      searchError: null,
      isSearchingPlaces: false,
    );
  }

  void selectPlace(PlaceSearchResult place) {
    state = state.copyWith(
      selectedPlace: place,
      title: !state.isTitleManual ? place.name : state.title,
      fieldErrors: _withoutField('placeId'),
    );
  }

  void changePlace() => state = state.copyWith(selectedPlace: null);

  void setTitle(String value) {
    state = state.copyWith(
      title: value,
      isTitleManual: true,
      fieldErrors: _withoutField('title'),
    );
  }

  void setStartTime(TimeOfDay? time) {
    state = state.copyWith(
      selectedTime: time,
      fieldErrors: _withoutField('startTime'),
    );
  }

  void setDurationMinutes(int? value) {
    final errors = _withoutField('estimatedDuration');
    if (value != null && value < 0) {
      errors['estimatedDuration'] = 'Thời lượng không được nhỏ hơn 0.';
    }
    state = state.copyWith(
      estimatedDurationMinutes: value,
      fieldErrors: errors,
    );
  }

  void setEstimatedCost(int? value) {
    final errors = _withoutField('estimatedCost');
    if (value != null && value < 0) {
      errors['estimatedCost'] = 'Chi phí không được nhỏ hơn 0.';
    }
    state = state.copyWith(estimatedCost: value, fieldErrors: errors);
  }

  void setNotes(String value) {
    final errors = _withoutField('notes');
    if (value.length > 300) {
      errors['notes'] = 'Ghi chú không được vượt quá 300 ký tự.';
    }
    state = state.copyWith(notes: value, fieldErrors: errors);
  }

  void setInsertAfterActivityId(String? id) {
    final errors = _withoutField('insertAfterActivityId');
    if (id != null &&
        !args.insertionChoices.any((activity) => activity.id == id)) {
      errors['insertAfterActivityId'] =
          'Hoạt động được chọn không còn trong ngày này.';
      state = state.copyWith(fieldErrors: errors);
      return;
    }
    state = state.copyWith(insertAfterActivityId: id, fieldErrors: errors);
  }

  Future<void> saveDraft() async {
    state = state.copyWith(draftStatus: DraftSaveStatus.saving);
    try {
      final draft = ActivityDraftModel(
        tripId: args.tripId,
        dayId: args.dayId,
        destinationId: args.destinationId,
        selectedPlaceId: state.selectedPlace?.id,
        selectedPlaceName: state.selectedPlace?.name,
        title: state.title,
        isTitleManual: state.isTitleManual,
        startTimeIso: _startTimeIso(),
        durationMinutes: state.estimatedDurationMinutes,
        estimatedCost: state.estimatedCost,
        notes: state.notes,
        insertAfterActivityId: state.insertAfterActivityId,
        updatedAt: DateTime.now(),
      );
      await ref.read(activityDraftLocalDataSourceProvider).saveDraft(draft);
      state = state.copyWith(
        draftStatus: DraftSaveStatus.saved,
        initialDraftSnapshot: draft,
      );
    } catch (_) {
      state = state.copyWith(draftStatus: DraftSaveStatus.error);
    }
  }

  Future<void> discardChanges() async {
    try {
      await ref
          .read(activityDraftLocalDataSourceProvider)
          .deleteDraft(tripId: args.tripId, dayId: args.dayId);
    } catch (_) {}
  }

  Future<ItineraryActivity?> submit() async {
    if (state.isSubmitting) return null;
    final errors = <String, String>{};
    if (!args.hasValidContext) {
      errors['context'] = 'Thông tin ngày hành trình không hợp lệ.';
    }
    if (!args.canManageItinerary) {
      errors['permission'] =
          'Bạn không có quyền quản lý hoạt động của chuyến đi này.';
    }
    if (state.selectedPlace == null || state.selectedPlace!.id.isEmpty) {
      errors['placeId'] = 'Vui lòng chọn một địa điểm.';
    }
    if (state.notes.length > 300) {
      errors['notes'] = 'Ghi chú không được vượt quá 300 ký tự.';
    }
    if (state.estimatedDurationMinutes != null &&
        state.estimatedDurationMinutes! < 0) {
      errors['estimatedDuration'] = 'Thời lượng không được nhỏ hơn 0.';
    }
    if (state.estimatedCost != null && state.estimatedCost! < 0) {
      errors['estimatedCost'] = 'Chi phí không được nhỏ hơn 0.';
    }
    final anchor = state.insertAfterActivityId;
    if (anchor != null &&
        !args.insertionChoices.any((activity) => activity.id == anchor)) {
      errors['insertAfterActivityId'] =
          'Hoạt động được chọn không còn trong ngày này.';
    }
    if (errors.isNotEmpty) {
      state = state.copyWith(fieldErrors: errors, submitError: null);
      return null;
    }

    state = state.copyWith(
      isSubmitting: true,
      submitError: null,
      fieldErrors: const {},
    );
    try {
      final title = state.title.trim();
      final result = await ref
          .read(tripItineraryControllerProvider(args.tripId).notifier)
          .createActivity(
            args.dayId,
            CreateActivityRequest(
              placeId: state.selectedPlace!.id,
              title: title.isEmpty ? null : title,
              startTimeIso: _startTimeIso(),
              estimatedDuration: state.estimatedDurationMinutes,
              estimatedCost: state.estimatedCost,
              notes: state.notes.trim().isEmpty ? null : state.notes.trim(),
              insertAfterActivityId: state.insertAfterActivityId,
            ),
          );

      // On successful create, delete matching local draft
      await ref
          .read(activityDraftLocalDataSourceProvider)
          .deleteDraft(tripId: args.tripId, dayId: args.dayId);

      state = state.copyWith(isSubmitting: false);
      return result;
    } catch (error) {
      state = state.copyWith(
        isSubmitting: false,
        fieldErrors: _fieldErrors(error),
        submitError: _safeMessage(error),
      );
      return null;
    }
  }

  Map<String, String> _withoutField(String key) =>
      Map<String, String>.from(state.fieldErrors)..remove(key);

  String? _startTimeIso() {
    final time = state.selectedTime;
    if (time == null) return null;
    return DestinationTimeConverter.toUtcIso(dayDate: args.dayDate, time: time);
  }

  Map<String, String> _fieldErrors(Object error) {
    if (error is! ApiException || error.code != 'VALIDATION_ERROR') {
      return const {};
    }
    final details = error.details;
    const supported = {
      'placeId',
      'title',
      'startTime',
      'estimatedDuration',
      'estimatedCost',
      'notes',
      'insertAfterActivityId',
    };
    final body = details is Map ? details : const {};
    final rawDetails = body['details'] ?? details;
    final result = <String, String>{};
    if (rawDetails is List) {
      for (final item in rawDetails.whereType<Map>()) {
        final field = item['field']?.toString();
        final message = item['message']?.toString();
        if (field != null && message != null && supported.contains(field)) {
          result[field] = message;
        }
      }
    } else if (rawDetails is Map) {
      for (final entry in rawDetails.entries) {
        final field = entry.key.toString();
        if (supported.contains(field)) {
          result[field] = entry.value is List
              ? (entry.value as List).join('\n')
              : entry.value.toString();
        }
      }
    }
    return result;
  }
}

String _safeMessage(Object error, {bool search = false}) {
  if (error is ApiException) {
    if ((error.statusCode ?? 0) >= 500) {
      return 'Máy chủ đang gặp sự cố. Vui lòng thử lại.';
    }
    return switch (error.statusCode) {
      401 => 'Phiên đăng nhập đã hết hạn.',
      403 => 'Bạn không có quyền thêm hoạt động cho chuyến đi này.',
      404 => 'Thông tin chuyến đi, ngày hoặc địa điểm không còn tồn tại.',
      _ =>
        error.message.trim().isEmpty
            ? 'Không thể hoàn tất yêu cầu. Vui lòng thử lại.'
            : error.message,
    };
  }
  return search
      ? 'Không thể tìm địa điểm. Vui lòng thử lại.'
      : 'Không thể thêm hoạt động. Vui lòng thử lại.';
}

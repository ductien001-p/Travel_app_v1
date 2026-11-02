import 'package:flutter/material.dart';

import '../data/models/activity_draft_model.dart';
import '../data/models/itinerary_models.dart';

enum PlaceCategoryGroup {
  all(label: 'Tất cả', backendCodes: []),
  food(label: 'Ăn uống', backendCodes: ['FOOD', 'CAFE']),
  accommodation(
    label: 'Lưu trú',
    backendCodes: ['HOTEL', 'RESORT', 'HOSTEL', 'HOMESTAY', 'VILLA'],
  ),
  nature(
    label: 'Thiên nhiên',
    backendCodes: ['MOUNTAIN', 'BEACH', 'CAVE', 'WATERFALL', 'LAKE', 'CAMPING'],
  ),
  culture(
    label: 'Văn hóa',
    backendCodes: [
      'MUSEUM',
      'TEMPLES',
      'CHURCH',
      'HISTORICAL_SITE',
      'MONUMENT',
      'PALACE',
      'CASTLE',
      'OLD_TOWN',
    ],
  ),
  entertainment(
    label: 'Giải trí',
    backendCodes: [
      'ZOO',
      'WATER_PARK',
      'PARK',
      'CINEMA',
      'THEATER',
      'NIGHT_MARKET',
      'SHOPPING_MALL',
      'MARKET',
      'ZIPLINE',
      'WALKING_STREET',
    ],
  );

  const PlaceCategoryGroup({required this.label, required this.backendCodes});
  final String label;
  final List<String> backendCodes;
}

enum DraftSaveStatus { idle, saving, saved, error }

class AddItineraryActivityArgs {
  const AddItineraryActivityArgs({
    required this.tripId,
    required this.dayId,
    required this.destinationId,
    required this.dayNumber,
    required this.dayDate,
    required this.city,
    required this.country,
    required this.insertionChoices,
    required this.canManageItinerary,
    this.budgetCurrency = 'VND',
  });

  final String tripId;
  final String dayId;
  final String destinationId;
  final int dayNumber;
  final DateTime dayDate;
  final String city;
  final String country;
  final List<ItineraryActivity> insertionChoices;
  final bool canManageItinerary;
  final String budgetCurrency;

  bool get hasValidContext =>
      tripId.trim().isNotEmpty &&
      dayId.trim().isNotEmpty &&
      destinationId.trim().isNotEmpty &&
      dayNumber > 0 &&
      insertionChoices.every(
        (activity) => activity.dayId == dayId && activity.tripId == tripId,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddItineraryActivityArgs &&
          tripId == other.tripId &&
          dayId == other.dayId &&
          destinationId == other.destinationId &&
          dayNumber == other.dayNumber &&
          dayDate == other.dayDate &&
          city == other.city &&
          country == other.country &&
          canManageItinerary == other.canManageItinerary &&
          budgetCurrency == other.budgetCurrency &&
          identical(insertionChoices, other.insertionChoices);

  @override
  int get hashCode => Object.hash(
    tripId,
    dayId,
    destinationId,
    dayNumber,
    dayDate,
    city,
    country,
    canManageItinerary,
    budgetCurrency,
    insertionChoices,
  );
}

class AddItineraryActivityState {
  const AddItineraryActivityState({
    required this.args,
    this.query = '',
    this.selectedCategory = PlaceCategoryGroup.all,
    this.searchResults = const [],
    this.selectedPlace,
    this.title = '',
    this.isTitleManual = false,
    this.selectedTime,
    this.estimatedDurationMinutes,
    this.estimatedCost,
    this.notes = '',
    this.insertAfterActivityId,
    this.isSearchingPlaces = false,
    this.isSubmitting = false,
    this.searchError,
    this.submitError,
    this.fieldErrors = const {},
    this.draftStatus = DraftSaveStatus.idle,
    this.initialDraftSnapshot,
  });

  final AddItineraryActivityArgs args;
  final String query;
  final PlaceCategoryGroup selectedCategory;
  final List<PlaceSearchResult> searchResults;
  final PlaceSearchResult? selectedPlace;
  final String title;
  final bool isTitleManual;
  final TimeOfDay? selectedTime;
  final int? estimatedDurationMinutes;
  final int? estimatedCost;
  final String notes;
  final String? insertAfterActivityId;
  final bool isSearchingPlaces;
  final bool isSubmitting;
  final String? searchError;
  final String? submitError;
  final Map<String, String> fieldErrors;
  final DraftSaveStatus draftStatus;
  final ActivityDraftModel? initialDraftSnapshot;

  bool get hasSelectedPlace => selectedPlace != null;
  bool get canSearch => query.trim().isNotEmpty && !isSearchingPlaces;

  bool get canSubmit =>
      args.hasValidContext &&
      args.canManageItinerary &&
      selectedPlace != null &&
      !isSubmitting &&
      notes.length <= 300 &&
      (estimatedDurationMinutes == null || estimatedDurationMinutes! >= 0) &&
      (estimatedCost == null || estimatedCost! >= 0);

  bool get isDirty {
    if (initialDraftSnapshot == null) {
      return query.isNotEmpty ||
          selectedPlace != null ||
          title.isNotEmpty ||
          selectedTime != null ||
          estimatedDurationMinutes != null ||
          estimatedCost != null ||
          notes.isNotEmpty ||
          insertAfterActivityId != null;
    }
    final snap = initialDraftSnapshot!;
    return selectedPlace?.id != snap.selectedPlaceId ||
        title != (snap.title ?? '') ||
        estimatedDurationMinutes != snap.durationMinutes ||
        estimatedCost != snap.estimatedCost ||
        notes != (snap.notes ?? '') ||
        insertAfterActivityId != snap.insertAfterActivityId;
  }

  AddItineraryActivityState copyWith({
    String? query,
    PlaceCategoryGroup? selectedCategory,
    List<PlaceSearchResult>? searchResults,
    Object? selectedPlace = _unchanged,
    String? title,
    bool? isTitleManual,
    Object? selectedTime = _unchanged,
    Object? estimatedDurationMinutes = _unchanged,
    Object? estimatedCost = _unchanged,
    String? notes,
    Object? insertAfterActivityId = _unchanged,
    bool? isSearchingPlaces,
    bool? isSubmitting,
    Object? searchError = _unchanged,
    Object? submitError = _unchanged,
    Map<String, String>? fieldErrors,
    DraftSaveStatus? draftStatus,
    Object? initialDraftSnapshot = _unchanged,
  }) => AddItineraryActivityState(
    args: args,
    query: query ?? this.query,
    selectedCategory: selectedCategory ?? this.selectedCategory,
    searchResults: searchResults ?? this.searchResults,
    selectedPlace: identical(selectedPlace, _unchanged)
        ? this.selectedPlace
        : selectedPlace as PlaceSearchResult?,
    title: title ?? this.title,
    isTitleManual: isTitleManual ?? this.isTitleManual,
    selectedTime: identical(selectedTime, _unchanged)
        ? this.selectedTime
        : selectedTime as TimeOfDay?,
    estimatedDurationMinutes: identical(estimatedDurationMinutes, _unchanged)
        ? this.estimatedDurationMinutes
        : estimatedDurationMinutes as int?,
    estimatedCost: identical(estimatedCost, _unchanged)
        ? this.estimatedCost
        : estimatedCost as int?,
    notes: notes ?? this.notes,
    insertAfterActivityId: identical(insertAfterActivityId, _unchanged)
        ? this.insertAfterActivityId
        : insertAfterActivityId as String?,
    isSearchingPlaces: isSearchingPlaces ?? this.isSearchingPlaces,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    searchError: identical(searchError, _unchanged)
        ? this.searchError
        : searchError as String?,
    submitError: identical(submitError, _unchanged)
        ? this.submitError
        : submitError as String?,
    fieldErrors: fieldErrors ?? this.fieldErrors,
    draftStatus: draftStatus ?? this.draftStatus,
    initialDraftSnapshot: identical(initialDraftSnapshot, _unchanged)
        ? this.initialDraftSnapshot
        : initialDraftSnapshot as ActivityDraftModel?,
  );
}

const _unchanged = Object();

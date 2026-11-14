class CreateActivityRequest {
  const CreateActivityRequest({
    required this.placeId,
    this.title,
    this.startTime,
    this.startTimeIso,
    this.estimatedDuration,
    this.estimatedCost,
    this.notes,
    this.insertAfterActivityId,
  });

  final String placeId;
  final String? title;
  final DateTime? startTime;
  final String? startTimeIso;
  final int? estimatedDuration;
  final int? estimatedCost;
  final String? notes;
  final String? insertAfterActivityId;

  Map<String, dynamic> toJson() => {
    'placeId': placeId,
    if (title != null && title!.trim().isNotEmpty) 'title': title!.trim(),
    if (startTimeIso != null && startTimeIso!.isNotEmpty)
      'startTime': startTimeIso
    else if (startTime != null)
      'startTime': startTime!.toIso8601String(),
    if (estimatedDuration != null) 'estimatedDuration': estimatedDuration,
    if (estimatedCost != null) 'estimatedCost': estimatedCost,
    if (notes != null && notes!.trim().isNotEmpty) 'notes': notes!.trim(),
    if (insertAfterActivityId != null)
      'insertAfterActivityId': insertAfterActivityId,
  };
}

class UpdateActivityRequest {
  const UpdateActivityRequest({
    this.title,
    this.placeId,
    this.startTime,
    this.clearStartTime = false,
    this.estimatedDuration,
    this.clearEstimatedDuration = false,
    this.estimatedCost,
    this.clearEstimatedCost = false,
    this.notes,
    this.clearNotes = false,
  });

  final String? title;
  final String? placeId;
  final DateTime? startTime;
  final bool clearStartTime;
  final int? estimatedDuration;
  final bool clearEstimatedDuration;
  final int? estimatedCost;
  final bool clearEstimatedCost;
  final String? notes;
  final bool clearNotes;

  bool get isEmpty => toJson().isEmpty;

  Map<String, dynamic> toJson() => {
    if (title != null) 'title': title,
    if (placeId != null) 'placeId': placeId,
    if (clearStartTime)
      'startTime': null
    else if (startTime != null)
      'startTime': startTime!.toIso8601String(),
    if (clearEstimatedDuration)
      'estimatedDuration': null
    else if (estimatedDuration != null)
      'estimatedDuration': estimatedDuration,
    if (clearEstimatedCost)
      'estimatedCost': null
    else if (estimatedCost != null)
      'estimatedCost': estimatedCost,
    if (clearNotes) 'notes': null else if (notes != null) 'notes': notes,
  };
}

class CheckinActivityRequest {
  const CheckinActivityRequest({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
  };
}

class CreateItineraryItemRequest {
  const CreateItineraryItemRequest({
    required this.dayId,
    required this.placeId,
    required this.title,
    required this.orderIndex,
    this.startTime,
    this.estimatedDuration,
    this.estimatedCost,
    this.isCheckin,
  });

  final String dayId;
  final String placeId;
  final String title;
  final DateTime? startTime;
  final int? estimatedDuration;
  final double? estimatedCost;
  final bool? isCheckin;
  final int orderIndex;

  Map<String, dynamic> toJson() => {
    'dayId': dayId,
    'placeId': placeId,
    'title': title,
    if (startTime != null) 'startTime': startTime!.toIso8601String(),
    if (estimatedDuration != null) 'estimatedDuration': estimatedDuration,
    if (estimatedCost != null) 'estimatedCost': estimatedCost,
    if (isCheckin != null) 'isCheckin': isCheckin,
    'orderIndex': orderIndex,
  };
}

class CreateItineraryItemsBatchRequest {
  const CreateItineraryItemsBatchRequest({required this.items});

  final List<CreateItineraryItemRequest> items;

  Map<String, dynamic> toJson() => {
    'items': items.map((item) => item.toJson()).toList(growable: false),
  };
}

class ActivityDraftModel {
  const ActivityDraftModel({
    required this.tripId,
    required this.dayId,
    required this.destinationId,
    this.selectedPlaceId,
    this.selectedPlaceName,
    this.title,
    this.isTitleManual = false,
    this.startTimeIso,
    this.durationMinutes,
    this.estimatedCost,
    this.notes,
    this.insertAfterActivityId,
    required this.updatedAt,
  });

  final String tripId;
  final String dayId;
  final String destinationId;
  final String? selectedPlaceId;
  final String? selectedPlaceName;
  final String? title;
  final bool isTitleManual;
  final String? startTimeIso;
  final int? durationMinutes;
  final int? estimatedCost;
  final String? notes;
  final String? insertAfterActivityId;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => {
    'tripId': tripId,
    'dayId': dayId,
    'destinationId': destinationId,
    'selectedPlaceId': selectedPlaceId,
    'selectedPlaceName': selectedPlaceName,
    'title': title,
    'isTitleManual': isTitleManual,
    'startTimeIso': startTimeIso,
    'durationMinutes': durationMinutes,
    'estimatedCost': estimatedCost,
    'notes': notes,
    'insertAfterActivityId': insertAfterActivityId,
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory ActivityDraftModel.fromJson(Map<String, dynamic> json) =>
      ActivityDraftModel(
        tripId: json['tripId'] as String,
        dayId: json['dayId'] as String,
        destinationId: json['destinationId'] as String,
        selectedPlaceId: json['selectedPlaceId'] as String?,
        selectedPlaceName: json['selectedPlaceName'] as String?,
        title: json['title'] as String?,
        isTitleManual: json['isTitleManual'] as bool? ?? false,
        startTimeIso: json['startTimeIso'] as String?,
        durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
        estimatedCost: (json['estimatedCost'] as num?)?.toInt(),
        notes: json['notes'] as String?,
        insertAfterActivityId: json['insertAfterActivityId'] as String?,
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );
}

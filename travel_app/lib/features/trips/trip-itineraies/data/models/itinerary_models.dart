class ItineraryPlace {
  const ItineraryPlace({
    required this.id,
    required this.name,
    this.description,
    this.category,
    this.city,
    this.country,
    this.address,
    this.latitude,
    this.longitude,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String? description;
  final String? category;
  final String? city;
  final String? country;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? imageUrl;

  factory ItineraryPlace.fromJson(Map<String, dynamic> json) => ItineraryPlace(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String?,
    category: json['category'] as String?,
    city: json['city'] as String?,
    country: json['country'] as String?,
    address: json['address'] as String?,
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
    imageUrl: json['imageUrl'] as String?,
  );
}

class ItineraryActivity {
  const ItineraryActivity({
    required this.id,
    required this.tripId,
    required this.dayId,
    required this.placeId,
    required this.title,
    required this.isCheckin,
    required this.orderIndex,
    required this.createdAt,
    required this.updatedAt,
    this.notes,
    this.startTime,
    this.estimatedCost,
    this.estimatedDuration,
    this.place,
  });

  final String id;
  final String tripId;
  final String dayId;
  final String placeId;
  final String title;
  final String? notes;
  final DateTime? startTime;
  final double? estimatedCost;
  final int? estimatedDuration;
  final bool isCheckin;
  final double orderIndex;
  final ItineraryPlace? place;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory ItineraryActivity.fromJson(Map<String, dynamic> json) {
    final rawCost = json['estimatedCost'];
    return ItineraryActivity(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      dayId: json['dayId'] as String,
      placeId: json['placeId'] as String,
      title: json['title'] as String,
      notes: json['notes'] as String?,
      startTime: _dateOrNull(json['startTime']),
      estimatedCost: rawCost == null
          ? null
          : rawCost is num
          ? rawCost.toDouble()
          : double.parse(rawCost as String),
      estimatedDuration: (json['estimatedDuration'] as num?)?.toInt(),
      isCheckin: json['isCheckin'] as bool,
      orderIndex: (json['orderIndex'] as num).toDouble(),
      place: json['place'] is Map
          ? ItineraryPlace.fromJson(
              Map<String, dynamic>.from(json['place'] as Map),
            )
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}

class ItineraryDaySummary {
  const ItineraryDaySummary({
    required this.activityCount,
    required this.estimatedDurationMinutes,
    required this.estimatedCost,
  });

  final int activityCount;
  final int estimatedDurationMinutes;
  final String estimatedCost;

  factory ItineraryDaySummary.fromJson(Map<String, dynamic> json) =>
      ItineraryDaySummary(
        activityCount: (json['activityCount'] as num).toInt(),
        estimatedDurationMinutes: (json['estimatedDurationMinutes'] as num)
            .toInt(),
        estimatedCost: json['estimatedCost'] as String,
      );
}

class ItineraryDay {
  const ItineraryDay({
    required this.id,
    required this.tripId,
    required this.destinationId,
    required this.dayNumber,
    required this.date,
    required this.activities,
    this.summary,
  });

  final String id;
  final String tripId;
  final String destinationId;
  final int dayNumber;
  final DateTime date;
  final List<ItineraryActivity> activities;
  final ItineraryDaySummary? summary;

  factory ItineraryDay.fromJson(Map<String, dynamic> json) => ItineraryDay(
    id: json['id'] as String,
    tripId: json['tripId'] as String,
    destinationId: json['destinationId'] as String,
    dayNumber: (json['dayNumber'] as num).toInt(),
    date: DateTime.parse(json['date'] as String),
    activities: _mapList(json['activities'], ItineraryActivity.fromJson),
    summary: json['summary'] is Map
        ? ItineraryDaySummary.fromJson(
            Map<String, dynamic>.from(json['summary'] as Map),
          )
        : null,
  );
}

class DestinationItinerary {
  const DestinationItinerary({
    required this.id,
    required this.tripId,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.order,
    required this.startDate,
    required this.endDate,
    required this.days,
    this.destinationCatalogId,
    this.destinationType,
    this.highlights = const [],
    this.coverImageUrl,
  });

  final String id;
  final String tripId;
  final String city;
  final String country;
  final double latitude;
  final double longitude;
  final int order;
  final DateTime startDate;
  final DateTime endDate;
  final List<ItineraryDay> days;
  final String? destinationCatalogId;
  final String? destinationType;
  final List<String> highlights;
  final String? coverImageUrl;

  factory DestinationItinerary.fromJson(Map<String, dynamic> json) =>
      DestinationItinerary(
        id: json['id'] as String,
        tripId: json['tripId'] as String,
        city: json['city'] as String,
        country: json['country'] as String,
        latitude: (json['lat'] as num).toDouble(),
        longitude: (json['lng'] as num).toDouble(),
        order: (json['order'] as num).toInt(),
        startDate: DateTime.parse(json['startDate'] as String),
        endDate: DateTime.parse(json['endDate'] as String),
        days: _mapList(json['itineraryDays'], ItineraryDay.fromJson),
        destinationCatalogId: json['destinationId'] as String?,
        destinationType: json['destinationType'] as String?,
        highlights: (json['highlights'] as List? ?? const [])
            .map((item) => item as String)
            .toList(growable: false),
        coverImageUrl: json['coverImageUrl'] as String?,
      );
}

class TripItineraryData {
  const TripItineraryData({
    required this.destinations,
    required this.canManageItinerary,
  });

  final List<DestinationItinerary> destinations;
  final bool canManageItinerary;

  factory TripItineraryData.fromEnvelope(Map<String, dynamic> json) {
    final permissions = json['permissions'];
    if (permissions is! Map || permissions['canManageItinerary'] is! bool) {
      throw const FormatException(
        'Itinerary response does not contain authoritative permissions.',
      );
    }
    return TripItineraryData(
      destinations: _mapList(json['data'], DestinationItinerary.fromJson),
      canManageItinerary: permissions['canManageItinerary'] as bool,
    );
  }
}

class TripCheckin {
  const TripCheckin({
    required this.id,
    required this.memberId,
    required this.activityId,
    required this.latitude,
    required this.longitude,
    required this.visitedAt,
    required this.createdAt,
  });

  final String id;
  final String memberId;
  final String activityId;
  final double latitude;
  final double longitude;
  final DateTime visitedAt;
  final DateTime createdAt;

  factory TripCheckin.fromJson(Map<String, dynamic> json) => TripCheckin(
    id: json['id'] as String,
    memberId: json['memberId'] as String,
    activityId: json['activityId'] as String,
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    visitedAt: DateTime.parse(json['visitedAt'] as String),
    createdAt: DateTime.parse(json['createdAt'] as String),
  );
}

class CreateItineraryItemsBatchResult {
  const CreateItineraryItemsBatchResult({
    required this.success,
    required this.createdCount,
    required this.items,
  });

  final bool success;
  final int createdCount;
  final List<ItineraryActivity> items;

  factory CreateItineraryItemsBatchResult.fromJson(Map<String, dynamic> json) =>
      CreateItineraryItemsBatchResult(
        success: json['success'] as bool,
        createdCount: (json['createdCount'] as num).toInt(),
        items: _mapList(json['items'], ItineraryActivity.fromJson),
      );
}

class TripItineraryCompletion {
  const TripItineraryCompletion({
    required this.totalActivities,
    required this.completedActivities,
    required this.progressPercent,
    required this.isTripCompleted,
  });

  final int totalActivities;
  final int completedActivities;
  final int progressPercent;
  final bool isTripCompleted;

  factory TripItineraryCompletion.fromJson(Map<String, dynamic> json) =>
      TripItineraryCompletion(
        totalActivities: (json['totalActivities'] as num).toInt(),
        completedActivities: (json['completedActivities'] as num).toInt(),
        progressPercent: (json['progressPercent'] as num).toInt(),
        isTripCompleted: json['isTripCompleted'] as bool,
      );
}

class PlaceSearchResult {
  const PlaceSearchResult({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.similarity,
    required this.distanceKm,
    this.description,
    this.category,
    this.address,
    this.averageRating,
    this.reviewCount = 0,
    this.thumbnailUrl,
  });

  final String id;
  final String name;
  final String? description;
  final double latitude;
  final double longitude;
  final double similarity;
  final double distanceKm;
  final String? category;
  final String? address;
  final double? averageRating;
  final int reviewCount;
  final String? thumbnailUrl;

  factory PlaceSearchResult.fromJson(Map<String, dynamic> json) =>
      PlaceSearchResult(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String?,
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
        similarity: (json['similarity'] as num).toDouble(),
        distanceKm: (json['distance_km'] as num).toDouble(),
        category: json['category'] as String?,
        address: json['address'] as String?,
        averageRating: (json['averageRating'] as num?)?.toDouble(),
        reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
        thumbnailUrl: json['thumbnailUrl'] as String?,
      );
}

DateTime? _dateOrNull(Object? value) =>
    value == null ? null : DateTime.parse(value as String);

List<T> _mapList<T>(Object? value, T Function(Map<String, dynamic>) parser) =>
    (value as List? ?? const [])
        .map((item) => parser(Map<String, dynamic>.from(item as Map)))
        .toList(growable: false);

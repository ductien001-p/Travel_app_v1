class TripDestination {
  const TripDestination({
    required this.id,
    required this.tripId,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.order,
    required this.startDate,
    required this.endDate,
    this.destinationCatalogId,
    this.destinationType,
    this.highlights = const [],
    this.coverImageUrl,
    this.itineraryDays = const [],
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
  final String? destinationCatalogId;
  final String? destinationType;
  final List<String> highlights;
  final String? coverImageUrl;
  final List<Map<String, dynamic>> itineraryDays;

  factory TripDestination.fromJson(
    Map<String, dynamic> json, {
    String? fallbackTripId,
  }) {
    return TripDestination(
      id: json['id'] as String,
      tripId: (json['tripId'] as String?) ?? fallbackTripId ?? '',
      city: json['city'] as String,
      country: json['country'] as String,
      latitude: (json['lat'] as num).toDouble(),
      longitude: (json['lng'] as num).toDouble(),
      order: json['order'] as int,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      destinationCatalogId: json['destinationId'] as String?,
      destinationType: json['destinationType'] as String?,
      highlights: (json['highlights'] as List? ?? const [])
          .map((item) => item as String)
          .toList(growable: false),
      coverImageUrl: json['coverImageUrl'] as String?,
      itineraryDays: (json['itineraryDays'] as List? ?? const [])
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList(growable: false),
    );
  }
}

class TripDestinationInput {
  const TripDestinationInput({
    required this.country,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.order,
    required this.startDate,
    required this.endDate,
    this.destinationId,
  });

  final String country;
  final String city;
  final double latitude;
  final double longitude;
  final int order;
  final DateTime startDate;
  final DateTime endDate;
  final String? destinationId;

  Map<String, dynamic> toJson() => {
    if (destinationId != null) 'destinationId': destinationId,
    'country': country,
    'city': city,
    'lat': latitude,
    'lng': longitude,
    'order': order,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
  };
}

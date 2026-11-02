class TripCreationUser {
  const TripCreationUser({
    required this.id,
    required this.username,
    required this.displayName,
    this.avatarId,
  });

  final String id;
  final String username;
  final String displayName;
  final String? avatarId;

  factory TripCreationUser.fromJson(Map<String, dynamic> json) =>
      TripCreationUser(
        id: json['id'] as String,
        username: json['username'] as String,
        displayName: (json['displayname'] ?? json['displayName']) as String,
        avatarId: json['avatarId'] as String?,
      );
}

class CompanionRecommendation {
  const CompanionRecommendation({
    required this.user,
    required this.tripsTogetherCount,
    this.invitationStatus,
  });

  final TripCreationUser user;
  final int tripsTogetherCount;
  final String? invitationStatus;

  factory CompanionRecommendation.fromJson(Map<String, dynamic> json) =>
      CompanionRecommendation(
        user: TripCreationUser.fromJson(
          Map<String, dynamic>.from(json['user'] as Map),
        ),
        tripsTogetherCount: (json['tripsTogetherCount'] as num).toInt(),
        invitationStatus: json['invitationStatus'] as String?,
      );
}

class DestinationCatalogItem {
  const DestinationCatalogItem({
    required this.id,
    required this.name,
    required this.country,
    required this.lat,
    required this.lng,
    required this.highlights,
    this.type,
    this.coverImageUrl,
  });

  final String id;
  final String name;
  final String country;
  final double lat;
  final double lng;
  final String? type;
  final List<String> highlights;
  final String? coverImageUrl;

  factory DestinationCatalogItem.fromJson(Map<String, dynamic> json) =>
      DestinationCatalogItem(
        id: json['id'] as String,
        name: json['name'] as String,
        country: json['country'] as String,
        lat: (json['lat'] as num).toDouble(),
        lng: (json['lng'] as num).toDouble(),
        type: json['type'] as String?,
        highlights: (json['highlights'] as List? ?? const [])
            .map((item) => item as String)
            .toList(growable: false),
        coverImageUrl: json['coverImageUrl'] as String?,
      );
}

class PlanningPlace {
  const PlanningPlace({
    required this.id,
    required this.name,
    required this.category,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.reviewCount,
    required this.distanceKm,
    this.description,
    this.averageRating,
    this.thumbnailUrl,
  });

  final String id;
  final String name;
  final String category;
  final String? description;
  final String address;
  final double latitude;
  final double longitude;
  final double? averageRating;
  final int reviewCount;
  final String? thumbnailUrl;
  final double distanceKm;

  factory PlanningPlace.fromJson(Map<String, dynamic> json) => PlanningPlace(
    id: json['id'] as String,
    name: json['name'] as String,
    category: json['category'] as String,
    description: json['description'] as String?,
    address: json['address'] as String,
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    averageRating: (json['averageRating'] as num?)?.toDouble(),
    reviewCount: (json['reviewCount'] as num).toInt(),
    thumbnailUrl: json['thumbnailUrl'] as String?,
    distanceKm: (json['distanceKm'] as num).toDouble(),
  );
}

class CatalogPlacesResult {
  const CatalogPlacesResult({
    required this.items,
    required this.total,
    required this.categories,
  });

  final List<PlanningPlace> items;
  final int total;
  final List<String> categories;

  factory CatalogPlacesResult.fromJson(Map<String, dynamic> json) =>
      CatalogPlacesResult(
        items: (json['data'] as List)
            .map(
              (item) => PlanningPlace.fromJson(
                Map<String, dynamic>.from(item as Map),
              ),
            )
            .toList(growable: false),
        total: (json['total'] as num).toInt(),
        categories: (json['categories'] as List)
            .map((item) => item as String)
            .toList(growable: false),
      );
}

class RoutePreviewResult {
  const RoutePreviewResult({
    required this.available,
    this.distanceMeters,
    this.durationSeconds,
    this.polyline,
    this.unavailableReason,
  });

  final bool available;
  final int? distanceMeters;
  final int? durationSeconds;
  final String? polyline;
  final String? unavailableReason;

  factory RoutePreviewResult.fromJson(Map<String, dynamic> json) =>
      RoutePreviewResult(
        available: json['available'] as bool,
        distanceMeters: (json['distanceMeters'] as num?)?.toInt(),
        durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
        polyline: json['polyline'] as String?,
        unavailableReason: json['unavailableReason'] as String?,
      );
}

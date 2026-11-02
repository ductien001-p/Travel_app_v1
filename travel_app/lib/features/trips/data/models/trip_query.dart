import 'trip_enums.dart';

class TripQuery {
  const TripQuery({
    this.search,
    this.tripType,
    this.visibility,
    this.status,
    this.budgetLevel,
    this.ownerId,
    this.destinationCatalogId,
    this.discover,
    this.mine,
    this.page = 1,
    this.limit = 20,
  });

  final String? search;
  final TripType? tripType;
  final TripVisibility? visibility;
  final TripStatus? status;
  final TripBudgetLevel? budgetLevel;
  final String? ownerId;
  final String? destinationCatalogId;
  final bool? discover;

  /// When true, `GET /trips` returns only trips the caller owns or has joined.
  final bool? mine;
  final int page;
  final int limit;

  TripQuery copyWith({
    String? search,
    TripType? tripType,
    TripVisibility? visibility,
    TripStatus? status,
    TripBudgetLevel? budgetLevel,
    String? ownerId,
    String? destinationCatalogId,
    bool? discover,
    bool? mine,
    int? page,
    int? limit,
  }) => TripQuery(
    search: search ?? this.search,
    tripType: tripType ?? this.tripType,
    visibility: visibility ?? this.visibility,
    status: status ?? this.status,
    budgetLevel: budgetLevel ?? this.budgetLevel,
    ownerId: ownerId ?? this.ownerId,
    destinationCatalogId: destinationCatalogId ?? this.destinationCatalogId,
    discover: discover ?? this.discover,
    mine: mine ?? this.mine,
    page: page ?? this.page,
    limit: limit ?? this.limit,
  );

  Map<String, dynamic> toJson() => {
    if (search != null && search!.isNotEmpty) 'search': search,
    if (tripType != null) 'tripType': tripType!.wireValue,
    if (visibility != null) 'visibility': visibility!.wireValue,
    if (status != null) 'status': status!.wireValue,
    if (budgetLevel != null) 'budgetLevel': budgetLevel!.wireValue,
    if (ownerId != null) 'ownerId': ownerId,
    if (destinationCatalogId != null && destinationCatalogId!.isNotEmpty)
      'destinationCatalogId': destinationCatalogId,
    if (discover != null) 'discover': discover,
    if (mine == true) 'mine': true,
    'page': page,
    'limit': limit,
  };
}

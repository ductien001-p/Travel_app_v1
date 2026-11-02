class CreateTripDestinationRequest {
  final String? destinationId;
  final String city;
  final String country;
  final double latitude;
  final double longitude;
  final int order;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> pendingPlaceIds;

  const CreateTripDestinationRequest({
    this.destinationId,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.order,
    required this.startDate,
    required this.endDate,
    this.pendingPlaceIds = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      if (destinationId != null) 'destinationId': destinationId,
      'city': city,
      'country': country,
      'lat': latitude,
      'lng': longitude,
      'order': order,
      'startDate': _formatDate(startDate),
      'endDate': _formatDate(endDate),
      if (pendingPlaceIds.isNotEmpty) 'pendingPlaceIds': pendingPlaceIds,
    };
  }

  String _formatDate(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }
}

import 'explore_places_models.dart';
import 'place_explore_api_models.dart';

FeaturedPlace mapFeaturedPlace(FeaturedPlaceApi place) {
  final description = place.description?.trim();
  return FeaturedPlace(
    id: place.id,
    name: place.name,
    imageUrl: place.coverImageUrl?.trim() ?? '',
    categoryLabel: _categoryLabel(place.category),
    rating: place.averageRating,
    saveCountLabel: '${place.saveCount} lưu',
    locationLabel: place.address.trim().isEmpty ? place.city : place.address,
    tagline: description == null || description.isEmpty
        ? place.city
        : description,
    bookmarked: place.bookmarked,
  );
}

NearbyPlace mapNearbyPlace(NearbyPlaceApi place) {
  final walk = place.travelMode == 'walk';
  return NearbyPlace(
    id: place.id,
    name: place.name,
    imageUrl: place.coverImageUrl?.trim() ?? '',
    categoryLabel: _categoryLabel(place.category),
    rating: place.averageRating,
    reviewCountLabel: _compactCount(place.reviewCount),
    address: place.address,
    distanceLabel: _distanceLabel(place.distanceMeters),
    travelLabel: '${place.travelMinutes} phút ${walk ? 'đi bộ' : 'lái xe'}',
    travelMode: walk ? NearbyTravelMode.walk : NearbyTravelMode.drive,
  );
}

PlaceCollection mapFeaturedCollection(FeaturedCollectionApi collection) {
  final rating = collection.averageRating;
  return PlaceCollection(
    id: collection.id,
    title: collection.title,
    eyebrow: collection.ownerDisplayName,
    imageUrl: collection.coverImageUrl?.trim() ?? '',
    countLabel: '${collection.placeCount} địa điểm',
    tone: rating != null && rating >= 4.5
        ? PlaceCollectionTone.trend
        : PlaceCollectionTone.summer,
  );
}

String _categoryLabel(String category) {
  return category.trim().replaceAll('_', ' ');
}

String _compactCount(int count) {
  if (count >= 1000) {
    final thousands = count / 1000;
    final text = thousands >= 10
        ? thousands.toStringAsFixed(0)
        : thousands.toStringAsFixed(1);
    return '${text}k';
  }
  return '$count';
}

String _distanceLabel(int meters) {
  if (meters < 1000) return '$meters m';
  final kilometers = meters / 1000;
  final text = kilometers >= 10
      ? kilometers.toStringAsFixed(0)
      : kilometers.toStringAsFixed(1);
  return '$text km';
}

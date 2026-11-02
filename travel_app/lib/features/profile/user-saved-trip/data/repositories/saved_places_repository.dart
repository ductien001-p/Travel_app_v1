import '../datasources/saved_places_datasource.dart';
import '../models/saved_places_models.dart';
import 'package:travel_frontend_v1/features/home/places/data/models/place_explore_api_models.dart';

class SavedPlacesRepository {
  const SavedPlacesRepository({required SavedPlacesDataSource dataSource})
    : _dataSource = dataSource;

  final SavedPlacesDataSource _dataSource;

  Future<SavedPlacesPage> getMine({int page = 1, int limit = 20}) {
    return _dataSource.getMine(page: page, limit: limit);
  }

  Future<int> getCount() => _dataSource.getCount();

  Future<void> unsave(String placeId) => _dataSource.unsave(placeId);

  Future<List<OwnedPlaceCollection>> listCollections() {
    return _dataSource.listCollections();
  }

  Future<PlaceCollectionDetail> getCollection(String id) {
    return _dataSource.getCollection(id);
  }

  Future<OwnedPlaceCollection> createCollection(String title) {
    return _dataSource.createCollection(title);
  }
}

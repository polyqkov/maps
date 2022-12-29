import '../../data/models/place_model.dart';

abstract class LocalRepository {
  Future<void> addPlace(PlaceModel placeModel);
  Future<List<PlaceModel?>?> getPlaces();
}

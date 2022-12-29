import '../../data/models/place_model.dart';
import 'local_storage_repository.dart';

class LocalService {
  final LocalRepository repository;

  LocalService(this.repository);

  Future<void> addPlace(PlaceModel placeModel) async {
    repository.addPlace(placeModel);
  }

  Future<List<PlaceModel?>?> getPlaces() async {
    return repository.getPlaces();
  }
}

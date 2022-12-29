import 'package:latlong2/latlong.dart';

import '../../data/models/place_model.dart';
import 'api_repository.dart';

class ApiService {
  final ApiRepository repository;

  ApiService(this.repository);

  Future<PlaceModel?> getAddress(LatLng? position) async {
    return repository.getAddress(position);
  }

  Future<PlaceModel?> getPlaces(String address) async {
    return repository.getPlaces(address);
  }
}

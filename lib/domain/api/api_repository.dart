import 'package:latlong2/latlong.dart';

import '../../data/models/place_model.dart';

abstract class ApiRepository {
  Future<PlaceModel?> getAddress(LatLng? position);
  Future<PlaceModel?> getPlaces(String address);
}

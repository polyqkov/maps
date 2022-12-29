import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';
import 'package:maps/data/models/place_model.dart';
import 'package:maps/domain/api/api_repository.dart';
import 'package:maps/map_url.dart';

class ApiRepositoryImpl implements ApiRepository {
  final _dio = Dio();

  @override
  Future<PlaceModel?> getAddress(LatLng? position) async {
    if (position != null) {
      try {
        var response = await _dio.get(
            'https://api.mapbox.com/geocoding/v5/mapbox.places/${position.longitude},${position.latitude}.json?limit=1&access_token=${MapCredentials.token}');

        return PlaceModel.fromJson(response.data);
      } on DioError {
        return null;
      }
    }
    return null;
  }

  @override
  Future<PlaceModel?> getPlaces(String address) async {
    try {
      var response = await _dio.get(
          'https://api.mapbox.com/geocoding/v5/mapbox.places/$address.json?limit=5&types=address%2Cregion%2Cpoi&access_token=${MapCredentials.token}');

      return PlaceModel.fromJson(response.data);
    } on DioError {
      return null;
    }
  }
}

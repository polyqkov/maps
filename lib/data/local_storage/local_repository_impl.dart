import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/local_storage/local_storage_repository.dart';
import '../models/place_model.dart';

class LocalRepositoryImpl implements LocalRepository {
  @override
  Future<void> addPlace(PlaceModel placeModel) async {
    var box = await Hive.openBox('places');
    List<dynamic>? places = box.get('places');
    places ??= [];
    places.add(json.encode(placeModel.toJson()));
    box.put('places', places);
    await box.close();
  }

  @override
  Future<List<PlaceModel?>?> getPlaces() async {
    var box = await Hive.openBox('places');

    return (box.get('places') as List<dynamic>?)
        ?.map((e) => PlaceModel.fromJson(json.decode(e.toString())))
        .toList();
  }
}

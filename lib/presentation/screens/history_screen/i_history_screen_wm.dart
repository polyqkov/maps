import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/models/place_model.dart';

abstract class IHistoryWM extends IWidgetModel {
  MapController get mapController;
  EdgeInsets get mediaQueryPadding;
  MediaQueryData get mediaQuery;
  ColorScheme get colorScheme;
  String get mapUrl;
  ListenableState<EntityState<List>> get displayCoordinatesNotifier;
  ListenableState<EntityState<List<PlaceModel?>?>> get placesNotifier;

  void Function(LatLng) get onTapMarker;
  void Function() get onTapBackButton;
}

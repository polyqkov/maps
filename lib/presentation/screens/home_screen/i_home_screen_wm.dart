import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/models/place_model.dart';

abstract class IHomeWM extends IWidgetModel {
  TextEditingController get addressEditingController;
  String get mapUrl;
  EdgeInsets get mediaQueryPadding;
  MediaQueryData get mediaQuery;
  Position? get userPosition;
  ListenableState<EntityState<LatLng?>> get currentPositionNotifier;
  ListenableState<EntityState<PlaceModel?>> get currentAddressNotifier;
  ListenableState<EntityState<bool>> get displayCoordinatesNotifier;
  MapController get mapController;
  ColorScheme get colorScheme;

  void Function() get onTapLocationButton;
  void Function() get onTapHistoryButton;
  void Function() get onTapAddressTextField;
  void Function() get onTapMarker;
  void Function(MapPosition, bool) get onMapPositionChanged;
}

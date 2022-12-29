import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/models/place_model.dart';

abstract class ISearchWM extends IWidgetModel {
  TextEditingController get addressEditingController;
  EdgeInsets get mediaQueryPadding;
  ListenableState<EntityState<PlaceModel?>> get placesNotifier;
  ColorScheme get colorScheme;

  void Function() get onTapBackButton;
  void Function(LatLng) get onTapPlaceItem;
  void Function(String) get onSearchTextChanged;
}

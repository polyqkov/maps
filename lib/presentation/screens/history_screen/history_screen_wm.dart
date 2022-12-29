import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:vrouter/vrouter.dart';

import '../../../data/local_storage/local_repository_impl.dart';
import '../../../data/models/place_model.dart';
import '../../../domain/local_storage/local_storage_service.dart';
import '../../../map_url.dart';
import '../../common/app_color_scheme_helper.dart';
import 'history_screen_model.dart';
import 'history_screen_view.dart';
import 'i_history_screen_wm.dart';

class HistoryScreenWM extends WidgetModel<HistoryScreenView, HistoryScreenModel>
    implements IHistoryWM {
  HistoryScreenWM(HistoryScreenModel model) : super(model);

  late MapController _mapController;
  final EntityStateNotifier<List> _displayCoordinatesNotifier =
      EntityStateNotifier(null);
  final EntityStateNotifier<List<PlaceModel?>?> _placesNotifier =
      EntityStateNotifier(null);

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    _mapController = MapController();
    _getPlaces();
  }

  @override
  String get mapUrl => MapCredentials.url;
  @override
  EdgeInsets get mediaQueryPadding => MediaQuery.of(context).padding;
  @override
  MediaQueryData get mediaQuery => MediaQuery.of(context);
  @override
  MapController get mapController => _mapController;
  @override
  ColorScheme get colorScheme => AppColorSchemeHelper.getColorScheme(context);
  @override
  ListenableState<EntityState<List>> get displayCoordinatesNotifier =>
      _displayCoordinatesNotifier;
  @override
  ListenableState<EntityState<List<PlaceModel?>?>> get placesNotifier =>
      _placesNotifier;

  @override
  void Function() get onTapBackButton => _onTapBackButton;
  @override
  void Function(LatLng) get onTapMarker => _onTapMarker;

  void _onTapBackButton() {
    context.vRouter.pop();
  }

  Future<void> _getPlaces() async {
    _placesNotifier.loading();
    final localRepository = LocalRepositoryImpl();
    final localService = LocalService(localRepository);
    _placesNotifier.content(await localService.getPlaces());
  }

  void _onTapMarker(LatLng coords) {
    _displayCoordinates(coords);
  }

  Future<void> _displayCoordinates(LatLng coords) async {
    _displayCoordinatesNotifier.content([true, coords]);
    await Future.delayed(const Duration(seconds: 2));
    _displayCoordinatesNotifier.content([false]);
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}

HistoryScreenWM createHistoryScreenWM(BuildContext context) =>
    HistoryScreenWM(HistoryScreenModel());

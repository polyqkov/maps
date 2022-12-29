import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vrouter/vrouter.dart';

import '../../../data/api/api_repository_impl.dart';
import '../../../data/local_storage/local_repository_impl.dart';
import '../../../data/models/place_model.dart';
import '../../../domain/api/api_service.dart';
import '../../../domain/local_storage/local_storage_service.dart';
import '../../../map_url.dart';
import '../../app_navigation/routes/app_routes.dart';
import '../../common/app_color_scheme_helper.dart';
import 'home_screen_model.dart';
import 'home_screen_view.dart';
import 'i_home_screen_wm.dart';

LatLng? positionGlobal;

class HomeScreenWM extends WidgetModel<HomeScreenView, HomeScreenModel>
    implements IHomeWM {
  HomeScreenWM(HomeScreenModel model) : super(model);

  late TextEditingController _addressEditingController;
  late MapController _mapController;
  final EntityStateNotifier<LatLng?> _currentPositionNotifier =
      EntityStateNotifier(null);
  final EntityStateNotifier<PlaceModel?> _currentAddressNotifier =
      EntityStateNotifier(null);
  final EntityStateNotifier<bool> _displayCoordinatesNotifier =
      EntityStateNotifier(null);
  Timer? _timer;
  Position? _userPosition;

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    _addressEditingController = TextEditingController();
    _mapController = MapController();
    _getLocation();
  }

  @override
  String get mapUrl => MapCredentials.url;
  @override
  EdgeInsets get mediaQueryPadding => MediaQuery.of(context).padding;
  @override
  MediaQueryData get mediaQuery => MediaQuery.of(context);
  @override
  TextEditingController get addressEditingController =>
      _addressEditingController;
  @override
  ListenableState<EntityState<LatLng?>> get currentPositionNotifier =>
      _currentPositionNotifier;
  @override
  ListenableState<EntityState<PlaceModel?>> get currentAddressNotifier =>
      _currentAddressNotifier;
  @override
  ListenableState<EntityState<bool>> get displayCoordinatesNotifier =>
      _displayCoordinatesNotifier;
  @override
  Position? get userPosition => _userPosition;
  @override
  MapController get mapController => _mapController;
  @override
  ColorScheme get colorScheme => AppColorSchemeHelper.getColorScheme(context);

  @override
  void Function() get onTapLocationButton => _onTapLocationButton;
  @override
  void Function() get onTapAddressTextField => _onTapAddressTextField;
  @override
  void Function(MapPosition position, bool hasGesture)
      get onMapPositionChanged => _onMapPositionChanged;
  @override
  void Function() get onTapMarker => _onTapMarker;
  @override
  void Function() get onTapHistoryButton => _onTapHistoryButton;

  void _onTapMarker() {
    _displayCoordinates();
  }

  void _onTapHistoryButton() {
    context.vRouter.to(AppRoutes.historyScreenRoute.path ?? '');
  }

  Future<void> _getLocation() async {
    if (await Permission.location.status.isGranted) {
      _currentAddressNotifier.loading();
      _userPosition = await Geolocator.getCurrentPosition();
      _mapController.move(
          LatLng(
              _userPosition?.latitude ?? 0.0, _userPosition?.longitude ?? 0.0),
          15);
      _mapController.rotate(0);
      _currentPositionNotifier.content(LatLng(
          _userPosition?.latitude ?? 0.0, _userPosition?.longitude ?? 0.0));
      _currentAddressNotifier.content(await _getAddress(LatLng(
          _userPosition?.latitude ?? 0.0, _userPosition?.longitude ?? 0.0)));
    } else {
      await Permission.location.request();
      if (!await Permission.location.status.isPermanentlyDenied) {
        _getLocation();
      }
    }
  }

  Future<void> _displayCoordinates() async {
    _displayCoordinatesNotifier.content(true);
    await Future.delayed(const Duration(seconds: 2));
    _displayCoordinatesNotifier.content(false);
  }

  Future<void> _onTapLocationButton() async {
    _getLocation();
  }

  void _onTapAddressTextField() {
    context.vRouter.to(AppRoutes.searchScreenRoute.path ?? '');
  }

  Future<void> _onMapPositionChanged(
      MapPosition position, bool hasGesture) async {
    _currentPositionNotifier.content(position.center);
    _currentAddressNotifier.loading();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) async {
      final place = await _getAddress(position.center);
      if (place != null) {
        await _addPlace(place);
      }
      _currentAddressNotifier.content(place);
      _timer?.cancel();
    });
  }

  Future<PlaceModel?> _getAddress(LatLng? position) async {
    final apiRepository = ApiRepositoryImpl();
    final apiService = ApiService(apiRepository);
    return apiService.getAddress(position);
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    final position = LatLng(
        positionGlobal?.longitude ?? 0.0, positionGlobal?.latitude ?? 0.0);
    if (positionGlobal != null) {
      _currentPositionNotifier.content(position);
      _currentAddressNotifier.content(await _getAddress(position));
      _mapController.move(position, 15);
    }
  }

  Future<void> _addPlace(PlaceModel placeModel) async {
    final localRepository = LocalRepositoryImpl();
    final localService = LocalService(localRepository);
    await localService.addPlace(placeModel);
  }

  @override
  void dispose() {
    _addressEditingController.dispose();
    _currentAddressNotifier.dispose();
    _currentPositionNotifier.dispose();
    _mapController.dispose();
    _timer?.cancel();
    super.dispose();
  }
}

HomeScreenWM createHomeScreenWM(BuildContext context) =>
    HomeScreenWM(HomeScreenModel());

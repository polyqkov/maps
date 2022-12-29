import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:vrouter/vrouter.dart';

import '../../../data/api/api_repository_impl.dart';
import '../../../data/local_storage/local_repository_impl.dart';
import '../../../data/models/place_model.dart';
import '../../../domain/api/api_service.dart';
import '../../../domain/local_storage/local_storage_service.dart';
import '../../common/app_color_scheme_helper.dart';
import '../home_screen/home_screen_wm.dart';
import 'i_search_screen_wm.dart';
import 'search_screen_model.dart';
import 'search_screen_view.dart';

class SearchScreenWM extends WidgetModel<SearchScreenView, SearchScreenModel>
    implements ISearchWM {
  SearchScreenWM(SearchScreenModel model) : super(model);

  late TextEditingController _addressEditingController;
  final EntityStateNotifier<PlaceModel?> _placesNotifier =
      EntityStateNotifier(null);

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();

    _addressEditingController = TextEditingController();
  }

  @override
  EdgeInsets get mediaQueryPadding => MediaQuery.of(context).padding;
  @override
  TextEditingController get addressEditingController =>
      _addressEditingController;
  @override
  ListenableState<EntityState<PlaceModel?>> get placesNotifier =>
      _placesNotifier;
  @override
  ColorScheme get colorScheme => AppColorSchemeHelper.getColorScheme(context);

  @override
  void Function() get onTapBackButton => _onTapBackButton;
  @override
  void Function(String value) get onSearchTextChanged => _onSearchTextChanged;
  @override
  void Function(LatLng coordinates) get onTapPlaceItem => _onTapPlaceItem;

  Future<void> _onTapPlaceItem(LatLng coordinates) async {
    context.vRouter.pop();
    positionGlobal = coordinates;
  }

  void _onTapBackButton() {
    context.vRouter.pop();
  }

  Future<void> _onSearchTextChanged(value) async {
    _placesNotifier.loading();
    final PlaceModel? placeModel = await _getPlaces(value);
    if (placeModel != null) {
      _addPlace(placeModel);
    }
    _placesNotifier.content(placeModel);
  }

  void _addPlace(PlaceModel placeModel) {
    final localRepository = LocalRepositoryImpl();
    final localService = LocalService(localRepository);
    localService.addPlace(placeModel);
  }

  Future<PlaceModel?> _getPlaces(String address) {
    final apiRepository = ApiRepositoryImpl();
    final apiService = ApiService(apiRepository);
    return apiService.getPlaces(address);
  }
}

SearchScreenWM createSearchScreenWM(BuildContext context) =>
    SearchScreenWM(SearchScreenModel());

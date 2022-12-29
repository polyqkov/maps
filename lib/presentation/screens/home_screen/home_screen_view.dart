import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:maps/presentation/common/app_border_grade.dart';
import 'package:maps/presentation/common/app_border_shape.dart';
import 'package:maps/presentation/widgets/animates/app_tap_animate.dart';

import '../../common/app_icons.dart';
import '../../common/app_offset_box.dart';
import '../../common/app_padding_grade.dart';
import '../../common/app_shadows.dart';
import '../../common/app_text_styles.dart';
import '../../widgets/animates/wave_dots.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_textfield.dart';
import '../../widgets/buttons/app_icon_button.dart';
import 'home_screen_wm.dart';
import 'i_home_screen_wm.dart';

class HomeScreenView extends ElementaryWidget<IHomeWM> {
  const HomeScreenView({
    Key? key,
    WidgetModelFactory<HomeScreenWM> wmFactory = createHomeScreenWM,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IHomeWM wm) {
    return AppScaffold(
      child: Stack(
        children: [
          EntityStateNotifierBuilder(
            listenableEntityState: wm.currentPositionNotifier,
            builder: (_, position) => FlutterMap(
              mapController: wm.mapController,
              options: MapOptions(
                minZoom: 5,
                maxZoom: 19,
                keepAlive: true,
                onPositionChanged: wm.onMapPositionChanged,
                interactiveFlags:
                    InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              ),
              children: [
                TileLayer(
                  urlTemplate: wm.mapUrl,
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      height: 40,
                      width: 40,
                      point: LatLng(position?.latitude ?? 0.0,
                          position?.longitude ?? 0.0),
                      builder: (_) {
                        return AppTapAnimate(
                          onTap: wm.onTapMarker,
                          child: const Icon(
                            Icons.location_on_rounded,
                            size: 50,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                EntityStateNotifierBuilder(
                  listenableEntityState: wm.displayCoordinatesNotifier,
                  builder: (_, display) => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: display ?? false
                        ? EntityStateNotifierBuilder(
                            listenableEntityState: wm.currentAddressNotifier,
                            builder: (_, address) => Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 150, left: 36, right: 36),
                              child: Center(
                                child: Container(
                                  decoration: ShapeDecoration(
                                      color: wm.colorScheme.primary,
                                      shape: AppBorderShape.getShape(
                                          cornerRadius:
                                              AppBorderGrade.smallBorder)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Coordinates\nLatitude: ${position?.latitude}\nLongitude: ${position?.longitude}',
                                      style: AppTextStyle.subheadRegular
                                          .copyWith(
                                              color: wm.colorScheme.onPrimary),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ),
                ),
              ],
            ),
          ),
          EntityStateNotifierBuilder(
            listenableEntityState: wm.currentAddressNotifier,
            builder: (_, address) => Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  top:
                      wm.mediaQueryPadding.top + AppPaddingGrade.regularPadding,
                  left: AppPaddingGrade.regularPadding,
                  right: AppPaddingGrade.regularPadding,
                ),
                child: Text(
                  address?.features?.first.placeName ?? '',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bodySemibold.copyWith(
                    color: wm.colorScheme.primary,
                  ),
                ),
              ),
            ),
            loadingBuilder: (context, data) => Padding(
              padding: EdgeInsets.only(
                top: wm.mediaQueryPadding.top + AppPaddingGrade.regularPadding,
                left: AppPaddingGrade.regularPadding,
                right: AppPaddingGrade.regularPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WaveDots(
                    color: wm.colorScheme.primary,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom:
                  wm.mediaQueryPadding.bottom + AppPaddingGrade.regularPadding,
              left: AppPaddingGrade.regularPadding,
              right: AppPaddingGrade.regularPadding,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIconButton(
                      icon: AppIcons.time,
                      onTap: wm.onTapHistoryButton,
                    ),
                    AppIconButton(
                      icon: AppIcons.location,
                      onTap: wm.onTapLocationButton,
                    ),
                  ],
                ),
                AppOffsetBox.heightRegularBox,
                AppTextfield(
                  onTap: wm.onTapAddressTextField,
                  enabled: false,
                  shadows: [AppShadows.regularShadow],
                  hintText: 'Search',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../common/app_border_grade.dart';
import '../../common/app_border_shape.dart';
import '../../common/app_icons.dart';
import '../../common/app_padding_grade.dart';
import '../../common/app_text_styles.dart';
import '../../widgets/animates/app_tap_animate.dart';
import '../../widgets/app_scaffold.dart';
import 'history_screen_wm.dart';
import 'i_history_screen_wm.dart';

class HistoryScreenView extends ElementaryWidget<IHistoryWM> {
  const HistoryScreenView({
    Key? key,
    WidgetModelFactory<HistoryScreenWM> wmFactory = createHistoryScreenWM,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IHistoryWM wm) {
    return AppScaffold(
      child: Stack(
        children: [
          FlutterMap(
            mapController: wm.mapController,
            options: MapOptions(
              minZoom: 5,
              maxZoom: 19,
              zoom: 5,
              keepAlive: true,
              interactiveFlags:
                  InteractiveFlag.pinchZoom | InteractiveFlag.drag,
            ),
            children: [
              TileLayer(
                urlTemplate: wm.mapUrl,
              ),
              EntityStateNotifierBuilder(
                listenableEntityState: wm.placesNotifier,
                builder: (_, places) => MarkerLayer(
                  markers: [
                    ...?places?.map((place) {
                      try {
                        return Marker(
                          height: 40,
                          width: 40,
                          point: place != null
                              ? place.features != null
                                  ? place.features?.first.geometry
                                              ?.coordinates !=
                                          null
                                      ? LatLng(
                                          place.features?.first.geometry
                                                  ?.coordinates?[1] ??
                                              0.0,
                                          place.features?.first.geometry
                                                  ?.coordinates?[0] ??
                                              0.0)
                                      : LatLng(0.0, 0.0)
                                  : LatLng(0.0, 0.0)
                              : LatLng(0.0, 0.0),
                          builder: (_) {
                            return AppTapAnimate(
                              onTap: () {
                                wm.onTapMarker(LatLng(
                                    place?.features?.first.geometry
                                            ?.coordinates?[1] ??
                                        0.0,
                                    place?.features?.first.geometry
                                            ?.coordinates?[0] ??
                                        0.0));
                              },
                              child: const Icon(
                                Icons.location_on_rounded,
                                size: 50,
                              ),
                            );
                          },
                        );
                      } catch (e) {
                        return Marker(
                          height: 0,
                          width: 0,
                          point: LatLng(0.0, 0.0),
                          builder: (_) {
                            return const Icon(null);
                          },
                        );
                      }
                    }),
                  ],
                ),
                errorBuilder: (context, e, data) => Text(e.toString()),
                loadingBuilder: (context, data) =>
                    const Center(child: CupertinoActivityIndicator()),
              ),
              EntityStateNotifierBuilder(
                listenableEntityState: wm.displayCoordinatesNotifier,
                builder: (_, display) => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: display?.first ?? false
                      ? Padding(
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
                                  'Coordinates\nLatitude: ${display?[1].latitude}\nLongitude: ${display?[1].longitude}',
                                  style: AppTextStyle.subheadRegular.copyWith(
                                      color: wm.colorScheme.onPrimary),
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
          Padding(
            padding: EdgeInsets.only(
              top: wm.mediaQueryPadding.top + AppPaddingGrade.regularPadding,
              left: AppPaddingGrade.regularPadding,
              right: AppPaddingGrade.regularPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTapAnimate(
                  onTap: wm.onTapBackButton,
                  child: const Icon(AppIcons.arrowLeft),
                ),
                Text(
                  'History',
                  style: AppTextStyle.title3Semibold.copyWith(
                    color: wm.colorScheme.primary,
                  ),
                ),
                const Icon(null),
              ],
            ),
          )
        ],
      ),
    );
  }
}

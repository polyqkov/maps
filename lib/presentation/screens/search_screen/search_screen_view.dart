import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

import '../../common/app_icons.dart';
import '../../common/app_offset_box.dart';
import '../../common/app_padding_grade.dart';
import '../../widgets/animates/app_tap_animate.dart';
import '../../widgets/app_place_list_item.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_textfield.dart';
import 'i_search_screen_wm.dart';
import 'search_screen_wm.dart';

class SearchScreenView extends ElementaryWidget<ISearchWM> {
  const SearchScreenView({
    Key? key,
    WidgetModelFactory<SearchScreenWM> wmFactory = createSearchScreenWM,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISearchWM wm) {
    return AppScaffold(
      paddingTop: wm.mediaQueryPadding.top,
      paddingLeft: AppPaddingGrade.regularPadding,
      paddingRight: AppPaddingGrade.regularPadding,
      child: Column(
        children: [
          AppOffsetBox.heightRegularBox,
          Row(
            children: [
              AppTapAnimate(
                onTap: wm.onTapBackButton,
                child: const Icon(AppIcons.arrowLeft),
              ),
              AppOffsetBox.widthRegularBox,
              Expanded(
                child: AppTextfield(
                  controller: wm.addressEditingController,
                  hintText: 'Search',
                  autofocus: true,
                  onChanged: wm.onSearchTextChanged,
                  keyboardType: TextInputType.streetAddress,
                ),
              ),
            ],
          ),
          EntityStateNotifierBuilder(
            listenableEntityState: wm.placesNotifier,
            builder: (_, places) => Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.only(top: AppPaddingGrade.smallPadding),
                children: [
                  ...?places?.features?.map(
                    (place) => AppPlaceListItem(
                      onTap: () {
                        wm.onTapPlaceItem(place.geometry?.coordinates != null
                            ? LatLng(place.geometry?.coordinates![0] ?? 0.0,
                                place.geometry?.coordinates![1] ?? 0.0)
                            : LatLng(0.0, 0.0));
                      },
                      title: place.text ?? '',
                      subTitle: place.placeName,
                    ),
                  ),
                ],
              ),
            ),
            loadingBuilder: (context, data) =>
                const Expanded(child: CupertinoActivityIndicator()),
          ),
        ],
      ),
    );
  }
}

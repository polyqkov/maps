import 'package:flutter/material.dart';
import 'package:maps/presentation/widgets/animates/app_tap_animate.dart';

import '../common/app_offset_box.dart';
import '../common/app_padding_grade.dart';
import '../common/app_text_styles.dart';

class AppPlaceListItem extends StatelessWidget {
  const AppPlaceListItem({
    Key? key,
    required this.title,
    required this.subTitle,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String? subTitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AppTapAnimate(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          top: AppPaddingGrade.smallPadding,
          bottom: AppPaddingGrade.smallPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyle.bodySemibold,
            ),
            AppOffsetBox.heightSmallBox,
            Text(
              subTitle ?? '',
              style: AppTextStyle.calloutMedium,
            ),
            AppOffsetBox.heightSmallBox,
            const Divider(),
          ],
        ),
      ),
    );
  }
}

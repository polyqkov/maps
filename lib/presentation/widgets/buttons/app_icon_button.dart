import 'package:flutter/material.dart';
import 'package:maps/presentation/common/app_shadows.dart';

import '../../common/app_border_grade.dart';
import '../../common/app_border_shape.dart';
import '../../common/app_color_scheme_helper.dart';
import '../animates/app_tap_animate.dart';

class AppIconButton extends StatefulWidget {
  const AppIconButton({
    Key? key,
    required this.icon,
    this.size,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final double? size;
  final void Function()? onTap;

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  @override
  Widget build(BuildContext context) {
    return AppTapAnimate(
      onTap: widget.onTap,
      pressedScale: 0.95,
      isButton: true,
      child: Container(
        decoration: ShapeDecoration(
          color: AppColorSchemeHelper.getColorScheme(context).secondary,
          shape: AppBorderShape.getShape(
              cornerRadius: AppBorderGrade.regularBorder),
          shadows: [AppShadows.regularShadow],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          child: Center(
            child: Icon(
              widget.icon,
              size: widget.size,
              color: AppColorSchemeHelper.getColorScheme(context).primary,
            ),
          ),
        ),
      ),
    );
  }
}

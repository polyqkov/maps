import 'package:flutter/material.dart';

import '../common/app_border_grade.dart';
import '../common/app_border_shape.dart';
import '../common/app_color_scheme_helper.dart';
import '../common/app_text_styles.dart';

class AppTextfield extends StatefulWidget {
  const AppTextfield({
    Key? key,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.textAlign,
    this.hintText,
    this.maxLength,
    this.autofocus,
    this.autofillHints,
    this.onTap,
    this.enabled = true, this.shadows,
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final TextAlign? textAlign;
  final String? hintText;
  final int? maxLength;
  final bool? autofocus;
  final Iterable<String>? autofillHints;
  final void Function()? onTap;
  final bool enabled;
  final List<BoxShadow>? shadows;

  @override
  State<AppTextfield> createState() => _AppTextfieldState();
}

class _AppTextfieldState extends State<AppTextfield> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 55,
        decoration: ShapeDecoration(
          color: AppColorSchemeHelper.getColorScheme(context).secondary,
          shape:
              AppBorderShape.getShape(cornerRadius: AppBorderGrade.smallBorder),
          shadows: widget.shadows,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: TextFormField(
            controller: widget.controller,
            autofillHints: widget.autofillHints,
            autofocus: widget.autofocus ?? false,
            maxLength: widget.maxLength,
            keyboardType: widget.keyboardType,
            textAlign: widget.textAlign ?? TextAlign.start,
            style: AppTextStyle.bodyRegular.copyWith(
              color: AppColorSchemeHelper.getColorScheme(context).primary,
            ),
            enabled: widget.enabled,
            textAlignVertical: TextAlignVertical.bottom,
            onChanged: widget.onChanged,
            cursorHeight: 20,
            decoration: InputDecoration(
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              hintText: (widget.hintText ?? ''),
              contentPadding: const EdgeInsets.only(bottom: 15),
              hintStyle: AppTextStyle.bodyRegular.copyWith(
                color: AppColorSchemeHelper.getColorScheme(context).tertiary,
              ),
              counterText: '',
            ),
          ),
        ),
      ),
    );
  }
}

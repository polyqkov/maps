import 'package:figma_squircle/figma_squircle.dart';

class AppBorderShape {
  static const double _kCornerSmoothing = 0.6;

  static getShape({required double cornerRadius}) {
    return SmoothRectangleBorder(
      borderRadius: SmoothBorderRadius.only(
        topLeft: SmoothRadius(
          cornerRadius: cornerRadius,
          cornerSmoothing: _kCornerSmoothing,
        ),
        topRight: SmoothRadius(
          cornerRadius: cornerRadius,
          cornerSmoothing: _kCornerSmoothing,
        ),
        bottomLeft: SmoothRadius(
          cornerRadius: cornerRadius,
          cornerSmoothing: _kCornerSmoothing,
        ),
        bottomRight: SmoothRadius(
          cornerRadius: cornerRadius,
          cornerSmoothing: _kCornerSmoothing,
        ),
      ),
    );
  }
}

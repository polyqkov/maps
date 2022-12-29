import 'package:flutter/widgets.dart';

class AppMediaQueryPaddingHelper {
  static EdgeInsets getPadding(BuildContext context) =>
      MediaQuery.of(context).padding;
}

import 'package:flutter/widgets.dart';

import 'app_colors.dart';

class AppShadows {
  static final regularShadow = BoxShadow(
    color: AppColors.systemGray06Dark.withOpacity(0.1),
    blurRadius: 15,
  );
}

import 'package:flutter/widgets.dart';
import 'package:maps/presentation/screens/history_screen/history_screen_view.dart';
import 'package:vrouter/vrouter.dart';

import '../../screens/home_screen/home_screen_view.dart';
import '../../screens/search_screen/search_screen_view.dart';

class AppRoutes {
  static final homeScreenRoute = VWidget(
    path: '/home_screen',
    widget: const HomeScreenView(),
    stackedRoutes: [searchScreenRoute, historyScreenRoute],
  );
  static final searchScreenRoute = VWidget(
    path: 'search_screen',
    widget: const SearchScreenView(),
    buildTransition: (animation1, _, child) => SlideTransition(
        position: animation1
            .drive(Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)),
        child: child),
  );
  static final historyScreenRoute = VWidget(
    path: 'history_screen',
    widget: const HistoryScreenView(),
    buildTransition: (animation1, _, child) => SlideTransition(
        position: animation1
            .drive(Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)),
        child: child),
  );
}

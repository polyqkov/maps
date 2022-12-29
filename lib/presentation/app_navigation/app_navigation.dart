import 'package:vrouter/vrouter.dart';

import 'i_app_navigation.dart';
import 'routes/app_routes.dart';

class AppNavigation implements IAppNavigation {
  final List<VRouteElement> _router = [AppRoutes.homeScreenRoute];

  @override
  get router => _router;
}

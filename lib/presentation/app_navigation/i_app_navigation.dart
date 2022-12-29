import 'package:vrouter/vrouter.dart';

abstract class IAppNavigation {
  final List<VRouteElement> router;

  IAppNavigation(this.router);
}

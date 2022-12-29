import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vrouter/vrouter.dart';

import 'presentation/app_navigation/app_navigation.dart';
import 'presentation/app_navigation/routes/app_routes.dart';
import 'presentation/common/app_themes.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  ));

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VRouter(
      initialUrl: AppRoutes.homeScreenRoute.path ?? '',
      debugShowCheckedModeBanner: false,
      mode: VRouterMode.history,
      routes: AppNavigation().router,
      theme: appLightTheme,
    );
  }
}

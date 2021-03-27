import 'package:bfit_tracker/controllers/bindings/auth_binding.dart';
import 'package:bfit_tracker/routes.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/home/home_screen.dart';
import 'package:bfit_tracker/ui/onboarding/onboarding_screen.dart';
import 'package:bfit_tracker/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:wiredash/wiredash.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      navigatorKey: this._navigatorKey,
      projectId: DotEnv().env['WIREDASH_PROJECT_ID'] ?? '',
      secret: DotEnv().env['WIREDASH_SECRET_KEY'] ?? '',
      child: GetMaterialApp(
        initialBinding: AuthBinding(),
        navigatorKey: this._navigatorKey,
        theme: mainTheme,
        debugShowCheckedModeBanner: false,
        unknownRoute:
            GetPage(name: Routes.NOT_FOUND, page: () => SplashScreenLoading()),
        initialRoute: '/',
        getPages: [
          GetPage(name: Routes.INITIAL, page: () => SplashScreenLoading(), binding: AuthBinding()),
          GetPage(name: Routes.ONBOARDING, page: () => OnboardingScreen()),
          GetPage(name: Routes.HOME, page: () => HomeScreen()),
        ],
      ),
    );
  }
}

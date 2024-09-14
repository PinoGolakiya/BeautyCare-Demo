import 'package:beuticare_app/core/routs/routes_name.dart';
import 'package:beuticare_app/core/utils/app_strings.dart';
import 'package:beuticare_app/screen_view/home_screen.dart';
import 'package:beuticare_app/screen_view/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == RoutesName.splashScreen) {}
    if (settings.name == RoutesName.homeScreen) {}
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RoutesName.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text(AppStrings.noRoutesDefined),
              ),
            );
          },
        );
    }
  }
}

import 'package:beuticare_app/core/routs/routes_name.dart';
import 'package:flutter/material.dart';

class SplashViewModel extends ChangeNotifier {


  /// Navigation next screen after 2 seconds
  navigationMethod(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.homeScreen, (route) => false);
    });
  }
}

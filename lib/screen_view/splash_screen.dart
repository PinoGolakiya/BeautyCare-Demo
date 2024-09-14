import 'package:beuticare_app/core/utils/app_images.dart';
import 'package:beuticare_app/core/utils/app_strings.dart';
import 'package:beuticare_app/provider_model/splash_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// Call splash provider and move next screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashViewModel>().navigationMethod(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          top: false,
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.appLogo,
                  height: size.height * 0.40,
                ),
              ),
              const Text(
                AppStrings.beautyCareProducts,
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          )),
    );
  }
}

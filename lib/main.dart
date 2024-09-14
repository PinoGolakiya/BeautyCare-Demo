import 'package:beuticare_app/core/routs/app_routes.dart';
import 'package:beuticare_app/core/routs/routes_name.dart';
import 'package:beuticare_app/core/utils/app_colors.dart';
import 'package:beuticare_app/core/utils/app_strings.dart';
import 'package:beuticare_app/provider_model/home_view_model.dart';
import 'package:beuticare_app/provider_model/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        initialRoute: RoutesName.splashScreen,
        onGenerateRoute: Routes.generateRoute,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.darkColor,
          // Set the background color to black
          appBarTheme: const AppBarTheme(
            color: AppColors.whiteColor, //  Set AppBar color to black as well
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.darkColor, // Set seed color to black
            background:
                AppColors.darkColor, //  Set background color in ColorScheme
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: AppColors.whiteColor),
            // Set text color to white for visibility
            bodyMedium: TextStyle(
                color: AppColors
                    .whiteColor), // Set text color to white for visibility
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ibx_app/features/splash_screen/pages/splash_screen.dart';
import 'package:ibx_app/features/weather/presentation/pages/weather_page.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String homePage = '/home';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => const SplashScreen(),
    homePage: (context) => WeatherPage(),
  };
}

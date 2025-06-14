import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:KAS/screens/login_screen.dart';
import 'package:KAS/screens/main_screen.dart';
import 'package:KAS/screens/register_screen.dart';
import 'package:KAS/screens/splash_screen.dart';

class AppRoute {
  static const String splashScreen = "";
  static const String loginScreen = "loginScreen";
  static const String registerScreen = "registerScreen";
  static const String mainScreen = "mainScreen";

  static final key = GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splashScreen:
        return _buildRoute(routeSettings, SplashScreen());
      case loginScreen:
        return _buildRoute(routeSettings, LoginScreen());
      case registerScreen:
        return _buildRoute(routeSettings, RegisterScreen());
      case mainScreen:
        final email = routeSettings.arguments as String? ?? "";
        return _buildRoute(routeSettings, MainScreen(email: email));
      default:
        throw RouteException("Route not found: ${routeSettings.name}");
    }
  }

  static Route<dynamic> _buildRoute(
    RouteSettings routeSettings,
    Widget newScreen,
  ) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (BuildContext context) => newScreen,
    );
  }
}

class RouteException implements Exception {
  final String message;
  RouteException(this.message);
}

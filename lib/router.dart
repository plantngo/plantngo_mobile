import 'package:flutter/material.dart';
import 'package:plantngo_frontend/screens/login/signup_screen.dart';
import 'screens/all.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginSignUpScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const LoginSignUpScreen());

    case LoginScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const LoginScreen());

    case SignUpScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SignUpScreen());

    case ForgetPasswordScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const ForgetPasswordScreen());
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}

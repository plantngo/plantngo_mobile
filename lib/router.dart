import 'package:flutter/material.dart';
import 'package:plantngo_frontend/screens/login/signup_screen.dart';
import 'utils/all.dart';

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
    case CustomerApp.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CustomerApp());
    case MerchantApp.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const MerchantApp());
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

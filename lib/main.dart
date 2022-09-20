import 'package:flutter/material.dart';
import 'package:plantngo_frontend/screens/login/signup_screen.dart';
import 'screens/all.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Plant&Go',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff00aa58),
        useMaterial3: true,
        primaryColorDark: const Color(0xff00aa58),
      ),
      initialRoute: '/',
      routes: {
        LoginSignUpScreen.routeName: (context) => const LoginSignUpScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
      },
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:plantngo_frontend/app.dart';
import 'package:plantngo_frontend/screens/login/signup_screen.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/all.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Plant&Go',
        theme: ThemeData(
          colorSchemeSeed: const Color(0xff00aa58),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          LoginSignUpScreen.routeName: (context) =>
              context.watch<AuthProvider>().isLoggedIn
                  ? App()
                  : LoginSignUpScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          SignUpScreen.routeName: (context) => const SignUpScreen(),
        },
      ),
    ),
  );
}

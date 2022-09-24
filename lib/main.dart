import 'package:flutter/material.dart';
import 'package:plantngo_frontend/app.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'screens/all.dart';
import 'providers/user_provider.dart';
import 'router.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant&Go',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff00aa58),
        useMaterial3: true,
      ),
      onGenerateRoute: ((settings) => generateRoute(settings)),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.usertype == 'C'
              ? const App()
              : const Scaffold()
          : const LoginSignUpScreen(),
    );
  }
}

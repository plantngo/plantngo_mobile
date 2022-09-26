import 'package:flutter/material.dart';
import 'package:plantngo_frontend/app.dart';
import 'package:plantngo_frontend/providers/customer_provider.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'screens/all.dart';
import 'providers/user_provider.dart';
import 'router.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => CustomerProvider()),
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
    print(Provider.of<CustomerProvider>(context).customer.token);
    return MaterialApp(
      title: 'Plant&Go',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff00aa58),
        useMaterial3: true,
      ),
      onGenerateRoute: ((settings) => generateRoute(settings)),
      home: Provider.of<CustomerProvider>(context).customer.token.isNotEmpty
          ? const App()
          : const LoginSignUpScreen(),
    );
  }
}

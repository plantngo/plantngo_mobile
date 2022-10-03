import 'package:flutter/material.dart';
import 'package:plantngo_frontend/providers/customer_provider.dart';
import 'package:plantngo_frontend/providers/merchant_category_provider.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
import 'package:plantngo_frontend/services/merchant_service.dart';
import 'package:provider/provider.dart';
import 'utils/all.dart';
import 'router.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CustomerProvider()),
    ChangeNotifierProvider(create: (context) => MerchantProvider()),
    ChangeNotifierProvider(create: (context) => MerchantCategoryProvider()),
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
    Widget app = const LoginSignUpScreen();

    if (Provider.of<CustomerProvider>(context).customer.token.isNotEmpty) {
      app = const CustomerApp();
    } else if (Provider.of<MerchantProvider>(context)
        .merchant
        .token
        .isNotEmpty) {
      app = const MerchantApp();
    }
    return MaterialApp(
        title: 'Plant&Go',
        theme: ThemeData(
          colorSchemeSeed: Colors.green,
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        onGenerateRoute: ((settings) => generateRoute(settings)),
        home: app);
  }
}

import 'package:flutter/material.dart';
import 'package:plantngo_frontend/providers/customer_provider.dart';
import 'package:plantngo_frontend/providers/merchant_category_provider.dart';
import 'package:plantngo_frontend/providers/location_provider.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'utils/all.dart';
import 'router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CustomerProvider()),
        ChangeNotifierProvider(create: (context) => MerchantProvider()),
        ChangeNotifierProvider(create: (context) => MerchantCategoryProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    AuthService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget app = const LoginSignUpScreen();

    /// Check if the logged in user is a customer or a merchant ///
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.light,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        cardTheme: const CardTheme(
          color: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
        ),
      ),
      onGenerateRoute: ((settings) => generateRoute(settings)),
      home: app,
    );
  }
}

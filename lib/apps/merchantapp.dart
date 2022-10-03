import 'package:flutter/material.dart';
import 'package:plantngo_frontend/providers/merchant_category_provider.dart';
import 'package:plantngo_frontend/screens/merchant/merchant_home_screen.dart';
import 'package:plantngo_frontend/screens/merchant/merchant_menu_screen.dart';
import 'package:plantngo_frontend/screens/merchant/merchant_account_screen.dart';
import 'package:plantngo_frontend/widgets/navigation/bottom_navbar_merchant.dart';
import 'package:provider/provider.dart';

class MerchantApp extends StatefulWidget {
  static const routeName = '/merchantapp';
  const MerchantApp({super.key});

  @override
  State<MerchantApp> createState() => _MerchantAppState();
}

class _MerchantAppState extends State<MerchantApp> {
  PageController pageController = PageController();

  int bottomNavbarSelectedIndex = 0;
  int topNavbarSelectedIndex = 0;

  final List<Widget> screens = const [
    MerchantHomeScreen(),
    MerchantMenuScreen(),
    MerchantAccountScreen(),
  ];

  void onBottomNavbarTap(int selectedIndex) {
    pageController.jumpToPage(selectedIndex);
  }

  void onPageChanged(int index) {
    setState(() {
      bottomNavbarSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => MerchantCategoryProvider()),
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          body: PageView(
            controller: pageController,
            onPageChanged: onPageChanged,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: screens,
          ),
          bottomNavigationBar: BottomNavbarMerchant(
            onTap: onBottomNavbarTap,
            selectedIndex: bottomNavbarSelectedIndex,
          ),
        ),
      ),
    );
  }
}

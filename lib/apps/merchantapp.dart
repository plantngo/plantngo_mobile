import 'package:flutter/material.dart';
import 'package:plantngo_frontend/providers/merchant_category_provider.dart';
import 'package:plantngo_frontend/screens/merchant/merchant_home_screen.dart';
import 'package:plantngo_frontend/screens/merchant/merchant_menu_screen.dart';
import 'package:plantngo_frontend/screens/merchant/merchant_account_screen.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
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
    switch (index) {
      case 1:
        AuthService.getUserData(context);
        break;
      default:
    }
    setState(() {
      bottomNavbarSelectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<MerchantCategoryProvider>(context, listen: false)
        .setCategories(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
    );
  }
}

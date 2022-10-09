import 'package:flutter/material.dart';
import 'package:plantngo_frontend/screens/customer/home/home_screen.dart';
import 'package:plantngo_frontend/screens/customer/profile_screen.dart';
import 'package:plantngo_frontend/screens/customer/reward_shop_screen.dart';
import 'package:plantngo_frontend/widgets/navigation/bottom_navbar.dart';


class CustomerApp extends StatefulWidget {
  static const routeName = '/customerapp';
  const CustomerApp({super.key});

  @override
  State<CustomerApp> createState() => _CustomerAppState();
}

class _CustomerAppState extends State<CustomerApp> {
  PageController pageController = PageController();

  int bottomNavbarSelectedIndex = 0;
  int topNavbarSelectedIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    RewardShop(),
    ProfileScreen(),
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(),
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: screens,
        ),
        bottomNavigationBar: BottomNavbar(
          onTap: onBottomNavbarTap,
          selectedIndex: bottomNavbarSelectedIndex,
        ),
      ),
    );
  }
}

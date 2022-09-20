import 'package:flutter/material.dart';
import 'package:plantngo_frontend/screens/home/home_screen.dart';
import 'package:plantngo_frontend/screens/profile/profile_screen.dart';
import 'package:plantngo_frontend/widgets/navigation/bottom_navbar.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  PageController pageController = PageController();

  int bottomNavbarSelectedIndex = 0;
  int topNavbarSelectedIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    Scaffold(),
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
      length: 5,
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

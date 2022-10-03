import 'package:flutter/material.dart';

class BottomNavbarMerchant extends StatelessWidget {
  final ValueSetter<int> onTap;
  int selectedIndex;

  BottomNavbarMerchant({
    required this.onTap,
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  final List<IconData> selectedIcon = [
    Icons.home_rounded,
    Icons.menu_book_rounded,
    Icons.account_circle_rounded,
  ];
  final List<IconData> unSelectedIcon = [
    Icons.home_outlined,
    Icons.menu_book_outlined,
    Icons.account_circle_outlined,
  ];

  IconData renderIcon(int index) {
    if (selectedIndex == index) {
      return selectedIcon[index];
    }
    return unSelectedIcon[index];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0,
            blurRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).backgroundColor,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Theme.of(context).primaryColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: selectedIndex,
          onTap: onTap,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                renderIcon(0),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                renderIcon(1),
              ),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                renderIcon(2),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

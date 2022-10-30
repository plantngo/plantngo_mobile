import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final ValueSetter<int> onTap;
  final int selectedIndex;

  BottomNavbar({
    required this.onTap,
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  final List<IconData> selectedIcon = [
    Icons.home_rounded,
    Icons.store_mall_directory,
    Icons.account_circle_rounded,
  ];
  final List<IconData> unSelectedIcon = [
    Icons.home_outlined,
    Icons.store_mall_directory_outlined,
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
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              blurRadius: 15.0,
              offset: Offset(0.0, 0.75)),
        ],
      ),
      child: ClipRRect(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
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
              label: 'Cart',
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

import 'package:flutter/material.dart';
import '../../utils/global_variables.dart';

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
            color: Theme.of(context).primaryColor,
            spreadRadius: 0,
            blurRadius: 10,
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

import 'package:flutter/material.dart';

class MenuItemTile extends StatefulWidget {
  const MenuItemTile({Key? key}) : super(key: key);

  @override
  _MenuItemTileState createState() => _MenuItemTileState();
}

class _MenuItemTileState extends State<MenuItemTile> {
  
  @override
  Widget build(BuildContext context) {
    return const ExpansionTile(
      title: Text('ExpansionTile 1'),
      subtitle: Text('Trailing expansion arrow icon'),
      children: [
        ListTile(title: Text('This is tile number 1')),
      ],
    );
  }
}

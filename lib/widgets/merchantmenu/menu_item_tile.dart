import 'package:flutter/material.dart';

class MenuItemTile extends StatefulWidget {
  const MenuItemTile({Key? key, this.value, required this.categoryName});

  final dynamic value;
  final String categoryName;

  @override
  _MenuItemTileState createState() => _MenuItemTileState();
}

class _MenuItemTileState extends State<MenuItemTile> {
  @override
  Widget build(BuildContext context) {
    List<Widget> productLists = [];
    productLists.add(SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Availability"),
          ),
        ],
      ),
    ));
    for (var item in widget.value) {
      bool available = true;
      productLists.add(ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${item.name}'),
            Text(
              '\$${item.price}0',
              style: const TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ],
        ),
        trailing: Checkbox(
          value: true,
          activeColor: Colors.green,
          onChanged: ((value) {
            setState(() {
              available = !available;
            });
          }),
        ),
      ));
    }
    String categoryName = widget.categoryName;
    return ExpansionTile(
        title: Row(
          children: [
            Text(categoryName),
            const Spacer(),
            Text(
              "${productLists.length - 1} items",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        children: productLists);
  }
}

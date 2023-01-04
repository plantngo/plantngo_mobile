import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/product.dart';

class MenuItemTile extends StatefulWidget {
  const MenuItemTile({Key? key, this.value, required this.categoryName});

  final List<Product>? value;
  final String categoryName;

  @override
  _MenuItemTileState createState() => _MenuItemTileState();
}

class _MenuItemTileState extends State<MenuItemTile> {
  List<bool> available = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> productLists = [];

    productLists.add(
      SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Availability"),
            ),
          ],
        ),
      ),
    );
    for (int i = 0; i < widget.value!.length; i++) {
      Product item = widget.value![i];
      try {
        available[i];
      } catch (e) {
        available.add(true);
      }
      productLists.add(
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item.name}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          subtitle: Text(
            '\$${item.price.toString().padRight(5, '0')}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          leading: Checkbox(
            value: available[i],
            activeColor: Theme.of(context).colorScheme.secondary,
            onChanged: ((value) {
              setState(() {
                available[i] = value!;
              });
            }),
          ),
        ),
      );
    }
    return ExpansionTile(
      title: Row(
        children: [
          Text(
            widget.categoryName,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const Spacer(),
          Text(
            "${productLists.length - 1} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
      children: productLists,
    );
  }
}

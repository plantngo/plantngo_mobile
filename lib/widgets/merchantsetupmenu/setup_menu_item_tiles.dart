import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/ingredient.dart';
import 'package:plantngo_frontend/screens/merchant/menu/category/edit_category_screen.dart';
import 'package:plantngo_frontend/screens/merchant/menu/item/edit_item_screen.dart';
import 'package:plantngo_frontend/services/product_service.dart';

class SetupMenuItemTile extends StatefulWidget {
  const SetupMenuItemTile({
    super.key,
    this.value,
    required this.categoryName,
  });

  final dynamic value;
  final String categoryName;

  @override
  _SetupMenuItemTileState createState() => _SetupMenuItemTileState();
}

class _SetupMenuItemTileState extends State<SetupMenuItemTile> {
  @override
  Widget build(BuildContext context) {
    List<Widget> productLists = [];
    for (var item in widget.value) {
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
          trailing: TextButton(
              onPressed: () async {
                List<Ingredient> ingredients =
                    await ProductService.getAllIngredientsByMerchantAndProduct(
                        context: context, productName: item.name);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditItemScreen(
                        item: item,
                        category: widget.categoryName,
                        ingredients: ingredients,
                      ),
                    ));
              },
              child: const Text("Edit Item"))));
    }
    String categoryName = widget.categoryName;
    return ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(categoryName),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditCategoryScreen(
                            categoryName: categoryName,
                          ),
                        ),
                      );
                    },
                    child: const Text("Edit category")),
              ],
            ),
            const Spacer(),
            Text(
              "${productLists.length} items",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        children: productLists);
  }
}

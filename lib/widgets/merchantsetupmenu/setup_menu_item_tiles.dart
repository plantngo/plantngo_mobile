import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/ingredient.dart';
import 'package:plantngo_frontend/screens/merchant/menu/category/edit_category_screen.dart';
import 'package:plantngo_frontend/screens/merchant/menu/item/edit_item_screen.dart';
import 'package:plantngo_frontend/services/product_service.dart';
import 'package:plantngo_frontend/utils/global_variables.dart';
import 'package:plantngo_frontend/widgets/tag/carbon_tag.dart';
import 'package:plantngo_frontend/widgets/tag/tag.dart';
import 'package:quiver/collection.dart';

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
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SizedBox(
              height: 100,
              width: 100,
              child: Image.network(
                item.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            item.name!,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.w300),
          ),
          subtitle: Row(
            children: [
              CarbonTag(text: "${formatEmission.format(item.carbonEmission!)}"),
              SizedBox(
                width: 5,
              ),
              Tag(text: "${formatMoney.format(item.price!)}")
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
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.alphabetic,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            categoryName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Spacer(),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditCategoryScreen(
                    categoryName: categoryName,
                  ),
                ),
              );
            },
            child: Text(
              "Edit Category",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
        ],
      ),
      children: [
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return productLists[index];
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: productLists.length,
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }
}

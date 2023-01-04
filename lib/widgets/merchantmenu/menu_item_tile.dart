import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/product.dart';
import 'package:plantngo_frontend/utils/global_variables.dart';
import 'package:plantngo_frontend/widgets/tag/carbon_tag.dart';
import 'package:plantngo_frontend/widgets/tag/tag.dart';

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
          mainAxisAlignment: MainAxisAlignment.end,
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
          trailing: Checkbox(
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
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return productLists[index];
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: productLists.length,
        ),
      ],
    );
  }
}

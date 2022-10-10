import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/product.dart';

class MerchantShopMenuSection extends StatelessWidget {
  List<Product> merchantProductList;
  String title;

  MerchantShopMenuSection({
    super.key,
    required this.merchantProductList,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: merchantProductList.length,
          itemBuilder: (_, i) {
            return ListTile(
              leading: SizedBox(
                height: 100,
                width: 100,
                child: Image.network(
                  "https://static.phdvasia.com/sg1/menu/single/desktop_thumbnail_0bd9658b-d8eb-438d-bc2c-fef8afa1b71e.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(merchantProductList[i].name!),
              subtitle:
                  Text("\$${merchantProductList[i].price!.toStringAsFixed(2)}"),
              onTap: () {
                // onTap();
              },
            );
          },
        ),
      ],
    );
  }
}

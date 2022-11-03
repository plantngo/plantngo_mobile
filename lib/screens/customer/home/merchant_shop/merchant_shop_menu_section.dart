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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
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
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: merchantProductList.length,
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemBuilder: (_, i) {
            return ListTile(
              leading: SizedBox(
                height: 100,
                width: 100,
                child: Image.network(
                  merchantProductList[i].imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                merchantProductList[i].name!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              subtitle: Text(
                "\$${merchantProductList[i].price!.toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.caption,
              ),
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

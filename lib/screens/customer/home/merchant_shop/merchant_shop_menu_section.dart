import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantngo_frontend/models/order.dart';
import 'package:plantngo_frontend/models/orderitem.dart';
import 'package:plantngo_frontend/models/product.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_shop/merchant_shop_item.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_shop/merchant_shop_update_order.dart';

class MerchantShopMenuSection extends StatelessWidget {
  List<Product> merchantProductList;
  Order? order;
  String title;
  Future Function(int, int) updateCustomerMerchantOrder;

  MerchantShopMenuSection({
    super.key,
    required this.merchantProductList,
    required this.order,
    required this.title,
    required this.updateCustomerMerchantOrder,
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
          padding: const EdgeInsets.all(10),
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
            return MerchantShopItem(
              order: order,
              product: merchantProductList[i],
              updateCustomerMerchantOrder: updateCustomerMerchantOrder,
            );
          },
        ),
      ],
    );
  }
}

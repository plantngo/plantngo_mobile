import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plantngo_frontend/models/order.dart';
import 'package:plantngo_frontend/models/product.dart';
import 'package:plantngo_frontend/screens/customer/home/merchant_shop/merchant_shop_update_order.dart';
import 'package:plantngo_frontend/utils/global_variables.dart';
import 'package:plantngo_frontend/widgets/tag/carbon_tag.dart';
import 'package:plantngo_frontend/widgets/tag/tag.dart';

class MerchantShopItem extends StatelessWidget {
  Order? order;
  Product product;
  Future Function(int, int) updateCustomerMerchantOrder;

  MerchantShopItem({
    super.key,
    required this.order,
    required this.product,
    required this.updateCustomerMerchantOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SizedBox(
              height: 100,
              width: 100,
              child: Image.network(
                product.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            product.name!,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.w300),
          ),
          subtitle: Row(
            children: [
              CarbonTag(
                  text: "${formatEmission.format(product.carbonEmission!)}"),
              SizedBox(
                width: 5,
              ),
              Tag(text: "${formatMoney.format(product.price!)}")
            ],
          ),
          // trailing: Text(
          //   "\$${product.price!.toStringAsFixed(2)}",
          //   style: Theme.of(context).textTheme.caption,
          // ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MerchantShopUpdateOrder(
                  merchantProduct: product,
                  order: order,
                  updateCustomerMerchantOrder: updateCustomerMerchantOrder,
                ),
              ),
            );
          },
        ),
        order != null &&
                order!.orderItems!.isNotEmpty &&
                order!.orderItems!
                    .where(
                      (element) => element.productId == product.id,
                    )
                    .isNotEmpty
            ? Positioned(
                top: 5,
                left: 10,
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${order!.orderItems!.where((element) => element.productId == product.id).first.quantity!}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}

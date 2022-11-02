import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantngo_frontend/models/order.dart';
import 'package:plantngo_frontend/models/orderitem.dart';
import 'package:plantngo_frontend/models/product.dart';

class MerchantShopMenuSection extends StatelessWidget {
  List<Product> merchantProductList;
  String title;
  Order? customerMerchantOrder;

  MerchantShopMenuSection({
    super.key,
    required this.merchantProductList,
    required this.customerMerchantOrder,
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
            return ListTile(
              leading: Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(
                        merchantProductList[i].imageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  customerMerchantOrder != null &&
                          customerMerchantOrder!.orderItems!.isNotEmpty &&
                          customerMerchantOrder!.orderItems!
                              .where((element) =>
                                  element.productId ==
                                  merchantProductList[i].id)
                              .isNotEmpty
                      ? Container(
                          height: 15,
                          width: 15,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${customerMerchantOrder!.orderItems!.where((element) => element.productId == merchantProductList[i].id).first.quantity!}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox()
                ],
              ),
              title: Text(
                merchantProductList[i].name!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              subtitle: Text(
                "\$${merchantProductList[i].price!.toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.caption,
              ),
              onTap: () {},
            );
          },
        ),
      ],
    );
  }
}

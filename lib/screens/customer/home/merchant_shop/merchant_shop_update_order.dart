import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/order.dart';
import 'package:plantngo_frontend/models/product.dart';

class MerchantShopUpdateOrder extends StatelessWidget {
  Product merchantProduct;
  Order? customerMerchantOrder;
  MerchantShopUpdateOrder({
    super.key,
    required this.merchantProduct,
    required this.customerMerchantOrder,
  });

  renderQuantity() {
    if (customerMerchantOrder == null ||
        customerMerchantOrder!.orderItems == null ||
        customerMerchantOrder!.orderItems!
            .where((element) => element.id == merchantProduct.id)
            .isEmpty) {
      return 0;
    }

    return customerMerchantOrder!.orderItems!
        .where((e) => e.productId == merchantProduct.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          merchantProduct.name!,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.green,
                    ),
                  ),
                  Text("${renderQuantity()}"),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Add to order"),
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              merchantProduct.imageUrl!,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}

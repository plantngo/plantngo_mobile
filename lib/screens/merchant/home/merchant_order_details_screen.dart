//todo add item picture?
import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/order.dart';
import 'package:plantngo_frontend/models/product.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
import 'package:plantngo_frontend/services/order_service.dart';
import 'package:plantngo_frontend/services/product_service.dart';
import 'package:plantngo_frontend/widgets/merchantorder/merchant_order_item_tile.dart';

class MerchantOrderDetailsScreen extends StatefulWidget {
  const MerchantOrderDetailsScreen(
      {Key? key, required this.order, required this.refresh})
      : super(key: key);

  final Order order;
  final void Function() refresh;

  @override
  _MerchantOrderDetailsScreenState createState() =>
      _MerchantOrderDetailsScreenState();
}

class _MerchantOrderDetailsScreenState
    extends State<MerchantOrderDetailsScreen> {
  List<MerchantOrderItemTile> orderItemsTiles = [];

  Future getOrderItems() async {
    List<MerchantOrderItemTile> futureOrderItemsTiles = [];

    for (var item in widget.order.orderItems!) {
      Product product = await ProductService.getProductById(
          context: context, id: item.productId!);
      futureOrderItemsTiles.add(MerchantOrderItemTile(
          quantity: item.quantity!,
          price: product.price!,
          name: product.name!));
    }
    orderItemsTiles = futureOrderItemsTiles;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getOrderItems(),
        builder: ((BuildContext context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Order ID: ${widget.order.id}"),
            ),
            body: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: orderItemsTiles,
            ),
            bottomNavigationBar: widget.order.orderStatus == "FULFILLED"
                ? SizedBox(
                    height: 115,
                    child: Container(
                      padding: const EdgeInsets.all(35),
                      color: const Color.fromARGB(33, 158, 158, 158),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                const Spacer(),
                                Text(
                                  "Total(\$): \$${widget.order.totalPrice}0",
                                  style: const TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : SizedBox(
                    height: 175,
                    child: Container(
                      padding: const EdgeInsets.all(35),
                      color: const Color.fromARGB(33, 158, 158, 158),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                const Spacer(),
                                Text(
                                  "Total(\$): \$${widget.order.totalPrice}0",
                                  style: const TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  foregroundColor:
                                      Theme.of(context).colorScheme.onPrimary,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                ).copyWith(
                                  elevation: ButtonStyleButton.allOrNull(0.0),
                                ),
                                child: const Text('Mark as Fulfilled'),
                                onPressed: () async {
                                  await OrderService
                                      .updateOrderStatusToFulfilled(
                                          context: context,
                                          order: widget.order);

                                  AuthService.getUserData(context);
                                  Navigator.pop(context);
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        }));
  }
}

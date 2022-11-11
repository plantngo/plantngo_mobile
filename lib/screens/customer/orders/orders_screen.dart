import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:plantngo_frontend/models/order.dart';
import 'package:plantngo_frontend/screens/customer/cart/cart_main_screen.dart';
import 'package:plantngo_frontend/screens/customer/orders/order_details_screen.dart';
import 'package:plantngo_frontend/services/customer_order_service.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future<List<Order>> futureCustomerOrders;

  @override
  void initState() {
    super.initState();
    setState(() {
      futureCustomerOrders = CustomerOrderService.getAllOrdersByCustomer(
        context: context,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            shape: const CircleBorder(),
            // Lead to checkout page
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CartMainScreen()),
              );
            },
            child: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Orders",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            FutureBuilder<List<Order>>(
              future: futureCustomerOrders,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Failed to load page"),
                  );
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Recent Orders",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemBuilder: (context, index) {
                          final _order = snapshot.data![index];
                          return ListTile(
                            title: Text(
                              _order.merchant!.company,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            horizontalTitleGap: 0,
                            subtitle: Row(
                              children: [
                                Text(
                                  "${_order.orderStatus!} ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color:
                                              _order.orderStatus! == "PENDING"
                                                  ? Colors.orange
                                                  : _order.orderStatus! ==
                                                          "FULFILLED"
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .secondary
                                                      : _order.orderStatus! ==
                                                              "CREATED"
                                                          ? Colors.blue
                                                          : Colors.red),
                                ),
                                Text(
                                  "Order #${_order.id!.toString().padLeft(5, '0')}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.network(
                                  _order.merchant!.logoUrl,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            trailing: Text(
                              "S\$${_order.totalPrice!.toStringAsFixed(2)}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => OrderDetailsScreen(
                                    order: _order,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  );
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 150,
                      ),
                      SizedBox(
                        height: 100,
                        child: SvgPicture.asset("assets/graphics/receipt.svg"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "You don't have any order history",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            )
          ],
        ),
      ),
    );
  }
}

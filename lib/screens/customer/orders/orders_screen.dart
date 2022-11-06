import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:plantngo_frontend/models/order.dart';
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Orders",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     boxShadow: const [
        //       BoxShadow(
        //         color: Colors.grey,
        //         offset: Offset(0, 2.0),
        //         blurRadius: 4.0,
        //       )
        //     ],
        //     gradient: LinearGradient(
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomRight,
        //       colors: [
        //         Colors.green.shade200,
        //         Colors.green.shade300,
        //         Colors.green,
        //       ],
        //     ),
        //   ),
        // ),
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
                          final result = snapshot.data![index];
                          return ListTile(
                            title: Text(
                              result.merchant!.company,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            horizontalTitleGap: 0,
                            subtitle: Row(
                              children: [
                                Text(
                                  "${result.orderStatus!} ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color:
                                              result.orderStatus! == "PENDING"
                                                  ? Colors.orange
                                                  : result.orderStatus! ==
                                                          "FULFILLED"
                                                      ? Colors.green
                                                      : Colors.red),
                                ),
                                Text(
                                  "Order #${result.id!.toString().padLeft(5, '0')}",
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
                                  result.merchant!.logoUrl,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            trailing: Text(
                              "S\$${result.totalPrice!.toStringAsFixed(2)}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const Scaffold(),
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

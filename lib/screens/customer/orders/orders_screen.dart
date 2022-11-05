import 'package:flutter/material.dart';

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
                } else if (snapshot.hasData
                    // && snapshot.data!.isNotEmpty
                    ) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Pending Orders",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final result = snapshot.data![index];
                          return result.orderStatus == "PENDING"
                              ? ListTile(
                                  title: Text(
                                    result.merchant!.company,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  subtitle: Text(
                                    "Order #${result.id!.toString().padLeft(5, '0')}",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Image.network(
                                        result.merchant!.logoUrl,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  trailing: Text(
                                    "S\$${result.totalPrice!.toStringAsFixed(2)}",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const Scaffold(),
                                      ),
                                    );
                                  },
                                )
                              : SizedBox();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        thickness: 5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Fulfilled Orders",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final result = snapshot.data![index];
                          return result.orderStatus == "FULFILLED"
                              ? ListTile(
                                  title: Text(
                                    result.merchant!.company,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  subtitle: Text(
                                    "Order #${result.id!.toString().padLeft(5, '0')}",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Image.network(
                                        result.merchant!.bannerUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  trailing: Text(
                                    "S\$${result.totalPrice!.toStringAsFixed(2)}",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const Scaffold(),
                                      ),
                                    );
                                  },
                                )
                              : SizedBox();
                        },
                      ),
                    ],
                  );
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No Results"),
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

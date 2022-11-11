import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantngo_frontend/models/order.dart';
import 'package:plantngo_frontend/screens/customer/cart/cart_order_list.dart';
import 'package:plantngo_frontend/screens/customer/orders/order_details_screen.dart';
import 'package:plantngo_frontend/services/customer_order_service.dart';
import 'package:plantngo_frontend/utils/error_handling.dart';
import 'package:quiver/strings.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<List<Order>> futureCustomerOrders;
  List<bool> orderSelectedArr = [];
  List<bool> orderIsDineIn = [];
  double totalPrice = 0;

  double calculateTotal(List<Order> orders) {
    double total = 0.0;
    for (int i = 0; i < orders.length; i++) {
      if (orderSelectedArr[i]) {
        total += orders[i].totalPrice!;
      }
    }
    return total;
  }

  onCheckboxChanged(bool newValue, int i) {
    setState(() {
      orderSelectedArr[i] = newValue;
    });
    futureCustomerOrders.then((value) {
      setState(() {
        totalPrice = calculateTotal(value);
      });
    });
  }

  onIsDineInChanged(bool newValue, int i) {
    setState(() {
      orderIsDineIn[i] = newValue;
    });
  }

  void retrieveAllOrders() {
    setState(() {
      futureCustomerOrders =
          CustomerOrderService.getAllOrdersByCustomerAndOrderStatus(
        context: context,
        orderStatus: "CREATED",
      );
    });
  }

  @override
  void initState() {
    super.initState();
    retrieveAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FutureBuilder<List<Order>>(
        future: futureCustomerOrders,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Failed to load page"),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          orderSelectedArr.where((element) => element).isEmpty
                              ? Colors.grey
                              : Theme.of(context).colorScheme.secondary)),
                  onPressed: orderSelectedArr
                          .where((element) => element)
                          .isEmpty
                      ? null
                      : () async {
                          List<Order> _orders = snapshot.data!;
                          for (int i = 0; i < _orders.length; i++) {
                            if (orderSelectedArr[i]) {
                              CustomerOrderService.updateOrderStatus(
                                context: context,
                                order: _orders[i],
                                orderStatus: "PENDING",
                                isDineIn: orderIsDineIn[i],
                              ).then((value) {
                                retrieveAllOrders();
                                if (value != null) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrderDetailsScreen(
                                        order: value,
                                      ),
                                    ),
                                  );
                                } else {
                                  showSnackBar(context,
                                      "Order Failed, please try again later.");
                                }
                              });
                            }
                          }
                          // set orders to pending
                        },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${orderSelectedArr.where((element) => element).length} order(s)",
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.shopping_bag_outlined, size: 20.0),
                          Text("Checkout Cart"),
                        ],
                      ),
                      Text(
                        "S\$ ${totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const SizedBox();
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text(
      //     "Cart",
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ),
      //   leading: BackButton(color: Colors.white),
      //   backgroundColor: Theme.of(context).colorScheme.secondary,
      //   foregroundColor: Colors.white,
      //   // flexibleSpace: Container(
      //   //   decoration: BoxDecoration(
      //   //     boxShadow: const [
      //   //       BoxShadow(
      //   //         color: Colors.grey,
      //   //         offset: Offset(0, 2.0),
      //   //         blurRadius: 4.0,
      //   //       )
      //   //     ],
      //   //     gradient: LinearGradient(
      //   //       begin: Alignment.topLeft,
      //   //       end: Alignment.bottomRight,
      //   //       colors: [
      //   //         Theme.of(context).colorScheme.secondary.shade200,
      //   //         Theme.of(context).colorScheme.secondary.shade300,
      //   //         Theme.of(context).colorScheme.secondary,
      //   //       ],
      //   //     ),
      //   //   ),
      //   // ),
      // ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<Order>>(
          future: futureCustomerOrders,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Failed to load page"),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Divider(
                          thickness: 2,
                          color:
                              Theme.of(context).colorScheme.secondary,
                        ),
                      );
                    },
                    itemBuilder: (context, index) {
                      final result = snapshot.data![index];
                      orderSelectedArr.add(false);
                      orderIsDineIn.add(false);
                      return CartOrderList(
                        order: result,
                        selected: orderSelectedArr[index],
                        isDineIn: orderIsDineIn[index],
                        index: index,
                        onCheckboxChanged: onCheckboxChanged,
                        onIsDineInChanged: onIsDineInChanged,
                        refreshHook: retrieveAllOrders,
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Divider(
                      thickness: 2,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  SizedBox(
                    height: 100,
                    child: SvgPicture.asset("assets/graphics/empty_cart.svg"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "You have nothing in your cart!",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

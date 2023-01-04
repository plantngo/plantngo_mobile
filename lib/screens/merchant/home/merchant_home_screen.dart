import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantngo_frontend/models/order.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/services/order_service.dart';
import 'package:plantngo_frontend/widgets/merchantorder/merchant_pending_order_tile.dart';

class MerchantHomeScreen extends StatefulWidget {
  const MerchantHomeScreen({super.key});

  @override
  State<MerchantHomeScreen> createState() => _MerchantHomeScreenState();
}

class _MerchantHomeScreenState extends State<MerchantHomeScreen> {
  List<Order> pendingOrders = [];
  List<MerchantOrderTile> pendingOrderTile = [];
  List<Order> fulfilledOrders = [];
  List<MerchantOrderTile> fulfilledOrderTile = [];
  List<Order> cancelledOrders = [];
  List<MerchantOrderTile> cancelledOrderTile = [];

  Future setPendingOrders() async {
    pendingOrders =
        await OrderService.getPendingOrdersByMerchant(context: context);
    List<MerchantOrderTile> pendingOrderTile = [];

    for (var item in pendingOrders) {
      pendingOrderTile.add(MerchantOrderTile(order: item, refresh: _refresh));
    }
    this.pendingOrderTile = pendingOrderTile.reversed.toList();

    fulfilledOrders =
        await OrderService.getFulfilledOrdersByMerchant(context: context);
    List<MerchantOrderTile> fulfilledOrderTile = [];

    for (var item in fulfilledOrders) {
      fulfilledOrderTile.add(MerchantOrderTile(order: item, refresh: _refresh));
    }

    this.fulfilledOrderTile = fulfilledOrderTile.reversed.toList();

    cancelledOrders =
        await OrderService.getCancelledOrdersByMerchant(context: context);
    List<MerchantOrderTile> cancelledOrderTile = [];

    for (var item in cancelledOrders) {
      cancelledOrderTile.add(MerchantOrderTile(order: item, refresh: _refresh));
    }

    this.cancelledOrderTile = cancelledOrderTile.reversed.toList();
  }

  Future _refresh() async {
    List<Order> pendingOrders =
        await OrderService.getPendingOrdersByMerchant(context: context);
    List<MerchantOrderTile> pendingOrderTile = [];
    for (var item in pendingOrders) {
      pendingOrderTile.add(MerchantOrderTile(order: item, refresh: _refresh));
    }
    List<Order> fulfilledOrders =
        await OrderService.getFulfilledOrdersByMerchant(context: context);
    List<MerchantOrderTile> fulfilledOrderTile = [];
    for (var item in fulfilledOrders) {
      fulfilledOrderTile.add(MerchantOrderTile(order: item, refresh: _refresh));
    }
    List<Order> cancelledOrders =
        await OrderService.getCancelledOrdersByMerchant(context: context);
    List<MerchantOrderTile> cancelledOrderTile = [];
    for (var item in cancelledOrders) {
      cancelledOrderTile.add(MerchantOrderTile(order: item, refresh: _refresh));
    }
    setState(() {
      this.pendingOrders = pendingOrders;
      this.pendingOrderTile = pendingOrderTile.reversed.toList();
      this.fulfilledOrders = fulfilledOrders;
      this.fulfilledOrderTile = fulfilledOrderTile.reversed.toList();
      this.cancelledOrders = cancelledOrders;
      this.cancelledOrderTile = cancelledOrderTile.reversed.toList();
    });
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setPendingOrders(),
      builder: (BuildContext context, snapshot) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "Orders",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Colors.white,
                bottom: TabBar(
                  indicatorPadding: const EdgeInsets.only(
                    bottom: 1,
                    left: 2,
                    right: 2,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white54,
                  tabs: [
                    Tab(
                      icon: Text('${pendingOrders.length} Order(s)'),
                    ),
                    const Tab(
                      text: 'Fulfilled',
                    ),
                    const Tab(
                      text: 'Cancelled',
                    ),
                  ],
                ),
              ),
              body: TabBarView(children: [
                RefreshIndicator(
                  onRefresh: _refresh,
                  child: pendingOrderTile.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                    height: 150,
                                    child: SvgPicture.asset(
                                        "assets/graphics/no_orders.svg")),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                    "You have no orders now!\nPull down to Refresh")
                              ],
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: pendingOrderTile.length,
                          itemBuilder: (context, index) {
                            return pendingOrderTile[index];
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                        ),
                ),
                ListView.separated(
                  itemCount: fulfilledOrderTile.length,
                  itemBuilder: (context, index) {
                    return fulfilledOrderTile[index];
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                ),
                ListView.separated(
                  itemCount: cancelledOrderTile.length,
                  itemBuilder: (context, index) {
                    return cancelledOrderTile[index];
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                )
              ])),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/order.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
import 'package:plantngo_frontend/services/order_service.dart';
import 'package:plantngo_frontend/widgets/merchantorder/merchant_order_tile.dart';
import 'package:provider/provider.dart';

class MerchantHomeScreen extends StatefulWidget {
  const MerchantHomeScreen({super.key});

  @override
  State<MerchantHomeScreen> createState() => _MerchantHomeScreenState();
}

class _MerchantHomeScreenState extends State<MerchantHomeScreen> {
  List<Order> pendingOrders = [];

  Future setPendingOrders() async {
    pendingOrders =
        await OrderService.getPendingOrdersByMerchant(context: context);
  }

  Future _refresh() async {
    List<Order> pendingOrders =
        await OrderService.getPendingOrdersByMerchant(context: context);
    setState(() {
      this.pendingOrders = pendingOrders;
    });
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    var merchantProvider = Provider.of<MerchantProvider>(context, listen: true);

    return FutureBuilder(
        future: setPendingOrders(),
        builder: (BuildContext context, snapshot) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        icon: Text('${pendingOrders.length} Orders'),
                      ),
                      const Tab(
                        text: 'Fulfilled',
                      ),
                      const Tab(
                        text: 'Cancelled',
                      ),
                    ],
                  ),
                  title: Text(
                    "Hello, ${merchantProvider.merchant.username}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  centerTitle: false,
                ),
                body: TabBarView(children: [
                  RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: <Widget>[
                          for (var item in pendingOrders)
                            MerchantOrderTile(
                              order: item,
                              refresh: _refresh,
                            )
                        ],
                      )),
                  const SingleChildScrollView(
                    child: Text('History Page'),
                  ),
                  const SingleChildScrollView(
                    child: Text('Cancelled Page'),
                  ),
                ])),
          );
        });
  }
}

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPendingOrders();
  }

  setPendingOrders() async {
    pendingOrders =
        await OrderService.getPendingOrdersByMerchant(context: context);
    setState(() {});
  }

  Future _refresh() async {
    setPendingOrders();
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    var merchantProvider = Provider.of<MerchantProvider>(context, listen: true);

    return Consumer<MerchantProvider>(builder:
        (BuildContext context, MerchantProvider merchantProvider, child) {
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
                      // for (var value in merchantProvider.merchant.categories!)
                      //   SetupMenuItemTile(
                      //       categoryName: value.name, value: value.products)
                      for (var item in pendingOrders)
                        MerchantOrderTile(order: item)
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

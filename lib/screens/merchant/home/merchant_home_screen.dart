import 'package:flutter/material.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/services/auth_service.dart';
import 'package:plantngo_frontend/widgets/merchantorder/merchant_order_tile.dart';
import 'package:plantngo_frontend/widgets/merchantsetupmenu/setup_menu_item_tiles.dart';
import 'package:provider/provider.dart';

class MerchantHomeScreen extends StatefulWidget {
  const MerchantHomeScreen({super.key});

  @override
  State<MerchantHomeScreen> createState() => _MerchantHomeScreenState();
}

class _MerchantHomeScreenState extends State<MerchantHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var merchantProvider = Provider.of<MerchantProvider>(context, listen: true);

    Future _refresh() async {
      AuthService.getUserData(context);
      await Future.delayed(Duration(seconds: 1));
    }

    return Consumer<MerchantProvider>(builder:
        (BuildContext context, MerchantProvider merchantProvider, child) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Text(
                        '${merchantProvider.merchant.orders?.length ?? 0} Orders'),
                  ),
                  const Tab(
                    text: 'History',
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
                    physics: AlwaysScrollableScrollPhysics(),
                    children: const <Widget>[
                      // for (var value in merchantProvider.merchant.categories!)
                      //   SetupMenuItemTile(
                      //       categoryName: value.name, value: value.products)
                      MerchantOrderTile(),
                      MerchantOrderTile(),
                      MerchantOrderTile(),
                      MerchantOrderTile(),
                      MerchantOrderTile(),
                      MerchantOrderTile(),
                      MerchantOrderTile(),
                      MerchantOrderTile(),
                      MerchantOrderTile(),
                      MerchantOrderTile(),
                      MerchantOrderTile(),
                      MerchantOrderTile(),
                    ],
                  )),
              const SingleChildScrollView(
                child: Text('History Page'),
              ),
            ])),
      );
    });
  }
}

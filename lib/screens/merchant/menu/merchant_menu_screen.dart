import 'package:flutter/material.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/screens/merchant/menu/placeholder_item.dart';
import 'package:plantngo_frontend/services/merchant_service.dart';
import 'package:provider/provider.dart';
import 'merchant_setup_menu_screen.dart';
import '../../../widgets/merchantmenu/menu_item_tile.dart';

class MerchantMenuScreen extends StatefulWidget {
  const MerchantMenuScreen({Key? key}) : super(key: key);
  static const routeName = '/merchantmenu';

  @override
  _MerchantMenuScreenState createState() => _MerchantMenuScreenState();
}

class _MerchantMenuScreenState extends State<MerchantMenuScreen> {
  final MerchantService merchantService = MerchantService();
  Map<String, List<bool>> categoryCheckBoxMap = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Menu",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Colors.white,
        ),
        body: Consumer<MerchantProvider>(builder:
            (BuildContext context, MerchantProvider merchantProvider, child) {
          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 56,
                child: Container(
                  alignment: Alignment.centerLeft,
                  color: const Color.fromARGB(31, 211, 211, 211),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Text(
                      "Total ${merchantProvider.merchant.categories?.length} Category(s)",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: merchantProvider.merchant.categories != null
                        ? [
                            ...merchantProvider.merchant.categories!
                                .map(
                                  (e) => MenuItemTile(
                                    categoryName: e.name,
                                    value: e.products,
                                  ),
                                )
                                .toList(),
                            SizedBox(height: 10),
                            PlaceholderItem(
                              height: 95,
                              widthPercent: 0.9,
                              text: "Add New Items or Categories",
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    MerchantSetupMenuScreen.routeName);
                              },
                            ),
                          ]
                        : [
                            PlaceholderItem(
                              height: 95,
                              widthPercent: 0.9,
                              text: "Add more Items or Categories",
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    MerchantSetupMenuScreen.routeName);
                              },
                            ),
                          ],
                  ),
                ),
              ),
            ],
          );
        }));
  }
}

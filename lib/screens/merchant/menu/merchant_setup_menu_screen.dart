import 'package:flutter/material.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/screens/merchant/menu/category/add_category_screen.dart';
import 'package:plantngo_frontend/screens/merchant/menu/item/add_item_screen.dart';
import 'package:plantngo_frontend/services/merchant_service.dart';
import 'package:plantngo_frontend/utils/error_handling.dart';
import 'package:provider/provider.dart';
import '../../../widgets/merchantsetupmenu/setup_menu_item_tiles.dart';

class MerchantSetupMenuScreen extends StatefulWidget {
  const MerchantSetupMenuScreen({Key? key}) : super(key: key);
  static const routeName = '/merchantsetupmenu';

  @override
  _MerchantSetupMenuScreenState createState() =>
      _MerchantSetupMenuScreenState();
}

class _MerchantSetupMenuScreenState extends State<MerchantSetupMenuScreen> {
  final MerchantService merchantService = MerchantService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Manage Menu",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Consumer<MerchantProvider>(
        builder:
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
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      "Total ${merchantProvider.merchant.categories!.length} Category(s)",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      for (var value in merchantProvider.merchant.categories!)
                        SetupMenuItemTile(
                          categoryName: value.name,
                          value: value.products,
                        )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: SizedBox(
        child: Container(
          color: Colors.grey.shade100,
          padding: const EdgeInsets.symmetric(
            horizontal: 35,
            vertical: 10,
          ),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ).copyWith(
                elevation: ButtonStyleButton.allOrNull(0.0),
              ),
              child: const Text('Add a new Item or Category'),
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        ListTile(
                          dense: true,
                          title: Text(
                            "Add Category",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, AddCategoryScreen.routeName);
                          },
                        ),
                        const Divider(),
                        ListTile(
                          dense: true,
                          title: Text(
                            "Add Item",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          onTap: () async {
                            if (Provider.of<MerchantProvider>(context,
                                    listen: false)
                                .merchant
                                .categories!
                                .isEmpty) {
                              showSnackBar(
                                  context, "You need at least 1 Category!");
                              Navigator.pushNamed(
                                context,
                                AddItemScreen.routeName,
                              );
                            } else {
                              Navigator.pushNamed(
                                  context, AddItemScreen.routeName);
                            }
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}

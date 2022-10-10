import 'package:flutter/material.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/screens/merchant/add_category_screen.dart';
import 'package:plantngo_frontend/screens/merchant/add_item_screen.dart';
import 'package:plantngo_frontend/services/merchant_service.dart';
import 'package:plantngo_frontend/utils/error_handling.dart';
import 'package:provider/provider.dart';
import '../../widgets/merchantsetupmenu/setup_menu_item_tiles.dart';

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
        title: const Text("Set Up Menu"),
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
                      "Main Menu (${merchantProvider.merchant.categories!.length} categories)",
                      style: const TextStyle(
                          color: Color.fromARGB(171, 0, 0, 0),
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                  for (var value in merchantProvider.merchant.categories!)
                    SetupMenuItemTile(
                        categoryName: value.name, value: value.products)
                ])),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 115,
        child: Container(
          padding: const EdgeInsets.all(35),
          color: const Color.fromARGB(33, 158, 158, 158),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ).copyWith(
                elevation: ButtonStyleButton.allOrNull(0.0),
              ),
              child: const Text('Add an item or category'),
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200,
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                if (Provider.of<MerchantProvider>(context,
                                        listen: false)
                                    .merchant
                                    .categories!
                                    .isEmpty) {
                                  showSnackBar(context, "Add categories first");
                                  Navigator.pushNamed(
                                      context, AddCategoryScreen.routeName);
                                } else {
                                  Navigator.pushNamed(
                                      context, AddItemScreen.routeName);
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      "Add a new Item",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AddCategoryScreen.routeName);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      "Add a new Category",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}

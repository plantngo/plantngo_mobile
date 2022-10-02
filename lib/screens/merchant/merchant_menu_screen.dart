import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/category.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import '../merchant/merchant_setup_menu_screen.dart';
import '../../widgets/merchantmenu/menu_item_tile.dart';
import 'package:provider/provider.dart';

class MerchantMenuScreen extends StatefulWidget {
  const MerchantMenuScreen({Key? key}) : super(key: key);
  static const routeName = '/merchantmenu';

  @override
  _MerchantMenuScreenState createState() => _MerchantMenuScreenState();
}

class _MerchantMenuScreenState extends State<MerchantMenuScreen> {
  List<Category>? _categories = [];

  Future<void> loadMenu() async {
    // final String response = await rootBundle.loadString(
    //     '/Users/jingkaiooi/Desktop/Plant&Go/plantngo_frontend/lib/testdata/products.json');
    // final data = await json.decode(response);

    setState(() {
      _categories = Provider.of<MerchantProvider>(context, listen: false)
          .merchant
          .categories;
    });
  }

  @override
  void initState() {
    loadMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<MenuItemTile> categoryList = [];
    _categories?.forEach((value) {
      categoryList
          .add(MenuItemTile(categoryName: value.name, value: value.products));
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Menu",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.pushNamed(
                      context, MerchantSetupMenuScreen.routeName);
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Row(children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 0.0, 20, 0.0),
                      child: Icon(
                        Icons.menu_book_outlined,
                        color: Colors.green,
                        size: 50,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Set Up Menu",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Add and edit menu details",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    const Spacer(flex: 2),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                    const Spacer(),
                  ]),
                )),
          ),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: Container(
              alignment: Alignment.centerLeft,
              color: const Color.fromARGB(31, 211, 211, 211),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  "Main Menu (${_categories?.length} categories)",
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
                child: Column(
              children: categoryList,
            )),
          ),
        ],
      ),
    );
  }
}

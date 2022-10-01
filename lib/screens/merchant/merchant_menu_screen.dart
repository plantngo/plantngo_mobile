import 'package:flutter/material.dart';
import '../merchant/merchant_setup_menu_screen.dart';

class MerchantMenuScreen extends StatefulWidget {
  const MerchantMenuScreen({Key? key}) : super(key: key);
  static const routeName = '/merchantmenu';

  @override
  _MerchantMenuScreenState createState() => _MerchantMenuScreenState();
}

class _MerchantMenuScreenState extends State<MerchantMenuScreen> {
  int num = 3;

  @override
  Widget build(BuildContext context) {
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
                  "Main Menu ($num categories)",
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
              children: const [
                ExpansionTile(
                  title: Text('ExpansionTile 1'),
                  subtitle: Text('Trailing expansion arrow icon'),
                  children: [
                    ListTile(title: Text('This is tile number 1')),
                  ],
                ),
                ExpansionTile(
                  title: Text('ExpansionTile 1'),
                  subtitle: Text('Trailing expansion arrow icon'),
                  children: [
                    ListTile(title: Text('This is tile number 1')),
                  ],
                ),
                ExpansionTile(
                  title: Text('ExpansionTile 1'),
                  subtitle: Text('Trailing expansion arrow icon'),
                  children: [
                    ListTile(title: Text('This is tile number 1')),
                  ],
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}

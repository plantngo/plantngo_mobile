import 'package:flutter/material.dart';

class MerchantSetupMenuScreen extends StatefulWidget {
  const MerchantSetupMenuScreen({Key? key}) : super(key: key);
  static const routeName = '/merchantsetupmenu';

  @override
  _MerchantSetupMenuScreenState createState() =>
      _MerchantSetupMenuScreenState();
}

class _MerchantSetupMenuScreenState extends State<MerchantSetupMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set Up Menu"),
      ),
      body: Column(
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
                      color: Colors.amber,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('Modal BottomSheet'),
                            ElevatedButton(
                              child: const Text('Close BottomSheet'),
                              onPressed: () => Navigator.pop(context),
                            ),
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

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
              onPressed: () {}),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MerchantPromotionScreen extends StatefulWidget {
  const MerchantPromotionScreen({Key? key}) : super(key: key);
  static const routeName = '/merchantpromotion';

  @override
  _MerchantPromotionScreenState createState() =>
      _MerchantPromotionScreenState();
}

class _MerchantPromotionScreenState extends State<MerchantPromotionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Promotion"),
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
              child: const Text('Create Promotion'),
              onPressed: () async {}),
        ),
      ),
    );
  }
}

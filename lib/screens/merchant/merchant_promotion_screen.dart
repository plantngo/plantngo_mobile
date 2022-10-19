import 'package:flutter/material.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/screens/merchant/create_promotion_screen.dart';
import 'package:provider/provider.dart';

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
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "${merchantProvider.merchant.promotions?.length} Ongoing Promotion",
                    style: const TextStyle(
                        color: Color.fromARGB(171, 0, 0, 0),
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: const <Widget>[],
              ),
            ),
          ],
        );
      }),
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
              onPressed: () async {
                Navigator.pushNamed(context, CreatePromotionScreen.routeName);
              }),
        ),
      ),
    );
  }
}

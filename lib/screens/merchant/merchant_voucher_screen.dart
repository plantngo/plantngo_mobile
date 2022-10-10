import 'package:flutter/material.dart';
import 'package:plantngo_frontend/providers/merchant_provider.dart';
import 'package:plantngo_frontend/screens/merchant/create_voucher_screen.dart';
import 'package:plantngo_frontend/widgets/merchantvoucher/merchant_voucher_tile.dart';
import 'package:provider/provider.dart';

class MerchantVoucherScreen extends StatefulWidget {
  const MerchantVoucherScreen({Key? key}) : super(key: key);
  static const routeName = '/merchantvoucher';

  @override
  _MerchantVoucherScreenState createState() => _MerchantVoucherScreenState();
}

class _MerchantVoucherScreenState extends State<MerchantVoucherScreen> {
  int numVouchers = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vouchers"),
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
                    "${merchantProvider.merchant.vouchers?.length} Active Vouchers",
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
                children: <Widget>[
                  if (merchantProvider.merchant.vouchers != null)
                    for (var item in merchantProvider.merchant.vouchers!)
                      MerchantVoucherTile(voucher: item)
                ],
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
              child: const Text('Create Voucher'),
              onPressed: () async {
                Navigator.pushNamed(context, CreateVoucherScreen.routeName);
              }),
        ),
      ),
    );
  }
}

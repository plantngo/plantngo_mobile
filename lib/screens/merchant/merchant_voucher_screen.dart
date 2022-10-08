import 'package:flutter/material.dart';
import 'package:plantngo_frontend/screens/merchant/create_voucher_screen.dart';
import 'package:plantngo_frontend/widgets/merchantvoucher/merchant_voucher_tile.dart';

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
                  "$numVouchers Active Vouchers",
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
              children: [
                const MerchantVoucherTile(
                    voucherTitle: "30% off Main courses",
                    voucherValue: 20,
                    voucherDescription: "Valid for 30 days"),
                const Divider(),
                GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      print("hi");
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.percent_rounded,
                        color: Colors.green,
                        size: 30,
                      ),
                      title: Text(
                        "20% off all products",
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text("Value: 20 Green Points"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 30,
                      ),
                    )),
                const Divider(),
                GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      print("hi");
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.percent_rounded,
                        color: Colors.green,
                        size: 30,
                      ),
                      title: Text(
                        "20% off all products",
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text("Valid for 30 days"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 30,
                      ),
                    )),
                const Divider(),
              ],
            ),
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
              child: const Text('Create Voucher'),
              onPressed: () async {
                Navigator.pushNamed(context, CreateVoucherScreen.routeName);
              }),
        ),
      ),
    );
  }
}

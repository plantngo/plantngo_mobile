import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/voucher.dart';
import 'package:plantngo_frontend/providers/voucher_shop_provider.dart';
import 'package:plantngo_frontend/screens/customer/voucherShop/voucher_checkout_screen.dart';
import 'package:plantngo_frontend/widgets/card/voucher_card.dart';
import 'package:plantngo_frontend/providers/customer_provider.dart';
import 'package:provider/provider.dart';

class VoucherShop extends StatefulWidget {
  const VoucherShop({super.key});

  @override
  State<VoucherShop> createState() => _VoucherShopState();
}

class _VoucherShopState extends State<VoucherShop> {
  List<bool> voucherActivate = [];

  @override
  void initState() {
    super.initState();
    Provider.of<VoucherShopProvider>(context, listen: false)
        .setVouchers(context);
  }

  @override
  Widget build(BuildContext context) {
    var customerProvider = Provider.of<CustomerProvider>(context, listen: true);
    var voucherShopProvider =
        Provider.of<VoucherShopProvider>(context, listen: true);

    List<Voucher> allVouchers = voucherShopProvider.vouchers;

    var greenPoints = (customerProvider.customer.greenPoints == null)
        ? 0
        : customerProvider.customer.greenPoints;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Rewards Shop",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Green Points: $greenPoints",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Column(
                      children: renderVouchers(allVouchers),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          backgroundColor: Color.fromARGB(225, 33, 150, 246),
          shape: const CircleBorder(),
          // Lead to checkout page
          onPressed: () {
            Navigator.pushNamed(context, VoucherCheckout.routeName);
          },
          child: const Icon(Icons.shopping_cart, color: Colors.black),
        ),
      ),
    );
  }

  renderVouchers(allVouchers) {
    List<Widget> listVouchers = [];

    for (int i = 0; i < allVouchers.length; i++) {
      setState(() {
        voucherActivate.add(false);
      });
      listVouchers.add(VoucherCard(
        voucher: allVouchers[i],
        isAdded: voucherActivate[i],
        onAddToCartTapped: () {
          setState(
            () {
              voucherActivate[i] = true;
            },
          );
        },
      ));
    }
    return listVouchers;
  }
}

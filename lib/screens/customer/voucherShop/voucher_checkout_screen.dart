import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:plantngo_frontend/models/voucher.dart';
import 'package:plantngo_frontend/providers/customer_provider.dart';
import 'package:plantngo_frontend/providers/voucher_shop_provider.dart';
import 'package:plantngo_frontend/widgets/card/voucher_checkout_card.dart';
import 'package:provider/provider.dart';

class VoucherCheckout extends StatefulWidget {
  const VoucherCheckout({super.key});
  static const routeName = '/vouchercheckout';

  @override
  State<VoucherCheckout> createState() => _VoucherCheckoutState();
}

class _VoucherCheckoutState extends State<VoucherCheckout> {
  @override
  Widget build(BuildContext context) {
    var customerProvider = Provider.of<CustomerProvider>(context, listen: true);
    var voucherShopProvider =
        Provider.of<VoucherShopProvider>(context, listen: true);
    var greenPoints = (customerProvider.customer.greenPoints == null)
        ? 0
        : customerProvider.customer.greenPoints;

    List<Voucher> vouchersInCart = customerProvider.customer.vouchersCart;

    int total = 0;
    for (var i = 0; i < vouchersInCart.length; i++) {
      total += vouchersInCart[i].value;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
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
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
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
                  children: renderVouchers(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, right: 30),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text(
                "Total: $total GP",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50, left: 50, right: 50),
            child: SizedBox(
              width: 300,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ).copyWith(
                  elevation: ButtonStyleButton.allOrNull(0.0),
                ),
                child: const Text('Checkout'),
                onPressed: () {
                  voucherShopProvider.purchaseVouchers(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  renderVouchers() {
    var customerProvider = Provider.of<CustomerProvider>(context, listen: true);
    List<Widget> listVouchers = [];
    List<Voucher> cartVouchers = customerProvider.customer.vouchersCart;
    print(cartVouchers);

    for (int i = 0; i < cartVouchers.length; i++) {
      listVouchers.add(VoucherCheckoutCard(
        voucher: cartVouchers[i],
      ));
    }

    return listVouchers.isEmpty
        ? [const Text("No Items in Cart")]
        : listVouchers;
  }
}

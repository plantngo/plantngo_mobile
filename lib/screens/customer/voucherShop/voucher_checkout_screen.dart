import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:plantngo_frontend/models/voucher.dart';
import 'package:plantngo_frontend/providers/customer_provider.dart';
import 'package:plantngo_frontend/providers/voucher_shop_provider.dart';
import 'package:plantngo_frontend/widgets/card/voucher_checkout_card.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_icons_icons.dart';

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
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text(
      //     "Checkout",
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ),
      //   backgroundColor: Theme.of(context).colorScheme.secondary,
      //   foregroundColor: Colors.white,
      //   // flexibleSpace: Container(
      //   //   decoration: BoxDecoration(
      //   //     boxShadow: [
      //   //       const BoxShadow(
      //   //         color: Colors.grey,
      //   //         offset: Offset(0, 2.0),
      //   //         blurRadius: 4.0,
      //   //       )
      //   //     ],
      //   //     gradient: LinearGradient(
      //   //       begin: Alignment.topLeft,
      //   //       end: Alignment.bottomRight,
      //   //       colors: [
      //   //         Theme.of(context).colorScheme.secondary.shade200,
      //   //         Theme.of(context).colorScheme.secondary.shade300,
      //   //         Theme.of(context).colorScheme.secondary,
      //   //       ],
      //   //     ),
      //   //   ),
      //   // ),
      // ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 8, top: 12, bottom: 10),
                      child: Text(
                        "Green Points: $greenPoints",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: Icon(
                        CustomIcons.leaf,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 20,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: renderVouchers(),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Total: $total",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      CustomIcons.leaf,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 50, left: 50, right: 50, top: 10),
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
                  onPressed: vouchersInCart.isEmpty
                      ? null
                      : () {
                          if (total > greenPoints!) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Insufficient Balance!'),
                                duration: Duration(milliseconds: 300),
                              ),
                            );
                          } else {
                            voucherShopProvider.purchaseVouchers(context);
                            customerProvider.customer.greenPoints =
                                greenPoints - total;
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                content: Text('Purchase Successful!'),
                                duration: Duration(milliseconds: 300),
                              ),
                            );
                          }
                        },
                  child: const Text('Checkout'),
                ),
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

    for (int i = 0; i < cartVouchers.length; i++) {
      listVouchers.add(VoucherCheckoutCard(
        voucher: cartVouchers[i],
      ));
    }

    return listVouchers.isEmpty
        ? [
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text("No Items in Cart"),
            )
          ]
        : listVouchers;
  }
}

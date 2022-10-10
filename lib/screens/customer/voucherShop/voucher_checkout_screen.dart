import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class VoucherCheckout extends StatefulWidget {
  const VoucherCheckout({super.key});
  static const routeName = '/vouchercheckout';

  @override
  State<VoucherCheckout> createState() => _VoucherCheckoutState();
}

class _VoucherCheckoutState extends State<VoucherCheckout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Checkout"),
        ),
        body: Column(
          children: [],
        ));
  }
}

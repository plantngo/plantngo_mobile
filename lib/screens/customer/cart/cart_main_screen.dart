import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:plantngo_frontend/screens/customer/cart/cart_screen.dart';
import 'package:plantngo_frontend/screens/customer/voucherShop/voucher_checkout_screen.dart';

class CartMainScreen extends StatefulWidget {
  const CartMainScreen({super.key});

  @override
  State<CartMainScreen> createState() => _CartMainScreenState();
}

class _CartMainScreenState extends State<CartMainScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0),
            child: AppBar(
              centerTitle: true,
              title: const Text(
                "Cart",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: BackButton(color: Colors.white),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              bottom: TabBar(
                tabs: const [
                  Text(
                    "Orders",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Vouchers",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              CartScreen(),
              VoucherCheckout(),
            ],
          ),
        ));
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/voucher.dart';
import 'package:provider/provider.dart';

import '../../providers/customer_provider.dart';

class VoucherCard extends StatelessWidget {
  final Voucher voucher;
  const VoucherCard({super.key, required this.voucher});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    var customerProvider = Provider.of<CustomerProvider>(context, listen: true);

    var rewardName = voucher.description ?? "";
    var price = voucher.value;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4.0,
        child: Container(
          height: 100,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            gradient: LinearGradient(
              stops: [0.02, 0.02],
              colors: [Colors.greenAccent, Colors.white],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 5,
                    child: ListTile(
                      // insert company logo here
                      leading: FlutterLogo(size: 50.0),
                      title: Text(rewardName,
                          style: const TextStyle(fontSize: 16)),
                      subtitle: Text("Price: $price",
                          style: TextStyle(
                              fontSize: 14, color: Colors.orange[900])),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 16, bottom: 4, top: 26),
                          child: IconButton(
                            icon: const Icon(Icons.add_shopping_cart, size: 30),
                            // Adds voucher to customer's cart
                            onPressed: () {

                            },
                            style: IconButton.styleFrom(
                              foregroundColor: colors.onSecondaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

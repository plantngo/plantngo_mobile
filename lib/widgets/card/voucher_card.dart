import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/voucher.dart';
import 'package:provider/provider.dart';

import '../../providers/customer_provider.dart';

class VoucherCard extends StatefulWidget {
  final Voucher voucher;
  const VoucherCard({super.key, required this.voucher});

  @override
  State<VoucherCard> createState() => _VoucherCardState();
}

class _VoucherCardState extends State<VoucherCard> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    var customerProvider = Provider.of<CustomerProvider>(context, listen: true);
    var rewardName = widget.voucher.description ?? "";
    rewardName = rewardName.toUpperCase();
    var price = widget.voucher.value;
    bool isPressed = false;

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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                      child: ListTile(
                        // insert company logo here
                        leading: const Image(
                            image: AssetImage('assets/icon/voucher.png')),
                        title: Text(rewardName,
                            style: const TextStyle(fontSize: 16)),
                        subtitle: Text("Price: $price",
                            style: TextStyle(
                                fontSize: 14, color: Colors.orange[900])),
                      ),
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
                            icon: Icon(Icons.add_shopping_cart, size: 30),
                            // Adds voucher to customer's cart
                            onPressed: () {
                              customerProvider.addVouchersToCart(
                                  context, widget.voucher);
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

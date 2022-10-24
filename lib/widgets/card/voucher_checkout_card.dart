import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/voucher.dart';
import 'package:plantngo_frontend/providers/voucher_shop_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/customer_provider.dart';

class VoucherCheckoutCard extends StatefulWidget {
  final Voucher voucher;

  VoucherCheckoutCard({
    super.key,
    required this.voucher,
  });

  @override
  State<VoucherCheckoutCard> createState() => _VoucherCheckoutCardState();
}

class _VoucherCheckoutCardState extends State<VoucherCheckoutCard> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    var customerProvider = Provider.of<CustomerProvider>(context, listen: true);
    var voucherShopProvider =
        Provider.of<VoucherShopProvider>(context, listen: true);
    var rewardName = widget.voucher.description ?? "";
    rewardName = rewardName.toUpperCase();
    var price = widget.voucher.value;

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Flexible(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: ListTile(
                  // insert company logo here
                  leading:
                      const Image(image: AssetImage('assets/icon/voucher.png')),
                  title: Text(rewardName, style: const TextStyle(fontSize: 16)),
                  subtitle: Text("Price: $price",
                      style:
                          TextStyle(fontSize: 14, color: Colors.orange[900])),
                ),
              ),
            ),
            Flexible(
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  customerProvider.removeVouchersFromCart(
                      context, widget.voucher);
                  voucherShopProvider.vouchers.add(widget.voucher);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Voucher Removed from Cart!'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

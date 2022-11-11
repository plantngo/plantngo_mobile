import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/voucher.dart';
import 'package:plantngo_frontend/screens/merchant/profile/voucher/edit_voucher_screen.dart';

class MerchantVoucherTile extends StatefulWidget {
  const MerchantVoucherTile({Key? key, required this.voucher})
      : super(key: key);

  final Voucher voucher;

  @override
  _MerchantVoucherTileState createState() => _MerchantVoucherTileState();
}

class _MerchantVoucherTileState extends State<MerchantVoucherTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditVoucherScreen(voucher: widget.voucher),
            ),
          );
        },
        child: ListTile(
          leading: Icon(
            Icons.percent_rounded,
            color: Theme.of(context).colorScheme.secondary,
            size: 30,
          ),
          title: Text(
            widget.voucher.description.toString(),
            style: const TextStyle(fontSize: 20),
          ),
          subtitle: Text("Value: ${widget.voucher.value} green points"),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 30,
          ),
        ));
  }
}

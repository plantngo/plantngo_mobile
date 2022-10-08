import 'package:flutter/material.dart';

class MerchantVoucherTile extends StatefulWidget {
  const MerchantVoucherTile(
      {Key? key, required this.voucherValue, required this.voucherDescription})
      : super(key: key);

  final double voucherValue;
  final String voucherDescription;

  @override
  _MerchantVoucherTileState createState() => _MerchantVoucherTileState();
}

class _MerchantVoucherTileState extends State<MerchantVoucherTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          print("hi");
        },
        child: ListTile(
          leading: const Icon(
            Icons.percent_rounded,
            color: Colors.green,
            size: 30,
          ),
          title: Text(
            widget.voucherDescription,
            style: const TextStyle(fontSize: 20),
          ),
          subtitle: Text("Value: ${widget.voucherValue} green points"),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 30,
          ),
        ));
  }
}

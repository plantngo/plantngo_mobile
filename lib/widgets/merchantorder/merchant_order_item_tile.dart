import 'package:flutter/material.dart';

class MerchantOrderItemTile extends StatefulWidget {
  const MerchantOrderItemTile(
      {Key? key,
      required this.quantity,
      required this.price,
      required this.name})
      : super(key: key);

  final int quantity;
  final String name;
  final double price;

  @override
  _MerchantOrderItemTileState createState() => _MerchantOrderItemTileState();
}

class _MerchantOrderItemTileState extends State<MerchantOrderItemTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${widget.name}'),
              Text(
                '\$${widget.price}0',
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ],
          ),
          trailing: Text("Qty: ${widget.quantity}"),
        ),
        const Divider()
      ],
    );
  }
}

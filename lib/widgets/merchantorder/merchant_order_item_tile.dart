import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/product.dart';

class MerchantOrderItemTile extends StatefulWidget {
  const MerchantOrderItemTile(
      {Key? key, required this.quantity, required this.product})
      : super(key: key);

  final int quantity;
  final Product product;

  @override
  _MerchantOrderItemTileState createState() => _MerchantOrderItemTileState();
}

class _MerchantOrderItemTileState extends State<MerchantOrderItemTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SizedBox(
              height: 80,
              width: 80,
              child: Image.network(
                widget.product.imageUrl!,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.product.name!),
              Text(
                '\$${widget.product.price}0',
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

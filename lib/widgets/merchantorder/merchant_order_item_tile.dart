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
              height: 100,
              width: 100,
              child: Image.network(
                widget.product.imageUrl!,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text(
            widget.product.name!,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          subtitle: Text(
            '\$${widget.product.price.toString().padRight(4, '0')}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: Text(
            "Qty: ${widget.quantity}",
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        const Divider()
      ],
    );
  }
}

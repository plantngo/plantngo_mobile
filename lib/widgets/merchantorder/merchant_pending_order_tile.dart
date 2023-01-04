import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/order.dart';
import 'package:plantngo_frontend/screens/merchant/home/merchant_order_details_screen.dart';

class MerchantOrderTile extends StatefulWidget {
  const MerchantOrderTile(
      {Key? key, required this.order, required this.refresh})
      : super(key: key);

  final Order order;
  final void Function() refresh;

  @override
  _MerchantOrderTileState createState() => _MerchantOrderTileState();
}

class _MerchantOrderTileState extends State<MerchantOrderTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MerchantOrderDetailsScreen(
              order: widget.order,
              refresh: widget.refresh,
            ),
          ),
        );
      },
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.order.isDineIn!
                ? Icons.restaurant_outlined
                : Icons.shopping_bag_outlined,
            color: Theme.of(context).colorScheme.secondary,
            size: 35,
          ),
        ],
      ),
      title: Text(
        "Order #${widget.order.id.toString().padLeft(5, '0')}",
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(
        "No of Items: ${widget.order.orderItems?.length}",
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
      ),
    );
  }
}

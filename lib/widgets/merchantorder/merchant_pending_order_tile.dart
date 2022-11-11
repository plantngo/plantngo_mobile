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
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
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
        //dine in uses: restaurant icon
        //takeway uses: Shopping Bag icon
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                widget.order.isDineIn! ? Icons.restaurant : Icons.shopping_bag,
                color: Theme.of(context).colorScheme.secondary,
                size: 30,
              ),
              title: Text(
                "Order #${widget.order.id.toString().padLeft(5, '0')}",
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: Text("No of Items: ${widget.order.orderItems?.length}"),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 30,
              ),
            ),
            const Divider()
          ],
        ));
  }
}

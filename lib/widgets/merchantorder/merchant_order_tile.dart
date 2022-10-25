import 'package:flutter/material.dart';

class MerchantOrderTile extends StatefulWidget {
  const MerchantOrderTile({Key? key}) : super(key: key);

  @override
  _MerchantOrderTileState createState() => _MerchantOrderTileState();
}

class _MerchantOrderTileState extends State<MerchantOrderTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => EditVoucherScreen(voucher: widget.voucher),
          //   ),
          // );
        },
        //dine in uses: restautant icon
        //takeway uses: Shopping Bag icon
        child: Column(
          children: const [
            ListTile(
              leading: const Icon(
                Icons.shopping_bag,
                color: Colors.green,
                size: 30,
              ),
              title: Text(
                "Order ID:",
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: Text("No of Items: "),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 30,
              ),
            ),
            Divider()
          ],
        ));
  }
}

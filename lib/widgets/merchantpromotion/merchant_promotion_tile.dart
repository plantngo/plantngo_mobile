import 'package:flutter/material.dart';
import 'package:plantngo_frontend/models/promotion.dart';
import 'package:plantngo_frontend/screens/merchant/edit_promotion_screen.dart';
import 'package:plantngo_frontend/screens/merchant/edit_voucher_screen.dart';

class MerchantPromotionTile extends StatefulWidget {
  const MerchantPromotionTile({Key? key, required this.promotion})
      : super(key: key);

  final Promotion promotion;

  @override
  _MerchantPromotionTileState createState() => _MerchantPromotionTileState();
}

class _MerchantPromotionTileState extends State<MerchantPromotionTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  EditPromotionScreen(promotion: widget.promotion),
            ),
          );
        },
        child: ListTile(
          leading: const Icon(
            Icons.percent_rounded,
            color: Colors.green,
            size: 30,
          ),
          title: Text(
            widget.promotion.description.toString(),
            style: const TextStyle(fontSize: 20),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 30,
          ),
        ));
  }
}

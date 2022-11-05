import 'package:flutter/material.dart';

class MerchantShopBottomAppBar extends StatelessWidget {
  void Function() onViewCartPressed;
  int itemCount;
  double itemTotalPrice;

  MerchantShopBottomAppBar({
    super.key,
    required this.itemCount,
    required this.itemTotalPrice,
    required this.onViewCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              blurRadius: 15.0,
              offset: Offset(0.0, 0.75)),
        ],
      ),
      child: ClipRRect(
        child: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ElevatedButton(
              onPressed: onViewCartPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$itemCount item(s)",
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.shopping_bag_outlined, size: 20.0),
                      Text("View Cart"),
                    ],
                  ),
                  Text(
                    "S\$ ${itemTotalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
